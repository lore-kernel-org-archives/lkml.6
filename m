Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C578C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E9521545
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWAXHYr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E9521545
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeHOXft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:35:49 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:44663 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeHOXfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:35:48 -0400
Received: by mail-pl0-f41.google.com with SMTP id ba4-v6so951978plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6eozs9VmxNiI/SR9RljQ6Eo+MYpLqjG9O39InccuD98=;
        b=YWAXHYr87+HnCtMnD3R2w8agXlPv0rYBVDZDhw01mckuY99K6foJP4dRf99rzkkJSX
         FtAYAcHStTFI2u/rSy7E9QZFBMpJQ6AMOL/xaAZliiZX/j31cor1ItgRvrZzsgYTvDiA
         4svvfWjDXuEqmMvNIEN2109tx0aSX5uyXyBJw0/o/bXPh2c3/mlKsBBKXnost7cPOgXY
         imhj/hUG8dOMBTPypiO/k3ZwSFkGN+AHOn7Mk5ELpTSvinD+oNrVDHWTtfMTsIguJC43
         E6dNSR3uxdYgQDx08B4TtoFOFtrtDq9W+9hf13yOleeU32fZmbhiFmqkn2vR2JVX5wf9
         CtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6eozs9VmxNiI/SR9RljQ6Eo+MYpLqjG9O39InccuD98=;
        b=hrMlLUvHQ00KsIVpb3sPtJs2xEGF5FjtMCbOycfq8ebyPb/kNpVSpVZa1joFBo7Ud5
         8Mw4tDUbbxbUuRJw5ipBxJpBWm/vGxNibybykMV6n+EDptUoCn7WYATkL14J84RcAvRu
         R0YvQegnK6rsIZO3sS/Esjik/OnbpiIsMaPAvfct8nuB4VKcAGJIx+C5jqI6ZvKcH3KR
         juuoikenbDxxuyGFsx+wTquTcybiFN1NivEqQl9he9UofeOH6BnCW1AIgRKFfs3bXyJW
         9/Ri/xu41JJl/MDu6Gxe2ki2S1schXRLoehulTF+DE0LqY7TaO7zNpOxB2ouhs024qd8
         Xz1g==
X-Gm-Message-State: AOUpUlG850Ap0TGxFV/vlO2u8rU8fWw59NLhFbwmXFN9wx5rWZUgFUwX
        lNeZjlm4RTJCtZLB3seaBB/5UWydU9zBehThOG+U5g==
X-Google-Smtp-Source: AA+uWPzdIWVKyBpx+4HjGH1bINKxNHdmmFY9lLP+ekF1KeeY5mNOzQES9zVdfst72eh4IFIA4Ic8Sz5C9fycVF4870k=
X-Received: by 2002:a17:902:d710:: with SMTP id w16-v6mr25699566ply.93.1534365722507;
 Wed, 15 Aug 2018 13:42:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 15 Aug 2018 13:41:42
 -0700 (PDT)
In-Reply-To: <000000000000c5b63005737f290d@google.com>
References: <00000000000056268e05737dcb95@google.com> <000000000000c5b63005737f290d@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 15 Aug 2018 13:41:42 -0700
Message-ID: <CACT4Y+Zsv0DuJhMZqrgm+Yj9g3LATuB3sA9_7sVF3ap7meM58A@mail.gmail.com>
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
To:     syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        netdev <netdev@vger.kernel.org>,
        Dan Streetman <ddstreet@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 1:28 PM, syzbot
<syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com> wrote:
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    31130a16d459 Merge tag 'for-linus-4.19-rc1-tag' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1116b46c400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e8d52931cda051de
> dashboard link: https://syzkaller.appspot.com/bug?extid=30209ea299c09d8785c9
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11617322400000


+netdev and Dan

There were more reproducers here:
https://groups.google.com/forum/#!msg/syzkaller/-06_laheMF0/MxCjIiHkBwAJ
and here:
https://groups.google.com/forum/#!msg/syzkaller/-06_laheMF0/4wfWs6ATBwAJ
and in the previous incarnation of the bug:
https://syzkaller.appspot.com/bug?id=1a97a5bd119fd97995f752819fd87840ab9479a9


> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com
>
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
> bridge0: port 2(bridge_slave_1) entered blocking state
> bridge0: port 2(bridge_slave_1) entered forwarding state
> bridge0: port 1(bridge_slave_0) entered blocking state
> bridge0: port 1(bridge_slave_0) entered forwarding state
> unregister_netdevice: waiting for lo to become free. Usage count = 1
> 8021q: adding VLAN 0 to HW filter on device bond0
> IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> IPVS: stopping master sync thread 6855 ...
> IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,
> id = 0
> IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,
> id = 0
> IPVS: stopping master sync thread 6859 ...
> IPVS: ftp: loaded support on port[0] = 21
> bridge0: port 1(bridge_slave_0) entered blocking state
> bridge0: port 1(bridge_slave_0) entered disabled state
> device bridge_slave_0 entered promiscuous mode
> bridge0: port 2(bridge_slave_1) entered blocking state
> bridge0: port 2(bridge_slave_1) entered disabled state
> device bridge_slave_1 entered promiscuous mode
> IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
> IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
> bond0: Enslaving bond_slave_0 as an active interface with an up link
> bond0: Enslaving bond_slave_1 as an active interface with an up link
> IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
> team0: Port device team_slave_0 added
> IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
> team0: Port device team_slave_1 added
> IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
> bridge0: port 2(bridge_slave_1) entered blocking state
> bridge0: port 2(bridge_slave_1) entered forwarding state
> bridge0: port 1(bridge_slave_0) entered blocking state
> bridge0: port 1(bridge_slave_0) entered forwarding state
> 8021q: adding VLAN 0 to HW filter on device bond0
> IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> IPVS: stopping master sync thread 7118 ...
> IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,
> id = 0
> IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,
> id = 0
> IPVS: stopping master sync thread 7122 ...
> IPVS: ftp: loaded support on port[0] = 21
> bridge0: port 1(bridge_slave_0) entered blocking state
> bridge0: port 1(bridge_slave_0) entered disabled state
> device bridge_slave_0 entered promiscuous mode
> bridge0: port 2(bridge_slave_1) entered blocking state
> bridge0: port 2(bridge_slave_1) entered disabled state
> device bridge_slave_1 entered promiscuous mode
> IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
> IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
> bond0: Enslaving bond_slave_0 as an active interface with an up link
> bond0: Enslaving bond_slave_1 as an active interface with an up link
> IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
> team0: Port device team_slave_0 added
> IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
> team0: Port device team_slave_1 added
> IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
> bridge0: port 2(bridge_slave_1) entered blocking state
> bridge0: port 2(bridge_slave_1) entered forwarding state
> bridge0: port 1(bridge_slave_0) entered blocking state
> bridge0: port 1(bridge_slave_0) entered forwarding state
> 8021q: adding VLAN 0 to HW filter on device bond0
> IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> IPVS: stopping master sync thread 7381 ...
> IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,
> id = 0
> IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,
> id = 0
> IPVS: stopping master sync thread 7385 ...
> IPVS: ftp: loaded support on port[0] = 21
> bridge0: port 1(bridge_slave_0) entered blocking state
> bridge0: port 1(bridge_slave_0) entered disabled state
> device bridge_slave_0 entered promiscuous mode
> bridge0: port 2(bridge_slave_1) entered blocking state
> bridge0: port 2(bridge_slave_1) entered disabled state
> device bridge_slave_1 entered promiscuous mode
> IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
> IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
> bond0: Enslaving bond_slave_0 as an active interface with an up link
> bond0: Enslaving bond_slave_1 as an active interface with an up link
> IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
> team0: Port device team_slave_0 added
> IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
> team0: Port device team_slave_1 added
> IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
> bridge0: port 2(bridge_slave_1) entered blocking state
> bridge0: port 2(bridge_slave_1) entered forwarding state
> bridge0: port 1(bridge_slave_0) entered blocking state
> bridge0: port 1(bridge_slave_0) entered forwarding state
> 8021q: adding VLAN 0 to HW filter on device bond0
> IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> IPVS: stopping master sync thread 7644 ...
> IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,
> id = 0
> IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,
> id = 0
> IPVS: stopping master sync thread 7648 ...
> IPVS: ftp: loaded support on port[0] = 21
> bridge0: port 1(bridge_slave_0) entered blocking state
> bridge0: port 1(bridge_slave_0) entered disabled state
> device bridge_slave_0 entered promiscuous mode
> bridge0: port 2(bridge_slave_1) entered blocking state
> bridge0: port 2(bridge_slave_1) entered disabled state
> device bridge_slave_1 entered promiscuous mode
> IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
> IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
> bond0: Enslaving bond_slave_0 as an active interface with an up link
> bond0: Enslaving bond_slave_1 as an active interface with an up link
> IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
> team0: Port device team_slave_0 added
> IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
> team0: Port device team_slave_1 added
> IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
> bridge0: port 2(bridge_slave_1) entered blocking state
> bridge0: port 2(bridge_slave_1) entered forwarding state
> bridge0: port 1(bridge_slave_0) entered blocking state
> bridge0: port 1(bridge_slave_0) entered forwarding state
> 8021q: adding VLAN 0 to HW filter on device bond0
> IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000c5b63005737f290d%40google.com.
>
> For more options, visit https://groups.google.com/d/optout.
