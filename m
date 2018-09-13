Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4BFC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58065204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHYr48P9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58065204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbeIMTHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:07:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40126 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbeIMTHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:07:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id l63-v6so2793330pga.7;
        Thu, 13 Sep 2018 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CMblwdm7qwAJTSPuunwbMt29VqYZiPQTYZqjyASBYc0=;
        b=NHYr48P9ZWs8V/UvF4VO06Zk+9l47AkYuvY4NJU1/Zn/FxjcIW6IN/CCttGllvvbaR
         mBGIJ9wZl7+JNNb7PDFA+bk04sQcL8m0wPQbD/FhAVsGIeO39WsBYqXVmA/jAPvDC1Bu
         Mziqj95UvHXkBkd7G2v+5zjcXvFxlgpS/2CLZm0dFu3T2KzPUS3iWd3DLKHCw5hqSLat
         12rCc7A0lSkEohi/w8y5B2T3x3FOKqJumLnZo1dMt4li2ilx/AvtnI87KJ1+oO+ywv+w
         miV2s6CWZTivaAgPcKiUJJb5cZsrVmvOBum9SUN7pvx/ImydTO91KODeEHkkWHjrH0Qm
         5s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CMblwdm7qwAJTSPuunwbMt29VqYZiPQTYZqjyASBYc0=;
        b=Fwwh4TD0SQGtbiMC+z2V8mimSPK7m+KtDBXPjrpVMc2zi55CP5IxxrvD/bDMXt71rh
         Nk2g8KEL0CP73FV3g5etJc88DQLVWSSu1KsFGvSFOBUJtLiUY7m+RMvCTSVjoy0RBDcx
         NJljWFVBizZBWVN59kpCqWLT7a6z8sGP9m2EjuqJXyA4XusM8g6JLvm9eaTsDlmXKJGG
         6Os651s9qN0hfopqMQVMAy3Xwu0t5Wnv78BM7waQJwHegSBf1N5uGqYijlPjD9UtAsUh
         vYgzbYNlAYPWB8P+VTKqiS3ivE8mAQAvuqlmR7z5ZsBquoDzrMkBWtJnGY24jh7y8sJd
         thLw==
X-Gm-Message-State: APzg51ADg6D22MS0T+qBYKA0sr7ng33eB/b9CZa89lTPE1lpNyV9i55M
        KedFua6TSHSnun0e6zNTW0V48enE
X-Google-Smtp-Source: ANB0Vdasob7glLkbORYk4vPNrNVDaOHt2s2xR2kTNL0hoTA2RKd4ToH6Ok/1Iv5vwPqRsgVl3tI9IQ==
X-Received: by 2002:a63:ad07:: with SMTP id g7-v6mr7361567pgf.19.1536847076034;
        Thu, 13 Sep 2018 06:57:56 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id 203-v6sm5071986pgb.14.2018.09.13.06.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 06:57:55 -0700 (PDT)
Subject: Re: KMSAN: uninit-value in pppoe_rcv
To:     Alexander Potapenko <glider@google.com>,
        syzbot+f5f6080811c849739212@syzkaller.appspotmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>, mostrows@earthlink.net,
        Networking <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
References: <0000000000004624c30575a9fd40@google.com>
 <CAG_fn=Vk2HMPCLJV3aj1dt0KkDmksasBRRfKGnCTRHjvQ6OnQg@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <7424e094-afda-084a-ad80-299f219ced92@gmail.com>
Date:   Thu, 13 Sep 2018 06:57:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=Vk2HMPCLJV3aj1dt0KkDmksasBRRfKGnCTRHjvQ6OnQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/12/2018 03:38 AM, Alexander Potapenko wrote:
> On Wed, Sep 12, 2018 at 12:24 PM syzbot
> <syzbot+f5f6080811c849739212@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    d2d741e5d189 kmsan: add initialization for shmem pages
>> git tree:       https://github.com/google/kmsan.git/master
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1465fc37800000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=48f9de3384bcd0f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=f5f6080811c849739212
>> compiler:       clang version 7.0.0 (trunk 329391)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d6e607800000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a15b5b800000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+f5f6080811c849739212@syzkaller.appspotmail.com
>>
>> IPVS: ftp: loaded support on port[0] = 21
>> ==================================================================
>> BUG: KMSAN: uninit-value in __get_item drivers/net/ppp/pppoe.c:172 [inline]
>> BUG: KMSAN: uninit-value in get_item drivers/net/ppp/pppoe.c:236 [inline]
>> BUG: KMSAN: uninit-value in pppoe_rcv+0xcef/0x10e0
>> drivers/net/ppp/pppoe.c:450
>> CPU: 0 PID: 4543 Comm: syz-executor355 Not tainted 4.16.0+ #87
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:17 [inline]
>>   dump_stack+0x185/0x1d0 lib/dump_stack.c:53
>>   kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
>>   __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
>>   __get_item drivers/net/ppp/pppoe.c:172 [inline]
>>   get_item drivers/net/ppp/pppoe.c:236 [inline]
>>   pppoe_rcv+0xcef/0x10e0 drivers/net/ppp/pppoe.c:450
>>   __netif_receive_skb_core+0x47df/0x4a90 net/core/dev.c:4562
>>   __netif_receive_skb net/core/dev.c:4627 [inline]
>>   netif_receive_skb_internal+0x49d/0x630 net/core/dev.c:4701
>>   netif_receive_skb+0x230/0x240 net/core/dev.c:4725
>>   tun_rx_batched drivers/net/tun.c:1555 [inline]
>>   tun_get_user+0x740f/0x7c60 drivers/net/tun.c:1962
>>   tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
>>   call_write_iter include/linux/fs.h:1782 [inline]
>>   new_sync_write fs/read_write.c:469 [inline]
>>   __vfs_write+0x7fb/0x9f0 fs/read_write.c:482
>>   vfs_write+0x463/0x8d0 fs/read_write.c:544
>>   SYSC_write+0x172/0x360 fs/read_write.c:589
>>   SyS_write+0x55/0x80 fs/read_write.c:581
>>   do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>> RIP: 0033:0x4447c9
>> RSP: 002b:00007fff64c8fc28 EFLAGS: 00000297 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004447c9
>> RDX: 000000000000fd87 RSI: 0000000020000600 RDI: 0000000000000004
>> RBP: 00000000006cf018 R08: 00007fff64c8fda8 R09: 00007fff00006bda
>> R10: 0000000000005fe7 R11: 0000000000000297 R12: 00000000004020d0
>> R13: 0000000000402160 R14: 0000000000000000 R15: 0000000000000000
>>
>> Uninit was created at:
>>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
>>   kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
>>   kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
>>   kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
>>   slab_post_alloc_hook mm/slab.h:445 [inline]
>>   slab_alloc_node mm/slub.c:2737 [inline]
>>   __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
>>   __kmalloc_reserve net/core/skbuff.c:138 [inline]
>>   __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
>>   alloc_skb include/linux/skbuff.h:984 [inline]
>>   alloc_skb_with_frags+0x1d4/0xb20 net/core/skbuff.c:5234
>>   sock_alloc_send_pskb+0xb56/0x1190 net/core/sock.c:2085
>>   tun_alloc_skb drivers/net/tun.c:1532 [inline]
>>   tun_get_user+0x2242/0x7c60 drivers/net/tun.c:1829
>>   tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
>>   call_write_iter include/linux/fs.h:1782 [inline]
>>   new_sync_write fs/read_write.c:469 [inline]
>>   __vfs_write+0x7fb/0x9f0 fs/read_write.c:482
>>   vfs_write+0x463/0x8d0 fs/read_write.c:544
>>   SYSC_write+0x172/0x360 fs/read_write.c:589
>>   SyS_write+0x55/0x80 fs/read_write.c:581
>>   do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>> ==================================================================
> I did a little digging before sending the bug upstream.
> If I add memset(obj, 0xfe, size) to __kmalloc_reserve(), these 0xfe
> bytes are visible in __get_item() at the place where KMSAN reports an
> error.
> 
> The problem is somehow related to tun_get_user() creating a fragmented
> sk_buff - when I change the call to tun_alloc_skb() so that it
> allocates a single buffer the bug goes away.
>

I guess the following patch would fix the issue

(I will submit it more formally)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index ce61231e96ea5fe27f512fbd0d80d4609997e508..333e967ed968ea3ff2dda25289f7f657263db2b9 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -423,6 +423,7 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
        struct pppoe_hdr *ph;
        struct pppox_sock *po;
        struct pppoe_net *pn;
+       __be16 sid;
        int len;
 
        skb = skb_share_check(skb, GFP_ATOMIC);
@@ -434,6 +435,7 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
 
        ph = pppoe_hdr(skb);
        len = ntohs(ph->length);
+       sid = ph->sid;
 
        skb_pull_rcsum(skb, sizeof(*ph));
        if (skb->len < len)
@@ -447,7 +449,7 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
        /* Note that get_item does a sock_hold(), so sk_pppox(po)
         * is known to be safe.
         */
-       po = get_item(pn, ph->sid, eth_hdr(skb)->h_source, dev->ifindex);
+       po = get_item(pn, sid, eth_hdr(skb)->h_source, dev->ifindex);
        if (!po)
                goto drop;



