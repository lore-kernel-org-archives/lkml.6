Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ABAC43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F36B2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ickpV30a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F36B2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeIKH1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 03:27:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39528 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeIKH1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 03:27:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so11426492pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 19:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=scF6mvj8cwwwU3O4EazFo+/YiBxOzi/oSj1zj30dyYM=;
        b=ickpV30a62x7SW+0mclTvrGK1Vt2JnFZxhiBbYkGEgt6bQh/rkflFcmZqK4z9cYsWr
         eUpbj458R6GKhWveMVGwDkTsjEEiqJhvW2dIbH14Hj5SJbQtmI0qd2BHuFjtYiXLQA+R
         lGTubZm1hpG9a5jtcqTIHcHv2hQPaN8t+2cQ+PNQnOYEmuL2e6k6v+3l/WrFbeSHO6z8
         mij3a7OEU0+liXDrEo9jo0MuIScQE18mqYk/TnOqvz0R5aVHklVsXnjNSr2xHxpywLPw
         UzSDcKRT9/PBc8FnODX+ZjdDWhDwsp34UfiX5f3ZBJGgrB/izet+T7x1dC//bZ1RVBYO
         oNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=scF6mvj8cwwwU3O4EazFo+/YiBxOzi/oSj1zj30dyYM=;
        b=tAXnFwQqqv0QbSRaEPsa3C8r2zXOR+PqNOIoPJU7lGPvnmZ/itDk4mIfxecRmZwrnn
         aXfLm/bnuvho/sUbpT3gp3AWpp8MOW0eqJCx2ZVPXWDy4VveUS9eEaM9eo2aAYJw3I+2
         vTcPfEjDWu0o8cx12bS+nyQ5oMlUbj4IY/YQYz9o3QJQE0aKS/6PpiQ45zbdZajDc7Vi
         A1guVHr+NICreE1oA7d56yKWMSqbx7mFAUf2tYia1ussrlR5yi0N0G7aeyK59/3b8VQw
         9bJDFqwB0NvyQwtKUbq/qriQhryW0tPh+CNmh7dyxADssPEfc+ss+SwWNcldIFth/zLe
         0JNA==
X-Gm-Message-State: APzg51BjuX5q5pQcG/41SHO5cslchfvlEckVVhtU8pwIaI2vaRL6vePq
        MN8qvFvT6W29PDCQ3hqmCUE=
X-Google-Smtp-Source: ANB0VdY5BJZyamzo0YiLoLldszQbRrXpX/Nv8zI1q6Xecu/rUw/cDr5h9zA7zCpZZH4kSHqZOEiSGg==
X-Received: by 2002:a65:6110:: with SMTP id z16-v6mr26145347pgu.412.1536633044308;
        Mon, 10 Sep 2018 19:30:44 -0700 (PDT)
Received: from localhost ([39.7.19.225])
        by smtp.gmail.com with ESMTPSA id o3-v6sm19304224pgv.53.2018.09.10.19.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 19:30:43 -0700 (PDT)
Date:   Tue, 11 Sep 2018 11:30:39 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 4.19 regression fix] printk: For early boot messages
 check loglevel when flushing the buffer
Message-ID: <20180911023039.GA4065@jagdpanzerIV>
References: <20180904180154.845-1-hdegoede@redhat.com>
 <20180905023522.GA1444@jagdpanzerIV>
 <93901f2b-91ad-a910-7031-0040b827a3af@redhat.com>
 <20180905053609.GA19936@jagdpanzerIV>
 <20180905083326.GC19936@jagdpanzerIV>
 <20180905110207.rxy3upplgkjbk5oi@pathway.suse.cz>
 <20180906072940.GA382@jagdpanzerIV>
 <20180906142825.u2fiqt62jmapr5ud@pathway.suse.cz>
 <20180907042132.GC2394@jagdpanzerIV>
 <20180910145747.emvfzv4mzlk5dfqk@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910145747.emvfzv4mzlk5dfqk@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/10/18 16:57), Petr Mladek wrote:
> 
> Good catch.
> 
> > ---
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index c036f128cdc3..ede29a7ba6db 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2545,6 +2545,7 @@ void console_flush_on_panic(void)
> >  	 * ensure may_schedule is cleared.
> >  	 */
> >  	console_trylock();
> > +	exclusive_console = NULL;
> 
> This is not be enough. It would cause replying old messages
> on all consoles.

Oh, that was intentional. I consider repeated messages to be less
problematic than the missing ones.

> Most problems should probably be solved when we store console_seq
> before setting exclusive_console. Then we could clear
> exclusive_console when reaching the stored sequence number.
> 
> Can this be that simple? ;-)

This can work, yes.

I also thought about doing it the way Linus, Jan Kara and Hannes
Reinecke proposed:

- store the console_seq nr of the first oops_in_progress message
  (oops_console_seq) and flush only messages that are in
  [oops_console_seq - 200, log_next_seq] range, as opposed to complete
  logbuf flush.

Hannes asked for this several times. And it was in Jan's printk patches
long time ago (if I'm not mistaken - sorry if I am -- Jan said that Linus
wanted that "just N messages prior to oops" thing).

Jan's patch:
 https://lore.kernel.org/lkml/1457964820-4642-3-git-send-email-sergey.senozhatsky@gmail.com/T/#u


> This reverts commit 375899cddcbb26881b03cb3fbdcfd600e4e67f4a.
> 
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
