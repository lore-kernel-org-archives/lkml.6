Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7D7C4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D067620896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw33HmUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D067620896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756096AbeFOIiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:38:11 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:36413 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755759AbeFOIiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:38:09 -0400
Received: by mail-pl0-f41.google.com with SMTP id a7-v6so5007618plp.3;
        Fri, 15 Jun 2018 01:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5VaEwDlQA7ZVagtHdnMhXMuq2Mg/unuu0il5UHgOdDk=;
        b=Zw33HmUvGrq5KHmWNWdI2lyEZCAGK8eokakVjUTrU1vSoazt1aIkRRhUB6DYkELSEj
         /UN+qfXSSwaPLj06YveHFVDFujWiSfbqZSlFRrw6hdbMeGTXsUk0uXwD36G1JaVRRCMH
         bg1wWqyd2YKRDv02ZjM8Zo68bvS75JYqbYViXS9UKdTKFKN1yMjx0rZ0zbaDSXdUsfSr
         gETQaOyEFcQW4nIjFA9y6dYQdHGnzt5g/PYbHqmXeVDrGY4deW/QmTPyv6bFiZu1asJ2
         Ui1wqww/vSEH3L3/2vJbxtlb+y5YsqQPM9DTN6Z0Uk7F3noKb1phdfdSW04zc2+eE7TJ
         hMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5VaEwDlQA7ZVagtHdnMhXMuq2Mg/unuu0il5UHgOdDk=;
        b=MevQgjwhxHBqKodvQw0o/b9jwcvET+C4bll3WtCvVUvlkIMkZIvJEVnXLUtVovRcWO
         I/kBkwsfC96UNtmbEPvO7Z8UIrHNC9U343x9UbjZ4UjUBAv4j2odsDcmg6VUNO6qRvt9
         4ZNUgfz2f3o5+ihbPvou24fO24ZvvdDfny9pQeL0SJLY11rWvCMPzC8Vqlg825w7Va55
         N+TBRCQOv/ZA+diKzcX9NNTGJ4gXIVTseTyrI/mMtO/acmyGVe4XYvWIbVyiUg7tsML7
         iujbYVFd8OqZVfrseuBGgFq/u6SSK1WeMdAAUm/XgkCGAWbhR76K11dVr9pFdc2BZw0f
         CyBA==
X-Gm-Message-State: APt69E1qe7xsB3uZQ1roPGgD6SmOvmYpFJEJAPQ6ziAd7eI8wr8GhTU1
        kuCCTXhZHSPAla/h/m0WhNk=
X-Google-Smtp-Source: ADUXVKLA86rylHs8q2rsKMLZRidsM7p1yUSIOEbkwhIvPj/CWZPi8eLLJqhd6HNcBqmEt45J2CPDhw==
X-Received: by 2002:a17:902:422:: with SMTP id 31-v6mr928219ple.320.1529051889235;
        Fri, 15 Jun 2018 01:38:09 -0700 (PDT)
Received: from localhost ([175.223.48.179])
        by smtp.gmail.com with ESMTPSA id m7-v6sm10019864pgr.5.2018.06.15.01.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 01:38:07 -0700 (PDT)
Date:   Fri, 15 Jun 2018 17:38:04 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: possible deadlock in console_unlock
Message-ID: <20180615083804.GB8964@jagdpanzerIV>
References: <00000000000087008b056df8fbb3@google.com>
 <20180607051019.GA10406@jagdpanzerIV>
 <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
 <20180607140100.GA398@tigerII.localdomain>
 <20180608081855.ctqakvwmg27aydby@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608081855.ctqakvwmg27aydby@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/08/18 10:18), Petr Mladek wrote:
[..]
> > Could be.
> > The good thing about printk_safe is that printk_safe sections can nest.
> > I suspect there might be locks/printk_safe sections nesting at some
> > point. In any case, switching to a new flavor of printk_safe will be
> > pretty easy - just replace printk_safe_enter() with printk_foo_enter()
> > and the same for printk_save_exit().
> 
> We could allow nesting. It is just a matter of how many bits we
> reserve for it in printk_context variable.
[..]
> In each case, I would like to keep the printk_safe context usage
> at minimum. It has its own problems caused by limited per-cpu buffers
> and the need to flush them.

May be. Every new printk_safe flavour comes with increasing memory
usage. We already have a bunch of pages pinned [and mostly unused]
to every CPU for printk_nmi and printk_safe. I'm a little unsure if
we have enough reasons to pin yet another bunch of pages to every
CPU. After all printk_safe is not used very commonly, so all in all
I think we should be fine with printk_safe buffers for the time being.
We always can introduce new printk_safe mode later.

> It is basically needed only to prevent deadlocks related to logbuf_lock.

I wouldn't say that we need printk_safe for logbuf_lock only.
printk_safe helps us to avoid deadlocks on:

- logbuf_lock spin_lock
- console_sem ->lock spin_lock
- console_owner spin_lock
- scheduler ->pi_lock spin_lock
- and probably something else.

	-ss
