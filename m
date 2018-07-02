Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E9BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B9D24747
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="JdbPfpp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B9D24747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeGBRR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:17:29 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42452 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeGBRR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:17:28 -0400
Received: by mail-oi0-f68.google.com with SMTP id n84-v6so17776896oib.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=WwnQkHzCAvl7rlcOJTWruADebt2jmBhFrhM5cL1PC2A=;
        b=JdbPfpp8iooV+rlHDvAGFfyM7Qo1EGoTUDAFq4ypifHksCMWsd1nslThjAGVEfEs69
         3NmfT0ejU91pZy3N/mDNBAiCv2vwkvvvelLcbhFLymICRJN1xSEUzFwPPllyOaxNk5N7
         +RGwKhY2v4y2+ePMeTKsXj14lCogb1p6cQ1WeiAjnC+3AU9IfZZRC22jG1VieOw3Ofx+
         K/jMpaTP6Zw4OdBYwpfO1HP/PBswJsbMxQUWY8icHcmg+LpDcQTFWsndaUhHRfgfiTU0
         SDgjOgffrxBRKl0ftsbbyG6DiaIBNgRUdvtaAtn+na0kaRGNjnTtBvsepGZTPDX/aph7
         heVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=WwnQkHzCAvl7rlcOJTWruADebt2jmBhFrhM5cL1PC2A=;
        b=Imk/dAmWDaZn9D5A6MRxKDLPQIrZTYlrO9borI67wym+3BFPOEkEdKoDalVPer5SSr
         4L30SiDxMqJJzOGFtILeJyyw/Iwx1suB6/7XAuUjQOO42xtlnqAcHkCubaFTmNTjoIs1
         I0J2Mi/WwkwsYQAjEOesEV29kVdCRdGcV+aQVlOG+K4kkhXi2MosqysVPLfOT/YQQlkg
         RFrK7dxtQ70JyWwLJQ82fhfXbX+sWkBRK/416IrqX0wpEQ+0Z+gVlpaXjcOOSPSY0lEz
         bl9TFJUqsjabmd4g7gi5j08sPp2csWrlDqxIjvMNTDxt6h9bulcjC6lwNocdQ2omrpGE
         gQCg==
X-Gm-Message-State: APt69E3r6i3bxNQtNLTWWMm6f3hkJLw8dGq9E57fsxtlPRj/dsbv5Saq
        kZS5UXFp8nqva/qFBjulgPbO2qI2qtqVviGLqzwWQQ==
X-Google-Smtp-Source: AAOMgpf8G8PyBYEsVfqsPkt2/OJy0ULHn5+3PO1ZN4Mkbwv+pnCaQEyPBH/oewzoGQEKtzhtcp1EXyLbx/6IRvwtrf0=
X-Received: by 2002:aca:5f56:: with SMTP id t83-v6mr14808556oib.115.1530551847510;
 Mon, 02 Jul 2018 10:17:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 10:17:27 -0700 (PDT)
In-Reply-To: <20180702165803.GB19488@linux.intel.com>
References: <153046008813.2019.6356018879675062644.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180702165803.GB19488@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 2 Jul 2018 10:17:27 -0700
Message-ID: <CAPcyv4itO22FfC8vK7CgFZ4aU3rWxz_G_5Eq1_t-fKmcZ-iQRQ@mail.gmail.com>
Subject: Re: [PATCH] lib/iov_iter: Fix pipe handling in _copy_to_iter_mcsafe
To:     Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 9:58 AM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> On Sun, Jul 01, 2018 at 08:52:20AM -0700, Dan Williams wrote:
>> By mistake the ITER_PIPE early-exit / warning from copy_from_iter() was
>> cargo-culted in _copy_to_iter_mcsafe() rather than a machine-check-safe
>> version of copy_to_iter_pipe().
>>
>> Implement copy_pipe_to_iter_mcsafe() being careful to return the
>> indication of short copies due to a CPU exception.
>>
>> Without this regression-fix all splice reads to dax-mode files fail.
>>
>> Fixes: 8780356ef630 ("x86/asm/memcpy_mcsafe: Define copy_to_iter_mcsafe()")
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Reported-by: Ross Zwisler <ross.zwisler@linux.intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>> Hi Ingo,
>>
>> I'm submitting this fix back through the tip tree since the regression
>> originated through tip/x86/dax.
>>
>>  lib/iov_iter.c |   37 +++++++++++++++++++++++++++++++++----
>>  1 file changed, 33 insertions(+), 4 deletions(-)
>
> Hey Dan,
>
> I retested the current linux/master with this patch applied, and XFS + DAX +
> generic/323 still dies for me:
>
>   run fstests generic/323 at 2018-07-02 10:51:35
>   BUG: unable to handle kernel paging request at 00007f16dc001000
>   PGD 80000000bb71a067 P4D 80000000bb71a067 PUD bb71b067 PMD bb6e8067 PTE 0
>   Oops: 0002 [#1] PREEMPT SMP PTI
>   CPU: 1 PID: 1598 Comm: aio-last-ref-he Not tainted
>   4.18.0-rc3-00001-g5174f2f2b6e5 #2
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>   rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/2014
>   RIP: 0010:__memcpy+0x12/0x20
>   Code: c3 e8 42 fb ff ff 48 8b 43 60 48 2b 43 50 88 43 4e 5b 5d c3 90 90 90
>   90 0f 1f 44 00 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 <f3> 48 a5 89 d1 f3
>   a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 f3 a4
>   RSP: 0018:ffffc90002783a60 EFLAGS: 00010246
>   RAX: 00007f16dc001000 RBX: ffff880151229000 RCX: 0000000000002000
>   RDX: 0000000000000000 RSI: ffff880151219000 RDI: 00007f16dc001000
>   RBP: ffffc90002783a68 R08: 0000004227a4083c R09: ffff880151219000
>   R10: ffffc90002783d40 R11: 0000000000000000 R12: 0000000000000000
>   R13: 0000000000010000 R14: ffffc90002783d18 R15: 0000000000010000
>   FS:  00007f16f1ec5700(0000) GS:ffff880114600000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007f16dc001000 CR3: 0000000035508000 CR4: 00000000000006e0
>   Call Trace:
>    ? copyout_mcsafe+0x3e/0x60
>    _copy_to_iter_mcsafe+0x9e/0x4c0
>    ? __lock_is_held+0x65/0xb0
>    pmem_copy_to_iter+0x17/0x20 [nd_pmem]
>    dax_copy_to_iter+0x49/0x70
>    dax_iomap_actor+0x1f8/0x280
>    ? dax_iomap_rw+0x100/0x100
>    iomap_apply+0xb5/0x130
>    ? dax_iomap_rw+0x100/0x100
>    dax_iomap_rw+0x95/0x100
>    ? dax_iomap_rw+0x100/0x100
>    xfs_file_dax_read+0x83/0x1f0
>    xfs_file_read_iter+0xac/0xc0
>    aio_read+0x11f/0x1a0
>    ? __might_fault+0x3e/0x90
>    io_submit_one+0x39d/0x5f0
>    ? io_submit_one+0x39d/0x5f0
>    __x64_sys_io_submit+0xa1/0x280
>    do_syscall_64+0x65/0x220
>    ? do_syscall_64+0x65/0x220
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> This failure looks identical to what I was hitting with the original bug
> report.

I see it now, my run was skipping generic/323.
