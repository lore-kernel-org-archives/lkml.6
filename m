Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D2CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7232620659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2rnZ3XI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7232620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeIFMDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:03:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38729 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeIFMDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:03:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so4834862pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 00:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dbx56dCi3L7H51x5Sc712gHMJOuLiIs9bbvf5MYsWEI=;
        b=R2rnZ3XIGNA0y7MfPFXazgVeSUJBYkToxKG4h9k2e/xndSYCMgUNTR9TwRazrPg1CO
         eQEyS56ucKLus4BorxKB8bAp+x3nZq+IkvUG3F0BHt9CdMhcQ9DebvBtuP7ejJkp9PXy
         dUHyAQXb3rBtWC+CUHEXL1q5oySmA2sgMdqwidxtbqKHLYnw9T+vhaqe9VKpUwwKDTgA
         WIMo5P9SAv9IPCh2qzF6OtYRPg7ss/RDivaB8lyGNkKFMFv1bHk3T9/eV3p6VDEL4Pgx
         cg0QERPaDoPU8aOW82JF6KuytoAad8CDYQvy21L5kpaM7Vb9u3sqgxCmMIsTBuDzWu/z
         nX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dbx56dCi3L7H51x5Sc712gHMJOuLiIs9bbvf5MYsWEI=;
        b=snpcFah1c2fkrR+jMbSeQZOUAxWTfwyQHms4Ia4ysm96QWQOBwBz4nRxzLVIsMgM/h
         zjLCcvnSNwrnoWzaV/AMvJyXXHPETWDfJ1yzaTSzrQ6fsLp55d38FTzWftUNAP9MwFJA
         7Phw7EO8B0VLXnL9XFaEPPEEBXzkgZaqzkc+Mzx+lUUt5R9jxo3Lb2E22h98fkEVrL8H
         RILo976cH/ztDTA0U3rIhUie47epkIlfPj08OCP9iBf1f1M9jaOdHHJdIrbaVtX+5yXT
         IuKB9XB3LpOt6n6EwFQV4BZQokwptEwkU/j2dDGnMcFLn91HwDev1i08sNc4TEY9bbxm
         9XMw==
X-Gm-Message-State: APzg51D4DEJmIya7YVEbASl00r7nAfBta1ggUHi+9zph2/NwKE8X6vLj
        lfIq3uz6lYXPq0zigKraFRg=
X-Google-Smtp-Source: ANB0VdauFavNEizutbg2CJmcEM1H6h/SBX/SlXm44ZsWIVyJ117LU/8AYxSSs/mITJdC9VE9UByOIg==
X-Received: by 2002:a62:7e93:: with SMTP id z141-v6mr1555101pfc.14.1536218985698;
        Thu, 06 Sep 2018 00:29:45 -0700 (PDT)
Received: from localhost ([110.70.59.68])
        by smtp.gmail.com with ESMTPSA id y86-v6sm6014613pfk.84.2018.09.06.00.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 00:29:44 -0700 (PDT)
Date:   Thu, 6 Sep 2018 16:29:40 +0900
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
Message-ID: <20180906072940.GA382@jagdpanzerIV>
References: <20180904180154.845-1-hdegoede@redhat.com>
 <20180905023522.GA1444@jagdpanzerIV>
 <93901f2b-91ad-a910-7031-0040b827a3af@redhat.com>
 <20180905053609.GA19936@jagdpanzerIV>
 <20180905083326.GC19936@jagdpanzerIV>
 <20180905110207.rxy3upplgkjbk5oi@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905110207.rxy3upplgkjbk5oi@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/05/18 13:02), Petr Mladek wrote:
> Note that the first registered console prints all messages
> even without this flag.

Hmm, OK, interesting point.

I assumed that the first console usually has CON_PRINTBUFFER bit set.
Or even a CON_PRINTBUFFER | CON_ANYTIME combo. E.g. 8250. It sort of
makes sense to have CON_PRINTBUFFER for the first console. Any later
consoles [e.g. fbcon, netcon] don't necessarily have CON_PRINTBUFFER.

So by the time we have callable console "quite" param should be already
parsed [except the earlycon case perhaps]:

	kernel_init_freeable
	 do_one_initcall
	  register_console
happens after
	setup_arch
	 parse_early_param
	  quiet_kernel/debug_kernel.

And
	setup_arch
	 parse_early_param
	  quiet_kernel/debug_kernel
happens before
	console_init
	 con_init
	  register_console.

And the first console has CON_PRINTBUFFER bit set. Well, just because
it sounds reasonable. Those were the main assumptions behind my code
snippet. Was any of those assumptions wrong?

> I played with another solution, see the patch below. It defines
> which messages have a valid NOCONS flag according to the msg_seq
> number. IMHO, it is a bit more straightforward but it is still
> a hack. I am not super happy about it.

I just skimmed through it, and probably missed some parts. But I sort
of expected to see some console_valid_nocons_seq manipulations in
register_console(), when we register a new CON_PRINTBUFFER console
on already running system.

> Hmm, I seriously think about reverting the commit 375899cddcbb
> ("printk: make sure to print log on console.") and solving it
> another way.

I can agree, definitely. That's one of the options.

	-ss
