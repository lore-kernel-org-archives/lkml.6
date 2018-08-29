Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99D9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7209F20880
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IjCbo/oz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7209F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeH2EDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:03:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36424 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeH2EDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:03:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so1489242pgo.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 17:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qfmDzD2PzYhUVNGYhzDe3ODRdlx8C58B7FMKXUpotgQ=;
        b=IjCbo/ozNMbPMfj4oDwE4GXzpdT3uam9irZETd8U1OxpeRleoSpdyYPi/omCb9WkH0
         sLugz1qi4u2SDpawhRBT26rp/JyMT6+5+c9GRZ1ZnFXG2ncGXlXoqRvFR/cIs1oeEY79
         VV14h3Vpf5vBj50C1GUn8dJGJXSYk6a1tmY66lpz8+M2QSid3ZIV6leMITUkiKsY9r1F
         p6Rl2PIxMwxXKVTVuaGKqZoXFu1HTvdkaBgS/+Xn7H8zjg7yF5Nr2T09qadc3eThmKlX
         O9BMzWh5jU+uAj0jqVwMPgp0qsSeIArSeemdYWCXUxiYgGsyDbEDxsc2aIQullaEj9fw
         X3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qfmDzD2PzYhUVNGYhzDe3ODRdlx8C58B7FMKXUpotgQ=;
        b=DL7748NZRrQi+lkjM73H2Rm2MdxIMkruq52pxQPnMbqF2v9KDS8bhkPHLb8XvkVyHJ
         e7rftwhs/gQAVQECzAZvo4v5puzdO5i1GTztla6Tbi2gAoHFag/IDbEzx5nrAasINw4P
         3S7ftgxSjqnJGkuj0kM0klU/T2XwcpODzG4Q74ym4LuW/Q2bVKNCjDP6xRzL38SyGRv9
         Zl8aURfrPcpKF8KM7TW2PrU98Jf5/Y1kJqhfru1mFCHpX0IL2dC/kR3RJEFSw+MvL29l
         zOoMRWP2AHQy+Ys0TcyJjT6D0YtxbWoBKpAZmdgpuJ+faPG0d2+K8dsfWQEId9mmVIVd
         afPA==
X-Gm-Message-State: APzg51BZ+AtAq2ytz686Nswxi2hcXtbpWK2/xPEFhVzpEZhQBPeP3AH7
        J2lc7kPpgRyeEj7DsmyIqsRdmQ==
X-Google-Smtp-Source: ANB0VdajgBRjiYNS2uMqBbPPbOmbhk4kpuXqxQeXCHGluhWvye3PGRn/ERpXuTlQI/GS+XmZkp6MSg==
X-Received: by 2002:a62:c60e:: with SMTP id m14-v6mr3520650pfg.40.1535501345131;
        Tue, 28 Aug 2018 17:09:05 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m15-v6sm3419571pfj.171.2018.08.28.17.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 17:09:04 -0700 (PDT)
Date:   Tue, 28 Aug 2018 17:09:04 -0700 (PDT)
X-Google-Original-Date: Tue, 28 Aug 2018 17:09:02 PDT (-0700)
Subject:     Re: [PATCH] riscv: Drop setup_initrd
In-Reply-To: <20180828221238.GA6605@roeck-us.net>
CC:     schwab@linux-m68k.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux@roeck-us.net
Message-ID: <mhng-fadb4889-1082-4cef-a4a6-8faf828c4528@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 15:12:38 PDT (-0700), linux@roeck-us.net wrote:
> On Tue, Aug 28, 2018 at 03:03:00PM -0700, Palmer Dabbelt wrote:
>> On Tue, 28 Aug 2018 14:59:59 PDT (-0700), linux@roeck-us.net wrote:
>> >On Tue, Aug 28, 2018 at 11:46:09PM +0200, Andreas Schwab wrote:
>> >>On Aug 28 2018, Guenter Roeck <linux@roeck-us.net> wrote:
>> >>
>> >>> On Tue, Aug 28, 2018 at 01:10:20PM -0700, Palmer Dabbelt wrote:
>> >>>> On Thu, 09 Aug 2018 21:11:40 PDT (-0700), linux@roeck-us.net wrote:
>> >>>> >setup_initrd() does not appear to serve a practical purpose other than
>> >>>> >preventing qemu boots with "-initrd" parameter, so let's drop it.
>> >>>> >
>> >>>> >Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> >>>> >---
>> >>>> > arch/riscv/kernel/setup.c | 39 ---------------------------------------
>> >>>> > 1 file changed, 39 deletions(-)
>> >>>> >
>> >>>> >diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> >>>> >index 2e56af3281f8..579f58a42974 100644
>> >>>> >--- a/arch/riscv/kernel/setup.c
>> >>>> >+++ b/arch/riscv/kernel/setup.c
>> >>>> >@@ -82,41 +82,6 @@ EXPORT_SYMBOL(empty_zero_page);
>> >>>> > /* The lucky hart to first increment this variable will boot the other cores */
>> >>>> > atomic_t hart_lottery;
>> >>>> >
>> >>>> >-#ifdef CONFIG_BLK_DEV_INITRD
>> >>>> >-static void __init setup_initrd(void)
>> >>>> >-{
>> >>>> >-	extern char __initramfs_start[];
>> >>>> >-	extern unsigned long __initramfs_size;
>> >>>> >-	unsigned long size;
>> >>>> >-
>> >>>> >-	if (__initramfs_size > 0) {
>> >>>> >-		initrd_start = (unsigned long)(&__initramfs_start);
>> >>>> >-		initrd_end = initrd_start + __initramfs_size;
>> >>>> >-	}
>> >>>
>> >>> The underlying problem is probably that __initramfs_size == 512 even
>> >>> if there is no embedded initrd. Result is that initrd_start and initrd_end
>> >>> are always overwritten, even if provided and even if there is no embedded
>> >>> initrd. Result is that initrd_start and initrd_end are always overwritten,
>> >>> and -initrd from the qemu command line is always ignored.
>> >>>
>> >>> A less invasive fix than mine would be
>> >>>
>> >>> -	if (__initramfs_size > 0) {
>> >>> +	if (__initramfs_size > 0 && !initrd_start) {
>> >>>
>> >>> Any chance you can test that with your setup ?
>> >>
>> >>You should just delete the last four lines above.  They serve no purpose.
>> >>
>> >
>> >You mean the entire if() statement plus the variable declarations ?
>> >
>> >That works for me, for both embedded initrd and initrd specified with
>> >-initrd option, but we still need someone to test if it works for
>> >Palmer's use case, ie with vmlinux (and possibly initrd) embedded in
>> >bbl.
>>
>> This still boots my Fedora images
>>
>>    diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>    index db20dc630e7e..aee603123030 100644
>>    --- a/arch/riscv/kernel/setup.c
>>    +++ b/arch/riscv/kernel/setup.c
>>    @@ -85,15 +85,8 @@ atomic_t hart_lottery;
>>     #ifdef CONFIG_BLK_DEV_INITRD
>>     static void __init setup_initrd(void)
>>     {
>>    -	extern char __initramfs_start[];
>>    -	extern unsigned long __initramfs_size;
>>     	unsigned long size;
>>    -	if (__initramfs_size > 0) {
>>    -		initrd_start = (unsigned long)(&__initramfs_start);
>>    -		initrd_end = initrd_start + __initramfs_size;
>>    -	}
>>    -
>>     	if (initrd_start >= initrd_end) {
>>     		printk(KERN_INFO "initrd not found or empty");
>>     		goto disable;
>>
>> but I have not tried an integrated initramfs.
>
> I tested the above both with external initrd and with integrated
> initramfs; both work for me.
>
> Should I resend my patch, using the above, or do you want to create
> a patch yourself ?

You should send one, then it'll go through my regular pre-PR testing flow to 
make sure it works on my end.  I just never trust these inline patches to be 
exact, even if it's unlikely there's any confusion on a patch this simple (at 
least, mechanically simple -- I'm afraid I still don't understand why the logic 
is incorrect).
