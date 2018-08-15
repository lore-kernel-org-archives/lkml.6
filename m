Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72255C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3841F21531
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3841F21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeHOXVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:21:44 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:40059 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbeHOXVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:21:44 -0400
Received: by mail-io0-f198.google.com with SMTP id i12-v6so2067410iom.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TtTQGJMPuCjhmVWUPITxsUVxoXOZD3gXOPK9xrF9gQE=;
        b=k0id43Zdsm5nkzXsvD5t5l5nv7k7/xrVRdbSBjm8LcctBFU8XZxro1MWPnIpBeaOKo
         EoTJU2b4TCx/lVez1jDidgehxlKeswlvQocJw3LKNDrDBlJ/Wp34cGnrjOdWQfVNOJEI
         dq9e7OIvyNb6ykHZGzhOHRk4xgfos2VzQ3ASrZIVYy4fZjumQy+6lJVKbZCQ56OR8azm
         PZClZcDmMjz9/FgzpJnFXAXXs4BL2BvwtfSpi0BAQhzyaONr6M6xLtWpJODvN+dRE6qR
         augV9d0cdCSBmLvn4SgAJHlbYFTdiydbkjFTTEIxPAqPJZ6UHUbbBPiWOekeZIQfGvyT
         3YUw==
X-Gm-Message-State: AOUpUlEMLMjJDFkCBbHDN2SCxIY5zGPHy9i4pkByUxcboKYwllXGyxFN
        HTFUbZcidoa8UTaRI+ty9/myuzOlf8Nfyc9LFEqGh1T+PxeL
X-Google-Smtp-Source: AA+uWPweoweFOPRWylbmqDJaIDI7s5b195g81gnACTms1AOs9lXNA48NnwpYZeLCeE41MLI6rUJkVIPTjwKMvbzv3gVR3DKPt6j4
MIME-Version: 1.0
X-Received: by 2002:a6b:cb06:: with SMTP id b6-v6mr12507019iog.107.1534364882413;
 Wed, 15 Aug 2018 13:28:02 -0700 (PDT)
Date:   Wed, 15 Aug 2018 13:28:02 -0700
In-Reply-To: <00000000000056268e05737dcb95@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5b63005737f290d@google.com>
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
From:   syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    31130a16d459 Merge tag 'for-linus-4.19-rc1-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1116b46c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8d52931cda051de
dashboard link: https://syzkaller.appspot.com/bug?extid=30209ea299c09d8785c9
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11617322400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered forwarding state
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered forwarding state
unregister_netdevice: waiting for lo to become free. Usage count = 1
8021q: adding VLAN 0 to HW filter on device bond0
IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
IPVS: stopping master sync thread 6855 ...
IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,  
id = 0
IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,  
id = 0
IPVS: stopping master sync thread 6859 ...
IPVS: ftp: loaded support on port[0] = 21
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
bond0: Enslaving bond_slave_0 as an active interface with an up link
bond0: Enslaving bond_slave_1 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered forwarding state
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered forwarding state
8021q: adding VLAN 0 to HW filter on device bond0
IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
IPVS: stopping master sync thread 7118 ...
IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,  
id = 0
IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,  
id = 0
IPVS: stopping master sync thread 7122 ...
IPVS: ftp: loaded support on port[0] = 21
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
bond0: Enslaving bond_slave_0 as an active interface with an up link
bond0: Enslaving bond_slave_1 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered forwarding state
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered forwarding state
8021q: adding VLAN 0 to HW filter on device bond0
IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
IPVS: stopping master sync thread 7381 ...
IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,  
id = 0
IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,  
id = 0
IPVS: stopping master sync thread 7385 ...
IPVS: ftp: loaded support on port[0] = 21
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
bond0: Enslaving bond_slave_0 as an active interface with an up link
bond0: Enslaving bond_slave_1 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered forwarding state
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered forwarding state
8021q: adding VLAN 0 to HW filter on device bond0
IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
IPVS: stopping master sync thread 7644 ...
IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,  
id = 0
IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0,  
id = 0
IPVS: stopping master sync thread 7648 ...
IPVS: ftp: loaded support on port[0] = 21
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
device bridge_slave_0 entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
bond0: Enslaving bond_slave_0 as an active interface with an up link
bond0: Enslaving bond_slave_1 as an active interface with an up link
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
team0: Port device team_slave_0 added
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
team0: Port device team_slave_1 added
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link becomes ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered forwarding state
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered forwarding state
8021q: adding VLAN 0 to HW filter on device bond0
IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready

