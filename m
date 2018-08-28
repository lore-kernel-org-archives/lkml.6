Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E991FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771202087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q8YBXjvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771202087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeH2B4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:56:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36783 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeH2B4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:56:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id e11-v6so1329202plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 15:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=GTP5TLiu8ZIK1B8aHd8RW/JzZjh7pWxb+c4C/CfSuNo=;
        b=Q8YBXjvcTNYq4oRu4X5Pa68zVU1qngFhGEK1gbcuniPZqGTKqloXvV/O6sK3YwOpDl
         NB/QFgL6VusDhhqChuYfa0myv98YyWsEPBdHAb9GFHHVZ13eIdYijnDjLPgHi+2qm2z+
         CZSP1nIdY+a3qd4AuxAiDCLTKxlO8SQ9nFBs8ic0qx3LaODAB1Xb2DhmNozBfiteSpGj
         uo/2FFi9fW4+kya5k+rbZqS4bvUR0JmruXhZshK/VrS4VjBPeu7PAOD4E/R+0u13i30e
         E4D+t2fF2fv07hBrWhBhyEMzSRlMf5Q9ftGd+Lwyv/nEwcJwHWwDX+SUumzAzNbRUN+m
         /oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=GTP5TLiu8ZIK1B8aHd8RW/JzZjh7pWxb+c4C/CfSuNo=;
        b=TRcRtX/DOgjV0HngcADfDRduN0OWJlUykMxADiS1N22Mou2zCKx6DC9VmQQRTRnmKt
         rH+HGCaCwDDk8FWbUbJT8ynjMxzZz4yGzelGTQqEwAJLoiLj3553+irk1kWe6X7VleBU
         prl9iGNl7Mn/Bn62hr4Ho7yOiL0yf+sWkbHpjxZ7XxHpgdm4lpnkhClVMEHB4wjNwXWc
         KeaiLWuaw5RyYtIEx2JHTtMseQxTa+ZTFgPtBxvdGT8tOO9/Zil3uEQWGpiy/SvX1C/l
         oPv1LXWdCLA8KZTIF4aLD9AzUSLeyy7vOv7cIX9Y1G2RerQO/6bDuFTq4Lbx9rg2B2J7
         7NRA==
X-Gm-Message-State: APzg51D7MkuH2fDQ7fnGEitWXWeaEEND+80IGIQOcWHoktq+JLY7l/oo
        b7TwXwcjfjkdze+f7wVEUmLRRg==
X-Google-Smtp-Source: ANB0VdY4v3/joZLdaHtdabYuqwN/7vT05Xho2MiuOd+Sw/314cKzmEdPQBamTF3KdGq8eR3aj7hOdA==
X-Received: by 2002:a17:902:1a2:: with SMTP id b31-v6mr3143131plb.279.1535493781650;
        Tue, 28 Aug 2018 15:03:01 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id t15-v6sm3695527pfa.158.2018.08.28.15.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 15:03:00 -0700 (PDT)
Date:   Tue, 28 Aug 2018 15:03:00 -0700 (PDT)
X-Google-Original-Date: Tue, 28 Aug 2018 15:02:59 PDT (-0700)
Subject:     Re: [PATCH] riscv: Drop setup_initrd
In-Reply-To: <20180828215959.GA6279@roeck-us.net>
CC:     schwab@linux-m68k.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux@roeck-us.net
Message-ID: <mhng-a243b527-2a6a-4d0c-994a-472e26cfc1d4@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 14:59:59 PDT (-0700), linux@roeck-us.net wrote:
> On Tue, Aug 28, 2018 at 11:46:09PM +0200, Andreas Schwab wrote:
>> On Aug 28 2018, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> > On Tue, Aug 28, 2018 at 01:10:20PM -0700, Palmer Dabbelt wrote:
>> >> On Thu, 09 Aug 2018 21:11:40 PDT (-0700), linux@roeck-us.net wrote:
>> >> >setup_initrd() does not appear to serve a practical purpose other than
>> >> >preventing qemu boots with "-initrd" parameter, so let's drop it.
>> >> >
>> >> >Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> >> >---
>> >> > arch/riscv/kernel/setup.c | 39 ---------------------------------------
>> >> > 1 file changed, 39 deletions(-)
>> >> >
>> >> >diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> >> >index 2e56af3281f8..579f58a42974 100644
>> >> >--- a/arch/riscv/kernel/setup.c
>> >> >+++ b/arch/riscv/kernel/setup.c
>> >> >@@ -82,41 +82,6 @@ EXPORT_SYMBOL(empty_zero_page);
>> >> > /* The lucky hart to first increment this variable will boot the other cores */
>> >> > atomic_t hart_lottery;
>> >> >
>> >> >-#ifdef CONFIG_BLK_DEV_INITRD
>> >> >-static void __init setup_initrd(void)
>> >> >-{
>> >> >-	extern char __initramfs_start[];
>> >> >-	extern unsigned long __initramfs_size;
>> >> >-	unsigned long size;
>> >> >-
>> >> >-	if (__initramfs_size > 0) {
>> >> >-		initrd_start = (unsigned long)(&__initramfs_start);
>> >> >-		initrd_end = initrd_start + __initramfs_size;
>> >> >-	}
>> >
>> > The underlying problem is probably that __initramfs_size == 512 even
>> > if there is no embedded initrd. Result is that initrd_start and initrd_end
>> > are always overwritten, even if provided and even if there is no embedded
>> > initrd. Result is that initrd_start and initrd_end are always overwritten,
>> > and -initrd from the qemu command line is always ignored.
>> >
>> > A less invasive fix than mine would be
>> >
>> > -	if (__initramfs_size > 0) {
>> > +	if (__initramfs_size > 0 && !initrd_start) {
>> >
>> > Any chance you can test that with your setup ?
>>
>> You should just delete the last four lines above.  They serve no purpose.
>>
>
> You mean the entire if() statement plus the variable declarations ?
>
> That works for me, for both embedded initrd and initrd specified with
> -initrd option, but we still need someone to test if it works for
> Palmer's use case, ie with vmlinux (and possibly initrd) embedded in
> bbl.

This still boots my Fedora images

    diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
    index db20dc630e7e..aee603123030 100644
    --- a/arch/riscv/kernel/setup.c
    +++ b/arch/riscv/kernel/setup.c
    @@ -85,15 +85,8 @@ atomic_t hart_lottery;
     #ifdef CONFIG_BLK_DEV_INITRD
     static void __init setup_initrd(void)
     {
    -	extern char __initramfs_start[];
    -	extern unsigned long __initramfs_size;
     	unsigned long size;
     
    -	if (__initramfs_size > 0) {
    -		initrd_start = (unsigned long)(&__initramfs_start);
    -		initrd_end = initrd_start + __initramfs_size;
    -	}
    -
     	if (initrd_start >= initrd_end) {
     		printk(KERN_INFO "initrd not found or empty");
     		goto disable;

but I have not tried an integrated initramfs.
