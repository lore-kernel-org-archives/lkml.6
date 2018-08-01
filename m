Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36238C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AFE20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYxggy6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AFE20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732988AbeHADi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:38:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42467 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732933AbeHADi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:38:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so6991610pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 18:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ik5iusv4uqvW6wnz5He611dutxX5uhyw2T16xcNLR50=;
        b=LYxggy6cqaPrdEI2eVEXnkcWvZHtbGD0m0zixqhdjoDnWA4YAHPYFm9eWzDI9c1n/7
         9VS314OvGtLfDCnyN3OOVHQG9MfW/7obGABvNKqpN+ff/RaOe6+v/fvy3ukuHb/n6SVW
         7A0t6tiT1mntA4qt7952oumirQyz+XzHz0ibwEABT6gak+FWjyxS2bAk0BAXe/MM++yN
         QhhWkQfyYonTkzkhoAjBH61XJ2QoGlGmY6kWRjYkt9z9UzKnfuL+BJa+0fxSw+ZAVaMY
         5xg6WujlizvWGfCXxdAhUPE/nFwZIP+PQj0uZboU0YLzjvckjPmqI3gXnptOwGYteu0a
         nLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ik5iusv4uqvW6wnz5He611dutxX5uhyw2T16xcNLR50=;
        b=ekX++N2ioZHaVXLk25Pq0D6bHnn8yB4QPD9xL/hcUIIqrASEDnT3meu2jWJacXgbFY
         Y4e0ohvPqbA+MYzu0dHDDi16ePcJyAPq8AVZIgqOtFv3Kcmri2i+D8xI8M4V9sJ7WaOk
         5aamaq+DJqL/kg+VN4psK2FplELCjDSBKootXhxb5AvmYrETjinNAz28A41LjaGaN6FG
         wO5mH0pfylth8P3hYt4/Ti6lOyE2hKjiX2ZEq4Pb8lRxiKXgW505y2YT/p2HwVSNzSpN
         RYXyNuQwOd2T+YCErh66dtxvadHWLFYlx768X/Mec6TgVxiN2zvFwD4UbJiFPDQSJ0M5
         tbVg==
X-Gm-Message-State: AOUpUlHHcJAX3n73lFYvEbNPg8p1e77NTfmKwe5bSmyM5EeVJrZjHw/b
        Zl5Z59cC76YlMDuPIqzVOFI=
X-Google-Smtp-Source: AAOMgpe3BFyWZY54IyArRkc1GpizN1hoqPMpW61s5cx42kKt0DnUmiZbvt17DCr0gZIKQbNiQoiKJA==
X-Received: by 2002:a65:498c:: with SMTP id r12-v6mr23078626pgs.112.1533088521717;
        Tue, 31 Jul 2018 18:55:21 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([61.69.188.107])
        by smtp.gmail.com with ESMTPSA id h10-v6sm30327932pfj.78.2018.07.31.18.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 18:55:21 -0700 (PDT)
Date:   Wed, 1 Aug 2018 11:55:14 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [resend] [PATCH 0/3] powerpc/pseries: use H_BLOCK_REMOVE
Message-ID: <20180801115514.441eecc8@roar.ozlabs.ibm.com>
In-Reply-To: <1532699493-10883-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1532699493-10883-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018 15:51:30 +0200
Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:

> [Resending so everyone is getting the cover letter]
> 
> On very large system we could see soft lockup fired when a process is exiting
> 
> watchdog: BUG: soft lockup - CPU#851 stuck for 21s! [forkoff:215523]
> Modules linked in: pseries_rng rng_core xfs raid10 vmx_crypto btrfs libcrc32c xor zstd_decompress zstd_compress xxhash lzo_compress raid6_pq crc32c_vpmsum lpfc crc_t10dif crct10dif_generic crct10dif_common dm_multipath scsi_dh_rdac scsi_dh_alua autofs4
> CPU: 851 PID: 215523 Comm: forkoff Not tainted 4.17.0 #1
> NIP:  c0000000000b995c LR: c0000000000b8f64 CTR: 000000000000aa18
> REGS: c00006b0645b7610 TRAP: 0901   Not tainted  (4.17.0)
> MSR:  800000010280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 22042082  XER: 00000000
> CFAR: 00000000006cf8f0 SOFTE: 0 
> GPR00: 0010000000000000 c00006b0645b7890 c000000000f99200 0000000000000000 
> GPR04: 8e000001a5a4de58 400249cf1bfd5480 8e000001a5a4de50 400249cf1bfd5480 
> GPR08: 8e000001a5a4de48 400249cf1bfd5480 8e000001a5a4de40 400249cf1bfd5480 
> GPR12: ffffffffffffffff c00000001e690800 
> NIP [c0000000000b995c] plpar_hcall9+0x44/0x7c
> LR [c0000000000b8f64] pSeries_lpar_flush_hash_range+0x324/0x3d0
> Call Trace:
> [c00006b0645b7890] [8e000001a5a4dd20] 0x8e000001a5a4dd20 (unreliable)
> [c00006b0645b7a00] [c00000000006d5b0] flush_hash_range+0x60/0x110
> [c00006b0645b7a50] [c000000000072a2c] __flush_tlb_pending+0x4c/0xd0
> [c00006b0645b7a80] [c0000000002eaf44] unmap_page_range+0x984/0xbd0
> [c00006b0645b7bc0] [c0000000002eb594] unmap_vmas+0x84/0x100
> [c00006b0645b7c10] [c0000000002f8afc] exit_mmap+0xac/0x1f0
> [c00006b0645b7cd0] [c0000000000f2638] mmput+0x98/0x1b0
> [c00006b0645b7d00] [c0000000000fc9d0] do_exit+0x330/0xc00
> [c00006b0645b7dc0] [c0000000000fd384] do_group_exit+0x64/0x100
> [c00006b0645b7e00] [c0000000000fd44c] sys_exit_group+0x2c/0x30
> [c00006b0645b7e30] [c00000000000b960] system_call+0x58/0x6c
> Instruction dump:
> 60000000 f8810028 7ca42b78 7cc53378 7ce63b78 7d074378 7d284b78 7d495378 
> e9410060 e9610068 e9810070 44000022 <7d806378> e9810028 f88c0000 f8ac0008
> 
> This happens when removing the PTE by calling the hypervisor using the
> H_BULK_REMOVE call. This call is processing up to 4 PTEs but is doing a
> tlbie for each PTE it is processing. This could lead to long time spent in
> the hypervisor (sometimes up to 4s) and soft lockup being raised because
> the scheduler is not called in zap_pte_range().
> 
> Since the Power7's time, the hypervisor is providing a new hcall
> H_BLOCK_REMOVE allowing processing up to 8 PTEs with one call to
> tlbie. By limiting the amount of tlbie generated, this reduces the time
> spent invalidating the PTEs.

Oh that's a nice feature. I must have an ancient PAPR because I don't
have it. It could be a good project for someone to implement it in KVM
too.

> 
> This hcall requires that the pages are "all within the same naturally
> aligned 8 page virtual address block".
> 
> With this patch series applied, I couldn't see any soft lockup raised on
> the victim LPAR I was running the test one.
> 
> This series is covering both normal pages and huge pages.

Really nice, thanks for working on the problem.

Thanks,
Nick
