Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4067627-1524173729-2-17363153621283404858
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  FSL_HELO_FAKE 2.361, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524173728; b=PJsC1BC9dj1Txzp+AWjJOJO3Fzl6FK0GA29/0zcle8iqfjkwlu
    5sy219BDNThnIOmzGSCJfgmjjG9E0bvoe4BNWj3ri01Bc2khIUWKdOx4vQ2tD5ul
    3kricm9ItKRiP6hF1I7iU7Q2W3VV82wGLCIB/i5fAg98TUkKVmBtP9Mu+7EuKjIM
    sBLxw/RO+PgaxQm89QhEOf6L+MAHjy8we2x7AGsitDWJAWswReYH9izgMRINu0f1
    /ve9I4AxGJXLKbCIpgjIB4BE5oiB63mnOFKEmeuoVdh1dGxXvqH6uRsPpyMzCSf/
    U1VN56pXGcfA2I0OPu0yfcgTZKlM68H8Y9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524173728; bh=m+mrd
    DpRV+Ew7B2g0bjNNta1xds2VKRid4hEHZqDiDM=; b=bC+v+BqEdpG11/Fp5w6Ej
    CZ35EcjlAgj0ClRCjIMorCh1bkeSnrd1/A58G2mRNuqBmrHbkseJ/i1CoxTwuAOt
    qzu7DBOC6DF72EyIhwO/e3pd5ozmdL6FYQ/hEWXuJHu/SL3H3TFZpP1lQDcaH+Gk
    YZSsmCTOwIonVqOPs9CSvKmRYIf76YMIa6Li+yYNOwYgZ7a4KFzAJrTd/nOnw8nb
    fxL8Y2l4zDNRoZ+4xPQinq2HA7WCWK8j49rUI922MMfGTq7FyR5uKDcNPbG5fnYG
    C8NmnpYpOLUXfek/NnYNGKFOpCXREdQPTqb1Pg4ywsNqSMFUysVjA5E5ZddhYgt3
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Hf7h0Rye x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PSjm/F90;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=49 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Hf7h0Rye x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PSjm/F90;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=49 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF1qa5aUpRy38iArNQKfcxA5Q62OJyP9rJT5lbN3Mu2IdK7CNim2+omoHq8MB2RAWD3lhaYBjOHfugAyKTVhjJnIZ9TQZBv42LPu/FbU5DO0BLYxpYna
    u4t6nlv/HhgtOaDnQCq99jwD16W3JiGh/kDKVFXkJUJYM3Qk/Do8aU+pQGaujpSDrxlm+y3c3v5FowuU7nfpsywDy2nuCNEML/TlXyEvcDeyVRmGn1VY+75V
    4gnO3R4SZBsJdS/7tRFRCg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=6HZ6NwbpNn0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
    a=mzoz-TVAAAAA:20 a=4RBUngkUAAAA:8 a=DDOyTI_5AAAA:8 a=O97_x0MR2xlHd1rCn5cA:9
    a=AsFc72ZJYHUox5lw:21 a=C8qBpCY9XUleb8SA:21 a=CjuIK1q_8ugA:10
    a=vVHabExCe68A:10 a=AjGcO6oz07-iQ99wixmX:22 a=DcSpbTIhAlouE1Uv7lRv:22
    a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48BcpR6g1sZZaC8iylF/VZ2ivdNNjXRqnPCpHhpJ7trdQ5xTQsP3x2CrRX26w7bwifXxYpe0g==
Date: Thu, 19 Apr 2018 14:35:17 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: maco@android.com
Subject: Re: KASAN: use-after-free Read in binder_release_work
Message-ID: <20180419213517.GA13221@gmail.com>
References: <001a113f8f14113e790568fd0c02@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <001a113f8f14113e790568fd0c02@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, tkjos@android.com, gregkh@linuxfoundation.org,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 arve@android.com,
 syzbot <syzbot+0cf1f1aa154f56ff2e8d@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 08:02:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> f2d285669aae656dfeafa0bf25e86bbbc5d22329 (Tue Apr 3 17:45:39 2018 +0000)
> Merge tag 'pm-4.17-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=0cf1f1aa154f56ff2e8d
> 
> So far this crash happened 4 times on upstream.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4827186146050048
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=6025869373997056
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=4772918563176448
> Kernel config: https://syzkaller.appspot.com/x/.config?id=686016073509112605
> compiler: gcc (GCC) 7.1.1 20170620
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0cf1f1aa154f56ff2e8d@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> binder: 4616:4618 transaction failed 29189/-3, size 0-0 line 2963
> binder: release 4616:4618 transaction 114 in, still active
> binder: send failed reply for transaction 114 to 4616:4618
> binder: 4620:4621 ioctl 400448c8 20000200 returned -22
> ==================================================================
> BUG: KASAN: use-after-free in __list_del_entry_valid+0x144/0x150
> lib/list_debug.c:54
> Read of size 8 at addr ffff8801d39a4210 by task kworker/1:2/1891
> 
> CPU: 1 PID: 1891 Comm: kworker/1:2 Not tainted 4.16.0+ #378
> binder: release 4620:4621 transaction 118 out, still active
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events binder_deferred_func
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x1a7/0x27d lib/dump_stack.c:53
> binder: release 4620:4621 transaction 117 in, still active
>  print_address_description+0x73/0x250 mm/kasan/report.c:256
> binder: undelivered TRANSACTION_COMPLETE
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report+0x23c/0x360 mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> binder: BINDER_SET_CONTEXT_MGR already set
>  __list_del_entry_valid+0x144/0x150 lib/list_debug.c:54
> binder: 4620:4622 ioctl 40046207 0 returned -16
>  __list_del_entry include/linux/list.h:117 [inline]
>  list_del_init include/linux/list.h:159 [inline]
>  binder_dequeue_work_head_ilocked drivers/android/binder.c:893 [inline]
>  binder_dequeue_work_head drivers/android/binder.c:913 [inline]
>  binder_release_work+0x163/0x4b0 drivers/android/binder.c:4191
> binder: 4620:4621 ioctl c0306201 20004000 returned -14
> binder: 4620:4621 ioctl 400448c8 20000200 returned -22
>  binder_thread_release+0x4e1/0x730 drivers/android/binder.c:4396
> binder_alloc: binder_alloc_mmap_handler: 4620 2000c000-2000e000 already
> mapped failed -16
>  binder_deferred_release drivers/android/binder.c:4939 [inline]
>  binder_deferred_func+0x4f4/0x1350 drivers/android/binder.c:5022
> binder_alloc: 4620: binder_alloc_buf, no vma
> binder: 4620:4623 transaction failed 29189/-3, size 0-0 line 2963
>  process_one_work+0xc97/0x1c40 kernel/workqueue.c:2113
> binder_alloc: 4620: binder_alloc_buf, no vma
> binder: 4620:4621 transaction failed 29189/-3, size 0-0 line 2963
> binder: release 4620:4622 transaction 118 in, still active
> binder: release 4620:4622 transaction 117 out, still active
>  worker_thread+0x1c3/0x1380 kernel/workqueue.c:2247
> binder: send failed reply for transaction 118, target dead
> binder: send failed reply for transaction 117, target dead
> binder: BINDER_SET_CONTEXT_MGR already set
> binder: 4624:4625 ioctl 40046207 0 returned -16
>  kthread+0x33c/0x400 kernel/kthread.c:238
> binder: 4624:4625 ioctl 400448c8 20000200 returned -22
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411
> 
> binder_alloc: 4620: binder_alloc_buf, no vma
> Allocated by task 4618:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
> binder: 4624:4626 transaction failed 29189/-3, size 0-0 line 2963
>  kmem_cache_alloc_trace+0x136/0x740 mm/slab.c:3608
>  kmalloc include/linux/slab.h:512 [inline]
>  kzalloc include/linux/slab.h:701 [inline]
>  binder_transaction+0x13d2/0x8200 drivers/android/binder.c:2900
>  binder_thread_write+0xcf1/0x38b0 drivers/android/binder.c:3513
>  binder_ioctl_write_read.isra.39+0x261/0xcb0 drivers/android/binder.c:4451
>  binder_ioctl+0xb72/0x1417 drivers/android/binder.c:4591
> binder: undelivered TRANSACTION_ERROR: 29189
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>  ksys_ioctl+0x94/0xb0 fs/ioctl.c:701
>  SYSC_ioctl fs/ioctl.c:708 [inline]
>  SyS_ioctl+0x24/0x30 fs/ioctl.c:706
>  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> binder: 4624:4626 ioctl c0306201 20004000 returned -14
> 
> Freed by task 1891:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
>  __cache_free mm/slab.c:3486 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3801
> binder: BINDER_SET_CONTEXT_MGR already set
>  binder_free_transaction+0x6a/0xa0 drivers/android/binder.c:1966
>  binder_send_failed_reply+0x1c9/0x380 drivers/android/binder.c:2005
>  binder_thread_release+0x4cc/0x730 drivers/android/binder.c:4395
>  binder_deferred_release drivers/android/binder.c:4939 [inline]
>  binder_deferred_func+0x4f4/0x1350 drivers/android/binder.c:5022
>  process_one_work+0xc97/0x1c40 kernel/workqueue.c:2113
>  worker_thread+0x1c3/0x1380 kernel/workqueue.c:2247
>  kthread+0x33c/0x400 kernel/kthread.c:238
> binder: 4624:4627 ioctl 40046207 0 returned -16
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411
> 
> The buggy address belongs to the object at ffff8801d39a4200
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 16 bytes inside of
>  192-byte region [ffff8801d39a4200, ffff8801d39a42c0)
> The buggy address belongs to the page:
> page:ffffea00074e6900 count:1 mapcount:0 mapping:ffff8801d39a4000 index:0x0
> binder: 4624:4626 ioctl 400448c8 20000200 returned -22
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801d39a4000 0000000000000000 0000000100000010
> raw: ffffea000738fbe0 ffffea00074e6a60 ffff8801dac00040 0000000000000000
> page dumped because: kasan: bad access detected
> 
> binder_alloc: binder_alloc_mmap_handler: 4624 2000c000-2000e000 already
> mapped failed -16
> Memory state around the buggy address:
>  ffff8801d39a4100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8801d39a4180: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
> > ffff8801d39a4200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                          ^
>  ffff8801d39a4280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> binder_alloc: 4620: binder_alloc_buf, no vma
>  ffff8801d39a4300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title

Martijn, this is going to be fixed by
https://patchwork.kernel.org/patch/10312345/
("ANDROID: binder: prevent transactions into own process"), right?
The syzbot bug ID in that patch is for a bug that is already closed,
so if it's not too late you should use this one.

- Eric
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
