Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4849DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15884218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551228255;
	bh=tuFSw5R/IY3d5VzY9NHjqCq9ElhpORyob+DwTxPKl98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BbK9Ry1WsPByhFQr+KmshPLJqr4T3wFDsUO/fAthFbTq3+Ok5TxUiPxMbYnqnAJv9
	 vmi2I+wH0p2Nr6MykKJNVXIp9b0koiwNG4r/uOvrBxpgiYXC8M1rRK2o7YHlXbETmA
	 SvZkWji6cdtNvxLrKltSHAWdu1UV0KfVOJvXvlYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfB0AoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:44:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbfB0AoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:44:13 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF74218D0;
        Wed, 27 Feb 2019 00:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551228251;
        bh=tuFSw5R/IY3d5VzY9NHjqCq9ElhpORyob+DwTxPKl98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d/HukszaGtph1+Ted7APVvXZxfWDZAD3BrUd6TwiUsidm+UG8A1dXIeL2b2GlI8z0
         OtLHapWPZq3c+4EvugvddBao+Dm65wYQivna5zfNPE8LUojcVuE9qAigFUSFRt1FBV
         QGlsTXIlQ+z3dVmlLJjtGI7tX7yqBbZLJTq855QM=
Date:   Tue, 26 Feb 2019 16:44:09 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+e326127852f785c44347@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, dccp@vger.kernel.org, garsilva@embeddedor.com,
        gerrit@erg.abdn.ac.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: BUG: please report to dccp@vger.kernel.org => prev = 5, last = 5
 at net/dccp/ccids/lib/packet_history.c:LINE/tfrc_rx_his
Message-ID: <20190227004409.GI218103@gmail.com>
References: <000000000000627205057803724d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000627205057803724d@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:58:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    771b65e89c8a Add linux-next specific files for 20181011
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=167d2376400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=45f1c06c4da0a925
> dashboard link: https://syzkaller.appspot.com/bug?extid=e326127852f785c44347
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e326127852f785c44347@syzkaller.appspotmail.com
> 
> BUG: please report to dccp@vger.kernel.org => prev = 5, last = 5 at
> net/dccp/ccids/lib/packet_history.c:425/tfrc_rx_hist_sample_rtt()
> CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 4.19.0-rc7-next-20181011+ #92
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x244/0x3ab lib/dump_stack.c:113
>  tfrc_rx_hist_sample_rtt.cold.3+0x54/0x5c
> net/dccp/ccids/lib/packet_history.c:422
>  ccid3_hc_rx_packet_recv+0x5c4/0xeb0 net/dccp/ccids/ccid3.c:767
>  ccid_hc_rx_packet_recv net/dccp/ccid.h:185 [inline]
>  dccp_deliver_input_to_ccids+0xf0/0x280 net/dccp/input.c:180
>  dccp_rcv_established+0x87/0xb0 net/dccp/input.c:378
>  dccp_v4_do_rcv+0x153/0x180 net/dccp/ipv4.c:656
>  sk_backlog_rcv include/net/sock.h:932 [inline]
>  __sk_receive_skb+0x3e0/0xeb0 net/core/sock.c:473
> binder: send failed reply for transaction 41 to 27388:27389
>  dccp_v4_rcv+0x10f9/0x1f58 net/dccp/ipv4.c:877
>  ip_local_deliver_finish+0x2e9/0xda0 net/ipv4/ip_input.c:215
>  NF_HOOK include/linux/netfilter.h:289 [inline]
>  ip_local_deliver+0x1e4/0x740 net/ipv4/ip_input.c:256
>  dst_input include/net/dst.h:450 [inline]
>  ip_rcv_finish+0x1f9/0x300 net/ipv4/ip_input.c:415
>  NF_HOOK include/linux/netfilter.h:289 [inline]
>  ip_rcv+0xe8/0x600 net/ipv4/ip_input.c:524
>  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4908
>  __netif_receive_skb+0x27/0x1e0 net/core/dev.c:5018
>  process_backlog+0x24e/0x7a0 net/core/dev.c:5822
>  napi_poll net/core/dev.c:6242 [inline]
>  net_rx_action+0x7fa/0x19b0 net/core/dev.c:6308
>  __do_softirq+0x30d/0xb26 kernel/softirq.c:292
>  run_ksoftirqd+0x5e/0x100 kernel/softirq.c:654
>  smpboot_thread_fn+0x68b/0xa00 kernel/smpboot.c:164
>  kthread+0x35a/0x440 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
> dccp_close: ABORT with 52224 bytes unread
> binder: send failed reply for transaction 43 to 27399:27404
> dccp_close: ABORT with 3584 bytes unread
> binder: send failed reply for transaction 45 to 27417:27418
> binder: send failed reply for transaction 47 to 27424:27425
> dccp_close: ABORT with 105984 bytes unread
> dccp_close: ABORT with 105984 bytes unread
> dccp_close: ABORT with 105984 bytes unread
> nf_conntrack: default automatic helper assignment has been turned off for
> security reasons and CT-based  firewall rule not found. Use the iptables CT
> target to attach helpers instead.
> Dead loop on virtual device ip6_vti0, fix it urgently!
> Dead loop on virtual device ip6_vti0, fix it urgently!
> Dead loop on virtual device ip6_vti0, fix it urgently!
> Dead loop on virtual device ip6_vti0, fix it urgently!
> Dead loop on virtual device ip6_vti0, fix it urgently!
> Dead loop on virtual device ip6_vti0, fix it urgently!
> IPVS: sync thread started: state = BACKUP, mcast_ifn = team_slave_0, syncid
> = 0, id = 0
> Dead loop on virtual device ip6_vti0, fix it urgently!
> IPVS: sync thread started: state = BACKUP, mcast_ifn = team_slave_0, syncid
> = 0, id = 0
> IPVS: ftp: loaded support on port[0] = 21
> : renamed from bpq0
> IPVS: ftp: loaded support on port[0] = 21
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
