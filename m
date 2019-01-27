Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65E1C282C7
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 02:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6061821903
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 02:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfA0C5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 21:57:04 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35272 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726435AbfA0C5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 21:57:03 -0500
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0R2v1UP011777
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 21:57:01 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0R2uu8s019456
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 21:57:01 -0500
Received: by mail-qk1-f199.google.com with SMTP id c71so14063329qke.18
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 18:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=ZU6fYgX2L+tqurdPPupHC5SorJIT6b26PhYEpxB5T3c=;
        b=O/mnXQwFQLf9yznKyu1Fb4The/iYcH1lmjX/MHO+wxV8KLCz0DUL2hnFd1kKsQoKEl
         OJ4krTCAvoqeHpORaPmLCCchVnvYzeodLRzb5tPbOcTtGG6UWcihuwwstIcfNbcJyHF+
         tY3RpuJAGjq7T26YlogfeDUqHrsA0WLrMz1GrisLjnH2VwQBSeHr1SZ1TAbJntS8p21l
         xcqbwhZEYaMCIXywU8rrHR2/Q0lQCxLl0nAkvDgAXKt6yhU8Lb+fqvDdRVDRMJngwStq
         PKCO76cEaRFYFUlCmoGXsRIotRxb+C8nIm4a0wJePoeljg4lhn1iZ5lbJngXr9wzmfQP
         bGsQ==
X-Gm-Message-State: AJcUuker5k8NveJFpS7VsBuibhOeO06HAu4F4pCXujFXfQdV74watqIK
        xJeCB6DNt9RpIZwBwrfLmFe1nE629b4G9tPt7hSnU3KtjzF7ERjei4WmRM+07dLty4LDSiq7hvF
        jwxXlbGks9cwhKaCFxcjrtrrpb2V6sH0faBU=
X-Received: by 2002:ac8:4258:: with SMTP id r24mr16999195qtm.213.1548557816128;
        Sat, 26 Jan 2019 18:56:56 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5jSTSA1zyfibchkeScN0Px/BA9bJBEwznfODo7UcryYWHhGEgZSbfqevgiMl580Awu9Wgf/A==
X-Received: by 2002:ac8:4258:: with SMTP id r24mr16999184qtm.213.1548557815923;
        Sat, 26 Jan 2019 18:56:55 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id t43sm120927602qtc.53.2019.01.26.18.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 18:56:54 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Pavel Machek <pavel@ucw.cz>
cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, mgorman@techsingularity.net,
        vbabka@suse.cz, aarcange@redhat.com, rientjes@google.com,
        mhocko@kernel.org, zi.yan@cs.rutgers.edu, hannes@cmpxchg.org
Subject: Re: [regression -next0117] What is kcompactd and why is he eating 100% of my cpu?
In-reply-to: <20190126200005.GB27513@amd>
References: <20190126200005.GB27513@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sat, 26 Jan 2019 21:56:53 -0500
Message-ID: <12171.1548557813@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jan 2019 21:00:05 +0100, Pavel Machek said:

> top - 13:38:51 up  1:42, 16 users,  load average: 1.41, 1.93, 1.62
> Tasks: 182 total,   3 running, 138 sleeping,   0 stopped,   0 zombie
> %Cpu(s):  2.3 us, 57.8 sy,  0.0 ni, 39.9 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> KiB Mem:   3020044 total,  2429420 used,   590624 free,    27468 buffers
> KiB Swap:  2097148 total,        0 used,  2097148 free.  1924268 cached Mem
>
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
>   608 root      20   0       0      0      0 R  99.6  0.0  11:34.38 kcompactd0
>  9782 root      20   0       0      0      0 I   7.9  0.0   0:59.02 kworker/0:
>  2971 root      20   0   46624  23076  13576 S   4.3  0.8   2:50.22 Xorg

I've noticed this as well on earlier kernels (next-20181224 to 20190115)

Some more info:

1) echo 3 > /proc/sys/vm/drop_caches  unwedges kcompactd in 1-3 seconds.

2) Typical kcompactd traceback:

cat /proc/27/stack
[<0>] retint_kernel+0x1b/0x2d
[<0>] lock_is_held_type+0x1b/0x50
[<0>] ___might_sleep+0xad/0x220
[<0>] __might_sleep+0x113/0x130
[<0>] on_each_cpu_cond_mask+0x12a/0x140
[<0>] on_each_cpu_cond+0x18/0x20
[<0>] invalidate_bh_lrus+0x29/0x30
[<0>] __buffer_migrate_page+0x154/0x340
[<0>] buffer_migrate_page_norefs+0x14/0x20
[<0>] move_to_new_page+0x8e/0x360
[<0>] migrate_pages+0x3cc/0xfd8
[<0>] compact_zone+0xb70/0x1380
[<0>] kcompactd_do_work+0x15b/0x500
[<0>] kcompactd+0x74/0x340
[<0>] kthread+0x158/0x170
[<0>] ret_from_fork+0x3a/0x50
[<0>] 0xffffffffffffffff

I've also seen khugepaged hung up:

cat /proc/29/stack
[<0>] ___preempt_schedule+0x16/0x18
[<0>] page_vma_mapped_walk+0x60/0x840
[<0>] remove_migration_pte+0x67/0x390
[<0>] rmap_walk_file+0x186/0x380
[<0>] rmap_walk+0xa3/0xd0
[<0>] remove_migration_ptes+0x69/0x70
[<0>] migrate_pages+0xb6d/0xfd8
[<0>] compact_zone+0xb70/0x1370
[<0>] compact_zone_order+0xd8/0x120
[<0>] try_to_compact_pages+0xe5/0x550
[<0>] __alloc_pages_direct_compact+0x6d/0x1a0
[<0>] __alloc_pages_slowpath+0x6c9/0x1640
[<0>] __alloc_pages_nodemask+0x558/0x5b0
[<0>] khugepaged+0x499/0x810
[<0>] kthread+0x158/0x170
[<0>] ret_from_fork+0x3a/0x50
[<0>] 0xffffffffffffffff

Looks like something has gone astray with compact_zone.

