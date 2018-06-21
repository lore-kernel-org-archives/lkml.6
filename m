Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575DFC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06572204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsHDSpf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06572204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932855AbeFUI34 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:29:56 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41412 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932466AbeFUI3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:29:54 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11-v6so1163478pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 01:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JMf2A+z0K1VHI2UNixAkQreoCiwaBaW2SCx1ucwJ7FE=;
        b=qsHDSpf/eeOjrOmFWIyNf8JC0O3mU2Dd/pfaZR60xunlgP6wpXDn3XeqmyvQBwLRKv
         JFqaKcJqpQj5TjbTeorMC/qRZnpS7xVIbITnQ4kdk+frWVhfALiPI0Qt24F80/CmXdbt
         N/gjnFl/4z6lf1wxMI/uNFoRKjv8i6vEbyqKVyt5YAnvqze5nU15SODZD+Jh53QsSvpm
         k4DqZHCEA0axffogyrj3MK7IuMDxjWcr6PnDCfwxc16reC16AO329I9j+98JERXBxlty
         y3uky2N4RsOYyWcdYnaJ7KOWkDXLgUu1AFv6dvMT5+QyNpwDomSVl2oFvqEhgwDzpaXI
         6s6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JMf2A+z0K1VHI2UNixAkQreoCiwaBaW2SCx1ucwJ7FE=;
        b=nP1TSay9+6xC8xE5fMRDrmvIqgcpAL7nFsCOJEPZdnQNlShAtqlHkIHXftsYkm2243
         kx8JwsoEbmmq7PuZPesmEX6D5lh6g3W3YkIVosphrtsY+7QCblhAyzgYPSypulh2rsYx
         w4NHiC4x6hHKrx+czkSw8bWalK609/M7SxYWnDNyzd02A+UznHRnItlY3oZ4meuVxgea
         Bdo6FkpTc2SyNvXk21udaud7e7uBjuvZb+r4bNF0TjykpTlL1zfiItZuweuknR4WLDtX
         X3BiAqwCmTq53aJzf2lxikQTLcsZmPzBG8mCd6WWVTaD89Pbw/MHI+3IV7xtbYvplgmc
         MThA==
X-Gm-Message-State: APt69E0KZvQpKRa3OGhmbApPW9wcfjEncduwaZbmmJIJh2mV4jJkyh9g
        OJgwPbkSBEI9xe116mGChjU=
X-Google-Smtp-Source: ADUXVKJL6B8cESrTA7OahRNGdXM5B7mbdYH3dF4Bw8OmU865cEfYnZehzzg4uO/rqvSmuYNrh40jqw==
X-Received: by 2002:a65:4107:: with SMTP id w7-v6mr21018022pgp.90.1529569793872;
        Thu, 21 Jun 2018 01:29:53 -0700 (PDT)
Received: from localhost ([39.7.59.103])
        by smtp.gmail.com with ESMTPSA id x19-v6sm8488502pfi.5.2018.06.21.01.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 01:29:52 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:29:49 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180621082949.GB677@jagdpanzerIV>
References: <20180524021451.GA23443@jagdpanzerIV>
 <CACT4Y+brbqfBWntjVaj-Ri2WhBdXpkA_PYs59qgLZ0vtepZEtw@mail.gmail.com>
 <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV>
 <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV>
 <20180620091541.GB444@jagdpanzerIV>
 <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
 <20180620110759.GD444@jagdpanzerIV>
 <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/20/18 13:32), Dmitry Vyukov wrote:
> >>
> >> So this is another reason to get rid of pr_cont entirely, right?
> >
> > Getting rid of pr_cont() from important output would be totally cool.
> > Quoting Linus:
> >
> >     Only acceptable use of continuations is basically boot-time testing,
> >     when you do things like
> >
> >      printk("Testing feature XYZ..");
> >      this_may_blow_up_because_of_hw_bugs();
> >      printk(KERN_CONT " ... ok\n");
> >
> >
> > I can recall at least 4 attempts when people tried to introduce new pr_cont()
> > or some concept with similar functionality to pr_cont(), but SMP safe. We
> > brought the first one - per-CPU pr_cont() buffers - to KS several years ago
> > but Linus didn't like it. Then there was a buffered printk() mode patch from
> > Tetsuo, then a solution from Steven, then I had my second try with a
> > soft-of-pr_cont() replacement.
> >
> > So, if we could get rid of pr_cont() from the most important parts
> > (instruction dumps, etc) then I would just vote to leave pr_cont()
> > alone and avoid any handling of it in printk context tracking. Simply
> > because we wouldn't care about pr_cont(). This also could simplify
> > Tetsuo's patch significantly.
> 
> Sounds good to me.

Another thing about pr_cont() is that as long as pr_cont() does not race
with pr_cont() from another task or from IRQ, the task that is the owner
(see struct cont in printk.c) of the existing continuation line can migrate,
IOW we can have

	CPU0	CPU1	CPU2	CPU3

	task A
	pr_cont()
		task A
		pr_cont()
			task A
			pr_cont()
				task A
				pr_cont("\n") << flush

The line was printed from 4 CPUs, but appears as a single line
in the logbuf. Should we account CPU0 or CPU3 as the line origin?

That's another reason why I don't really want to handle pr_cont in
any special way in context tracking.

So, currently, context tracking looks like this:

---
	char mode = 'T';

	if (in_serving_softirq())
		mode = 'S';
	if (in_irq())
		mode = 'I';
	if (in_nmi())
		mode = 'N';

	ret = snprintf(buf, buf_len, "%c<%d>%c",
			mode,
			raw_smp_processor_id(),
			cont.len ? '+' : ' ');
---

I add a '+' symbol to continuation lines. Which should simply hint
that tracking info for that particular line is not entirely trustworthy.

I also don't add any tracking info for printk_safe output. We get
tracking info for such lines from the printk_safe flush path
(irq work that happens on the same CPU that added printk_safe output).

	-ss
