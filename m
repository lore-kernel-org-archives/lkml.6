Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3B4C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6142083B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBMO3TwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6142083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeH2CGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:06:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41125 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH2CGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:06:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id s15-v6so1367405pgv.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 15:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6EmbRKvWlWNXGdvcmmItNgpvvKWAu3AhxpsYuEWiNLs=;
        b=EBMO3TwKOhuWBr3KlMg5H0Im8+bisw50fQwdA0ylNVMtdFVBzPzvXhsNnnE6BFVmsi
         U/v1RG6Hj7YrYQA+KiF6ecKYhQufPopCSatCdmr1ksFa2oMhuJkALfH1H3UhBQPMpt+J
         A6fEaAoMrHBCHppEQQERPg02sxxrPn3/63eEkAgMV4tFdQ1gfL/hapYsrgzcrMpVcurf
         MAxY3CyGDlmO+s97DSVhMNEiUEhih1yo2TwzlpTFUcj73tQf1CyWTbTs4L3kE1OzRToL
         ZvZ1OTVBj2KUCb4XCMAS/I/nZUfJVm+hd8YXh8VFYRk8PqH/wybtlSCWm88Aw+WzIV5m
         1oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6EmbRKvWlWNXGdvcmmItNgpvvKWAu3AhxpsYuEWiNLs=;
        b=YpiGLsvqva2G0Ezl7U0SRzkXQKOOpbDfG7prYJYoEIQ3AJivGWB5gndS779v4YV/sU
         51Sq31u6ASnXHcUx8VGT0cuHr457PCC+4GjzJND0OEmQ+wZhcMB8Rq56IXhy2I8v3Nc5
         w1Rhrbqo24sKDKvHMZ/pKlaMYteicJXQIQuRkZQ2cwNL9bswI5f/DI83sXYSwp2HFGfE
         pCXm2XWdtdWw93n+c0ArkVPogReMoldGxE1hTlGrwTTi5tay7vsTRYnaSul1jeckyOCC
         YJmKMZ47wdDpRmyzEXrOXJHQ6Ep63jdc/dNWjEvYsZEngidacpZoKql4C/uLeDP9idtE
         3Obg==
X-Gm-Message-State: APzg51D6PpzsR7jLPykgGqZPbEbeYgitwej74nPM5MvB4kER+67zoInf
        MYm0vX6FkANQ0C5+t1K7+zw=
X-Google-Smtp-Source: ANB0VdZEeL+9ad0Emrg3Xb5aUXQcIhjB4N9EIaKkeXil5wzVKNamFPTtNcmy9EuYvuS2PQe8IHW6jg==
X-Received: by 2002:a63:2d84:: with SMTP id t126-v6mr1478155pgt.128.1535494359935;
        Tue, 28 Aug 2018 15:12:39 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g6-v6sm3370418pfb.11.2018.08.28.15.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 15:12:39 -0700 (PDT)
Date:   Tue, 28 Aug 2018 15:12:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     schwab@linux-m68k.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Drop setup_initrd
Message-ID: <20180828221238.GA6605@roeck-us.net>
References: <20180828215959.GA6279@roeck-us.net>
 <mhng-a243b527-2a6a-4d0c-994a-472e26cfc1d4@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-a243b527-2a6a-4d0c-994a-472e26cfc1d4@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 03:03:00PM -0700, Palmer Dabbelt wrote:
> On Tue, 28 Aug 2018 14:59:59 PDT (-0700), linux@roeck-us.net wrote:
> >On Tue, Aug 28, 2018 at 11:46:09PM +0200, Andreas Schwab wrote:
> >>On Aug 28 2018, Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >>> On Tue, Aug 28, 2018 at 01:10:20PM -0700, Palmer Dabbelt wrote:
> >>>> On Thu, 09 Aug 2018 21:11:40 PDT (-0700), linux@roeck-us.net wrote:
> >>>> >setup_initrd() does not appear to serve a practical purpose other than
> >>>> >preventing qemu boots with "-initrd" parameter, so let's drop it.
> >>>> >
> >>>> >Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >>>> >---
> >>>> > arch/riscv/kernel/setup.c | 39 ---------------------------------------
> >>>> > 1 file changed, 39 deletions(-)
> >>>> >
> >>>> >diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> >>>> >index 2e56af3281f8..579f58a42974 100644
> >>>> >--- a/arch/riscv/kernel/setup.c
> >>>> >+++ b/arch/riscv/kernel/setup.c
> >>>> >@@ -82,41 +82,6 @@ EXPORT_SYMBOL(empty_zero_page);
> >>>> > /* The lucky hart to first increment this variable will boot the other cores */
> >>>> > atomic_t hart_lottery;
> >>>> >
> >>>> >-#ifdef CONFIG_BLK_DEV_INITRD
> >>>> >-static void __init setup_initrd(void)
> >>>> >-{
> >>>> >-	extern char __initramfs_start[];
> >>>> >-	extern unsigned long __initramfs_size;
> >>>> >-	unsigned long size;
> >>>> >-
> >>>> >-	if (__initramfs_size > 0) {
> >>>> >-		initrd_start = (unsigned long)(&__initramfs_start);
> >>>> >-		initrd_end = initrd_start + __initramfs_size;
> >>>> >-	}
> >>>
> >>> The underlying problem is probably that __initramfs_size == 512 even
> >>> if there is no embedded initrd. Result is that initrd_start and initrd_end
> >>> are always overwritten, even if provided and even if there is no embedded
> >>> initrd. Result is that initrd_start and initrd_end are always overwritten,
> >>> and -initrd from the qemu command line is always ignored.
> >>>
> >>> A less invasive fix than mine would be
> >>>
> >>> -	if (__initramfs_size > 0) {
> >>> +	if (__initramfs_size > 0 && !initrd_start) {
> >>>
> >>> Any chance you can test that with your setup ?
> >>
> >>You should just delete the last four lines above.  They serve no purpose.
> >>
> >
> >You mean the entire if() statement plus the variable declarations ?
> >
> >That works for me, for both embedded initrd and initrd specified with
> >-initrd option, but we still need someone to test if it works for
> >Palmer's use case, ie with vmlinux (and possibly initrd) embedded in
> >bbl.
> 
> This still boots my Fedora images
> 
>    diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>    index db20dc630e7e..aee603123030 100644
>    --- a/arch/riscv/kernel/setup.c
>    +++ b/arch/riscv/kernel/setup.c
>    @@ -85,15 +85,8 @@ atomic_t hart_lottery;
>     #ifdef CONFIG_BLK_DEV_INITRD
>     static void __init setup_initrd(void)
>     {
>    -	extern char __initramfs_start[];
>    -	extern unsigned long __initramfs_size;
>     	unsigned long size;
>    -	if (__initramfs_size > 0) {
>    -		initrd_start = (unsigned long)(&__initramfs_start);
>    -		initrd_end = initrd_start + __initramfs_size;
>    -	}
>    -
>     	if (initrd_start >= initrd_end) {
>     		printk(KERN_INFO "initrd not found or empty");
>     		goto disable;
> 
> but I have not tried an integrated initramfs.

I tested the above both with external initrd and with integrated
initramfs; both work for me.

Should I resend my patch, using the above, or do you want to create
a patch yourself ?

Thanks,
Guenter
