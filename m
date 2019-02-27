Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD21C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB218218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551228141;
	bh=LJ14Ftlz9Lr7Y6X47bHhXjVktPay1oG9dcoQXYCXD/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h2G2Y6X+qHozaA18cwLOEDyfPxoAKc9oOs0x3EKt0iMjg7k8dz5a+pUYcV2sZYRzb
	 7Ji+9hmtLBor3L4wK95BBKkZ4gvUz9Ntx/J7um6j3MaVgTxa5VsUSCzPiAXyw0gvQu
	 4NUceymZYDE2LSGEhXO4/KQ5BX3nZvWa+TXj+PlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfB0AmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:42:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbfB0AmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:42:19 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9380218D0;
        Wed, 27 Feb 2019 00:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551228138;
        bh=LJ14Ftlz9Lr7Y6X47bHhXjVktPay1oG9dcoQXYCXD/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iyhUgJRu6KY7gbxJMTPbcSSLgAm9oV7NqxBXEmZNV6hg4Ubg2qPtzVlObU/eGTRyh
         5T4fym5Mpp6hjJ+w2zmEuD3X8UKsLc6s2rJoAeXxz/MtyLDh0JS09RDU5OYrNYT8fx
         mHscyuT5L2OKsfSz9kG/Yy4JD8HabI2nPy2iWIlE=
Date:   Tue, 26 Feb 2019 16:42:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+3c8a843d9de82272915b@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, dccp@vger.kernel.org, gerrit@erg.abdn.ac.uk,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: please report to dccp@vger.kernel.org => prev = 10, last =
 10 at net/dccp/ccids/lib/packet_history.c:LINE/tfrc_rx_h
Message-ID: <20190227004215.GG218103@gmail.com>
References: <0000000000007664bf057d71f6d7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007664bf057d71f6d7@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 02:55:03AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    6531e115b7ab Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13b0bd5d400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
> dashboard link: https://syzkaller.appspot.com/bug?extid=3c8a843d9de82272915b
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3c8a843d9de82272915b@syzkaller.appspotmail.com
> 
> bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as
> long as lo is part of bond bond0
> bond0: lo is up - this may be due to an out of date ifenslave
> A link change request failed with some changes committed already. Interface
> lo may have been left with an inconsistent configuration, please check.
> BUG: please report to dccp@vger.kernel.org => prev = 10, last = 10 at
> net/dccp/ccids/lib/packet_history.c:425/tfrc_rx_hist_sample_rtt()
> CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 4.20.0-rc6+ #374
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x244/0x39d lib/dump_stack.c:113
>  tfrc_rx_hist_sample_rtt.cold.3+0x54/0x5c
> net/dccp/ccids/lib/packet_history.c:422
>  ccid3_hc_rx_packet_recv+0x5c4/0xeb0 net/dccp/ccids/ccid3.c:767
>  ccid_hc_rx_packet_recv net/dccp/ccid.h:185 [inline]
>  dccp_deliver_input_to_ccids+0xf0/0x280 net/dccp/input.c:180
>  dccp_rcv_established+0x87/0xb0 net/dccp/input.c:378
>  dccp_v4_do_rcv+0x153/0x180 net/dccp/ipv4.c:656
>  sk_backlog_rcv include/net/sock.h:932 [inline]
>  __sk_receive_skb+0x3e5/0xec0 net/core/sock.c:473
>  dccp_v4_rcv+0x10f9/0x1f58 net/dccp/ipv4.c:877
>  ip_local_deliver_finish+0x2e9/0xda0 net/ipv4/ip_input.c:215
>  NF_HOOK include/linux/netfilter.h:289 [inline]
>  ip_local_deliver+0x1e9/0x750 net/ipv4/ip_input.c:256
>  dst_input include/net/dst.h:450 [inline]
>  ip_rcv_finish+0x1f9/0x300 net/ipv4/ip_input.c:415
>  NF_HOOK include/linux/netfilter.h:289 [inline]
>  ip_rcv+0xed/0x600 net/ipv4/ip_input.c:524
>  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4946
>  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5056
>  process_backlog+0x24e/0x7a0 net/core/dev.c:5864
>  napi_poll net/core/dev.c:6287 [inline]
>  net_rx_action+0x7fa/0x19b0 net/core/dev.c:6353
>  __do_softirq+0x308/0xb7e kernel/softirq.c:292
>  run_ksoftirqd+0x5e/0x100 kernel/softirq.c:654
>  smpboot_thread_fn+0x68b/0xa00 kernel/smpboot.c:164
>  kthread+0x35a/0x440 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
> IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
> IPVS: ftp: loaded support on port[0] = 21
> dccp_close: ABORT with 36864 bytes unread
> bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as
> long as lo is part of bond bond0
> bond0: lo is up - this may be due to an out of date ifenslave
> A link change request failed with some changes committed already. Interface
> lo may have been left with an inconsistent configuration, please check.
> IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
> bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as
> long as lo is part of bond bond0
> bond0: lo is up - this may be due to an out of date ifenslave
> A link change request failed with some changes committed already. Interface
> lo may have been left with an inconsistent configuration, please check.
> IPVS: ftp: loaded support on port[0] = 21
> bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as
> long as lo is part of bond bond0
> bond0: lo is up - this may be due to an out of date ifenslave
> A link change request failed with some changes committed already. Interface
> lo may have been left with an inconsistent configuration, please check.
> IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
> IPVS: ftp: loaded support on port[0] = 21
> IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
> bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as
> long as lo is part of bond bond0
> bond0: lo is up - this may be due to an out of date ifenslave
> A link change request failed with some changes committed already. Interface
> lo may have been left with an inconsistent configuration, please check.
> IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
> bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as
> long as lo is part of bond bond0
> bond0: lo is up - this may be due to an out of date ifenslave
> IPVS: ftp: loaded support on port[0] = 21
> A link change request failed with some changes committed already. Interface
> lo may have been left with an inconsistent configuration, please check.
> IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
> bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as
> long as lo is part of bond bond0
> bond0: lo is up - this may be due to an out of date ifenslave
> A link change request failed with some changes committed already. Interface
> lo may have been left with an inconsistent configuration, please check.
> IPVS: ftp: loaded support on port[0] = 21
> IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
> bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as
> long as lo is part of bond bond0
> bond0: lo is up - this may be due to an out of date ifenslave
> IPVS: ftp: loaded support on port[0] = 21
> A link change request failed with some changes committed already. Interface
> lo may have been left with an inconsistent configuration, please check.
> IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
> IPVS: ftp: loaded support on port[0] = 21
> IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
> bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as
> long as lo is part of bond bond0
> bond0: lo is up - this may be due to an out of date ifenslave
> IPVS: ftp: loaded support on port[0] = 21
> A link change request failed with some changes committed already. Interface
> lo may have been left with an inconsistent configuration, please check.
> IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
> IPVS: ftp: loaded support on port[0] = 21
> IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
> bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as
> long as lo is part of bond bond0
> bond0: lo is up - this may be due to an out of date ifenslave
> A link change request failed with some changes committed already. Interface
> lo may have been left with an inconsistent configuration, please check.
> IPVS: ftp: loaded support on port[0] = 21
> IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
> bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as
> long as lo is part of bond bond0
> bond0: lo is up - this may be due to an out of date ifenslave
> A link change request failed with some changes committed already. Interface
> lo may have been left with an inconsistent configuration, please check.
> IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
> bond0: enslaved VLAN challenged slave lo. Adding VLANs will be blocked as
> long as lo is part of bond bond0
> bond0: lo is up - this may be due to an out of date ifenslave
> A link change request failed with some changes committed already. Interface
> lo may have been left with an inconsistent configuration, please check.
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
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000007664bf057d71f6d7%40google.com.
> For more options, visit https://groups.google.com/d/optout.

#syz dup: BUG: please report to dccp@vger.kernel.org => prev = 0, last = 0 at net/dccp/ccids/lib/packet_history.c:LINE/tfrc_rx_hist_sample_rtt()

Still occurring, see existing thread with reproducer here:
https://groups.google.com/d/msg/syzkaller-bugs/u5nq3PdPkIc/M7tbibYVCQAJ

- Eric
