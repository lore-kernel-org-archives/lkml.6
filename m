Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-454547-1521657772-2-13230318674818974808
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521657770; b=amQhWz9vQ8oUFvCfNwSAlJSo+oRVg7hqAvvCzYDDOZV9fY0
    l8++3kFsYGFnRI7yrhcepQFgV9zD3iXVAplzrfGU2RuYBCXD2os4bzwHtsb9kwDX
    OxMhWxdyAd9/Ry2M35iC3nJSW/Ro6ZiQ62bP7QVBX/zw7e3DO+tZXFTVqOXISA50
    YCNJP2+YZ2QiX+lkFDUUmXYKjTEMwZl4ipU1Aa2TEPdH+el10SCb0LC5R1HUOtw8
    kJXYIYzpi9A4ORaBATWw30QF0J7ww73TgBny8vuDSFgwLAkpznBWXc34nn5Uw2Cg
    5FKSypc629KantXEtUxOrYr618urVgW6Kv3APUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521657770; bh=t87A62XtQIcqOEalUsvQwO2t6exN3rKH5luqxV
    gCgrg=; b=fX4T/YUvaokxTnL0SM/+5kUD97XbkCKkxXLrb6id+2oAl82Uwpc8kJ
    iK+vmmB2lziNcy3pKXetcezYy+5Que61y1InAHBoNuR3qXXtAIQarsDiymfHLB3V
    t64s4UrmJcSGssNzlesu+4zZCc9lyddATGwwKsEhLRg4HInxgMdrmBDeoFDV7cox
    u2lcvm0YVDnQQ78IRD1yZrAJLYrSdtwjFL9JNYha3fRV+75kddJ52aYA1XFLTh24
    bBJeruBAhIJM++sJKGLny7M9hXNLCtTT9CcavuEugM2hzCjK4+t49jPcAn2JCY7A
    XYiB9Tq4Dvrd70vUSpGnZ2eb/4M9QHng==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=IvvV5NiT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nuOlE7Eh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=IvvV5NiT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nuOlE7Eh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeCUSmq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 14:42:46 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:38180 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752556AbeCUSmp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 14:42:45 -0400
X-Google-Smtp-Source: AG47ELtJHn07Xx52a9AyPtyqNLTZ3JfHrGMQgnuHlxDI3IHj6KW2IbkQH2RegRzOjvQRRCXWS/gA6/lp2cFf7ydcI2w=
MIME-Version: 1.0
In-Reply-To: <20180321161314.7711-1-mike.kravetz@oracle.com>
References: <0d24f817-303a-7b4d-4603-b2d14e4b391a@oracle.com> <20180321161314.7711-1-mike.kravetz@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 21 Mar 2018 11:42:44 -0700
Message-ID: <CAPcyv4g9Gbz00YZEX=25eZ8TEBvhmcTO-ZBamvZRqN-LPZmk5Q@mail.gmail.com>
Subject: Re: [PATCH v2] shm: add split function to shm_vm_ops
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 9:13 AM, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> If System V shmget/shmat operations are used to create a hugetlbfs
> backed mapping, it is possible to munmap part of the mapping and
> split the underlying vma such that it is not huge page aligned.
> This will untimately result in the following BUG:
>
> kernel BUG at /build/linux-jWa1Fv/linux-4.15.0/mm/hugetlb.c:3310!
> Oops: Exception in kernel mode, sig: 5 [#1]
> LE SMP NR_CPUS=2048 NUMA PowerNV
> Modules linked in: kcm nfc af_alg caif_socket caif phonet fcrypt
>                 8<--8<--8<--8< snip 8<--8<--8<--8<
> CPU: 18 PID: 43243 Comm: trinity-subchil Tainted: G         C  E
> 4.15.0-10-generic #11-Ubuntu
> NIP:  c00000000036e764 LR: c00000000036ee48 CTR: 0000000000000009
> REGS: c000003fbcdcf810 TRAP: 0700   Tainted: G         C  E
> (4.15.0-10-generic)
> MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24002222  XER:
> 20040000
> CFAR: c00000000036ee44 SOFTE: 1
> GPR00: c00000000036ee48 c000003fbcdcfa90 c0000000016ea600 c000003fbcdcfc40
> GPR04: c000003fd9858950 00007115e4e00000 00007115e4e10000 0000000000000000
> GPR08: 0000000000000010 0000000000010000 0000000000000000 0000000000000000
> GPR12: 0000000000002000 c000000007a2c600 00000fe3985954d0 00007115e4e00000
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR20: 00000fe398595a94 000000000000a6fc c000003fd9858950 0000000000018554
> GPR24: c000003fdcd84500 c0000000019acd00 00007115e4e10000 c000003fbcdcfc40
> GPR28: 0000000000200000 00007115e4e00000 c000003fbc9ac600 c000003fd9858950
> NIP [c00000000036e764] __unmap_hugepage_range+0xa4/0x760
> LR [c00000000036ee48] __unmap_hugepage_range_final+0x28/0x50
> Call Trace:
> [c000003fbcdcfa90] [00007115e4e00000] 0x7115e4e00000 (unreliable)
> [c000003fbcdcfb50] [c00000000036ee48]
> __unmap_hugepage_range_final+0x28/0x50
> [c000003fbcdcfb80] [c00000000033497c] unmap_single_vma+0x11c/0x190
> [c000003fbcdcfbd0] [c000000000334e14] unmap_vmas+0x94/0x140
> [c000003fbcdcfc20] [c00000000034265c] exit_mmap+0x9c/0x1d0
> [c000003fbcdcfce0] [c000000000105448] mmput+0xa8/0x1d0
> [c000003fbcdcfd10] [c00000000010fad0] do_exit+0x360/0xc80
> [c000003fbcdcfdd0] [c0000000001104c0] do_group_exit+0x60/0x100
> [c000003fbcdcfe10] [c000000000110584] SyS_exit_group+0x24/0x30
> [c000003fbcdcfe30] [c00000000000b184] system_call+0x58/0x6c
> Instruction dump:
> 552907fe e94a0028 e94a0408 eb2a0018 81590008 7f9c5036 0b090000 e9390010
> 7d2948f8 7d2a2838 0b0a0000 7d293038 <0b090000> e9230086 2fa90000 419e0468
> ---[ end trace ee88f958a1c62605 ]---
>
> This bug was introduced by commit 31383c6865a5 ("mm, hugetlbfs:
> introduce ->split() to vm_operations_struct").  A split function
> was added to vm_operations_struct to determine if a mapping can
> be split.  This was mostly for device-dax and hugetlbfs mappings
> which have specific alignment constraints.
>
> Mappings initiated via shmget/shmat have their original vm_ops
> overwritten with shm_vm_ops.  shm_vm_ops functions will call back
> to the original vm_ops if needed.  Add such a split function to
> shm_vm_ops.
>
> Fixes: 31383c6865a5 ("mm, hugetlbfs: introduce ->split() to vm_operations_struct")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reported by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Tested-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...don't worry about resending if this has already hit a maintainer tree.
