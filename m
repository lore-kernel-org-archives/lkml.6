Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989A9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2563020835
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6a1lshE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2563020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeH2Bxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:53:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43905 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH2Bxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:53:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id v66-v6so1348429pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9XrLbb6tmalPVT45yux6sPLcBQjpkAuvKpcSsE2gIo8=;
        b=O6a1lshEB6SbQBIqx8krXBSEDfsDHysVJcp5HLzhs7KL3s/YOOdh8ZENsOEcg7hR9I
         WilEF7ySpLkjz3l7ZPFsTtNtN1artDX6NzQqKZdF+Ag+YoHIonzKK1a2yFdk9kRATpuH
         tNQoQLmmo5rDN31nhA5mjbu1EzGbKrVR9Yb91qcCswzE8FLklffn2frInBRbsmfUNDdI
         IfqLx+T8T88nf4XdElqv8CvEWqfD6J1e4oVQPze8+Th+BF7zaHxcqlpnUGY+9/w+BIV7
         QRDntu9kDZ3+6YqMMQ70Xi1r3zoUf9zI57w9t1LoOCXlY6FT48HStI6IPKCD4i+OpEiU
         J0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9XrLbb6tmalPVT45yux6sPLcBQjpkAuvKpcSsE2gIo8=;
        b=aGH3kIjhCRRfF/NKSM2Na/bIERc1V+JlN5iBkFETvXCqlQ3U1qGYkqFc1paXMk6cEc
         qsbhQ9oyYZ0wT9GlQkUPscCRQoIPRgT2psqS5cYw9wSrukpKVzpW+nOB7ugvrRUUSvtc
         rjY/dgazZnqlxui923wOH9rPEoW/eo18JjfBzN+hM4xdA8y/Bbk+qjHhAnOW7yCb+DFm
         cYGmsOAS5QnRICNJgHamW5aH2tejdtNLggssDAnXHHv6VWbc1M/nZorCgFjiv0LjP/Fn
         TShJDvkMa8AcGRXISi0kGLuurwVojRaXWk6qqsw2bcKNgOL1CH8G/yZK70o3WbLP4uLt
         dMnA==
X-Gm-Message-State: APzg51AekQP7hs5nycqTMndpFVXTbbXrJSr1zv+DEK6cLYDjpsCe13G4
        3D6agxjgBeWCTvISDY4VmsY=
X-Google-Smtp-Source: ANB0VdYrB75rpWqfqTbJS7nnXD29fENd69nysWjlj0pHkZsxvSpH6Tm+xaLD+sHPhvDtKk5o55zL5w==
X-Received: by 2002:a63:d002:: with SMTP id z2-v6mr3252351pgf.262.1535493602149;
        Tue, 28 Aug 2018 15:00:02 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h190-v6sm8582183pge.18.2018.08.28.15.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 15:00:01 -0700 (PDT)
Date:   Tue, 28 Aug 2018 14:59:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Drop setup_initrd
Message-ID: <20180828215959.GA6279@roeck-us.net>
References: <1533874300-17656-1-git-send-email-linux@roeck-us.net>
 <mhng-7faee2bb-ee3e-48d1-a016-782ebbbb903d@palmer-si-x1c4>
 <20180828212505.GA24238@roeck-us.net>
 <87mut6b1we.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mut6b1we.fsf@igel.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 11:46:09PM +0200, Andreas Schwab wrote:
> On Aug 28 2018, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Tue, Aug 28, 2018 at 01:10:20PM -0700, Palmer Dabbelt wrote:
> >> On Thu, 09 Aug 2018 21:11:40 PDT (-0700), linux@roeck-us.net wrote:
> >> >setup_initrd() does not appear to serve a practical purpose other than
> >> >preventing qemu boots with "-initrd" parameter, so let's drop it.
> >> >
> >> >Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> >---
> >> > arch/riscv/kernel/setup.c | 39 ---------------------------------------
> >> > 1 file changed, 39 deletions(-)
> >> >
> >> >diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> >> >index 2e56af3281f8..579f58a42974 100644
> >> >--- a/arch/riscv/kernel/setup.c
> >> >+++ b/arch/riscv/kernel/setup.c
> >> >@@ -82,41 +82,6 @@ EXPORT_SYMBOL(empty_zero_page);
> >> > /* The lucky hart to first increment this variable will boot the other cores */
> >> > atomic_t hart_lottery;
> >> >
> >> >-#ifdef CONFIG_BLK_DEV_INITRD
> >> >-static void __init setup_initrd(void)
> >> >-{
> >> >-	extern char __initramfs_start[];
> >> >-	extern unsigned long __initramfs_size;
> >> >-	unsigned long size;
> >> >-
> >> >-	if (__initramfs_size > 0) {
> >> >-		initrd_start = (unsigned long)(&__initramfs_start);
> >> >-		initrd_end = initrd_start + __initramfs_size;
> >> >-	}
> >
> > The underlying problem is probably that __initramfs_size == 512 even
> > if there is no embedded initrd. Result is that initrd_start and initrd_end
> > are always overwritten, even if provided and even if there is no embedded
> > initrd. Result is that initrd_start and initrd_end are always overwritten,
> > and -initrd from the qemu command line is always ignored.
> >
> > A less invasive fix than mine would be
> >
> > -	if (__initramfs_size > 0) {
> > +	if (__initramfs_size > 0 && !initrd_start) {
> >
> > Any chance you can test that with your setup ?
> 
> You should just delete the last four lines above.  They serve no purpose.
> 

You mean the entire if() statement plus the variable declarations ?

That works for me, for both embedded initrd and initrd specified with
-initrd option, but we still need someone to test if it works for 
Palmer's use case, ie with vmlinux (and possibly initrd) embedded in
bbl.

Thanks,
Guenter

> Andreas.
> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
