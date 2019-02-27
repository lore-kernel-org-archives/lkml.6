Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03454C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76EC218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551228166;
	bh=fSbq1Bkn0Dcg1vBbfoZOpervhEH6Hdv45+tLgT926aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VM1NANBwoIEynpLTfDP6626QCB1x/Q3HLxBXQDivnCWK/Mrmitpra9dOwVQN6JE7G
	 2cLxnJyGmEaNs/fdZvmTuO1npjAc3vUKNohN/2+vptjEip8+IlBOSFV+sNIc6EpFAH
	 zdDkdUdCCWwsjFjh1cYwVHX4LsYNWWZUBdNdWb4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfB0Amp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:42:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbfB0Amo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:42:44 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0BA6218D0;
        Wed, 27 Feb 2019 00:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551228163;
        bh=fSbq1Bkn0Dcg1vBbfoZOpervhEH6Hdv45+tLgT926aM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kxv7sBTliIB5s03g8Oz8jmvjykLxMedmeFqb6oR3Da3Ske1TybBUSD51qq4as0nIq
         WvtSJMTuXC9IkLgxQvxY3o0HOv3t9n0e22ffw5OjL+nS1OsYaYCg8uSgygpPzM7AxX
         wHWFsVoHyfRAL6xhI9WOSv5m68gZqEZqycK8XM+g=
Date:   Tue, 26 Feb 2019 16:42:41 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+e786ba000564d103a6fe@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, dccp@vger.kernel.org, garsilva@embeddedor.com,
        gerrit@erg.abdn.ac.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: BUG: please report to dccp@vger.kernel.org => prev = 2, last = 2
 at net/dccp/ccids/lib/packet_history.c:LINE/tfrc_rx_his
Message-ID: <20190227004240.GH218103@gmail.com>
References: <0000000000006dc2420578e29de3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006dc2420578e29de3@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 03:13:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    ca9eb48fe01f Merge tag 'regulator-v5.0' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1482a939400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=963b24abf3f7c2d8
> dashboard link: https://syzkaller.appspot.com/bug?extid=e786ba000564d103a6fe
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e786ba000564d103a6fe@syzkaller.appspotmail.com
> 
> input: syz0 as /devices/virtual/input/input6
> BUG: please report to dccp@vger.kernel.org => prev = 2, last = 2 at
> net/dccp/ccids/lib/packet_history.c:425/tfrc_rx_hist_sample_rtt()
> CPU: 1 PID: 18 Comm: ksoftirqd/1 Not tainted 4.19.0+ #298
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c4/0x2b6 lib/dump_stack.c:113
>  tfrc_rx_hist_sample_rtt.cold.3+0x54/0x5c
> net/dccp/ccids/lib/packet_history.c:422
>  ccid3_hc_rx_packet_recv+0x5c4/0xeb0 net/dccp/ccids/ccid3.c:767
>  ccid_hc_rx_packet_recv net/dccp/ccid.h:185 [inline]
>  dccp_deliver_input_to_ccids+0xf0/0x280 net/dccp/input.c:180
>  dccp_rcv_established+0x87/0xb0 net/dccp/input.c:378
>  dccp_v4_do_rcv+0x153/0x180 net/dccp/ipv4.c:656
>  sk_backlog_rcv include/net/sock.h:931 [inline]
>  __sk_receive_skb+0x3e5/0xec0 net/core/sock.c:473
>  dccp_v4_rcv+0x10f9/0x1f58 net/dccp/ipv4.c:877
>  ip_local_deliver_finish+0x2e9/0xda0 net/ipv4/ip_input.c:215
>  NF_HOOK include/linux/netfilter.h:289 [inline]
>  ip_local_deliver+0x1e9/0x750 net/ipv4/ip_input.c:256
>  dst_input include/net/dst.h:450 [inline]
>  ip_rcv_finish+0x1f9/0x300 net/ipv4/ip_input.c:415
>  NF_HOOK include/linux/netfilter.h:289 [inline]
>  ip_rcv+0xed/0x600 net/ipv4/ip_input.c:524
>  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4913
>  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5023
>  process_backlog+0x218/0x6f0 net/core/dev.c:5829
>  napi_poll net/core/dev.c:6249 [inline]
>  net_rx_action+0x7c5/0x1950 net/core/dev.c:6315
>  __do_softirq+0x30c/0xb03 kernel/softirq.c:292
>  run_ksoftirqd+0x94/0x100 kernel/softirq.c:653
>  smpboot_thread_fn+0x68b/0xa00 kernel/smpboot.c:164
>  kthread+0x35a/0x420 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
> net_ratelimit: 18 callbacks suppressed
> dccp_close: ABORT with 105978 bytes unread
> input: syz0 as /devices/virtual/input/input7
> input: syz0 as /devices/virtual/input/input8
> dccp_close: ABORT with 52730 bytes unread
> input: syz0 as /devices/virtual/input/input9
> dccp_close: ABORT with 105978 bytes unread
> dccp_close: ABORT with 105978 bytes unread
> dccp_close: ABORT with 77306 bytes unread
> dccp_close: ABORT with 89594 bytes unread
> input: syz0 as /devices/virtual/input/input10
> input: syz0 as /devices/virtual/input/input11
> input: syz0 as /devices/virtual/input/input12
> input: syz0 as /devices/virtual/input/input13
> input: syz0 as /devices/virtual/input/input14
> input: syz0 as /devices/virtual/input/input15
> input: syz0 as /devices/virtual/input/input16
> input: syz0 as /devices/virtual/input/input17
> input: syz0 as /devices/virtual/input/input18
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> 

#syz dup: BUG: please report to dccp@vger.kernel.org => prev = 0, last = 0 at net/dccp/ccids/lib/packet_history.c:LINE/tfrc_rx_hist_sample_rtt()

Still occurring, see existing thread with reproducer here:
https://groups.google.com/d/msg/syzkaller-bugs/u5nq3PdPkIc/M7tbibYVCQAJ

- Eric
