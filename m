Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE19C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D604720821
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARkAVp7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfBHSxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:53:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39416 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBHSxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:53:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id f16so4777200wmh.4;
        Fri, 08 Feb 2019 10:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mW06J15iA8RJWyR956RTrFHmWmZ+yugmLE5+mhSHrQ4=;
        b=ARkAVp7kJ1mi1nC70zsKUZ4hO26KTlmKEnsBBNt7d4Pew653glwzG5Y8Z7BaLmhPPp
         6FWO9oVEzwBW57u640kbRczjxWrAPjdR1Ou6mlTB8QkGwJjPTQlMELVTfAtzuo8mJE1J
         i1S+MtXzaE4/jTHvbzRtE1YZvF+/xpEfNQFhHNmbwtY2SY/DxYKVUpjNq2LmKLvkGInI
         /2BFdRZ83642H0qNwT7qWOo++bmnazfFsFiKeprIsBy9u0pCFqYoFWgrNikhEj6xjIbj
         +aq1RF8KAzK7I6A5iTzjblrUgwL/m+ICCMs/d9fQU3JZzENR1aaAlsou3IOHWGOKiWB6
         nQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mW06J15iA8RJWyR956RTrFHmWmZ+yugmLE5+mhSHrQ4=;
        b=D7UpqqEj1iLvUyXuGp9Hp7X4dJzUe3rw3n+t+Qo+WlKOyVzAEH4whJ+i93V+5BtT89
         2d9mUl8jyeC/yyPd+jHd5Ke/jRF5X35AwrxK93MwtfNDOSu4JSSutGy2msg7N8cKibB4
         8VfcRKXcP34su89CjnrMuDfgWELKmdRwlefZ6k94qt7BMEty0bCW9KYbdfrPgQMzfDSq
         D9Hw6izJDVF+/lsYMm15P9yrzYWG4jQVg0P6GyzI7+xJ6xpCLWHBXL4FGjCCysROUDwS
         H+eahQ9uqQO5NcxmYqIpsbXCJjAt2FYF3Nn8FS+LHzUZ5rYZNQAfAeqbohsAYDh0xGJh
         i8IA==
X-Gm-Message-State: AHQUAua2E7PAaMSmXl9JvDD3D5gKVUzSEHDXTx9FjRK7ySSoeACwau76
        tWBnkHjPwHTkDwAyA8WqutNE2rK9
X-Google-Smtp-Source: AHgI3Ia5oSLL55n5dyEpzW4iJfLqYYSnztLYiw/jxSVr0IYhCjGYlkPOTchC0/LhOwpig8PqSzQNHg==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr17043725wrh.317.1549651982882;
        Fri, 08 Feb 2019 10:53:02 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:7cef:f5e9:d82c:bb62? (p200300EA8BF1E2007CEFF5E9D82CBB62.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:7cef:f5e9:d82c:bb62])
        by smtp.googlemail.com with ESMTPSA id 65sm8405879wrb.62.2019.02.08.10.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 10:53:02 -0800 (PST)
Subject: Re: Linux 5.0 regression: rtl8169 / kernel BUG at
 lib/dynamic_queue_limits.c:27!
To:     Sander Eikelenboom <linux@eikelenboom.it>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
References: <6c389fde-4c8d-300b-8c3c-300d6105c30a@eikelenboom.it>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <0f605e50-56fe-06b5-9b66-6aed89a608ce@gmail.com>
Date:   Fri, 8 Feb 2019 19:52:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <6c389fde-4c8d-300b-8c3c-300d6105c30a@eikelenboom.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.2019 19:29, Sander Eikelenboom wrote:
> L.S.,
> 
> While testing a linux 5.0-rc5 kernel (with some patches on top but they don't seem related) under Xen i the nasty splat below, 
> that I haven encountered with Linux 4.20.x.
> 
> Unfortunately I haven't got a clear reproducer for this and bisecting could be nasty due to another (networking related) kernel bug.
> 
> If you need more info, want me to run a debug patch etc., please feel free to ask.
> 
Thanks for the report. However I see no change in the r8169 driver between
4.20 and 5.0 with regard to BQL code. Having said that the root cause could
be somewhere else. Therefore I'm afraid a bisect will be needed.

> --
> Sander
> 
Heiner

> 
> [ 6466.554866] kernel BUG at lib/dynamic_queue_limits.c:27!
> [ 6466.571425] invalid opcode: 0000 [#1] SMP NOPTI
> [ 6466.585890] CPU: 3 PID: 7057 Comm: as Not tainted 5.0.0-rc5-20190208-thp-net-florian-doflr+ #1
> [ 6466.598693] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , BIOS V1.8B1 09/13/2010
> [ 6466.611579] RIP: e030:dql_completed+0x126/0x140
> [ 6466.624339] Code: 2b 47 54 ba 00 00 00 00 c7 47 54 ff ff ff ff 0f 48 c2 48 8b 15 7b 39 4a 01 48 89 57 58 e9 48 ff ff ff 44 89 c0 e9 40 ff ff ff <0f> 0b 8b 47 50 29 e8 41 0f 48 c3 eb 9f 90 90 90 90 90 90 90 90 90
> [ 6466.648130] RSP: e02b:ffff88807d4c3e78 EFLAGS: 00010297
> [ 6466.659616] RAX: 0000000000000042 RBX: ffff8880049cf800 RCX: 0000000000000000
> [ 6466.672835] RDX: 0000000000000001 RSI: 0000000000000042 RDI: ffff8880049cf8c0
> [ 6466.684521] RBP: ffff888077df7260 R08: 0000000000000001 R09: 0000000000000000
> [ 6466.696824] R10: 00000000387c2336 R11: 00000000387c2336 R12: 0000000010000000
> [ 6466.709953] R13: ffff888077df6898 R14: ffff888077df75c0 R15: 0000000000454677
> [ 6466.722165] FS:  00007fd869147200(0000) GS:ffff88807d4c0000(0000) knlGS:0000000000000000
> [ 6466.733228] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6466.746581] CR2: 00007fd867dfd000 CR3: 0000000074884000 CR4: 0000000000000660
> [ 6466.758366] Call Trace:
> [ 6466.768118]  <IRQ>
> [ 6466.778214]  rtl8169_poll+0x4f4/0x640
> [ 6466.789198]  net_rx_action+0x23d/0x370
> [ 6466.798467]  __do_softirq+0xed/0x229
> [ 6466.807039]  irq_exit+0xb7/0xc0
> [ 6466.815471]  xen_evtchn_do_upcall+0x27/0x40
> [ 6466.826647]  xen_do_hypervisor_callback+0x29/0x40
> [ 6466.835902]  </IRQ>
> [ 6466.845361] RIP: e030:xen_hypercall_mmu_update+0xa/0x20
> [ 6466.853390] Code: 51 41 53 b8 00 00 00 00 0f 05 41 5b 59 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 51 41 53 b8 01 00 00 00 0f 05 <41> 5b 59 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
> [ 6466.874031] RSP: e02b:ffffc90003c0bdd0 EFLAGS: 00000246
> [ 6466.883452] RAX: 0000000000000000 RBX: 000000041f83bfe8 RCX: ffffffff8100102a
> [ 6466.891986] RDX: deadbeefdeadf00d RSI: deadbeefdeadf00d RDI: deadbeefdeadf00d
> [ 6466.903402] RBP: 0000000000000fe8 R08: 000000000000000b R09: 0000000000000000
> [ 6466.911201] R10: deadbeefdeadf00d R11: 0000000000000246 R12: 800000050c346067
> [ 6466.918491] R13: ffff8880607c4fe8 R14: ffff888005082800 R15: 0000000000000000
> [ 6466.926647]  ? xen_hypercall_mmu_update+0xa/0x20
> [ 6466.938195]  ? xen_set_pte_at+0x78/0xe0
> [ 6466.947046]  ? __handle_mm_fault+0xc43/0x1060
> [ 6466.955772]  ? do_mmap+0x44b/0x5b0
> [ 6466.964410]  ? handle_mm_fault+0xf8/0x200
> [ 6466.973290]  ? __do_page_fault+0x231/0x4a0
> [ 6466.981973]  ? page_fault+0x8/0x30
> [ 6466.990904]  ? page_fault+0x1e/0x30
> [ 6466.999585] Modules linked in:
> [ 6467.007533] ---[ end trace 94bec01608fe4061 ]---
> [ 6467.016751] RIP: e030:dql_completed+0x126/0x140
> [ 6467.024271] Code: 2b 47 54 ba 00 00 00 00 c7 47 54 ff ff ff ff 0f 48 c2 48 8b 15 7b 39 4a 01 48 89 57 58 e9 48 ff ff ff 44 89 c0 e9 40 ff ff ff <0f> 0b 8b 47 50 29 e8 41 0f 48 c3 eb 9f 90 90 90 90 90 90 90 90 90
> [ 6467.039726] RSP: e02b:ffff88807d4c3e78 EFLAGS: 00010297
> [ 6467.047243] RAX: 0000000000000042 RBX: ffff8880049cf800 RCX: 0000000000000000
> [ 6467.054202] RDX: 0000000000000001 RSI: 0000000000000042 RDI: ffff8880049cf8c0
> [ 6467.062000] RBP: ffff888077df7260 R08: 0000000000000001 R09: 0000000000000000
> [ 6467.069664] R10: 00000000387c2336 R11: 00000000387c2336 R12: 0000000010000000
> [ 6467.077715] R13: ffff888077df6898 R14: ffff888077df75c0 R15: 0000000000454677
> [ 6467.084916] FS:  00007fd869147200(0000) GS:ffff88807d4c0000(0000) knlGS:0000000000000000
> [ 6467.093352] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6467.101492] CR2: 00007fd867dfd000 CR3: 0000000074884000 CR4: 0000000000000660
> [ 6467.110542] Kernel panic - not syncing: Fatal exception in interrupt
> [ 6467.118166] Kernel Offset: disabled
> (XEN) [2019-02-08 18:04:48.854] Hardware Dom0 crashed: rebooting machine in 5 seconds.
> 

