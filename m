Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BE0C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6092087A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fv1C3S/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6092087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeH2EoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:44:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45717 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725199AbeH2EoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:44:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4-v6so1509683pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 17:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zi+47oxGTI+zGyzfDQUObYZof1AovSeYSaA1wderdVI=;
        b=fv1C3S/2KrbhsU8umLNqxxtH5xmyQnQAXAypoB8XJk7Sb+hSfZqDWhA/1ULgBWEg1B
         mj+5A8X7/ejfqRBZY7AIejFQ6C53yBYvw40uHPW8RPap1VFYuOSoz+EYBJ/eZR4HBrb3
         /OFQESQLP7O35p70E5i2dt8zoA9WVcY5VW7Zybd66fyqc7EqFOd8sHPXOM/I0BLM+pjK
         h8HCbWAe88ZlSAgHO1PTCvxxh2QpV9PkUr674GQ+LrnxC6B1b4CjjfNdSMKDP7LkBo+R
         KZOv5vRbnUPgtAPkeSL6ygzOGixhsymZ+1NGXtff4iPv/YA+oq0rDjGGulbZS0Mf6qNl
         1A0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zi+47oxGTI+zGyzfDQUObYZof1AovSeYSaA1wderdVI=;
        b=swIdYBq/pj//8w7Aqm8JPpcCSqFiI8jfiFbCRsa9lm09PQb3zBhWqnG9KF4KBB5y8E
         wBpneId0AGw2lVqOSrgOi14sFySfWtNc/UERAYt48vBzgo2euXuhYKDtr5JVZh9+dRyc
         mN4faackrGA2VIWBCfDHJcEHmZ0ED6LcFA22/KeLCxn/h+EB/XJn6i3kkxCT1m3B5q/C
         iPSrU/tLWGnNiyrFRfQOULqE4uL288DegZl5u1dycxUHksTwGWyyDP3XjvKzbfX9POLI
         PqVmVXS1hA0sXp4aMtSmcnay/OMmkOybQUvJzxS91+ClW7XfqaWYWnUmrBJ5zByB1qmr
         ZJKA==
X-Gm-Message-State: APzg51AcGzF5Ch/WhvUFK2eLHNFOftUHyRjCSlRdf692fhxiEF2e1vFj
        EBcePg/VJ2Mbv0az2mKvVJGzggOF0tk=
X-Google-Smtp-Source: ANB0Vda8vm+3IvR5qvkxEtj5dWlIx5IHDomiB9Lu1nGoPZdjcCIM1OwFwqjQM2GVJG1hqDJocnL3dg==
X-Received: by 2002:a63:f206:: with SMTP id v6-v6mr3689570pgh.319.1535503797673;
        Tue, 28 Aug 2018 17:49:57 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id c68-v6sm4057974pfj.51.2018.08.28.17.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 17:49:56 -0700 (PDT)
Date:   Tue, 28 Aug 2018 17:49:56 -0700 (PDT)
X-Google-Original-Date: Tue, 28 Aug 2018 17:48:55 PDT (-0700)
Subject:     Re: [PATCH] riscv: Drop setup_initrd
In-Reply-To: <eee9cb69-6a3f-6a99-4e83-dbab3a8f5984@roeck-us.net>
CC:     schwab@linux-m68k.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux@roeck-us.net
Message-ID: <mhng-f20ef153-c2be-4ba8-bd1f-9e241281b18d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 17:36:28 PDT (-0700), linux@roeck-us.net wrote:
> On 08/28/2018 05:09 PM, Palmer Dabbelt wrote:
>> On Tue, 28 Aug 2018 15:12:38 PDT (-0700), linux@roeck-us.net wrote:
>>> On Tue, Aug 28, 2018 at 03:03:00PM -0700, Palmer Dabbelt wrote:
>>>> On Tue, 28 Aug 2018 14:59:59 PDT (-0700), linux@roeck-us.net wrote:
>>>> >On Tue, Aug 28, 2018 at 11:46:09PM +0200, Andreas Schwab wrote:
>>>> >>On Aug 28 2018, Guenter Roeck <linux@roeck-us.net> wrote:
>>>> >>
>>>> >>> On Tue, Aug 28, 2018 at 01:10:20PM -0700, Palmer Dabbelt wrote:
>>>> >>>> On Thu, 09 Aug 2018 21:11:40 PDT (-0700), linux@roeck-us.net wrote:
>>>> >>>> >setup_initrd() does not appear to serve a practical purpose other than
>>>> >>>> >preventing qemu boots with "-initrd" parameter, so let's drop it.
>>>> >>>> >
>>>> >>>> >Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> >>>> >---
>>>> >>>> > arch/riscv/kernel/setup.c | 39 ---------------------------------------
>>>> >>>> > 1 file changed, 39 deletions(-)
>>>> >>>> >
>>>> >>>> >diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>>> >>>> >index 2e56af3281f8..579f58a42974 100644
>>>> >>>> >--- a/arch/riscv/kernel/setup.c
>>>> >>>> >+++ b/arch/riscv/kernel/setup.c
>>>> >>>> >@@ -82,41 +82,6 @@ EXPORT_SYMBOL(empty_zero_page);
>>>> >>>> > /* The lucky hart to first increment this variable will boot the other cores */
>>>> >>>> > atomic_t hart_lottery;
>>>> >>>> >
>>>> >>>> >-#ifdef CONFIG_BLK_DEV_INITRD
>>>> >>>> >-static void __init setup_initrd(void)
>>>> >>>> >-{
>>>> >>>> >-    extern char __initramfs_start[];
>>>> >>>> >-    extern unsigned long __initramfs_size;
>>>> >>>> >-    unsigned long size;
>>>> >>>> >-
>>>> >>>> >-    if (__initramfs_size > 0) {
>>>> >>>> >-        initrd_start = (unsigned long)(&__initramfs_start);
>>>> >>>> >-        initrd_end = initrd_start + __initramfs_size;
>>>> >>>> >-    }
>>>> >>>
>>>> >>> The underlying problem is probably that __initramfs_size == 512 even
>>>> >>> if there is no embedded initrd. Result is that initrd_start and initrd_end
>>>> >>> are always overwritten, even if provided and even if there is no embedded
>>>> >>> initrd. Result is that initrd_start and initrd_end are always overwritten,
>>>> >>> and -initrd from the qemu command line is always ignored.
>>>> >>>
>>>> >>> A less invasive fix than mine would be
>>>> >>>
>>>> >>> -    if (__initramfs_size > 0) {
>>>> >>> +    if (__initramfs_size > 0 && !initrd_start) {
>>>> >>>
>>>> >>> Any chance you can test that with your setup ?
>>>> >>
>>>> >>You should just delete the last four lines above.  They serve no purpose.
>>>> >>
>>>> >
>>>> >You mean the entire if() statement plus the variable declarations ?
>>>> >
>>>> >That works for me, for both embedded initrd and initrd specified with
>>>> >-initrd option, but we still need someone to test if it works for
>>>> >Palmer's use case, ie with vmlinux (and possibly initrd) embedded in
>>>> >bbl.
>>>>
>>>> This still boots my Fedora images
>>>>
>>>>    diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>>>    index db20dc630e7e..aee603123030 100644
>>>>    --- a/arch/riscv/kernel/setup.c
>>>>    +++ b/arch/riscv/kernel/setup.c
>>>>    @@ -85,15 +85,8 @@ atomic_t hart_lottery;
>>>>     #ifdef CONFIG_BLK_DEV_INITRD
>>>>     static void __init setup_initrd(void)
>>>>     {
>>>>    -    extern char __initramfs_start[];
>>>>    -    extern unsigned long __initramfs_size;
>>>>         unsigned long size;
>>>>    -    if (__initramfs_size > 0) {
>>>>    -        initrd_start = (unsigned long)(&__initramfs_start);
>>>>    -        initrd_end = initrd_start + __initramfs_size;
>>>>    -    }
>>>>    -
>>>>         if (initrd_start >= initrd_end) {
>>>>             printk(KERN_INFO "initrd not found or empty");
>>>>             goto disable;
>>>>
>>>> but I have not tried an integrated initramfs.
>>>
>>> I tested the above both with external initrd and with integrated
>>> initramfs; both work for me.
>>>
>>> Should I resend my patch, using the above, or do you want to create
>>> a patch yourself ?
>>
>> You should send one, then it'll go through my regular pre-PR testing flow to make sure it works on my end.  I just never trust these inline patches to be exact, even if it's unlikely there's any confusion on a patch this simple (at least, mechanically simple -- I'm afraid I still don't understand why the logic is incorrect).
>>
>
> Done.
>
> There is no need to override initrd_start and initrd_end; populate_rootfs()
> uses __initramfs_start and __initramfs_size directly when loading a built-in
> initramfs. initrd_start and initrd_end, on the other side, are for an external
> initrd, loaded separately (and initialized in __early_init_dt_declare_initrd()).

OK, that makes sense.  I dropped your patch onto for-next, assuming nothing's 
gone wrong it should go in next week.  It boots a Fedora rootfs for me.

Thanks!
