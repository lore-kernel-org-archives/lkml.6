Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A9CECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1B5208DE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1B5208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbeGONwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 09:52:05 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:53498 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbeGONwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 09:52:04 -0400
Received: by mail-io0-f200.google.com with SMTP id o24-v6so32337747iob.20
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 06:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0ubL1CPEg/Ks7YdQk9SFlErjEauL3WWCNG1IcrDth94=;
        b=MTIL2YFqmpB0qDtB+ocO0Wvw+SoyGwwhxLraDbOF5HfCvrC7cSK3SWISOtsKdgp+25
         9Ku0dkaQWdk9668KFbWOf3QZQIb9+2ntYg8mEev+RCbghy5VMRuQMaiOFRfKTgDhhRka
         Pk35o4TzLcQTKBkkMwMPYEhzrMAZ8/Y7lI5xAEMK2n+Qc6oUVd73Kf9e0/H/vef5SNjK
         /yT3ek5M8BCjN937nCFDzTL1hICdCXN+U2s1D5tQYmq24eoEkGqTSPJqNzjBGkLTOG0/
         HZioO4TXJUXoYsNI99sLayxgY8dDLVn4j7ZaOCMdwSfijQOC7TOjdTsAi5gMtj/W76t4
         Y1pw==
X-Gm-Message-State: AOUpUlFInKoa3NS7aE69ZvDS8oY2O4tysAS3ZocfflJttVzS4aV0eww3
        6KJuqFnl9b42n5SDEt3npbN/PI4TRRLHDR/m4CTpgXW6Q7Qg
X-Google-Smtp-Source: AAOMgpcwlQHzaKPbMluUYvXiFPGfrdf9T5wHEX71DZBmgVCN4pwVOzDZ9dD8AhMVmwdJ9T/BMCgS9+1uUWaKiL6A3vO0rPsSzw/s
MIME-Version: 1.0
X-Received: by 2002:a24:eb03:: with SMTP id h3-v6mr5435233itj.28.1531661345023;
 Sun, 15 Jul 2018 06:29:05 -0700 (PDT)
Date:   Sun, 15 Jul 2018 06:29:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063079a057109b225@google.com>
Subject: WARNING: kernel stack regs has bad value (2)
From:   syzbot <syzbot+adcfacd9eff46da50187@syzkaller.appspotmail.com>
To:     hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c31496dbacc2 Merge tag 'for-linus-4.18-rc5-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a07b70400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=adcfacd9eff46da50187
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1059cf0c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145325d0400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+adcfacd9eff46da50187@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
WARNING: kernel stack regs at (____ptrval____) in syz-executor095:4533 has  
bad 'bp' value (____ptrval____)
unwind stack type:0 next_sp:          (null) mask:0x2 graph_idx:0
(____ptrval____): ffff8801ac6ee7d0 (0xffff8801ac6ee7d0)
(____ptrval____): ffffffff812d369d (__save_stack_trace+0x7d/0xf0)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6e8000 (0xffff8801ac6e8000)
(____ptrval____): ffff8801ac6f0000 (0xffff8801ac6f0000)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 0000000000000002 (0x2)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): 0000010100000000 (0x10100000000)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6ee740 (0xffff8801ac6ee740)
(____ptrval____): ffffffff811f4748 (vmx_vcpu_run+0x1328/0x2600)
(____ptrval____): ffff8801ac6ef2c8 (0xffff8801ac6ef2c8)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): ffff8801ac6ee930 (0xffff8801ac6ee930)
(____ptrval____): ffffffff8a1c3468 (stack_trace+0xa2b48/0x400020)
(____ptrval____): ffff8801ac6ee934 (0xffff8801ac6ee934)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): ffff8801ac6ee7e0 (0xffff8801ac6ee7e0)
(____ptrval____): ffffffff812d372a (save_stack_trace+0x1a/0x20)
(____ptrval____): ffff8801ac6ee820 (0xffff8801ac6ee820)
(____ptrval____): ffffffff815e0c40 (save_trace+0xe0/0x290)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): ffff8801ac1c0fb8 (0xffff8801ac1c0fb8)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): dffffc0000000000 (0xdffffc0000000000)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): ffff8801ac1c0fd8 (0xffff8801ac1c0fd8)
(____ptrval____): ffff8801ac6eebc0 (0xffff8801ac6eebc0)
(____ptrval____): ffffffff815ee1b8 (__lock_acquire+0x39a8/0x5020)
(____ptrval____): ffff8801ac6ee828 (0xffff8801ac6ee828)
(____ptrval____): ffffffff00000002 (0xffffffff00000002)
(____ptrval____): ffff8801ac1c1028 (0xffff8801ac1c1028)
(____ptrval____): ffff8801ac1c0fb0 (0xffff8801ac1c0fb0)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): 3cec49f900000001 (0x3cec49f900000001)
(____ptrval____): 3cec49f9674b576e (0x3cec49f9674b576e)
(____ptrval____): fffffbfff1566074 (0xfffffbfff1566074)
(____ptrval____): ecb7e67100000000 (0xecb7e67100000000)
(____ptrval____): ffff8801ac6ee8f0 (0xffff8801ac6ee8f0)
(____ptrval____): ffff880100000001 (0xffff880100000001)
(____ptrval____): ffffed00358ddd1e (0xffffed00358ddd1e)
(____ptrval____): ffff8801ac6ee930 (0xffff8801ac6ee930)
(____ptrval____): ffff8801ac6ee970 (0xffff8801ac6ee970)
(____ptrval____): ffff8801ac1c1000 (0xffff8801ac1c1000)
(____ptrval____): ffff8801ac1c0fb0 (0xffff8801ac1c0fb0)
(____ptrval____): ffff8801ac1c0fa8 (0xffff8801ac1c0fa8)
(____ptrval____): ffff8801ac1c0fb8 (0xffff8801ac1c0fb8)
(____ptrval____): 1ffff100358ddd1a (0x1ffff100358ddd1a)
(____ptrval____): ffff8801ac1c0fe0 (0xffff8801ac1c0fe0)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bf1308 (K512_4+0x6788/0x12085c)
(____ptrval____): ffffffff815ea810 (trace_hardirqs_on+0x10/0x10)
(____ptrval____): ffffc90001e356a8 (0xffffc90001e356a8)
(____ptrval____): ffff8801ac6ee920 (0xffff8801ac6ee920)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6ee9c0 (0xffff8801ac6ee9c0)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): ffff8801ac6ee920 (0xffff8801ac6ee920)
(____ptrval____): ffffffff817c0c08 (__sanitizer_cov_trace_cmp8+0x18/0x20)
(____ptrval____): ffff8801ac6eeaa8 (0xffff8801ac6eeaa8)
(____ptrval____): ffffffff81118bc8 (gfn_to_rmap+0x498/0x860)
(____ptrval____): 0006ba970000000b (0x6ba970000000b)
(____ptrval____): ffffffff8a1c3468 (stack_trace+0xa2b48/0x400020)
(____ptrval____): ffff880100000000 (0xffff880100000000)
(____ptrval____): ffff8801abc3ecf0 (0xffff8801abc3ecf0)
(____ptrval____): ffff8801ca1a0848 (0xffff8801ca1a0848)
(____ptrval____): ffff8801ca1a0840 (0xffff8801ca1a0840)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bda700 (regoff.34024+0x36cce0/0x37af60)
(____ptrval____): ffffffff81118730 (fast_page_fault+0x10d0/0x10d0)
(____ptrval____): ffffffff88bd51c7 (regoff.34024+0x3677a7/0x37af60)
(____ptrval____): ffffffff8a5a4e70 (lock_classes+0x3c4b0/0x29fee0)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): ffff8801ac6ee9a0 (0xffff8801ac6ee9a0)
(____ptrval____): ffffffff817c0c88  
(__sanitizer_cov_trace_const_cmp8+0x18/0x20)
(____ptrval____): 1ffff100358ddd3c (0x1ffff100358ddd3c)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffffea0006d60000 (0xffffea0006d60000)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd7c30 (regoff.34024+0x36a210/0x37af60)
(____ptrval____): ffffffff815e86f0 (print_usage_bug+0xc0/0xc0)
(____ptrval____): ffffffff81086081 (kvm_release_pfn_clean+0xa1/0x2d0)
(____ptrval____): 000000028111b6d0 (0x28111b6d0)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd7160 (regoff.34024+0x369740/0x37af60)
(____ptrval____): ffffffff81085fe0 (kvm_pfn_to_page+0xa0/0xa0)
(____ptrval____): ffff8801ca1abc48 (0xffff8801ca1abc48)
(____ptrval____): 1ffff10000000002 (0x1ffff10000000002)
(____ptrval____): ffffed0000000018 (0xffffed0000000018)
(____ptrval____): ffff8801ca1a0840 (0xffff8801ca1a0840)
(____ptrval____): ffff8801ca1a0848 (0xffff8801ca1a0848)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bda700 (regoff.34024+0x36cce0/0x37af60)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd51c7 (regoff.34024+0x3677a7/0x37af60)
(____ptrval____): ffffffff815e16e0 (graph_lock+0x170/0x170)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffffffff817c0c88  
(__sanitizer_cov_trace_const_cmp8+0x18/0x20)
(____ptrval____): ffff8801ac6eeaa8 (0xffff8801ac6eeaa8)
(____ptrval____): ffffffff8110c54e (pte_list_add.isra.63+0x5e/0x460)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): ffff8801ac368000 (0xffff8801ac368000)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): 00000000000002e0 (0x2e0)
(____ptrval____): ffff8801ac1c0fda (0xffff8801ac1c0fda)
(____ptrval____): 0000000000000082 (0x82)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): 000000000000000d (0xd)
(____ptrval____): ffff8801ac6eee58 (0xffff8801ac6eee58)
(____ptrval____): ffffffff815eb00c (__lock_acquire+0x7fc/0x5020)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac1c1008 (0xffff8801ac1c1008)
(____ptrval____): ffffc90001e2c018 (0xffffc90001e2c018)
(____ptrval____): ffffc90001e2c018 (0xffffc90001e2c018)
(____ptrval____): 0000000000000002 (0x2)
(____ptrval____): ffff8801ac6eeb40 (0xffff8801ac6eeb40)
(____ptrval____): ffffffff815e1fe6 (find_held_lock+0x36/0x1c0)
(____ptrval____): 00000003ac6eeb50 (0x3ac6eeb50)
(____ptrval____): ffff8801ac6eeb98 (0xffff8801ac6eeb98)
(____ptrval____): 1ffff100358ddd6f (0x1ffff100358ddd6f)
(____ptrval____): ffff8801ac6eec58 (0xffff8801ac6eec58)
(____ptrval____): ffffc90001e2c018 (0xffffc90001e2c018)
(____ptrval____): ffff8801ac1c0fd0 (0xffff8801ac1c0fd0)
(____ptrval____): ffff880100000000 (0xffff880100000000)
(____ptrval____): ffff8801ac1c0fd8 (0xffff8801ac1c0fd8)
(____ptrval____): ffff8801ac1c0fb0 (0xffff8801ac1c0fb0)
(____ptrval____): ffffffff89f5b1c8 (lock_chains+0x42ac8/0x200020)
(____ptrval____): ffff8801ac1c0fb8 (0xffff8801ac1c0fb8)
(____ptrval____): 1ffff100358ddd6e (0x1ffff100358ddd6e)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bf1308 (K512_4+0x6788/0x12085c)
(____ptrval____): ffffffff815ea810 (trace_hardirqs_on+0x10/0x10)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): ffff8801ac6eec90 (0xffff8801ac6eec90)
(____ptrval____): 1ffff100358ddd83 (0x1ffff100358ddd83)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6eece0 (0xffff8801ac6eece0)
(____ptrval____): ffffffff815f1934 (lock_acquire+0x1e4/0x540)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffffffff8162e471 (vprintk_emit+0x191/0xdf0)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffffffff81601b47 (do_raw_spin_unlock+0xa7/0x2f0)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): 0000000000000086 (0x86)
(____ptrval____): 0000000081601aa0 (0x81601aa0)
(____ptrval____): ffffffff88f89118 (logbuf_lock+0x18/0x60)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd51c7 (regoff.34024+0x3677a7/0x37af60)
(____ptrval____): ffffffff815f1750 (lock_release+0xa30/0xa30)
(____ptrval____): ffff8801ac6eec40 (0xffff8801ac6eec40)
(____ptrval____): ffffffff81b9da54 (kasan_check_write+0x14/0x20)
(____ptrval____): ffff8801ac6eec78 (0xffff8801ac6eec78)
(____ptrval____): ffffffff816017a1 (do_raw_spin_lock+0xc1/0x200)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): ffffc90001e2c000 (0xffffc90001e2c000)
(____ptrval____): ffff8801ac6eee18 (0xffff8801ac6eee18)
(____ptrval____): ffff8801ac2d0040 (0xffff8801ac2d0040)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6eec98 (0xffff8801ac6eec98)
(____ptrval____): ffffffff87940252 (_raw_spin_unlock+0x22/0x30)
(____ptrval____): ffff8801ac6eee98 (0xffff8801ac6eee98)
(____ptrval____): ffff8801ac6eeec0 (0xffff8801ac6eeec0)
(____ptrval____): ffffffff8113e294 (tdp_page_fault+0x194/0xc00)
(____ptrval____): 00000000817c0be6 (0x817c0be6)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): ffffffff88f89100 (log_wait+0x80/0x80)
(____ptrval____): 00000000ffffffff (0xffffffff)
(____ptrval____): ffffffff87ea6e00 (__func__.46424+0x1b60/0x1fe0)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6eef18 (0xffff8801ac6eef18)
(____ptrval____): ffff8801ac6eed00 (0xffff8801ac6eed00)
(____ptrval____): ffffffff8794009a (_raw_spin_lock+0x2a/0x40)
(____ptrval____): ffffffff8162e471 (vprintk_emit+0x191/0xdf0)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6eeea0 (0xffff8801ac6eeea0)
(____ptrval____): ffffffff8162e471 (vprintk_emit+0x191/0xdf0)
(____ptrval____): ffff880100000000 (0xffff880100000000)
(____ptrval____): ffffffff815eb000 (__lock_acquire+0x7f0/0x5020)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 1ffff100358dddab (0x1ffff100358dddab)
(____ptrval____): ffffffff88bf1398 (K512_4+0x6818/0x12085c)
(____ptrval____): ffffff00815f0d20 (0xffffff00815f0d20)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 0000000000000093 (0x93)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bf2640 (K512_4+0x7ac0/0x12085c)
(____ptrval____): ffffffff8162e2e0 (wake_up_klogd+0x110/0x110)
(____ptrval____): ffffffff88bd51c7 (regoff.34024+0x3677a7/0x37af60)
(____ptrval____): ffffffff815f1750 (lock_release+0xa30/0xa30)
(____ptrval____): ffff8801ac6eff48 (0xffff8801ac6eff48)
(____ptrval____): 1ffff100358dddbe (0x1ffff100358dddbe)
(____ptrval____): ffff8801daf236a0 (0xffff8801daf236a0)
(____ptrval____): 1ffff10000000000 (0x1ffff10000000000)
(____ptrval____): ffff8801daf236b0 (0xffff8801daf236b0)
(____ptrval____): ffff8801ac6eedb8 (0xffff8801ac6eedb8)
(____ptrval____): ffffffff81b9da31 (kasan_check_read+0x11/0x20)
(____ptrval____): ffff8801ac6eee58 (0xffff8801ac6eee58)
(____ptrval____): ffffffff8166782c (rcu_is_watching+0x8c/0x150)
(____ptrval____): ffff8801ac6eeef8 (0xffff8801ac6eeef8)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff00000001 (0xffffffff00000001)
(____ptrval____): ffffffff816677a0 (rcu_report_qs_rnp+0x7a0/0x7a0)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): ffff8801ac6eee20 (0xffff8801ac6eee20)
(____ptrval____): ffffffff817c0c2a  
(__sanitizer_cov_trace_const_cmp1+0x1a/0x20)
(____ptrval____): ffff8801ac6eee70 (0xffff8801ac6eee70)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): 1ffff100358dddd6 (0x1ffff100358dddd6)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd51c7 (regoff.34024+0x3677a7/0x37af60)
(____ptrval____): ffffffff815e16e0 (graph_lock+0x170/0x170)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): ffffffff87ea6e00 (__func__.46424+0x1b60/0x1fe0)
(____ptrval____): ffff8801ac6eef18 (0xffff8801ac6eef18)
(____ptrval____): ffff8801ac6eef18 (0xffff8801ac6eef18)
(____ptrval____): 000000000000053b (0x53b)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6eeec0 (0xffff8801ac6eeec0)
(____ptrval____): ffffffff8162f598 (vprintk_default+0x28/0x30)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffffffff87ea6e00 (__func__.46424+0x1b60/0x1fe0)
(____ptrval____): ffff8801ac6eeee8 (0xffff8801ac6eeee8)
(____ptrval____): ffffffff8163181a (vprintk_func+0x7a/0xe7)
(____ptrval____): ffffed00358ddddf (0xffffed00358ddddf)
(____ptrval____): ffffffff87ea6e00 (__func__.46424+0x1b60/0x1fe0)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): ffff8801ac6eef98 (0xffff8801ac6eef98)
(____ptrval____): ffffffff816303cb (printk+0xa7/0xcf)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bebe8c (K512_4+0x130c/0x12085c)
(____ptrval____): ffffffff81630324 (kmsg_dump_rewind_nolock+0xe4/0xe4)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff880100000008 (0xffff880100000008)
(____ptrval____): ffff8801ac6eefa8 (0xffff8801ac6eefa8)
(____ptrval____): ffff8801ac6eef58 (0xffff8801ac6eef58)
(____ptrval____): ffff8801ac1c0fb0 (0xffff8801ac1c0fb0)
(____ptrval____): ffffffff88f925a0 (rcu_callback_map+0x40/0x40)
(____ptrval____): 0000000000000086 (0x86)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): 000000000000053b (0x53b)
(____ptrval____): ffffffff87e7a2c0 (__func__.46946+0x1e0/0xa00)
(____ptrval____): 000000000000053b (0x53b)
(____ptrval____): ffffffff81362e15 (__do_page_fault+0x395/0xe50)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 1ffff100358dddf5 (0x1ffff100358dddf5)
(____ptrval____): ffff8801ac1c0de8 (0xffff8801ac1c0de8)
(____ptrval____): ffff8801ac6ef028 (0xffff8801ac6ef028)
(____ptrval____): ffffffff8155ca72 (___might_sleep.cold.85+0x30/0x13a)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88be6507 (regoff.34024+0x378ae7/0x37af60)
(____ptrval____): ffffffff81542620 (check_same_owner+0x340/0x340)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): ffff8801ac2d0040 (0xffff8801ac2d0040)
(____ptrval____): 000000000000020e (0x20e)
(____ptrval____): ffff8801ac6ef248 (0xffff8801ac6ef248)
(____ptrval____): 000000000000020e (0x20e)
(____ptrval____): ffff8801ac6ef168 (0xffff8801ac6ef168)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): 0000000000000482 (0x482)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): ffffffff87e7a2c0 (__func__.46946+0x1e0/0xa00)
(____ptrval____): 000000000000053b (0x53b)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6ef068 (0xffff8801ac6ef068)
(____ptrval____): ffffffff815429e5 (__might_sleep+0x95/0x190)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): 00000000000059c6 (0x59c6)
(____ptrval____): 00000000000059c6 (0x59c6)
(____ptrval____): ffff8801ac6ef2c8 (0xffff8801ac6ef2c8)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6ef150 (0xffff8801ac6ef150)
(____ptrval____): ffffffff81362e36 (__do_page_fault+0x3b6/0xe50)
(____ptrval____): ffff8801ac6ef108 (0xffff8801ac6ef108)
(____ptrval____): ffffffff812d36ad (__save_stack_trace+0x8d/0xf0)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 00000014ac1c1000 (0x14ac1c1000)
(____ptrval____): 1ffff100358dde19 (0x1ffff100358dde19)
(____ptrval____): ffff8801d9073628 (0xffff8801d9073628)
(____ptrval____): ffff8801d9073580 (0xffff8801d9073580)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88be7a3b (regoff.34024+0x37a01b/0x37af60)
(____ptrval____): ffffffff81362a80 (mm_fault_error+0x380/0x380)
(____ptrval____): ffffffff815ea810 (trace_hardirqs_on+0x10/0x10)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bdde20 (regoff.34024+0x370400/0x37af60)
(____ptrval____): ffffffff81130880  
(kvm_mmu_slot_gfn_write_protect+0xd0/0xd0)
(____ptrval____): ffff8801d4379dc0 (0xffff8801d4379dc0)
(____ptrval____): ffff8801ac6ef108 (0xffff8801ac6ef108)
(____ptrval____): ffff8801ac6ef108 (0xffff8801ac6ef108)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): 1ffff100358dde2e (0x1ffff100358dde2e)
(____ptrval____): ffff8801ac6ef2c8 (0xffff8801ac6ef2c8)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 00000000000059c6 (0x59c6)
(____ptrval____): ffff8801ac6ef290 (0xffff8801ac6ef290)
(____ptrval____): ffff8801ac6ef2b8 (0xffff8801ac6ef2b8)
(____ptrval____): ffffffff813639f6 (do_page_fault+0xf6/0x8c0)
(____ptrval____): ffff8801ac2d0040 (0xffff8801ac2d0040)
(____ptrval____): 000000000000000d (0xd)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd5ac0 (regoff.34024+0x3680a0/0x37af60)
(____ptrval____): ffffffff81363900 (vmalloc_sync_all+0x30/0x30)
(____ptrval____): ffff8801ac6ef1d8 (0xffff8801ac6ef1d8)
(____ptrval____): ffffffff810da1ed (kvm_multiple_exception+0x22d/0x580)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 01ffffff00000001 (0x1ffffff00000001)
(____ptrval____): ffff8801ac6ef388 (0xffff8801ac6ef388)
(____ptrval____): ffff8801ac2d0040 (0xffff8801ac2d0040)
(____ptrval____): 000000000000000d (0xd)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6ef388 (0xffff8801ac6ef388)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6ef200 (0xffff8801ac6ef200)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd51c7 (regoff.34024+0x3677a7/0x37af60)
(____ptrval____): ffffffff815e16e0 (graph_lock+0x170/0x170)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): ffff8801ac6ef3b0 (0xffff8801ac6ef3b0)
(____ptrval____): ffffffff811d988b (handle_wrmsr+0x22b/0xa30)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): ffff8801ac6ef268 (0xffff8801ac6ef268)
(____ptrval____): 0000020e815e2225 (0x20e815e2225)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd7c30 (regoff.34024+0x36a210/0x37af60)
(____ptrval____): 0000000000000086 (0x86)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6ef2b0 (0xffff8801ac6ef2b0)
(____ptrval____): ffffffff81007d20 (trace_hardirqs_off_thunk+0x1a/0x1c)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6ef2c9 (0xffff8801ac6ef2c9)
(____ptrval____): ffffffff87a00fce (page_fault+0x1e/0x30)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac2d0040 (0xffff8801ac2d0040)
(____ptrval____): 0000000010000000 (0x10000000)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): 0000000000000286 (0x286)
(____ptrval____): ffffffff811f471a (vmx_vcpu_run+0x12fa/0x2600)
(____ptrval____): 1ffffffff11a2200 (0x1ffffffff11a2200)
(____ptrval____): ffffffff811f4727 (vmx_vcpu_run+0x1307/0x2600)
(____ptrval____): 0000000000000005 (0x5)
(____ptrval____): ffffffffffffffff (0xffffffffffffffff)
(____ptrval____): ffffffff811f4748 (vmx_vcpu_run+0x1328/0x2600)
(____ptrval____): 0000000000000010 (0x10)
(____ptrval____): 0000000000010046 (0x10046)
(____ptrval____): ffff8801ac6ef370 (0xffff8801ac6ef370)
(____ptrval____): 0000000000000018 (0x18)
(____ptrval____): 0000000000000286 (0x286)
(____ptrval____): ffffffff88d11000 (raw_data+0x2000/0x2000)
(____ptrval____): 0000000000000003 (0x3)
(____ptrval____): ffffffff88d11000 (raw_data+0x2000/0x2000)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6ef3b0 (0xffff8801ac6ef3b0)
(____ptrval____): ffff8801ac1c0ff8 (0xffff8801ac1c0ff8)
(____ptrval____): ffffffff00000001 (0xffffffff00000001)
(____ptrval____): ffff8801ac1c1000 (0xffff8801ac1c1000)
(____ptrval____): ffff8801ac1c0fb0 (0xffff8801ac1c0fb0)
(____ptrval____): ffff8801ac1c0fa8 (0xffff8801ac1c0fa8)
(____ptrval____): ffff8801ac1c0fb8 (0xffff8801ac1c0fb8)
(____ptrval____): 1ffff100358dde7c (0x1ffff100358dde7c)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bf1308 (K512_4+0x6788/0x12085c)
(____ptrval____): ffffffff815ea810 (trace_hardirqs_on+0x10/0x10)
(____ptrval____): 0000000000000286 (0x286)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 1ffff100358dde83 (0x1ffff100358dde83)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd51c7 (regoff.34024+0x3677a7/0x37af60)
(____ptrval____): ffffffff811ee670 (handle_vmfunc+0x9d0/0x9d0)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): dffffc0000000000 (0xdffffc0000000000)
(____ptrval____): 0000000000000007 (0x7)
(____ptrval____): ffffed00358381f6 (0xffffed00358381f6)
(____ptrval____): ffff8801ac6ef4b0 (0xffff8801ac6ef4b0)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd5e44 (regoff.34024+0x368424/0x37af60)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffffffff00000019 (0xffffffff00000019)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): ffffffff810e6589 (vcpu_enter_guest+0x11a9/0x6090)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): ffff8801ac2d0040 (0xffff8801ac2d0040)
(____ptrval____): ffffffff88d11000 (raw_data+0x2000/0x2000)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6ef840 (0xffff8801ac6ef840)
(____ptrval____): ffffffff810e743b (vcpu_enter_guest+0x205b/0x6090)
(____ptrval____): 0000000067966f00 (0x67966f00)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd51c7 (regoff.34024+0x3677a7/0x37af60)
(____ptrval____): ffffffff815e16e0 (graph_lock+0x170/0x170)
(____ptrval____): 0000000000000200 (0x200)
(____ptrval____): 0000000000231860 (0x231860)
(____ptrval____): ffff8801ac2d040c (0xffff8801ac2d040c)
(____ptrval____): ffff8801ac2d2bfc (0xffff8801ac2d2bfc)
(____ptrval____): ffff8801ac2d4400 (0xffff8801ac2d4400)
(____ptrval____): ffff8801ac2d0068 (0xffff8801ac2d0068)
(____ptrval____): ffffffec530b43e2 (0xffffffec530b43e2)
(____ptrval____): 1ffff100358ddeaa (0x1ffff100358ddeaa)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bdc660 (regoff.34024+0x36ec40/0x37af60)
(____ptrval____): ffffffff810e53e0 (kvm_set_msr_common+0x26a0/0x26a0)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): 0000000000004000 (0x4000)
(____ptrval____): ffffffff892b29b0 (depot_lock+0x10/0xfe0)
(____ptrval____): ffff8801ac6ef590 (0xffff8801ac6ef590)
(____ptrval____): ffffffff81b9da54 (kasan_check_write+0x14/0x20)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): 1ffff100358ddec8 (0x1ffff100358ddec8)
(____ptrval____): ffff8801ac1c0fb8 (0xffff8801ac1c0fb8)
(____ptrval____): ffff8801ac2d00f8 (0xffff8801ac2d00f8)
(____ptrval____): ffff8801ac2d00f8 (0xffff8801ac2d00f8)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6ef608 (0xffff8801ac6ef608)
(____ptrval____): ffffffff815e1fe6 (find_held_lock+0x36/0x1c0)
(____ptrval____): 00000001ac6ef5f0 (0x1ac6ef5f0)
(____ptrval____): ffff8801ac6ef660 (0xffff8801ac6ef660)
(____ptrval____): 1ffff100358ddec8 (0x1ffff100358ddec8)
(____ptrval____): ffff8801ac6ef720 (0xffff8801ac6ef720)
(____ptrval____): ffff8801ac2d00f8 (0xffff8801ac2d00f8)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): ffff8801ac6ef660 (0xffff8801ac6ef660)
(____ptrval____): ffff8801ac6ef748 (0xffff8801ac6ef748)
(____ptrval____): 0000000000000286 (0x286)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff00000001 (0xffffffff00000001)
(____ptrval____): ffff8801ac1c0fb0 (0xffff8801ac1c0fb0)
(____ptrval____): 0000000000000286 (0x286)
(____ptrval____): ffffffff00000001 (0xffffffff00000001)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bf1398 (K512_4+0x6818/0x12085c)
(____ptrval____): ffffffff815f0d20 (lock_downgrade+0x8f0/0x8f0)
(____ptrval____): ffffc90001e35da8 (0xffffc90001e35da8)
(____ptrval____): ffffc90000000000 (0xffffc90000000000)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): ffff8801ac6ef6b8 (0xffff8801ac6ef6b8)
(____ptrval____): ffffffff815e1fe6 (find_held_lock+0x36/0x1c0)
(____ptrval____): 00000002ac1c0780 (0x2ac1c0780)
(____ptrval____): ffff8801ac6ef6a0 (0xffff8801ac6ef6a0)
(____ptrval____): ffffffff8137bfbc (get_cpu_entry_area+0xc/0x30)
(____ptrval____): 1ffff100358dded7 (0x1ffff100358dded7)
(____ptrval____): ffff8801ac6ef730 (0xffff8801ac6ef730)
(____ptrval____): ffffffff812db0c1 (load_fixmap_gdt+0x111/0x180)
(____ptrval____): ffff8801ac6ef710 (0xffff8801ac6ef710)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88be44e7 (regoff.34024+0x376ac7/0x37af60)
(____ptrval____): ffffffff812dafb0 (load_direct_gdt+0x1c0/0x1c0)
(____ptrval____): ffff880100000002 (0xffff880100000002)
(____ptrval____): fe0000032000007f (0xfe0000032000007f)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffffffff00000002 (0xffffffff00000002)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bf1398 (K512_4+0x6818/0x12085c)
(____ptrval____): ffffffff815f0d20 (lock_downgrade+0x8f0/0x8f0)
(____ptrval____): 0000000000000003 (0x3)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): ffffffff8aa4cb60 (console_drivers+0x40/0x40)
(____ptrval____): dffffc0000000000 (0xdffffc0000000000)
(____ptrval____): ffff8801ac6ef748 (0xffff8801ac6ef748)
(____ptrval____): ffffffff81b9da54 (kasan_check_write+0x14/0x20)
(____ptrval____): ffff8801ac6ef8c8 (0xffff8801ac6ef8c8)
(____ptrval____): ffffffff879313e7 (__mutex_unlock_slowpath+0x197/0x8c0)
(____ptrval____): ffffffff88bdfcbf (regoff.34024+0x37229f/0x37af60)
(____ptrval____): ffffffff811dee00 (vmx_set_virtual_apic_mode+0x770/0x770)
(____ptrval____): 1ffff100358ddef0 (0x1ffff100358ddef0)
(____ptrval____): ffffed0000000000 (0xffffed0000000000)
(____ptrval____): fffffbfff1566074 (0xfffffbfff1566074)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bf0d20 (K512_4+0x61a0/0x12085c)
(____ptrval____): ffffffff87931250 (wait_for_completion+0x8d0/0x8d0)
(____ptrval____): ffffffff00000019 (0xffffffff00000019)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): ffff8801ac6ef7a0 (0xffff8801ac6ef7a0)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd5b9e (regoff.34024+0x36817e/0x37af60)
(____ptrval____): ffffffff8152e3b0 (kick_process+0x110/0x110)
(____ptrval____): ffff8801daf236a0 (0xffff8801daf236a0)
(____ptrval____): 1ffff100358ddf01 (0x1ffff100358ddf01)
(____ptrval____): ffff8801daf236b0 (0xffff8801daf236b0)
(____ptrval____): ffff8801ac6ef7f0 (0xffff8801ac6ef7f0)
(____ptrval____): ffffffff81b9da31 (kasan_check_read+0x11/0x20)
(____ptrval____): ffff8801ac6ef890 (0xffff8801ac6ef890)
(____ptrval____): ffffffff8166782c (rcu_is_watching+0x8c/0x150)
(____ptrval____): 1ffff100358ddf07 (0x1ffff100358ddf07)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd5b9e (regoff.34024+0x36817e/0x37af60)
(____ptrval____): ffffffff8166b8c0 (rcu_pm_notify+0xc0/0xc0)
(____ptrval____): ffffffffac1c0780 (0xffffffffac1c0780)
(____ptrval____): ffff8801ac1c0fb0 (0xffff8801ac1c0fb0)
(____ptrval____): ffffffff88f925a0 (rcu_callback_map+0x40/0x40)
(____ptrval____): 0000000000000286 (0x286)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): ffffffff88f925a0 (rcu_callback_map+0x40/0x40)
(____ptrval____): ffff8801ac2d0098 (0xffff8801ac2d0098)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6ef890 (0xffff8801ac6ef890)
(____ptrval____): 0000000000000286 (0x286)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): 0000000000000003 (0x3)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): ffffffff81071205 (kvm_vcpu_ioctl+0x2b5/0x1300)
(____ptrval____): ffff8801ac6ef8a8 (0xffff8801ac6ef8a8)
(____ptrval____): ffffffff8165d408 (rcu_read_lock_sched_held+0x108/0x120)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6ef8d8 (0xffff8801ac6ef8d8)
(____ptrval____): ffffffff81b9c089 (kfree+0x1e9/0x260)
(____ptrval____): 1ffff100358ddf20 (0x1ffff100358ddf20)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac2d0098 (0xffff8801ac2d0098)
(____ptrval____): ffff8801ac6efc08 (0xffff8801ac6efc08)
(____ptrval____): ffffffff8107120a (kvm_vcpu_ioctl+0x2ba/0x1300)
(____ptrval____): 000000008ac0dca8 (0x8ac0dca8)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bda5c8 (regoff.34024+0x36cba8/0x37af60)
(____ptrval____): ffffffff81070f50  
(kvm_uevent_notify_change.part.31+0x440/0x440)
(____ptrval____): ffffffff88f92620 (rcu_bh_lock_map+0x40/0x40)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6ef970 (0xffff8801ac6ef970)
(____ptrval____): ffffffff815e1fe6 (find_held_lock+0x36/0x1c0)
(____ptrval____): 00000001d4f4c698 (0x1d4f4c698)
(____ptrval____): ffff8801ac6ef9c8 (0xffff8801ac6ef9c8)
(____ptrval____): 1ffff100358ddf35 (0x1ffff100358ddf35)
(____ptrval____): ffff8801ac6efa88 (0xffff8801ac6efa88)
(____ptrval____): ffffffff88f92620 (rcu_bh_lock_map+0x40/0x40)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): ffff8801ac6ef9c8 (0xffff8801ac6ef9c8)
(____ptrval____): ffff8801ac6efab0 (0xffff8801ac6efab0)
(____ptrval____): 0000000000000286 (0x286)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff880100000001 (0xffff880100000001)
(____ptrval____): ffff8801ac1c0fb0 (0xffff8801ac1c0fb0)
(____ptrval____): 0000000000000286 (0x286)
(____ptrval____): ffffffff00000001 (0xffffffff00000001)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bf1398 (K512_4+0x6818/0x12085c)
(____ptrval____): ffffffff815f0d20 (lock_downgrade+0x8f0/0x8f0)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 00000000ac6efb10 (0xac6efb10)
(____ptrval____): ffffffff88f92620 (rcu_bh_lock_map+0x40/0x40)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801daf236a0 (0xffff8801daf236a0)
(____ptrval____): 1ffff100358ddf45 (0x1ffff100358ddf45)
(____ptrval____): ffff8801daf236b0 (0xffff8801daf236b0)
(____ptrval____): ffff8801ac6efa10 (0xffff8801ac6efa10)
(____ptrval____): ffffffff81b9da31 (kasan_check_read+0x11/0x20)
(____ptrval____): ffffffff89f1ab08 (lock_chains+0x2408/0x200020)
(____ptrval____): ffffffff8166782c (rcu_is_watching+0x8c/0x150)
(____ptrval____): ffff8801b2d33480 (0xffff8801b2d33480)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd5e44 (regoff.34024+0x368424/0x37af60)
(____ptrval____): ffffffff816677a0 (rcu_report_qs_rnp+0x7a0/0x7a0)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 1ffff100358ddf51 (0x1ffff100358ddf51)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd51c7 (regoff.34024+0x3677a7/0x37af60)
(____ptrval____): ffffffff815e16e0 (graph_lock+0x170/0x170)
(____ptrval____): ffff8801ac6efb10 (0xffff8801ac6efb10)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): 1ffff100358ddf5c (0x1ffff100358ddf5c)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): ffff8801ac6efb80 (0xffff8801ac6efb80)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6efba8 (0xffff8801ac6efba8)
(____ptrval____): ffffffff81cd723e (mntput_no_expire+0x18e/0xbc0)
(____ptrval____): ffffed00358ddf6a (0xffffed00358ddf6a)
(____ptrval____): 0000000000000008 (0x8)
(____ptrval____): ffff8801ac6efae8 (0xffff8801ac6efae8)
(____ptrval____): ffffffff87940252 (_raw_spin_unlock+0x22/0x30)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffffffff88bd51c7 (regoff.34024+0x3677a7/0x37af60)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): 1ffff100358ddf74 (0x1ffff100358ddf74)
(____ptrval____): ffff8801ac1c0fb8 (0xffff8801ac1c0fb8)
(____ptrval____): ffff8801ac1c0f10 (0xffff8801ac1c0f10)
(____ptrval____): ffff8801ac1c0f10 (0xffff8801ac1c0f10)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6efb68 (0xffff8801ac6efb68)
(____ptrval____): ffffffff815e1fe6 (find_held_lock+0x36/0x1c0)
(____ptrval____): 0000000141b58ab3 (0x141b58ab3)
(____ptrval____): ffff8801ac6efbc0 (0xffff8801ac6efbc0)
(____ptrval____): 1ffff100358ddf74 (0x1ffff100358ddf74)
(____ptrval____): ffff8801ac6efc80 (0xffff8801ac6efc80)
(____ptrval____): ffff8801ac1c0f10 (0xffff8801ac1c0f10)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): ffff8801ac6efbc0 (0xffff8801ac6efbc0)
(____ptrval____): ffff8801ac6efca8 (0xffff8801ac6efca8)
(____ptrval____): 0000000000000086 (0x86)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff880100000001 (0xffff880100000001)
(____ptrval____): ffff8801ac1c0fb0 (0xffff8801ac1c0fb0)
(____ptrval____): 0000000000000086 (0x86)
(____ptrval____): ffffffff00000001 (0xffffffff00000001)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bf1398 (K512_4+0x6818/0x12085c)
(____ptrval____): ffffffff815f0d20 (lock_downgrade+0x8f0/0x8f0)
(____ptrval____): ffff8801acec8000 (0xffff8801acec8000)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 00000000ac1c0fb0 (0xac1c0fb0)
(____ptrval____): ffff8801ac6efc08 (0xffff8801ac6efc08)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): ffff8801ad5f5500 (0xffff8801ad5f5500)
(____ptrval____): 1ffff100358ddf8a (0x1ffff100358ddf8a)
(____ptrval____): ffffffff81070f50  
(kvm_uevent_notify_change.part.31+0x440/0x440)
(____ptrval____): ffff8801ac6efc08 (0xffff8801ac6efc08)
(____ptrval____): ffffffff817c0c66  
(__sanitizer_cov_trace_const_cmp4+0x16/0x20)
(____ptrval____): ffff8801ac6efdb8 (0xffff8801ac6efdb8)
(____ptrval____): ffffffff81c946b1 (do_vfs_ioctl+0x201/0x1720)
(____ptrval____): ffffffff81601b47 (do_raw_spin_unlock+0xa7/0x2f0)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd5e44 (regoff.34024+0x368424/0x37af60)
(____ptrval____): ffffffff81601aa0 (do_raw_spin_trylock+0x1c0/0x1c0)
(____ptrval____): ffff8801ac1c0fb0 (0xffff8801ac1c0fb0)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88c0a198 (K512_4+0x1f618/0x12085c)
(____ptrval____): ffffffff81c944b0 (ioctl_preallocate+0x300/0x300)
(____ptrval____): ffffffff817c0c66  
(__sanitizer_cov_trace_const_cmp4+0x16/0x20)
(____ptrval____): ffff8801ac6efda0 (0xffff8801ac6efda0)
(____ptrval____): ffffffff81cc9107 (__fget_light+0x2f7/0x440)
(____ptrval____): ffffffff815ea661 (trace_hardirqs_on_caller+0x421/0x5c0)
(____ptrval____): 00004000ac1c0ef8 (0x4000ac1c0ef8)
(____ptrval____): ffff8801d03f1b98 (0xffff8801d03f1b98)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd7800 (regoff.34024+0x369de0/0x37af60)
(____ptrval____): ffffffff81cc8e10 (fget_raw+0x20/0x20)
(____ptrval____): ffff8801ac6efcc0 (0xffff8801ac6efcc0)
(____ptrval____): ffffffff00000001 (0xffffffff00000001)
(____ptrval____): ffff8801ac6efd78 (0xffff8801ac6efd78)
(____ptrval____): ffffffff81510c0f (task_work_run+0x22f/0x2a0)
(____ptrval____): 1ffff100358ddf9e (0x1ffff100358ddf9e)
(____ptrval____): ffff8801ac1c0ef8 (0xffff8801ac1c0ef8)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffff8801d03f1b98 (0xffff8801d03f1b98)
(____ptrval____): ffffffff815109e0 (task_work_cancel+0x250/0x250)
(____ptrval____): ffff8801ac1c0fb0 (0xffff8801ac1c0fb0)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801d03f1c00 (0xffff8801d03f1c00)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): ffffffff8100ab9c (exit_to_usermode_loop+0x8c/0x370)
(____ptrval____): ffff8801ac6efdf8 (0xffff8801ac6efdf8)
(____ptrval____): ffff8801ad5f5500 (0xffff8801ad5f5500)
(____ptrval____): 1ffff100358ddfdc (0x1ffff100358ddfdc)
(____ptrval____): ffff8801ac6efd58 (0xffff8801ac6efd58)
(____ptrval____): ffffffff817c0c66  
(__sanitizer_cov_trace_const_cmp4+0x16/0x20)
(____ptrval____): ffff8801ac6efe08 (0xffff8801ac6efe08)
(____ptrval____): ffffffff8148be96 (do_group_exit+0xb6/0x440)
(____ptrval____): ffff8801ac6efd78 (0xffff8801ac6efd78)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): ffff8801ac6efdb8 (0xffff8801ac6efdb8)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd5b9e (regoff.34024+0x36817e/0x37af60)
(____ptrval____): ffffffff8148bde0 (__ia32_sys_exit+0x50/0x50)
(____ptrval____): ffff8801ad5f5500 (0xffff8801ad5f5500)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6efdb8 (0xffff8801ac6efdb8)
(____ptrval____): ffff8801ac1c0fb0 (0xffff8801ac1c0fb0)
(____ptrval____): ffff8801ac6efdf8 (0xffff8801ac6efdf8)
(____ptrval____): ffffffff81c95c51 (ksys_ioctl+0x81/0xd0)
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): ffffffff8100c3ba (do_syscall_64+0x9a/0x820)
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 1ffff100358ddfc8 (0x1ffff100358ddfc8)
(____ptrval____): ffff8801ac6eff20 (0xffff8801ac6eff20)
(____ptrval____): ffff8801ac6eff58 (0xffff8801ac6eff58)
(____ptrval____): dffffc0000000000 (0xdffffc0000000000)
(____ptrval____): ffff8801ac6efe20 (0xffff8801ac6efe20)
(____ptrval____): ffffffff8148c25e (__x64_sys_exit_group+0x3e/0x50)
(____ptrval____): 00000000000000e7 (0xe7)
(____ptrval____): ffff8801ac6eff48 (0xffff8801ac6eff48)
(____ptrval____): ffffffff8100c4d9 (do_syscall_64+0x1b9/0x820)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd5a98 (regoff.34024+0x368078/0x37af60)
(____ptrval____): ffffffff8100c320 (syscall_return_slowpath+0x5e0/0x5e0)
(____ptrval____): ffff8801ac6efe68 (0xffff8801ac6efe68)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6eff48 (0xffff8801ac6eff48)
(____ptrval____): ffffffff8100c05d (syscall_return_slowpath+0x31d/0x5e0)
(____ptrval____): ffff8801ac6eff58 (0xffff8801ac6eff58)
(____ptrval____): 0000000041b58ab3 (0x41b58ab3)
(____ptrval____): ffffffff88bd51c7 (regoff.34024+0x3677a7/0x37af60)
(____ptrval____): ffff8801ac1c0fb0 (0xffff8801ac1c0fb0)
(____ptrval____): ffff8801ac6efea8 (0xffff8801ac6efea8)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac1c0780 (0xffff8801ac1c0780)
(____ptrval____): ffffffff87a0009d  
(entry_SYSCALL_64_after_hwframe+0x59/0xbe)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 0000000000000086 (0x86)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffff8801ac6eff48 (0xffff8801ac6eff48)
(____ptrval____): ffffffff81007d20 (trace_hardirqs_off_thunk+0x1a/0x1c)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ecb7e67167966f00 (0xecb7e67167966f00)
(____ptrval____): 0000000000000000 ...
(____ptrval____): ffffffff87a0008d  
(entry_SYSCALL_64_after_hwframe+0x49/0xbe)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 00000000006d3180 (0x6d3180)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): 00000000004c1a28 (0x4c1a28)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 0000000000000246 (0x246)
(____ptrval____): 0000000000000001 (0x1)
(____ptrval____): ffffffffffffffd0 (0xffffffffffffffd0)
(____ptrval____): 00000000000000e7 (0xe7)
(____ptrval____): ffffffffffffffda (0xffffffffffffffda)
(____ptrval____): 0000000000441d38 (0x441d38)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 000000000000003c (0x3c)
(____ptrval____): 0000000000000000 ...
(____ptrval____): 00000000000000e7 (0xe7)
(____ptrval____): 0000000000441d38 (0x441d38)
(____ptrval____): 0000000000000033 (0x33)
(____ptrval____): 0000000000000246 (0x246)
(____ptrval____): 00007ffcbeaa59c8 (0x7ffcbeaa59c8)
(____ptrval____): 000000000000002b (0x2b)
BUG: sleeping function called from invalid context at  
arch/x86/mm/fault.c:1339
in_atomic(): 0, irqs_disabled(): 1, pid: 4533, name: syz-executor095
1 lock held by syz-executor095/4533:
  #0: (____ptrval____) (&mm->mmap_sem){++++}, at:  
__do_page_fault+0x389/0xe50 arch/x86/mm/fault.c:1325
irq event stamp: 11468
hardirqs last  enabled at (11467): [<ffffffff8100c3ba>]  
do_syscall_64+0x9a/0x820 arch/x86/entry/common.c:277
hardirqs last disabled at (11468): [<ffffffff87a01166>]  
error_entry+0x76/0xd0 arch/x86/entry/entry_64.S:1262
softirqs last  enabled at (11202): [<ffffffff87c00780>]  
__do_softirq+0x780/0xb17 kernel/softirq.c:314
softirqs last disabled at (11185): [<ffffffff81491df1>] invoke_softirq  
kernel/softirq.c:368 [inline]
softirqs last disabled at (11185): [<ffffffff81491df1>]  
irq_exit+0x1d1/0x200 kernel/softirq.c:408
CPU: 1 PID: 4533 Comm: syz-executor095 Not tainted 4.18.0-rc4+ #147
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  ___might_sleep.cold.85+0x11f/0x13a kernel/sched/core.c:6187
  __might_sleep+0x95/0x190 kernel/sched/core.c:6140
  __do_page_fault+0x3b6/0xe50 arch/x86/mm/fault.c:1339
  do_page_fault+0xf6/0x8c0 arch/x86/mm/fault.c:1471
  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1160
RIP: 0010:msr_write_intercepted arch/x86/kvm/vmx.c:2338 [inline]
RIP: 0010:vmx_vcpu_run+0x1328/0x2600 arch/x86/kvm/vmx.c:10160
Code: 91 00 00 00 e8 19 c4 5c 00 48 8b 54 24 08 48 b8 00 00 00 00 00 fc ff  
df 48 c1 ea 03 80 3c 02 00 0f 85 8c 10 00 00 48 8b 04 24 <48> 8b 98 40 57  
00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 40 48
RSP: 0018:ffff8801ac6ef370 EFLAGS: 00010046
RAX: 0000000000000286 RBX: 0000000010000000 RCX: ffffffff811f471a
RDX: 1ffffffff11a2200 RSI: ffffffff811f4727 RDI: 0000000000000005
RBP: ffff8801ac2d0040 R08: ffff8801ac1c0780 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
BUG: unable to handle kernel paging request at 00000000000059c6
PGD 1aced7067 P4D 1aced7067 PUD 1d2c49067 PMD 0
Oops: 0000 [#1] SMP KASAN
CPU: 1 PID: 4533 Comm: syz-executor095 Tainted: G        W          
4.18.0-rc4+ #147
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:msr_write_intercepted arch/x86/kvm/vmx.c:2338 [inline]
RIP: 0010:vmx_vcpu_run+0x1328/0x2600 arch/x86/kvm/vmx.c:10160
Code: 91 00 00 00 e8 19 c4 5c 00 48 8b 54 24 08 48 b8 00 00 00 00 00 fc ff  
df 48 c1 ea 03 80 3c 02 00 0f 85 8c 10 00 00 48 8b 04 24 <48> 8b 98 40 57  
00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 40 48
RSP: 0018:ffff8801ac6ef370 EFLAGS: 00010046
RAX: 0000000000000286 RBX: 0000000010000000 RCX: ffffffff811f471a
RDX: 1ffffffff11a2200 RSI: ffffffff811f4727 RDI: 0000000000000005
RBP: ffff8801ac2d0040 R08: ffff8801ac1c0780 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000001e45880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000059c6 CR3: 00000001d7aee000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: 00000000000059c6
---[ end trace 6c69f3f1490dc60f ]---
RIP: 0010:msr_write_intercepted arch/x86/kvm/vmx.c:2338 [inline]
RIP: 0010:vmx_vcpu_run+0x1328/0x2600 arch/x86/kvm/vmx.c:10160
Code: 91 00 00 00 e8 19 c4 5c 00 48 8b 54 24 08 48 b8 00 00 00 00 00 fc ff  
df 48 c1 ea 03 80 3c 02 00 0f 85 8c 10 00 00 48 8b 04 24 <48> 8b 98 40 57  
00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 40 48
RSP: 0018:ffff8801ac6ef370 EFLAGS: 00010046
RAX: 0000000000000286 RBX: 0000000010000000 RCX: ffffffff811f471a
RDX: 1ffffffff11a2200 RSI: ffffffff811f4727 RDI: 0000000000000005
RBP: ffff8801ac2d0040 R08: ffff8801ac1c0780 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000001e45880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000059c6 CR3: 00000001d7aee000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
