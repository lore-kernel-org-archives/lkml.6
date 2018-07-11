Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596F5C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8FC2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="o4n+yYH7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HhlS4TNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8FC2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbeGKVt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:49:29 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:60377 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390476AbeGKVt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:49:29 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 32E61256;
        Wed, 11 Jul 2018 17:43:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 11 Jul 2018 17:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=LKxdHjvbzHqWCvLMt
        ysu/h6lmqGxQFVuhZicxaoeRg0=; b=o4n+yYH7UVjF/xHlg5vbd3PUtNYjFyYXp
        X4a/SroGZDe6ETAjzxdySQ4d9xf6i8mmKCmUJ8Hro4SljKhwEX2DvAFCyzrRVdWp
        LgOVDMqInf1uOflXXVYC3sZ3BH26V1RF/4Z6bJYmYWDyHqIF5HTeLHaestSR8IHe
        ruN/BTz30XelZA7acyoa8yvx1x5aUemUGRUibCtBJI40nk7zth9un4AJiEm4xjOa
        5H9E7/mQwQEWse6JRzAmpCjA6KVMMUGdXgon9FhfODueWok8iAIyVRQhU4enYe22
        Py9tdm5tshj0uHMyzmwtVrKjV4Ztl8VHifL4Lr2joBfy0sZ+s0KMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=LKxdHjvbzHqWCvLMtysu/h6lmqGxQFVuhZicxaoeRg0=; b=HhlS4TNB
        Yl+A6pFudD0qZw0Anz6GQmxCdK1l40Spi0J6ed1LeLlNQ2CQYawLQaDpG3NQ4ulM
        u9tCvQ7bL05nAAJtF04lCQCJhxoamUQ0nRWDjwzHzbUccleloBJn5XN+89/R4Mbw
        l8Qwd5XY1SJJ7FPBTtPSViD1Htfw9phOic1vqcgwJ0xeWhFU0cBup3lBz9dTubOe
        XPT9hZtqk0iCeiySd/0zlHTCV+RweRXwxyIVEc/Cg5kYxS4rsoViBtLB7U6DAym8
        zaVXCeo0xhcB/ViCBLqTm04Cxh3Tv7VZA+J7r9EoowEx5ykud+X3P2IvFISc0hh6
        RoMvYvyCZBXZqA==
X-ME-Proxy: <xmx:63lGW_NwWIjlOTXKW6SoxJ5FIJFo6FH6BVJJDSpRxkcPNIgbi4wmMQ>
    <xmx:63lGW8NOkmGgTM1mo_oH6jfcQp6rBcWq5RZFMxk_RC5BYCXIobIzjg>
    <xmx:63lGW74ZN6POo-1nnN_BZsRlYiiStlDSM_Faplr6D8eh9tkJrEeuzA>
    <xmx:63lGWwkYdyBukuGh2iripGx-tAS8zBsSlHTUhqI6WYe1BBVTNPntMw>
    <xmx:63lGW4YEN7eejuVgGAWSN6H_-EaXE2SGk2PekiCi90t8qMzaw96p9g>
    <xmx:63lGWwS_QQLo-XrzQYxI4VYYYGQwxAmzw_CstmXz-e5Sdg6Ldm9Iig>
X-ME-Sender: <xms:63lGW2_JcQWaoZ_Ufp9FD3w-iwI6geEJvYsIW1NZk1aFLoY-NlI_SA>
Received: from localhost (ppp121-44-208-89.bras1.syd2.internode.on.net [121.44.208.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id CC1A91026B;
        Wed, 11 Jul 2018 17:43:06 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next 2/2] docs: networking: Fix failover build warnings
Date:   Thu, 12 Jul 2018 07:42:50 +1000
Message-Id: <20180711214250.19039-3-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711214250.19039-1-me@tobin.cc>
References: <20180711214250.19039-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently building the net_failover docs causes a bunch of warnings to
be emitted.  These warnings are all related to indentation and correctly
highlight missing '::' (for code sections).  It looks, from other rst
files in Documentation, that the first column should be indented 2
spaces.

Add '::' before code snippets and indent all snippets uniformly starting
with 2 spaces.

Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

Cc'd Jon incase he wants to suggest a preferred level of indentation.

thanks,
Tobin.

 Documentation/networking/net_failover.rst | 111 +++++++++++-----------
 1 file changed, 57 insertions(+), 54 deletions(-)

diff --git a/Documentation/networking/net_failover.rst b/Documentation/networking/net_failover.rst
index 70ca2f5800c4..06c97dcb57ca 100644
--- a/Documentation/networking/net_failover.rst
+++ b/Documentation/networking/net_failover.rst
@@ -36,37 +36,39 @@ feature on the virtio-net interface and assign the same MAC address to both
 virtio-net and VF interfaces.
 
 Here is an example XML snippet that shows such configuration.
-
- <interface type='network'>
-   <mac address='52:54:00:00:12:53'/>
-   <source network='enp66s0f0_br'/>
-   <target dev='tap01'/>
-   <model type='virtio'/>
-   <driver name='vhost' queues='4'/>
-   <link state='down'/>
-   <address type='pci' domain='0x0000' bus='0x00' slot='0x0a' function='0x0'/>
- </interface>
- <interface type='hostdev' managed='yes'>
-   <mac address='52:54:00:00:12:53'/>
-   <source>
-     <address type='pci' domain='0x0000' bus='0x42' slot='0x02' function='0x5'/>
-   </source>
-   <address type='pci' domain='0x0000' bus='0x00' slot='0x0b' function='0x0'/>
- </interface>
+::
+
+  <interface type='network'>
+    <mac address='52:54:00:00:12:53'/>
+    <source network='enp66s0f0_br'/>
+    <target dev='tap01'/>
+    <model type='virtio'/>
+    <driver name='vhost' queues='4'/>
+    <link state='down'/>
+    <address type='pci' domain='0x0000' bus='0x00' slot='0x0a' function='0x0'/>
+  </interface>
+  <interface type='hostdev' managed='yes'>
+    <mac address='52:54:00:00:12:53'/>
+    <source>
+      <address type='pci' domain='0x0000' bus='0x42' slot='0x02' function='0x5'/>
+    </source>
+    <address type='pci' domain='0x0000' bus='0x00' slot='0x0b' function='0x0'/>
+  </interface>
 
 Booting a VM with the above configuration will result in the following 3
 netdevs created in the VM.
-
-4: ens10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
-    link/ether 52:54:00:00:12:53 brd ff:ff:ff:ff:ff:ff
-    inet 192.168.12.53/24 brd 192.168.12.255 scope global dynamic ens10
-       valid_lft 42482sec preferred_lft 42482sec
-    inet6 fe80::97d8:db2:8c10:b6d6/64 scope link
-       valid_lft forever preferred_lft forever
-5: ens10nsby: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master ens10 state UP group default qlen 1000
-    link/ether 52:54:00:00:12:53 brd ff:ff:ff:ff:ff:ff
-7: ens11: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master ens10 state UP group default qlen 1000
-    link/ether 52:54:00:00:12:53 brd ff:ff:ff:ff:ff:ff
+::
+
+  4: ens10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
+      link/ether 52:54:00:00:12:53 brd ff:ff:ff:ff:ff:ff
+      inet 192.168.12.53/24 brd 192.168.12.255 scope global dynamic ens10
+         valid_lft 42482sec preferred_lft 42482sec
+      inet6 fe80::97d8:db2:8c10:b6d6/64 scope link
+         valid_lft forever preferred_lft forever
+  5: ens10nsby: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master ens10 state UP group default qlen 1000
+      link/ether 52:54:00:00:12:53 brd ff:ff:ff:ff:ff:ff
+  7: ens11: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master ens10 state UP group default qlen 1000
+      link/ether 52:54:00:00:12:53 brd ff:ff:ff:ff:ff:ff
 
 ens10 is the 'failover' master netdev, ens10nsby and ens11 are the slave
 'standby' and 'primary' netdevs respectively.
@@ -80,37 +82,38 @@ the paravirtual datapath when the VF is unplugged.
 
 Here is a sample script that shows the steps to initiate live migration on
 the source hypervisor.
+::
 
-# cat vf_xml
-<interface type='hostdev' managed='yes'>
-  <mac address='52:54:00:00:12:53'/>
-  <source>
-    <address type='pci' domain='0x0000' bus='0x42' slot='0x02' function='0x5'/>
-  </source>
-  <address type='pci' domain='0x0000' bus='0x00' slot='0x0b' function='0x0'/>
-</interface>
+  # cat vf_xml
+  <interface type='hostdev' managed='yes'>
+    <mac address='52:54:00:00:12:53'/>
+    <source>
+      <address type='pci' domain='0x0000' bus='0x42' slot='0x02' function='0x5'/>
+    </source>
+    <address type='pci' domain='0x0000' bus='0x00' slot='0x0b' function='0x0'/>
+  </interface>
 
-# Source Hypervisor
-#!/bin/bash
+  # Source Hypervisor
+  #!/bin/bash
 
-DOMAIN=fedora27-tap01
-PF=enp66s0f0
-VF_NUM=5
-TAP_IF=tap01
-VF_XML=
+  DOMAIN=fedora27-tap01
+  PF=enp66s0f0
+  VF_NUM=5
+  TAP_IF=tap01
+  VF_XML=
 
-MAC=52:54:00:00:12:53
-ZERO_MAC=00:00:00:00:00:00
+  MAC=52:54:00:00:12:53
+  ZERO_MAC=00:00:00:00:00:00
 
-virsh domif-setlink $DOMAIN $TAP_IF up
-bridge fdb del $MAC dev $PF master
-virsh detach-device $DOMAIN $VF_XML
-ip link set $PF vf $VF_NUM mac $ZERO_MAC
+  virsh domif-setlink $DOMAIN $TAP_IF up
+  bridge fdb del $MAC dev $PF master
+  virsh detach-device $DOMAIN $VF_XML
+  ip link set $PF vf $VF_NUM mac $ZERO_MAC
 
-virsh migrate --live $DOMAIN qemu+ssh://$REMOTE_HOST/system
+  virsh migrate --live $DOMAIN qemu+ssh://$REMOTE_HOST/system
 
-# Destination Hypervisor
-#!/bin/bash
+  # Destination Hypervisor
+  #!/bin/bash
 
-virsh attach-device $DOMAIN $VF_XML
-virsh domif-setlink $DOMAIN $TAP_IF down
+  virsh attach-device $DOMAIN $VF_XML
+  virsh domif-setlink $DOMAIN $TAP_IF down
-- 
2.17.1

