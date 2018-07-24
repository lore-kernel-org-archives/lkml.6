Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732FEECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AABD20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNQ6RUcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AABD20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388474AbeGXLJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:09:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43322 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388241AbeGXLJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:09:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id r13-v6so3078779ljg.10;
        Tue, 24 Jul 2018 03:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NH+1OxHhsTbowDDOaKObcurt1JlZC7oC24YVSI6L2W8=;
        b=cNQ6RUcbtcbbiuD0lbP7z/FLPsaegNeTAn5FsYHXi9thMO8x95a5Buezr1CoecHGv3
         dJuM2ku1V3qheC0H7OEKCRirDMcBIyImAK+Ic3PF7bWphR8tn9K7Mw61TPj/d84tfaSM
         BKpilX4WGoowh/KVyO7cVAmn3/45jZ0sjW8nClveN0uGo0n3yZfo5wAEIGHj2O/ygE2J
         5jN5QADiS+7FZfT2XtlWOp1MiIKJprLkpUZznKEh5lqphYDB2Qtgsxl8UKpGPO499TMn
         MftSHBzeqBDbOUgIXM0s1SU3IYdlddAau1WSkz78YaI1uY/dc3Li7ZOFYNDR0ehuaCQN
         aa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NH+1OxHhsTbowDDOaKObcurt1JlZC7oC24YVSI6L2W8=;
        b=dCnwyDA116x/IQSM/pYVqKwyG+Vmdv73L1VkjDWtJF7j/fkpYL9mLjwyFazqAk2Lr2
         XLMWpYn99OgcdgdDAxAuBP/XVYOHTYJLfCGa5gstZHjF6hh29lXNLNykGxdFT8AbdxZP
         ZnrwYwsPfXL3hrHJC9WbxIlqZkAqyW02xaCGzki8GCqZQfF0OEyMQLKrnPVIU4eWID0e
         s6PPtbdbEa8mMl5ucREY2qo5cfPOwhSrmNjR/jwZ9i1DpDVP7LV76B9zs0IVdjMkzS8Y
         Yf2h/v7N20sOashmBpCM0ZA/lOivVJqoyr/ldK7x/s4ypud8xuDP7YKjszBMJieaPp/w
         S6GQ==
X-Gm-Message-State: AOUpUlFjS1y9kxIyDVNLkeb/7V8vsCUXoFVOgXwXXphFID8ff27cjBUr
        q/rzSAgpF+8ZEtc1z7NRxiI=
X-Google-Smtp-Source: AAOMgpdfU7fyxpKyPjLY+pXbOTA4GC9nlUwxgR9i4dSq2Yi/GdFCadHFfy4KmXLEO972UeKS8B+Dzg==
X-Received: by 2002:a2e:498:: with SMTP id a24-v6mr12011745ljf.27.1532426654589;
        Tue, 24 Jul 2018 03:04:14 -0700 (PDT)
Received: from ?IPv6:2001:2012:22e:1b00:f2e2:9015:9262:3fde? ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id c29-v6sm1761484lfh.32.2018.07.24.03.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 03:04:13 -0700 (PDT)
Subject: Re: [PATCH] net/p9/trans_fd.c: fix double list_del()
To:     jiangyiwen <jiangyiwen@huawei.com>, ericvh@gmail.com,
        rminnich@sandia.gov, lucho@ionkov.net
Cc:     asmadeus@codewreck.org, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
References: <20180723121902.20201-1-tomasbortoli@gmail.com>
 <5B568374.9010507@huawei.com>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <844e4101-6980-82dd-6f02-0a7193ed438c@gmail.com>
Date:   Tue, 24 Jul 2018 12:04:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5B568374.9010507@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 03:40 AM, jiangyiwen wrote:
> On 2018/7/23 20:19, Tomas Bortoli wrote:
>> A double list_del(&req->req_list) is possible in p9_fd_cancel() as
>> shown by Syzbot. To prevent it we have to ensure that we have the
>> client->lock when deleting the list. Furthermore, we have to update
>> the status of the request before releasing the lock, to prevent the
>> race.
>>
>> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
>> Reported-by: syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com
>> ---
>>  net/9p/trans_fd.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
>> index a64b01c56e30..370c6c69a05c 100644
>> --- a/net/9p/trans_fd.c
>> +++ b/net/9p/trans_fd.c
>> @@ -199,15 +199,14 @@ static void p9_mux_poll_stop(struct p9_conn *m)
>>  static void p9_conn_cancel(struct p9_conn *m, int err)
>>  {
>>  	struct p9_req_t *req, *rtmp;
>> -	unsigned long flags;
>>  	LIST_HEAD(cancel_list);
>>  
>>  	p9_debug(P9_DEBUG_ERROR, "mux %p err %d\n", m, err);
>>  
>> -	spin_lock_irqsave(&m->client->lock, flags);
>> +	spin_lock(&m->client->lock);
>>  
>>  	if (m->err) {
>> -		spin_unlock_irqrestore(&m->client->lock, flags);
>> +		spin_unlock(&m->client->lock);
>>  		return;
>>  	}
>>  
>> @@ -219,7 +218,6 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>>  	list_for_each_entry_safe(req, rtmp, &m->unsent_req_list, req_list) {
>>  		list_move(&req->req_list, &cancel_list);
>>  	}
>> -	spin_unlock_irqrestore(&m->client->lock, flags);
>>  
>>  	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
>>  		p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);
>> @@ -228,6 +226,7 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>>  			req->t_err = err;
>>  		p9_client_cb(m->client, req, REQ_STATUS_ERROR);
>>  	}
>> +	spin_unlock(&m->client->lock);
> 
> If you want to expand the ranges of client->lock, the cancel_list will not
> be necessary, you can optimize this code.
> 

Unfortunately, not. Moving the spin_lock() before the for makes the
crash appear again. This because the calls to list_move() in the for
before delete all the elements from req->req_list, so the list is empty,
another call to list_del() would trigger a double del.
That's why we hold the lock to update the status of all those requests..
otherwise we have again the race with p9_fd_cancel().
Crash log at the bottom.


> Thanks,
> Yiwen.
> 
>>  }
>>  
>>  static __poll_t
>> @@ -370,12 +369,12 @@ static void p9_read_work(struct work_struct *work)
>>  		if (m->req->status != REQ_STATUS_ERROR)
>>  			status = REQ_STATUS_RCVD;
>>  		list_del(&m->req->req_list);
>> -		spin_unlock(&m->client->lock);
>>  		p9_client_cb(m->client, m->req, status);
>>  		m->rc.sdata = NULL;
>>  		m->rc.offset = 0;
>>  		m->rc.capacity = 0;
>>  		m->req = NULL;
>> +		spin_unlock(&m->client->lock);
>>  	}
>>  
>>  end_clear:
>>
> 
> 

Crash:

syzkaller login: [   55.691138] list_del corruption,
ffff88004de337a8->next is LIST_POISON1 (dead000000000100)
[   55.693058] ------------[ cut here ]------------
[   55.693910] kernel BUG at lib/list_debug.c:47!
[   55.695060] invalid opcode: 0000 [#1] SMP KASAN
[   55.696008] CPU: 1 PID: 9500 Comm: repro1 Not tainted 4.18.0-rc4+ #260
[   55.696027] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[   55.696027] RIP: 0010:__list_del_entry_valid+0xd3/0x150
[   55.696027] Code: 00 00 00 49 8b 54 24 08 48 39 f2 75 3b 48 83 c4 08
b8 01 00 00 00 5b 41 5c 5d c3 4c 89 e2 48 c7 c7 80 06 b8 87 e8 21 c6 1d
fe <0f> 0b 48 c7 c7 e0 06 b8 87 e8 13 c6 1d fe 0f 0b 48 c7 c7 40 07 b8
[   55.696027] RSP: 0018:ffff88004de2f198 EFLAGS: 00010282
[   55.696027] RAX: 000000000000004e RBX: dead000000000200 RCX:
ffffffff815efe0e
[   55.696027] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffff88006c9265ac
[   55.696027] RBP: ffff88004de2f1b0 R08: ffffed000d924fc1 R09:
0000000000000001
[   55.696027] R10: ffffed000cdc94e8 R11: ffff88006c927e07 R12:
dead000000000100
[   55.696027] R13: ffff880066e4a740 R14: ffff88004de337a8 R15:
ffff88004de2f240
[   55.696027] FS:  00007efc61d2e700(0000) GS:ffff88006c900000(0000)
knlGS:0000000000000000
[   55.696027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   55.696027] CR2: 00007efc613ab330 CR3: 000000005e86f000 CR4:
00000000000006e0
[   55.696027] Call Trace:
[   55.696027]  ? _raw_spin_lock+0x32/0x40
[   55.696027]  p9_fd_cancel+0xf3/0x390
[   55.696027]  ? p9_fd_request+0x238/0x3e0
[   55.696027]  ? p9_fd_close+0x5a0/0x5a0
[   55.696027]  p9_client_rpc+0xacf/0x11b0
[   55.696027]  ? p9_client_prepare_req.part.11+0xd20/0xd20
[   55.696027]  ? __fget+0x378/0x5a0
[   55.696027]  ? iterate_fd+0x400/0x400
[   55.696027]  ? finish_wait+0x4b0/0x4b0
[   55.696027]  ? rcu_read_lock_sched_held+0x108/0x120
[   55.696027]  ? p9_fd_cancel+0x390/0x390
[   55.696027]  p9_client_create+0xa33/0x1600
[   55.696027]  ? v9fs_drop_inode+0x100/0x140
[   55.696027]  ? p9_client_read+0xbe0/0xbe0
[   55.724517]  ? __sched_text_start+0x8/0x8
[   55.724517]  ? find_held_lock+0x35/0x1d0
[   55.724517]  ? __lockdep_init_map+0xe4/0x650
[   55.724517]  ? lockdep_init_map+0x9/0x10
[   55.724517]  ? kasan_check_write+0x14/0x20
[   55.724517]  ? __init_rwsem+0x1ce/0x2b0
[   55.724517]  ? do_raw_write_unlock+0x2a0/0x2a0
[   55.724517]  ? rcu_read_lock_sched_held+0x108/0x120
[   55.724517]  ? __kmalloc_track_caller+0x49f/0x760
[   55.724517]  ? save_stack+0xa3/0xd0
[   55.724517]  v9fs_session_init+0x218/0x1980
[   55.724517]  ? v9fs_session_init+0x218/0x1980
[   55.724517]  ? v9fs_show_options+0x740/0x740
[   55.724517]  ? kasan_check_read+0x11/0x20
[   55.724517]  ? rcu_is_watching+0x8c/0x150
[   55.724517]  ? rcu_pm_notify+0xc0/0xc0
[   55.736879]  ? v9fs_mount+0x62/0x880
[   55.736879]  ? rcu_read_lock_sched_held+0x108/0x120
[   55.738600]  ? kmem_cache_alloc_trace+0x48d/0x740
[   55.738600]  v9fs_mount+0x81/0x880
[   55.738600]  ? v9fs_mount+0x81/0x880
[   55.738600]  mount_fs+0x66/0x2f0
[   55.738600]  vfs_kern_mount.part.26+0xcc/0x4a0
[   55.738600]  ? may_umount+0xa0/0xa0
[   55.738600]  ? _raw_read_unlock+0x22/0x30
[   55.738600]  ? __get_fs_type+0x8a/0xc0
[   55.738600]  do_mount+0xd86/0x2e90
[   55.738600]  ? kasan_check_read+0x11/0x20
[   55.738600]  ? do_raw_spin_unlock+0xa7/0x330
[   55.738600]  ? copy_mount_string+0x40/0x40
[   55.738600]  ? copy_mount_options+0x5f/0x2e0
[   55.738600]  ? rcu_read_lock_sched_held+0x108/0x120
[   55.738600]  ? kmem_cache_alloc_trace+0x48d/0x740
[   55.738600]  ? copy_mount_options+0x1f7/0x2e0
[   55.738600]  ksys_mount+0xab/0x120
[   55.738600]  __x64_sys_mount+0xbe/0x150
[   55.738600]  ? trace_hardirqs_on_caller+0x421/0x5c0
[   55.738600]  do_syscall_64+0x18c/0x760
[   55.738600]  ? finish_task_switch+0x186/0x9f0
[   55.738600]  ? syscall_return_slowpath+0x560/0x560
[   55.738600]  ? syscall_return_slowpath+0x2b0/0x560
[   55.738600]  ? __switch_to_asm+0x34/0x70
[   55.738600]  ? prepare_exit_to_usermode+0x360/0x360
[   55.738600]  ? __switch_to_asm+0x34/0x70
[   55.738600]  ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
[   55.738600]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   55.738600]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   55.738600] RIP: 0033:0x7efc61442b79
[   55.763914] Code: f3 fa ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f c2 2a 00 31 d2 48 29 c2 64
[   55.763914] RSP: 002b:00007efc61d2de88 EFLAGS: 00000246 ORIG_RAX:
00000000000000a5
[   55.763914] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007efc61442b79
[   55.769909] RDX: 0000000020000380 RSI: 0000000020000000 RDI:
0000000000000000
[   55.769909] RBP: 00007efc61d2deb0 R08: 0000000020000240 R09:
00007efc61d2e9c0
[   55.769909] R10: 0000000000000000 R11: 0000000000000246 R12:
00007ffd68da6aa0
[   55.773854] R13: 00007efc61d2e9c0 R14: 00007efc61d39040 R15:
0000000000000003
[   55.773854] Modules linked in:
[   55.776650] ---[ end trace 8de8057bee332983 ]---
[   55.777631] RIP: 0010:__list_del_entry_valid+0xd3/0x150
[   55.778754] Code: 00 00 00 49 8b 54 24 08 48 39 f2 75 3b 48 83 c4 08
b8 01 00 00 00 5b 41 5c 5d c3 4c 89 e2 48 c7 c7 80 06 b8 87 e8 21 c6 1d
fe <0f> 0b 48 c7 c7 e0 06 b8 87 e8 13 c6 1d fe 0f 0b 48 c7 c7 40 07 b8
[   55.782685] RSP: 0018:ffff88004de2f198 EFLAGS: 00010282
[   55.783785] RAX: 000000000000004e RBX: dead000000000200 RCX:
ffffffff815efe0e
[   55.785126] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffff88006c9265ac
[   55.786470] RBP: ffff88004de2f1b0 R08: ffffed000d924fc1 R09:
0000000000000001
[   55.788007] R10: ffffed000cdc94e8 R11: ffff88006c927e07 R12:
dead000000000100
[   55.789517] R13: ffff880066e4a740 R14: ffff88004de337a8 R15:
ffff88004de2f240
[   55.791173] FS:  00007efc61d2e700(0000) GS:ffff88006c900000(0000)
knlGS:0000000000000000
[   55.792746] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   55.793882] CR2: 00007efc613ab330 CR3: 000000005e86f000 CR4:
00000000000006e0
[   55.795410] Kernel panic - not syncing: Fatal exception
[   55.796384] Kernel Offset: disabled
[   55.796384] Rebooting in 86400 seconds..

