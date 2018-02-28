Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-422553-1519831436-2-17846278078022738195
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519831435; b=XdUSIIccypW6dqFw46VCDwI03el5/uvNckkVit3wnQ+9ItW
    lVvuwDA2Ts48ide9A4ywU5Xl/0Vuupnz1sbv8wfFMBnITeKvYoHXduzw+PVSXS/I
    b6Qmh19vTnvM/ruPLZtMDWaybbE1LlSaxiawB14Xj1QqA8pHp5pb+Amo3LjfYyGJ
    T3t30wVaIVYa7IjOrfCaAOYXS5UV/cXJ1nINZ1TC61DXPHws9/9Iz78LwGk6bg9W
    ppXcE1hXGvq1deqyrnVVgDBiM5iDFJC0sTGXtaVrdm0/eyTQ0m7ee5jkla9nUODb
    hRvlDB+fQRCSy3gwWSUGR/LHxlWMNaaMigjKNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831435; bh=SFdWVcbUaXtLBlX4HQV
    q1clle7VAS5sAlZjLlp4AwWE=; b=M7xHZ+PwPNv4Q4iethADwwpk8hDY8iaw3f+
    YLDrzun5hNPiXWJySd/YukuD93jkJVoEpV7dYPBBvkmuv9W3OpGQWQ1zikyQG92m
    nrPf4pqhD+JvKY1VK3IfdxSEkvBupCyAgoTQpZ8S7/H7yXF5eajkoVE/dyUYjEA2
    z4f7ZZQngS4qE52CT4FuTQWpnZUlGWKFe11uCgpJYq3XFaknqjdKRWBHhl6d6fkw
    UBmP9uFx/UDHG4m+06Di0FBfRSIU9k9QPtp0lEwssoJEB6msXQIkzE1mMP2wnUR5
    zm2pIlbS2aTXpKwnrmRSgqqeKKAU8wmm+FxN7LzYCWevMVucw4A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932777AbeB1PX1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:23:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33392 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752890AbeB1PWq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:46 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Nikolay Aleksandrov" <nikolay@cumulusnetworks.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.741018268@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 053/140] net: bridge: fix early call to
 br_stp_change_bridge_id and plug newlink leaks
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

commit 84aeb437ab98a2bce3d4b2111c79723aedfceb33 upstream.

The early call to br_stp_change_bridge_id in bridge's newlink can cause
a memory leak if an error occurs during the newlink because the fdb
entries are not cleaned up if a different lladdr was specified, also
another minor issue is that it generates fdb notifications with
ifindex = 0. Another unrelated memory leak is the bridge sysfs entries
which get added on NETDEV_REGISTER event, but are not cleaned up in the
newlink error path. To remove this special case the call to
br_stp_change_bridge_id is done after netdev register and we cleanup the
bridge on changelink error via br_dev_delete to plug all leaks.

This patch makes netlink bridge destruction on newlink error the same as
dellink and ioctl del which is necessary since at that point we have a
fully initialized bridge device.

To reproduce the issue:
$ ip l add br0 address 00:11:22:33:44:55 type bridge group_fwd_mask 1
RTNETLINK answers: Invalid argument

$ rmmod bridge
[ 1822.142525] =============================================================================
[ 1822.143640] BUG bridge_fdb_cache (Tainted: G           O    ): Objects remaining in bridge_fdb_cache on __kmem_cache_shutdown()
[ 1822.144821] -----------------------------------------------------------------------------

[ 1822.145990] Disabling lock debugging due to kernel taint
[ 1822.146732] INFO: Slab 0x0000000092a844b2 objects=32 used=2 fp=0x00000000fef011b0 flags=0x1ffff8000000100
[ 1822.147700] CPU: 2 PID: 13584 Comm: rmmod Tainted: G    B      O     4.15.0-rc2+ #87
[ 1822.148578] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-20140531_083030-gandalf 04/01/2014
[ 1822.150008] Call Trace:
[ 1822.150510]  dump_stack+0x78/0xa9
[ 1822.151156]  slab_err+0xb1/0xd3
[ 1822.151834]  ? __kmalloc+0x1bb/0x1ce
[ 1822.152546]  __kmem_cache_shutdown+0x151/0x28b
[ 1822.153395]  shutdown_cache+0x13/0x144
[ 1822.154126]  kmem_cache_destroy+0x1c0/0x1fb
[ 1822.154669]  SyS_delete_module+0x194/0x244
[ 1822.155199]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[ 1822.155773]  entry_SYSCALL_64_fastpath+0x23/0x9a
[ 1822.156343] RIP: 0033:0x7f929bd38b17
[ 1822.156859] RSP: 002b:00007ffd160e9a98 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
[ 1822.157728] RAX: ffffffffffffffda RBX: 00005578316ba090 RCX: 00007f929bd38b17
[ 1822.158422] RDX: 00007f929bd9ec60 RSI: 0000000000000800 RDI: 00005578316ba0f0
[ 1822.159114] RBP: 0000000000000003 R08: 00007f929bff5f20 R09: 00007ffd160e8a11
[ 1822.159808] R10: 00007ffd160e9860 R11: 0000000000000202 R12: 00007ffd160e8a80
[ 1822.160513] R13: 0000000000000000 R14: 0000000000000000 R15: 00005578316ba090
[ 1822.161278] INFO: Object 0x000000007645de29 @offset=0
[ 1822.161666] INFO: Object 0x00000000d5df2ab5 @offset=128

Fixes: 30313a3d5794 ("bridge: Handle IFLA_ADDRESS correctly when creating bridge device")
Fixes: 5b8d5429daa0 ("bridge: netlink: register netdevice before executing changelink")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2: register_netdevice() was the last thing done in
 br_dev_newlink(), so no extra cleanup is needed]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -215,6 +215,11 @@ static int br_dev_newlink(struct net *sr
 			  struct nlattr *tb[], struct nlattr *data[])
 {
 	struct net_bridge *br = netdev_priv(dev);
+	int err;
+
+	err = register_netdevice(dev);
+	if (err)
+		return err;
 
 	if (tb[IFLA_ADDRESS]) {
 		spin_lock_bh(&br->lock);
@@ -222,7 +227,7 @@ static int br_dev_newlink(struct net *sr
 		spin_unlock_bh(&br->lock);
 	}
 
-	return register_netdevice(dev);
+	return 0;
 }
 
 struct rtnl_link_ops br_link_ops __read_mostly = {
