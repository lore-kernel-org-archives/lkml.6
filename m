Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3056513-1522810932-2-14691992897150834001
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.1
X-Spam-hits: BAYES_00 -1.9, FROM_LOCAL_HEX 0.006, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  HEXHASH_WORD 1.624, RCVD_IN_DNSWL_MED -2.3, SORTED_RECIPS 2.499,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522810931; b=xDx+RoyM0JtUn8syHVwB22BxBh1BT3taZr3zb2vJHYjeoXSG9d
    q4HYRoFcGkmh0OVxp9lmZT2HvfeTiZ2WmRdhIMPkB23Bv1XmNS6EstaIkgNoyUnf
    eZ9/oSObLKIxv0SofYS3S6oxK5W1gM0gUg1wcp4YCnbU7dnoN//mz976uVeisf+x
    x5pbPa/bVIDSn7c+yAjCIbKDVrlUU2Oof60Bhfv0IffDtoZv2sajS3YAOflATgbh
    Eat71pbYE2NaPas1vDCJAcAedyi8U6Mfud7enrwMFSsRceYKmiKOmjmul6YQmYYo
    UF0HgBn2ogqIviLkceOEZciOYzTtzLrPzWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:date:message-id:subject:from
    :to:list-id:list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:content-transfer-encoding:content-type:sender;
    s=fm2; t=1522810931; bh=Lado7811KqRoNDKHGhNemiB7OiTPrCSumb1g5lC
    7nPY=; b=o6qze4HlwZXZCGwJ24JTWOzODBYp5hYvox68bgJRnvUYBKKLA/agdE7
    tSoOBbv/KLSMmWJiFEcmvvemrfClsJfmrQgGM7Pqw/GKGJNe5gdb3FTr0OMqzdQr
    j3Vg+antdzCpO114yBAs+58DVjdhqAPbvmQl7zoLV5Ft/4aZa2zD2IHJ+PeCW+ar
    yuh5ikEyvtp8WPRJWmncfcODw8aA675+grZoddOek6Bu/kjmIS4FQloKDlxvLXBD
    8OIIz9S/GRlARXD5lkUnBH3drFOzON/muw2cYI95KjPPa1alHamrzV6SX+3x0es/
    1a6yzuEbXpw0gpYIEefQctCoBmuc6MA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=syzkaller.appspotmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NhpSiw14;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=syzkaller.appspotmail.com header.result=pass header_org.domain=appspotmail.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=49 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=syzkaller.appspotmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NhpSiw14;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=syzkaller.appspotmail.com header.result=pass header_org.domain=appspotmail.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=49 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPIAbvpdUwY3IozqEnOTSZwvxZXPEOhgCx6iJZ8+Lm/1iqcVaUfIo/Zaty6+dMN1/wfxc3eQdXGB2XRlKCx/RqV8SnxlPkH9M8+zlWauGr8kcsbBMDlr
    50UU7E4lIju0fTV1dnflNIb7Te40rprfacsEfN8/gcLhI8CpDWOPNVgAqHkJH5IeP8jjzo0USsOmi3OjDVg0wK4/fKawEI6NO3OTX/mZA+8GfJwletMexNns
    MHW1SP5l6p1evSNmcgt29Q==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8
    a=hSkVLCK3AAAA:8 a=mzoz-TVAAAAA:20 a=4RBUngkUAAAA:8 a=DDOyTI_5AAAA:8
    a=YTh6j2p5y9rnolt21SgA:9 a=2BgFRX3yVZY9aF1g:21 a=E9egMsVkgrvRCV19:21
    a=CjuIK1q_8ugA:10 a=vVHabExCe68A:10 a=AjGcO6oz07-iQ99wixmX:22
    a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48rupwhgaU6LaAquFUucfE8wXFoEdCbVMpG3fMOqHIycxjrN6wYLvdqvHRKeJUdRucnwoxH30LFch0XJ+o+x9F581zjzm0Q
MIME-Version: 1.0
Date: Tue, 03 Apr 2018 20:02:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113f8f14113e790568fd0c02@google.com>
Subject: KASAN: use-after-free Read in binder_release_work
From: syzbot <syzbot+0cf1f1aa154f56ff2e8d@syzkaller.appspotmail.com>
To: arve@android.com, devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, maco@android.com,
 syzkaller-bugs@googlegroups.com, tkjos@android.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
f2d285669aae656dfeafa0bf25e86bbbc5d22329 (Tue Apr 3 17:45:39 2018 +0000)
Merge tag 'pm-4.17-rc1' of  
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=0cf1f1aa154f56ff2e8d

So far this crash happened 4 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4827186146050048
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6025869373997056
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4772918563176448
Kernel config: https://syzkaller.appspot.com/x/.config?id=686016073509112605
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0cf1f1aa154f56ff2e8d@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

binder: 4616:4618 transaction failed 29189/-3, size 0-0 line 2963
binder: release 4616:4618 transaction 114 in, still active
binder: send failed reply for transaction 114 to 4616:4618
binder: 4620:4621 ioctl 400448c8 20000200 returned -22
==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0x144/0x150  
lib/list_debug.c:54
Read of size 8 at addr ffff8801d39a4210 by task kworker/1:2/1891

CPU: 1 PID: 1891 Comm: kworker/1:2 Not tainted 4.16.0+ #378
binder: release 4620:4621 transaction 118 out, still active
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events binder_deferred_func
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x1a7/0x27d lib/dump_stack.c:53
binder: release 4620:4621 transaction 117 in, still active
  print_address_description+0x73/0x250 mm/kasan/report.c:256
binder: undelivered TRANSACTION_COMPLETE
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report+0x23c/0x360 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
binder: BINDER_SET_CONTEXT_MGR already set
  __list_del_entry_valid+0x144/0x150 lib/list_debug.c:54
binder: 4620:4622 ioctl 40046207 0 returned -16
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_init include/linux/list.h:159 [inline]
  binder_dequeue_work_head_ilocked drivers/android/binder.c:893 [inline]
  binder_dequeue_work_head drivers/android/binder.c:913 [inline]
  binder_release_work+0x163/0x4b0 drivers/android/binder.c:4191
binder: 4620:4621 ioctl c0306201 20004000 returned -14
binder: 4620:4621 ioctl 400448c8 20000200 returned -22
  binder_thread_release+0x4e1/0x730 drivers/android/binder.c:4396
binder_alloc: binder_alloc_mmap_handler: 4620 2000c000-2000e000 already  
mapped failed -16
  binder_deferred_release drivers/android/binder.c:4939 [inline]
  binder_deferred_func+0x4f4/0x1350 drivers/android/binder.c:5022
binder_alloc: 4620: binder_alloc_buf, no vma
binder: 4620:4623 transaction failed 29189/-3, size 0-0 line 2963
  process_one_work+0xc97/0x1c40 kernel/workqueue.c:2113
binder_alloc: 4620: binder_alloc_buf, no vma
binder: 4620:4621 transaction failed 29189/-3, size 0-0 line 2963
binder: release 4620:4622 transaction 118 in, still active
binder: release 4620:4622 transaction 117 out, still active
  worker_thread+0x1c3/0x1380 kernel/workqueue.c:2247
binder: send failed reply for transaction 118, target dead
binder: send failed reply for transaction 117, target dead
binder: BINDER_SET_CONTEXT_MGR already set
binder: 4624:4625 ioctl 40046207 0 returned -16
  kthread+0x33c/0x400 kernel/kthread.c:238
binder: 4624:4625 ioctl 400448c8 20000200 returned -22
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411

binder_alloc: 4620: binder_alloc_buf, no vma
Allocated by task 4618:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
binder: 4624:4626 transaction failed 29189/-3, size 0-0 line 2963
  kmem_cache_alloc_trace+0x136/0x740 mm/slab.c:3608
  kmalloc include/linux/slab.h:512 [inline]
  kzalloc include/linux/slab.h:701 [inline]
  binder_transaction+0x13d2/0x8200 drivers/android/binder.c:2900
  binder_thread_write+0xcf1/0x38b0 drivers/android/binder.c:3513
  binder_ioctl_write_read.isra.39+0x261/0xcb0 drivers/android/binder.c:4451
  binder_ioctl+0xb72/0x1417 drivers/android/binder.c:4591
binder: undelivered TRANSACTION_ERROR: 29189
  vfs_ioctl fs/ioctl.c:46 [inline]
  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
  ksys_ioctl+0x94/0xb0 fs/ioctl.c:701
  SYSC_ioctl fs/ioctl.c:708 [inline]
  SyS_ioctl+0x24/0x30 fs/ioctl.c:706
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
binder: 4624:4626 ioctl c0306201 20004000 returned -14

Freed by task 1891:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
  set_track mm/kasan/kasan.c:459 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
  __cache_free mm/slab.c:3486 [inline]
  kfree+0xd9/0x260 mm/slab.c:3801
binder: BINDER_SET_CONTEXT_MGR already set
  binder_free_transaction+0x6a/0xa0 drivers/android/binder.c:1966
  binder_send_failed_reply+0x1c9/0x380 drivers/android/binder.c:2005
  binder_thread_release+0x4cc/0x730 drivers/android/binder.c:4395
  binder_deferred_release drivers/android/binder.c:4939 [inline]
  binder_deferred_func+0x4f4/0x1350 drivers/android/binder.c:5022
  process_one_work+0xc97/0x1c40 kernel/workqueue.c:2113
  worker_thread+0x1c3/0x1380 kernel/workqueue.c:2247
  kthread+0x33c/0x400 kernel/kthread.c:238
binder: 4624:4627 ioctl 40046207 0 returned -16
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411

The buggy address belongs to the object at ffff8801d39a4200
  which belongs to the cache kmalloc-192 of size 192
The buggy address is located 16 bytes inside of
  192-byte region [ffff8801d39a4200, ffff8801d39a42c0)
The buggy address belongs to the page:
page:ffffea00074e6900 count:1 mapcount:0 mapping:ffff8801d39a4000 index:0x0
binder: 4624:4626 ioctl 400448c8 20000200 returned -22
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801d39a4000 0000000000000000 0000000100000010
raw: ffffea000738fbe0 ffffea00074e6a60 ffff8801dac00040 0000000000000000
page dumped because: kasan: bad access detected

binder_alloc: binder_alloc_mmap_handler: 4624 2000c000-2000e000 already  
mapped failed -16
Memory state around the buggy address:
  ffff8801d39a4100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801d39a4180: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
> ffff8801d39a4200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff8801d39a4280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
binder_alloc: 4620: binder_alloc_buf, no vma
  ffff8801d39a4300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
If you want to test a patch for this bug, please reply with:
#syz test: git://repo/address.git branch
and provide the patch inline or as an attachment.
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
