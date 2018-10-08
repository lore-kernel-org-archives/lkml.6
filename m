Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2752AC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB4D21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB4D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeJHURm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:17:42 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:39016 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJHURm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:17:42 -0400
Received: by mail-io1-f69.google.com with SMTP id x5-v6so19550506ioa.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 06:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=inKmNwI/lD1VKBFHxUhd+8t17U5OaTsxXF5/K2+X5PQ=;
        b=qBj2YwIc3ZAn0KA4jFeCY7OBHr21VWmJsZs02gfM+YtUTj1GWlJdndIOMSSxj1dpI7
         LSI1CR7AgmfM0ilX+RgqJ4C/ffKgcgXhE1jYC7gXOlYUHLYLvVhDERdd7qkfkSXTQVp5
         QByQhnLoV2syCE8zVd89jAN+sq3BKdbpRQxf4PFmDMPo7DmNj82jYyp6v+XLgigwLsaB
         wEmF877k14Sez9fLsraYasqbOoaJBgFIo8PMMWSusoIIIJfZN13JSuiz6hkXzR89lhZ6
         KX1TGRT6N14r90LO+2QdXV4p0z3SV6r7mB/yr/meHd/Z+xWi88HOl6kho90l+h/bEIWN
         9M8A==
X-Gm-Message-State: ABuFfoj+GiMRCTOBGpHjfjZjDLWBuUU/Hoz81AFmSiGcxaZrfLrYY7r+
        o3lQt15tAxKDTZ7WdgmWvfODleNcr40rj8XxBkPkdFs/3Olv
X-Google-Smtp-Source: ACcGV63ODG9hMrexP/9HXGKn9KPiPa0umrctO3KpWLwFGoySeKTqZDQ9M/ezel9CfvxtVParpZY1oguyeb/USSVuR/NbJaThZllN
MIME-Version: 1.0
X-Received: by 2002:a24:484a:: with SMTP id p71-v6mr12777088ita.23.1539003963279;
 Mon, 08 Oct 2018 06:06:03 -0700 (PDT)
Date:   Mon, 08 Oct 2018 06:06:03 -0700
In-Reply-To: <0000000000005e2e530576c6f9ce@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a2f4a0577b7480f@google.com>
Subject: Re: KMSAN: uninit-value in __dev_mc_add
From:   syzbot <syzbot+001516d86dbe88862cec@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sunlw.fnst@cn.fujitsu.com, syzkaller-bugs@googlegroups.com,
        vdronov@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    43c85fe5a0ee kmsan: suppress false positives in KVM
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=15ffd5b9400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ff9630e1f32e076
dashboard link: https://syzkaller.appspot.com/bug?extid=001516d86dbe88862cec
compiler:       clang version 8.0.0 (trunk 339414)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10adf491400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100c8159400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+001516d86dbe88862cec@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KMSAN: uninit-value in memcmp+0x117/0x180 lib/string.c:863
CPU: 1 PID: 18 Comm: kworker/1:0 Not tainted 4.19.0-rc4+ #64
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x306/0x460 lib/dump_stack.c:113
  kmsan_report+0x1a2/0x2e0 mm/kmsan/kmsan.c:917
  __msan_warning+0x7c/0xe0 mm/kmsan/kmsan_instr.c:500
  memcmp+0x117/0x180 lib/string.c:863
  __hw_addr_add_ex net/core/dev_addr_lists.c:61 [inline]
  __dev_mc_add+0x1f9/0x8b0 net/core/dev_addr_lists.c:670
  dev_mc_add+0x6d/0x80 net/core/dev_addr_lists.c:687
  igmp6_group_added+0x2d7/0xab0 net/ipv6/mcast.c:676
  __ipv6_dev_mc_inc+0xeff/0x10f0 net/ipv6/mcast.c:934
  ipv6_dev_mc_inc+0x70/0x80 net/ipv6/mcast.c:941
  addrconf_join_solict net/ipv6/addrconf.c:2098 [inline]
  addrconf_dad_begin net/ipv6/addrconf.c:3879 [inline]
  addrconf_dad_work+0x3e7/0x2690 net/ipv6/addrconf.c:4006
  process_one_work+0x19c4/0x24f0 kernel/workqueue.c:2153
  worker_thread+0x206d/0x2b30 kernel/workqueue.c:2296
  kthread+0x59c/0x5d0 kernel/kthread.c:247
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:416

Local variable description: ----buf@igmp6_group_added
Variable was created at:
  igmp6_group_added+0x57/0xab0 net/ipv6/mcast.c:664
  __ipv6_dev_mc_inc+0xeff/0x10f0 net/ipv6/mcast.c:934
==================================================================

