Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86526C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2549A20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtLjynfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2549A20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbeIMHch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:32:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44206 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeIMHch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:32:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id ba4-v6so1866339plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 19:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Kmv67edTIACeVNGQqutw8YLxCdC2K1VWkBDYYF6aoo=;
        b=GtLjynfjQTBoVUGEmAW3oFaGI51rxp+JCFtzH1bSx8Q0zuvOSdTZTW+hKdS7kjDwBl
         MriF2cplR9P2KAD69nQBurxsOF4Fq6k5+2MBuQE86tgVFEHDMeD5VwrDpuBcVrd5cxCy
         tgKux5APgG7XpJc0p1yiuln4HlTD8PxkV2Oc0ANOw1KAhSxJiuYm18Wbl3PkHLMZLYNP
         Jh22ua/HULjVAFrf8ahFOIXR08R39SQWgIkRddky91Txw77GX8d98R9AUxSK8E/3Cblt
         EHBozd5i+LFgC028R9dfg5IN5I6Xn+OdGarwD3e6npdEe12f9F5yf/AOP9B49k5rqIXh
         i9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Kmv67edTIACeVNGQqutw8YLxCdC2K1VWkBDYYF6aoo=;
        b=dB/szhyeGJU/5gyd/ps4/EmkPBv4eGAJJgtRFEdUAZMohJeecERRARrzykpNfd1hjF
         I02reVNh8sZ0RegsBu0uayIC5cm134aPRjnj/5+oGB6zTAjNlqDdOzq5AnPfx+ZxtLhk
         WC61OsRLpTtKN/Xy6G+J9YpJnCEw17oqysCmI47cUyOj0fTJ5vjyv+vRMNzYvAuE9YZs
         LxW6GBTNZFLn2IFAljwiKtwNHJTbl3tWGy6aTGj0Kba67zSoe2rz8swBhjNDvbRxALy3
         mwtLMyvHC5aP1WfiHYLGJVqKhhbTs+Rz5BcyBeducdvxBhZSiab12GxrBxu6f0D3yxmv
         wZig==
X-Gm-Message-State: APzg51AoKsB92gMjkXKMP9Nj+pcqyYcthuog1Z1gWil9fpMc6NiPFthq
        TTEykB4V6dfmsvK2JQp8VGM=
X-Google-Smtp-Source: ANB0VdYP5fLXKlielIWBlpdILr3jycAWcvahCbyonOyAgSNwIHI/gSpvBza2dq8nSzMs2djNPYs4Fw==
X-Received: by 2002:a17:902:2f84:: with SMTP id t4-v6mr5061460plb.87.1536805517260;
        Wed, 12 Sep 2018 19:25:17 -0700 (PDT)
Received: from localhost ([175.223.16.57])
        by smtp.gmail.com with ESMTPSA id z63-v6sm2939541pgd.69.2018.09.12.19.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 19:25:15 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:25:12 +0900
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
Message-ID: <20180913022512.GA24488@jagdpanzerIV>
References: <20180905083326.GC19936@jagdpanzerIV>
 <20180905110207.rxy3upplgkjbk5oi@pathway.suse.cz>
 <20180906072940.GA382@jagdpanzerIV>
 <20180906142825.u2fiqt62jmapr5ud@pathway.suse.cz>
 <20180907042132.GC2394@jagdpanzerIV>
 <20180910145747.emvfzv4mzlk5dfqk@pathway.suse.cz>
 <20180911023039.GA4065@jagdpanzerIV>
 <20180911084722.22fqbewiebzsdofm@pathway.suse.cz>
 <20180912074930.GA470@jagdpanzerIV>
 <20180912133347.23ulng4njaa3uzsa@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912133347.23ulng4njaa3uzsa@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/12/18 15:33), Petr Mladek wrote:
> >  	console_trylock();
> >  	console_may_schedule = 0;
> > +	if (exclusive_console) {
> > +		exclusive_console = NULL;
> > +		console_seq = rollback_console_seq;
> 
> This might be controversial. Yes, it might help in some situations
> (slow exclusive console). But it might be counterproductive
> when the exclusive console is the one that is readable
> after the crash, used for debugging and this change causes
> an incomplete log.

Well, OK. We still print oops messages, just get to this point sooner.

> I would do this change only when people complains about
> the current behavior.

OK. Agreed.

> I think that more important is to do:
[..]
> IMHO, this is a clear win. It fixes a clear mistake.
> 
> I would just rename the variable to exclusive_console_seq_stop or so.

OK. Send a patch.

Reported-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>


	-ss
