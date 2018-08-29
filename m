Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E43C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E63E20880
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZdcsLhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E63E20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeH2Eal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:30:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35645 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeH2Eal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:30:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id d9-v6so1484606plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 17:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ay9bDyKlNjZrWsTsR1hDpWLNRDF5FYCNhB6nNM5kTlA=;
        b=sZdcsLhJQD4c8hHtjlnz/Y7YXIu81iMkyIl/X1/Is0YOO4oEYzPWwSO1vd/4T2sDI/
         YK1PiPPZABDACDElBv2bdkwb7KhAQnmr6lPEqWnyJ46e2Vd6KKi7G/1R8zNyoklrLqKi
         UGLXeRl4Sp1N4YcgzWl9QTmBa4pWsG1FWlM+kL+buu49cYC+WR7X4EM4BZYx+OR1iTIa
         PN2ubwL0ODDTSDB7UZZVG6414nRQ66NwOOQz5tMcPOxFk+1i2vpf29PhYjcRlwViirPb
         zGmq0IEOgcQCwSei/nQLQroFrFsfmbMyOpZzw4gaRJWDRc/bJu7WB7A0fVxNmuBy8gBi
         i6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ay9bDyKlNjZrWsTsR1hDpWLNRDF5FYCNhB6nNM5kTlA=;
        b=VwPFHT50gUt+OgyVpkKWCrchAyccoVNqmp2EsBTmq/Crw0zeCvaD/FJHqa6eYC+8wF
         Sf/xG9vhOxqVo67QdTbQ21erYLKcfGc5o6gnUvtthsvJHlcGf4zyeSj4Q05rq5tefx6a
         3K6CKkIxOgc3RVYEGxWqQxFMksz9N/+shgPkLIqbW3/+mXLMsFXokbemrFcgwVtwNsWA
         XqdLrkbCAzefnMAOTk1w7xqnUw2KurFQ3s2mgIc3DcaXjvTZE54LwZS83eH+0UpAu52N
         ERJ/9jiN0YZKmz86qh+EazLfY84u6jbvYLXk9Qqk6R/SpdQgNxJvkb+p3lDIL7tYbKoy
         viFw==
X-Gm-Message-State: APzg51DuWxQIAD1+W/8ElIlsLgJGEvQ+rRCOOtfkRz5K7nCK4CtagjXR
        hjRPbZAxDug4p3E3rPV0dy40sg3l
X-Google-Smtp-Source: ANB0VdZIzHO9vK4lJ58LVlhW+9BfMYjLxDpGDqy3OAUOXgISIEmfvS8JihCtN9jyu6h10O1veVQzgw==
X-Received: by 2002:a17:902:187:: with SMTP id b7-v6mr3690848plb.269.1535502989690;
        Tue, 28 Aug 2018 17:36:29 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z11-v6sm5152931pgz.62.2018.08.28.17.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 17:36:29 -0700 (PDT)
Subject: Re: [PATCH] riscv: Drop setup_initrd
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     schwab@linux-m68k.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-fadb4889-1082-4cef-a4a6-8faf828c4528@palmer-si-x1c4>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <eee9cb69-6a3f-6a99-4e83-dbab3a8f5984@roeck-us.net>
Date:   Tue, 28 Aug 2018 17:36:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <mhng-fadb4889-1082-4cef-a4a6-8faf828c4528@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 05:09 PM, Palmer Dabbelt wrote:
> On Tue, 28 Aug 2018 15:12:38 PDT (-0700), linux@roeck-us.net wrote:
>> On Tue, Aug 28, 2018 at 03:03:00PM -0700, Palmer Dabbelt wrote:
>>> On Tue, 28 Aug 2018 14:59:59 PDT (-0700), linux@roeck-us.net wrote:
>>> >On Tue, Aug 28, 2018 at 11:46:09PM +0200, Andreas Schwab wrote:
>>> >>On Aug 28 2018, Guenter Roeck <linux@roeck-us.net> wrote:
>>> >>
>>> >>> On Tue, Aug 28, 2018 at 01:10:20PM -0700, Palmer Dabbelt wrote:
>>> >>>> On Thu, 09 Aug 2018 21:11:40 PDT (-0700), linux@roeck-us.net wrote:
>>> >>>> >setup_initrd() does not appear to serve a practical purpose other than
>>> >>>> >preventing qemu boots with "-initrd" parameter, so let's drop it.
>>> >>>> >
>>> >>>> >Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> >>>> >---
>>> >>>> > arch/riscv/kernel/setup.c | 39 ---------------------------------------
>>> >>>> > 1 file changed, 39 deletions(-)
>>> >>>> >
>>> >>>> >diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>> >>>> >index 2e56af3281f8..579f58a42974 100644
>>> >>>> >--- a/arch/riscv/kernel/setup.c
>>> >>>> >+++ b/arch/riscv/kernel/setup.c
>>> >>>> >@@ -82,41 +82,6 @@ EXPORT_SYMBOL(empty_zero_page);
>>> >>>> > /* The lucky hart to first increment this variable will boot the other cores */
>>> >>>> > atomic_t hart_lottery;
>>> >>>> >
>>> >>>> >-#ifdef CONFIG_BLK_DEV_INITRD
>>> >>>> >-static void __init setup_initrd(void)
>>> >>>> >-{
>>> >>>> >-    extern char __initramfs_start[];
>>> >>>> >-    extern unsigned long __initramfs_size;
>>> >>>> >-    unsigned long size;
>>> >>>> >-
>>> >>>> >-    if (__initramfs_size > 0) {
>>> >>>> >-        initrd_start = (unsigned long)(&__initramfs_start);
>>> >>>> >-        initrd_end = initrd_start + __initramfs_size;
>>> >>>> >-    }
>>> >>>
>>> >>> The underlying problem is probably that __initramfs_size == 512 even
>>> >>> if there is no embedded initrd. Result is that initrd_start and initrd_end
>>> >>> are always overwritten, even if provided and even if there is no embedded
>>> >>> initrd. Result is that initrd_start and initrd_end are always overwritten,
>>> >>> and -initrd from the qemu command line is always ignored.
>>> >>>
>>> >>> A less invasive fix than mine would be
>>> >>>
>>> >>> -    if (__initramfs_size > 0) {
>>> >>> +    if (__initramfs_size > 0 && !initrd_start) {
>>> >>>
>>> >>> Any chance you can test that with your setup ?
>>> >>
>>> >>You should just delete the last four lines above.  They serve no purpose.
>>> >>
>>> >
>>> >You mean the entire if() statement plus the variable declarations ?
>>> >
>>> >That works for me, for both embedded initrd and initrd specified with
>>> >-initrd option, but we still need someone to test if it works for
>>> >Palmer's use case, ie with vmlinux (and possibly initrd) embedded in
>>> >bbl.
>>>
>>> This still boots my Fedora images
>>>
>>>    diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>>    index db20dc630e7e..aee603123030 100644
>>>    --- a/arch/riscv/kernel/setup.c
>>>    +++ b/arch/riscv/kernel/setup.c
>>>    @@ -85,15 +85,8 @@ atomic_t hart_lottery;
>>>     #ifdef CONFIG_BLK_DEV_INITRD
>>>     static void __init setup_initrd(void)
>>>     {
>>>    -    extern char __initramfs_start[];
>>>    -    extern unsigned long __initramfs_size;
>>>         unsigned long size;
>>>    -    if (__initramfs_size > 0) {
>>>    -        initrd_start = (unsigned long)(&__initramfs_start);
>>>    -        initrd_end = initrd_start + __initramfs_size;
>>>    -    }
>>>    -
>>>         if (initrd_start >= initrd_end) {
>>>             printk(KERN_INFO "initrd not found or empty");
>>>             goto disable;
>>>
>>> but I have not tried an integrated initramfs.
>>
>> I tested the above both with external initrd and with integrated
>> initramfs; both work for me.
>>
>> Should I resend my patch, using the above, or do you want to create
>> a patch yourself ?
> 
> You should send one, then it'll go through my regular pre-PR testing flow to make sure it works on my end.  I just never trust these inline patches to be exact, even if it's unlikely there's any confusion on a patch this simple (at least, mechanically simple -- I'm afraid I still don't understand why the logic is incorrect).
> 

Done.

There is no need to override initrd_start and initrd_end; populate_rootfs()
uses __initramfs_start and __initramfs_size directly when loading a built-in
initramfs. initrd_start and initrd_end, on the other side, are for an external
initrd, loaded separately (and initialized in __early_init_dt_declare_initrd()).

Hope this helps,
Guenter
