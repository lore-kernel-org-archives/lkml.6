Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A038AF81831
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A302120C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQuRf0/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A302120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeIMVqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:46:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40310 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbeIMVqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:46:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19-v6so5135248ljc.7;
        Thu, 13 Sep 2018 09:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lGwyDs9W4j5di21BOrfnQzE+rTaUYUeZh+Nv0CJWESA=;
        b=MQuRf0/nznS2mVeA/8bUnEWmNHazV4lxt0j66fAMa92fbdELvXbQYPU4cG8KM/trwX
         CBwQg8kGk/stWmCtwXTl6GEawbiItTytsnu2J8HsqJUnBPk9rz+Qn8y82VZvTsbkkkAB
         A89lBQp9j9b4/686qxfZsdIUrpyzjYbV4uI2+7x1u9wB8s7D0MfXorYtbgnPzgEjaYWv
         IZ30pZ7qN6/9ZJhWZt7ZBJeW7lTwkV0f8nqAafd9qlL3iyJRnnWbEgy2hNx90Ppvkfnt
         breyDmCtI/J4it3pdbfYKpFv67nEwo5eUZMRXQjmA49DEnHWuwHLEm8AWSFqMhqAXbMv
         4eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lGwyDs9W4j5di21BOrfnQzE+rTaUYUeZh+Nv0CJWESA=;
        b=NFTQRqpNtSecL/rt0exG42QtXkAN5e/A/onpIQ3lQY6kPBK6wKdMfo4lRla8LyZJWN
         FBcRK0keP2C++NDO44s/o8OEBpe+l2nWtU2TLBmwZky+Dizjg/QCIDgWAbO3keiFZSOs
         +Iq+Bv+2YC0uZxvtByc5SY6AGGm9IZ31E9TiYUPcQEDRPPQ5rvd6PORKn4+7I5jQN29O
         ImsWnefIRd1HKzgJIgPY7IZE/3iFB5Xqea+3vel+HiAfT7Aw3AreAP1JJlwPbEiM5AS6
         4+eQdapHnCK0+rY0EHjGjQSgQTJoIy4YRaF9mNqqPu78vCx3Z1i+bgrqUfuU9x2fWnQK
         SYcA==
X-Gm-Message-State: APzg51DNIKXZ9N/Y46I8+GOGPZIjchga9JWYPhueBqcJrpO/gp/b1n8T
        TqJslQ4TTa7wUa2Svaok2Eg=
X-Google-Smtp-Source: ANB0VdZ4DLgB+7WnT8NhgrwcYjITc2XHjlMtLa5FYg6I2Hqyy9yGy3ZmJDLsUut/2WD6zPqakmG6sg==
X-Received: by 2002:a2e:84c6:: with SMTP id q6-v6mr5520187ljh.65.1536856554049;
        Thu, 13 Sep 2018 09:35:54 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id c14-v6sm790139lfi.23.2018.09.13.09.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 09:35:52 -0700 (PDT)
Subject: Re: KMSAN: uninit-value in pppoe_rcv
To:     Alexander Potapenko <glider@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     syzbot+f5f6080811c849739212@syzkaller.appspotmail.com,
        LKML <linux-kernel@vger.kernel.org>, mostrows@earthlink.net,
        Networking <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
References: <0000000000004624c30575a9fd40@google.com>
 <CAG_fn=Vk2HMPCLJV3aj1dt0KkDmksasBRRfKGnCTRHjvQ6OnQg@mail.gmail.com>
 <7424e094-afda-084a-ad80-299f219ced92@gmail.com>
 <CAG_fn=WXPsQBWR1GDsprY3aL4oW0v6EGhNB5wrvPJCOMh_U7wQ@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <315231c0-462e-45d4-aeab-3d546387e2ca@gmail.com>
Date:   Thu, 13 Sep 2018 09:35:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=WXPsQBWR1GDsprY3aL4oW0v6EGhNB5wrvPJCOMh_U7wQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/13/2018 07:12 AM, Alexander Potapenko wrote:
> On Thu, Sep 13, 2018 at 3:57 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>>
>>
>> On 09/12/2018 03:38 AM, Alexander Potapenko wrote:
>>> On Wed, Sep 12, 2018 at 12:24 PM syzbot
>>> <syzbot+f5f6080811c849739212@syzkaller.appspotmail.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> syzbot found the following crash on:
>>>>
>>>> HEAD commit:    d2d741e5d189 kmsan: add initialization for shmem pages
>>>> git tree:       https://github.com/google/kmsan.git/master
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1465fc37800000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=48f9de3384bcd0f
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=f5f6080811c849739212
>>>> compiler:       clang version 7.0.0 (trunk 329391)
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d6e607800000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a15b5b800000
>>>>
>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>> Reported-by: syzbot+f5f6080811c849739212@syzkaller.appspotmail.com
>>>>
>>>> IPVS: ftp: loaded support on port[0] = 21
>>>> ==================================================================
>>>> BUG: KMSAN: uninit-value in __get_item drivers/net/ppp/pppoe.c:172 [inline]
>>>> BUG: KMSAN: uninit-value in get_item drivers/net/ppp/pppoe.c:236 [inline]
>>>> BUG: KMSAN: uninit-value in pppoe_rcv+0xcef/0x10e0
>>>> drivers/net/ppp/pppoe.c:450
>>>> CPU: 0 PID: 4543 Comm: syz-executor355 Not tainted 4.16.0+ #87
>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>>> Google 01/01/2011
>>>> Call Trace:
>>>>   __dump_stack lib/dump_stack.c:17 [inline]
>>>>   dump_stack+0x185/0x1d0 lib/dump_stack.c:53
>>>>   kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
>>>>   __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
>>>>   __get_item drivers/net/ppp/pppoe.c:172 [inline]
>>>>   get_item drivers/net/ppp/pppoe.c:236 [inline]
>>>>   pppoe_rcv+0xcef/0x10e0 drivers/net/ppp/pppoe.c:450
>>>>   __netif_receive_skb_core+0x47df/0x4a90 net/core/dev.c:4562
>>>>   __netif_receive_skb net/core/dev.c:4627 [inline]
>>>>   netif_receive_skb_internal+0x49d/0x630 net/core/dev.c:4701
>>>>   netif_receive_skb+0x230/0x240 net/core/dev.c:4725
>>>>   tun_rx_batched drivers/net/tun.c:1555 [inline]
>>>>   tun_get_user+0x740f/0x7c60 drivers/net/tun.c:1962
>>>>   tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
>>>>   call_write_iter include/linux/fs.h:1782 [inline]
>>>>   new_sync_write fs/read_write.c:469 [inline]
>>>>   __vfs_write+0x7fb/0x9f0 fs/read_write.c:482
>>>>   vfs_write+0x463/0x8d0 fs/read_write.c:544
>>>>   SYSC_write+0x172/0x360 fs/read_write.c:589
>>>>   SyS_write+0x55/0x80 fs/read_write.c:581
>>>>   do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>>>>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>>>> RIP: 0033:0x4447c9
>>>> RSP: 002b:00007fff64c8fc28 EFLAGS: 00000297 ORIG_RAX: 0000000000000001
>>>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004447c9
>>>> RDX: 000000000000fd87 RSI: 0000000020000600 RDI: 0000000000000004
>>>> RBP: 00000000006cf018 R08: 00007fff64c8fda8 R09: 00007fff00006bda
>>>> R10: 0000000000005fe7 R11: 0000000000000297 R12: 00000000004020d0
>>>> R13: 0000000000402160 R14: 0000000000000000 R15: 0000000000000000
>>>>
>>>> Uninit was created at:
>>>>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
>>>>   kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
>>>>   kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
>>>>   kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
>>>>   slab_post_alloc_hook mm/slab.h:445 [inline]
>>>>   slab_alloc_node mm/slub.c:2737 [inline]
>>>>   __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
>>>>   __kmalloc_reserve net/core/skbuff.c:138 [inline]
>>>>   __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
>>>>   alloc_skb include/linux/skbuff.h:984 [inline]
>>>>   alloc_skb_with_frags+0x1d4/0xb20 net/core/skbuff.c:5234
>>>>   sock_alloc_send_pskb+0xb56/0x1190 net/core/sock.c:2085
>>>>   tun_alloc_skb drivers/net/tun.c:1532 [inline]
>>>>   tun_get_user+0x2242/0x7c60 drivers/net/tun.c:1829
>>>>   tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
>>>>   call_write_iter include/linux/fs.h:1782 [inline]
>>>>   new_sync_write fs/read_write.c:469 [inline]
>>>>   __vfs_write+0x7fb/0x9f0 fs/read_write.c:482
>>>>   vfs_write+0x463/0x8d0 fs/read_write.c:544
>>>>   SYSC_write+0x172/0x360 fs/read_write.c:589
>>>>   SyS_write+0x55/0x80 fs/read_write.c:581
>>>>   do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
>>>>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>>>> ==================================================================
>>> I did a little digging before sending the bug upstream.
>>> If I add memset(obj, 0xfe, size) to __kmalloc_reserve(), these 0xfe
>>> bytes are visible in __get_item() at the place where KMSAN reports an
>>> error.
>>>
>>> The problem is somehow related to tun_get_user() creating a fragmented
>>> sk_buff - when I change the call to tun_alloc_skb() so that it
>>> allocates a single buffer the bug goes away.
>>>
>>
>> I guess the following patch would fix the issue
>>
>> (I will submit it more formally)
> No, as far as I can see it doesn't.
> Saving sid before __skb_pull() is still a good idea, but in this
> particular case |ph| doesn't change.
>> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
>> index ce61231e96ea5fe27f512fbd0d80d4609997e508..333e967ed968ea3ff2dda25289f7f657263db2b9 100644
>> --- a/drivers/net/ppp/pppoe.c
>> +++ b/drivers/net/ppp/pppoe.c
>> @@ -423,6 +423,7 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
>>         struct pppoe_hdr *ph;
>>         struct pppox_sock *po;
>>         struct pppoe_net *pn;
>> +       __be16 sid;
>>         int len;
>>
>>         skb = skb_share_check(skb, GFP_ATOMIC);
>> @@ -434,6 +435,7 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
>>
>>         ph = pppoe_hdr(skb);
>>         len = ntohs(ph->length);

Then ph->length needs to be better validated.

>> +       sid = ph->sid;

I'll take a look, thanks.

