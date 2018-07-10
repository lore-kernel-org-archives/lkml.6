Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A602C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37D5208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQzBatlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37D5208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeGJMoA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:44:00 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:42182 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbeGJMn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:43:58 -0400
Received: by mail-wr1-f53.google.com with SMTP id p1-v6so14463413wrs.9;
        Tue, 10 Jul 2018 05:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=T2qSgeWrtbbcAQumV6eJa64N9MIXHatq/FelVbcKJZo=;
        b=pQzBatlM8w9u+vPOoS0uWjsaEv7oz0mwouVBDWWCbvg8Y10BPonlxdToaLojjG/GUt
         23+CYR0ngcF5FWmvYfyaxwJHkBa+8zSpS+FXFmUfn7XFw2eGn1EgiCdLHzIu7DpTkWoo
         wVPfei/f10ZSJOX0nRdS/cdF83yPsCZ6EzUw98MzcRCfc/65pDIZfDvtKVBQWDZZH1Nf
         KOlF0OOi5EjsNIDeuNsvzi+O1a50CxKaKISENLdzQoP/KQvSW16H0OhjoFky5IZrvPCk
         qe+Yz7hYrQewv97zOVx2xYC6M0+EFzcG01idJKmWzFORD3PJ2l0nVzNnYrJY5WVHxL7Q
         L3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=T2qSgeWrtbbcAQumV6eJa64N9MIXHatq/FelVbcKJZo=;
        b=nmLns1tzNKTwh7wKNcS8OxYS6Lc7+6u85Ez0/wev2yL3+9wp+VEmxIBSgnneiUOJ6n
         GODYHuiyOBE9uQ2pVLUpAE7gHxrp7jz9fh9YyzKa+UNfGRsa46DBcm50m+/5km6W4W+8
         OoPrG7wPViXgm08qvTf09n+6kvv86WSBIvDB0E8MvRkaiR0pHM/gLoCxhCCvAT6l8ojQ
         NJhqTZXSa5WPsyM4k48FxqUet+pQyjd8Cj8/O9wg5xKVsQILfAAckr2kwdFckffWyTOL
         0ghMOeCXsIrC6RZLzqx9+hkN7x2P7O4hPdZHJWCP7ia39XnTPx6Fb0bouZhKnXik7M+g
         tUvQ==
X-Gm-Message-State: APt69E3aI7Pk+LKnheUElgv1dMp5eiCUXTVa8HFWeL7sG+0d7UuPfaNv
        WGteZ6DbA7xuIhGJBuMBZt4=
X-Google-Smtp-Source: AAOMgpdJMN5USsw/x1nmu+fKOBtD9kUJiiW4h0pZsAZfzk3zM4DPsjzmg49nhjHS2gILIdtG2en22A==
X-Received: by 2002:adf:e841:: with SMTP id d1-v6mr17529783wrn.269.1531226636892;
        Tue, 10 Jul 2018 05:43:56 -0700 (PDT)
Received: from debian ([148.252.241.226])
        by smtp.gmail.com with ESMTPSA id 24-v6sm42619904wrz.94.2018.07.10.05.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 05:43:56 -0700 (PDT)
Date:   Tue, 10 Jul 2018 13:43:47 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: BUG: KASAN: use-after-free in ex_handler_refcount
Message-ID: <20180710124347.bg5mrlobkxgia24n@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I was running a KASAN enabled kernel and noticed the following:


[  916.786725] ==================================================================
[  916.786746] BUG: KASAN: use-after-free in ex_handler_refcount+0x5b/0x127
[  916.786753] Write of size 4 at addr ffff880105144bc0 by task kworker/u9:0/2298

[  916.786763] CPU: 1 PID: 2298 Comm: kworker/u9:0 Tainted: G     U  W  O    4.14.47-20180606+ #32
[  916.786767] Hardware name: xxx yyy/zzz, BIOS 2017.01-00087-g43e04de 08/30/2017
[  916.786805] Workqueue: hci0 hci_rx_work [bluetooth]
[  916.786810] Call Trace:
[  916.786824]  dump_stack+0x46/0x59
[  916.786834]  print_address_description+0x6b/0x23b
[  916.786842]  ? ex_handler_refcount+0x5b/0x127
[  916.786848]  kasan_report+0x220/0x246
[  916.786856]  ex_handler_refcount+0x5b/0x127
[  916.786863]  ? ex_handler_clear_fs+0x85/0x85
[  916.786870]  fixup_exception+0x8c/0x96
[  916.786878]  do_trap+0x66/0x2c1
[  916.786886]  do_error_trap+0x152/0x180
[  916.786893]  ? fixup_bug+0x78/0x78
[  916.786926]  ? amp_destroy_logical_link+0xd0/0xf6 [bluetooth]
[  916.786933]  ? __schedule+0x113b/0x1453
[  916.786939]  ? sysctl_net_exit+0xe/0xe
[  916.786946]  ? __wake_up_common+0x343/0x343
[  916.786952]  ? insert_work+0x107/0x163
[  916.786959]  invalid_op+0x1b/0x40
[  916.786994] RIP: 0010:amp_destroy_logical_link+0xd0/0xf6 [bluetooth]
[  916.786998] RSP: 0018:ffff88009540f970 EFLAGS: 00010296
[  916.787004] RAX: 0000000000000000 RBX: ffff880105144b48 RCX: ffff880105144bc0
[  916.787008] RDX: 000000000000002f RSI: ffff88013b80ed40 RDI: ffffffffa05810c0
[  916.787012] RBP: ffff8800069c59d8 R08: 000000003fee624d R09: ffffffff81cfcf9b
[  916.787015] R10: 000000008e0e2c51 R11: 0000000000000001 R12: ffff880042ddc908
[  916.787019] R13: ffff880105144bc8 R14: 0000000000000068 R15: ffff880093f02168
[  916.787027]  ? __sk_destruct+0x2c6/0x2d4
[  916.787063]  hci_event_packet+0xff5/0x7dd2 [bluetooth]
[  916.787098]  ? hci_le_meta_evt+0x2bab/0x2bab [bluetooth]
[  916.787117]  ? xhci_urb_enqueue+0xbd8/0xcf5 [xhci_hcd]
[  916.787127]  ? __accumulate_pelt_segments+0x24/0x33
[  916.787133]  ? __accumulate_pelt_segments+0x24/0x33
[  916.787140]  ? __update_load_avg_se.isra.2+0x217/0x3a4
[  916.787146]  ? set_next_entity+0x7c3/0x12cd
[  916.787153]  ? pick_next_entity+0x25e/0x26c
[  916.787159]  ? pick_next_task_fair+0x2ca/0xc1a
[  916.787165]  ? __accumulate_pelt_segments+0x24/0x33
[  916.787172]  ? __update_load_avg_cfs_rq.isra.3+0x24b/0x44c
[  916.787178]  ? __switch_to+0x769/0xbc4
[  916.787185]  ? compat_start_thread+0x66/0x66
[  916.787192]  ? finish_task_switch+0x392/0x431
[  916.787222]  ? hci_rx_work+0x154/0x487 [bluetooth]
[  916.787252]  hci_rx_work+0x154/0x487 [bluetooth]
[  916.787261]  process_one_work+0x579/0x9e9
[  916.787268]  worker_thread+0x68f/0x804
[  916.787277]  kthread+0x31c/0x32b
[  916.787283]  ? rescuer_thread+0x70c/0x70c
[  916.787289]  ? kthread_create_on_node+0xa3/0xa3
[  916.787297]  ret_from_fork+0x35/0x40

[  916.787305] Allocated by task 2298:
[  916.787315]  kasan_kmalloc.part.1+0x51/0xc7
[  916.787320]  __kmalloc+0x17f/0x1b6
[  916.787326]  sk_prot_alloc+0xf2/0x1a3
[  916.787332]  sk_alloc+0x22/0x297
[  916.787364]  sco_sock_alloc.constprop.7+0x23/0x202 [bluetooth]
[  916.787397]  sco_connect_cfm+0x2d0/0x566 [bluetooth]
[  916.787427]  hci_conn_request_evt.isra.53+0x6d3/0x762 [bluetooth]
[  916.787458]  hci_event_packet+0x85e/0x7dd2 [bluetooth]
[  916.787486]  hci_rx_work+0x154/0x487 [bluetooth]
[  916.787491]  process_one_work+0x579/0x9e9
[  916.787496]  worker_thread+0x68f/0x804
[  916.787502]  kthread+0x31c/0x32b
[  916.787508]  ret_from_fork+0x35/0x40

[  916.787512] Freed by task 2298:
[  916.787519]  kasan_slab_free+0xb3/0x15e
[  916.787524]  kfree+0x103/0x1a9
[  916.787528]  __sk_destruct+0x2c6/0x2d4
[  916.787560]  sco_conn_del.isra.1+0xba/0x10e [bluetooth]
[  916.787591]  hci_event_packet+0xff5/0x7dd2 [bluetooth]
[  916.787619]  hci_rx_work+0x154/0x487 [bluetooth]
[  916.787624]  process_one_work+0x579/0x9e9
[  916.787629]  worker_thread+0x68f/0x804
[  916.787635]  kthread+0x31c/0x32b
[  916.787641]  ret_from_fork+0x35/0x40

[  916.787647] The buggy address belongs to the object at ffff880105144b48
 which belongs to the cache kmalloc-1024 of size 1024
[  916.787652] The buggy address is located 120 bytes inside of
 1024-byte region [ffff880105144b48, ffff880105144f48)
[  916.787654] The buggy address belongs to the page:
[  916.787660] page:ffffea0004145000 count:1 mapcount:0 mapping:          (null) index:0x0 compound_mapcount: 0
[  916.798662] flags: 0x8000000000008100(slab|head)
[  916.803829] raw: 8000000000008100 0000000000000000 0000000000000000 0000000100170017
[  916.803836] raw: ffffea00001a7220 ffffea0000931420 ffff88013b80ed40 0000000000000000
[  916.803839] page dumped because: kasan: bad access detected

[  916.803842] Memory state around the buggy address:
[  916.803849]  ffff880105144a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  916.803853]  ffff880105144b00: fc fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb
[  916.803858] >ffff880105144b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  916.803861]                                            ^
[  916.803865]  ffff880105144c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  916.803870]  ffff880105144c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  916.803872] ==================================================================

Will really appreciate help in finding the issue and fixing it.
It is reproducible on almost all cycles, so I can test any patch if needed.


--
Regards
Sudip
