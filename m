Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1A1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F2020823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="kjO1HDmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F2020823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeKSPrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 10:47:55 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50793 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbeKSPry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 10:47:54 -0500
Received: by mail-it1-f194.google.com with SMTP id a185so5163141itc.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 21:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CE7yrRL0khltPMjspiLTGTJo4Bz4ViZeGorTdyFdf2w=;
        b=kjO1HDmnF4hjRLkNvq+CZquQlmjofzh83pzPSVqJk/0Vo6oHVr452ERLEyb8/NjB8u
         XJFOMHTa+G6ZxIes/SsIU6SA41l7y9K1ocuzylMMkxup2eu80asGbDPQ0oHiyiIARLGa
         nsx1EwioyHWMpijgr6pNQqeIBRfqiOcZyBAL+5fgS8nG5yFGeLuLdsnzjONY/x6i2kLC
         xafkMBSiSguIPYFu4mRFE/83bjZYtu0OLV65OgfHDeErUMdmgOQRb/PrRHGHGP5qolG7
         KLGK1QLAXrtg0hkp1alos7iSCFdMYtdCAQ/BKHnO4IYP55sqtwHuilXsFZCP4XNbQySd
         Xf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CE7yrRL0khltPMjspiLTGTJo4Bz4ViZeGorTdyFdf2w=;
        b=hWoYykqLR6EgZ8vz3RFwzWMXl5Q1Iyq4NycdJfzX2V4dCoug8eGTvD1aMxPo3c3nwx
         cDemC5RSPeU5KgSJa7L5ZAGmtwA0p+Rydwan+k8utr3uTGdYK3YGZWm75KP9kWrqwSWf
         ITfPc19KotiW80cCyGpmmeDtJ3DH0FNYvOrpIYJ3Tbf8mD2+OOdjBqs1rN0PsA7w6f9Z
         scpwiD9/WwQsKNX1Q6UaKOGHsUmSUYEJTr/DsB2YGdLQemDbf52lnzI4cFBa6oFpMcxw
         Ib5g6QK7ZVQfZZhlv7/sifn7tovnC2DPX8/GSN1gStMNH0vzP4vw09aqR4HRAH+iKb+s
         D91g==
X-Gm-Message-State: AGRZ1gKW+LJLtehWj4A1sismNVWDBTbmb7Ud7CEwGuD8S9wSWtm9LceM
        MrwEM99nuaOBuI5tS0Gg0xP1Fw==
X-Google-Smtp-Source: AJdET5crmhhvBrv7bj3sJxN11h6tx8l/4WIZejo7qp02cqagdhax2ZhjY1NkfOg5G25KZ5pk19KQsw==
X-Received: by 2002:a02:3b54:: with SMTP id i20-v6mr19245846jaf.17.1542605124552;
        Sun, 18 Nov 2018 21:25:24 -0800 (PST)
Received: from [192.168.43.100] ([172.58.139.31])
        by smtp.googlemail.com with ESMTPSA id j129sm3769536itb.41.2018.11.18.21.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 21:25:24 -0800 (PST)
Subject: Re: [PATCH v3 0/3] sh: system call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
References: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <0b9aaa2f-9eda-82f1-8d52-b537a8c0c190@landley.net>
Date:   Sun, 18 Nov 2018 23:25:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/18 10:32 PM, Firoz Khan wrote:
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the 
> system call table generation support implementation 
> across all the architectures. 

I applied the patch in https://github.com/landley/mkroot and the result booted
under qemu-system-sh4, seems to work fine. Network's fine, it can read a block
device, etc.

Acked-and-or-tested-by: Rob Landley <rob@landley.net>

I assume that this is just git du jour and not your patch:

WARNING: CPU: 0 PID: 1 at mm/slub.c:2448 ___slab_alloc.constprop.34+0x196/0x288

CPU: 0 PID: 1 Comm: swapper Not tainted 4.20.0-rc3 #1
PC is at ___slab_alloc.constprop.34+0x196/0x288
PR is at __slab_alloc.constprop.33+0x2a/0x4c
PC  : 8c09d09a SP  : 8f829ea0 SR  : 400080f0
TEA : c0001240
R0  : 8c09cf04 R1  : 8c01cbec R2  : 00000000 R3  : 00000000
R4  : 8f8020a0 R5  : 006080c0 R6  : 8c01d74a R7  : 8fff5180
R8  : 8c011a40 R9  : 8fff5180 R10 : 8f8020a0 R11 : 00008000
R12 : 8c01d74a R13 : 006080c0 R14 : 8f80211c
MACH: 0000008e MACL: 0ae4849d GBR : 00000000 PR  : 8c09d1b6

Call trace:
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] __slab_alloc.constprop.33+0x2a/0x4c
 [<(ptrval)>] arch_local_save_flags+0x0/0x8
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] mm_init.isra.6+0xca/0x120
 [<(ptrval)>] kmem_cache_alloc+0x9a/0xf4
 [<(ptrval)>] mm_init.isra.6+0xca/0x120
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] kmem_cache_alloc+0x9a/0xf4
 [<(ptrval)>] mm_alloc+0xe/0x48
 [<(ptrval)>] mm_init.isra.6+0xca/0x120
 [<(ptrval)>] memset+0x0/0x8c
 [<(ptrval)>] __do_execve_file+0x1de/0x574
 [<(ptrval)>] getname_kernel+0x1e/0xc8
 [<(ptrval)>] kmem_cache_alloc+0x0/0xf4
 [<(ptrval)>] do_execve+0x16/0x24
 [<(ptrval)>] arch_local_save_flags+0x0/0x8
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] printk+0x0/0x24
 [<(ptrval)>] kernel_init+0x34/0xec
 [<(ptrval)>] ret_from_kernel_thread+0xc/0x14
 [<(ptrval)>] schedule_tail+0x0/0x58
 [<(ptrval)>] kernel_init+0x0/0xec

---[ end trace 6e84d1e05051e55d ]---

