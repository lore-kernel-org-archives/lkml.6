Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64295C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033CD2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033CD2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeH2Bju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:39:50 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:55378 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeH2Bju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:39:50 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 420Ml73rhdz1qtdm;
        Tue, 28 Aug 2018 23:46:10 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 420Ml64xLwz1qqlF;
        Tue, 28 Aug 2018 23:46:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id dRrDImarXeHg; Tue, 28 Aug 2018 23:46:09 +0200 (CEST)
X-Auth-Info: vkGdbDEgOqmTzuM+9x8OUeVxIgF27j2cL7FvQ5qzyw3EnqqWaXT1JJXsOC2qtaOd
Received: from igel.home (ppp-188-174-153-80.dynamic.mnet-online.de [188.174.153.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 28 Aug 2018 23:46:09 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 3A5602C12DD; Tue, 28 Aug 2018 23:46:09 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Drop setup_initrd
References: <1533874300-17656-1-git-send-email-linux@roeck-us.net>
        <mhng-7faee2bb-ee3e-48d1-a016-782ebbbb903d@palmer-si-x1c4>
        <20180828212505.GA24238@roeck-us.net>
X-Yow:  ..  Like I always say -- nothing can beat the BRATWURST
 here in DUSSELDORF!!
Date:   Tue, 28 Aug 2018 23:46:09 +0200
In-Reply-To: <20180828212505.GA24238@roeck-us.net> (Guenter Roeck's message of
        "Tue, 28 Aug 2018 14:25:05 -0700")
Message-ID: <87mut6b1we.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 28 2018, Guenter Roeck <linux@roeck-us.net> wrote:

> On Tue, Aug 28, 2018 at 01:10:20PM -0700, Palmer Dabbelt wrote:
>> On Thu, 09 Aug 2018 21:11:40 PDT (-0700), linux@roeck-us.net wrote:
>> >setup_initrd() does not appear to serve a practical purpose other than
>> >preventing qemu boots with "-initrd" parameter, so let's drop it.
>> >
>> >Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> >---
>> > arch/riscv/kernel/setup.c | 39 ---------------------------------------
>> > 1 file changed, 39 deletions(-)
>> >
>> >diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> >index 2e56af3281f8..579f58a42974 100644
>> >--- a/arch/riscv/kernel/setup.c
>> >+++ b/arch/riscv/kernel/setup.c
>> >@@ -82,41 +82,6 @@ EXPORT_SYMBOL(empty_zero_page);
>> > /* The lucky hart to first increment this variable will boot the other cores */
>> > atomic_t hart_lottery;
>> >
>> >-#ifdef CONFIG_BLK_DEV_INITRD
>> >-static void __init setup_initrd(void)
>> >-{
>> >-	extern char __initramfs_start[];
>> >-	extern unsigned long __initramfs_size;
>> >-	unsigned long size;
>> >-
>> >-	if (__initramfs_size > 0) {
>> >-		initrd_start = (unsigned long)(&__initramfs_start);
>> >-		initrd_end = initrd_start + __initramfs_size;
>> >-	}
>
> The underlying problem is probably that __initramfs_size == 512 even
> if there is no embedded initrd. Result is that initrd_start and initrd_end
> are always overwritten, even if provided and even if there is no embedded
> initrd. Result is that initrd_start and initrd_end are always overwritten,
> and -initrd from the qemu command line is always ignored.
>
> A less invasive fix than mine would be
>
> -	if (__initramfs_size > 0) {
> +	if (__initramfs_size > 0 && !initrd_start) {
>
> Any chance you can test that with your setup ?

You should just delete the last four lines above.  They serve no purpose.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
