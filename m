Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80327C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D973920645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="IacdYuIy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SyUsL6uC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D973920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeIKMLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:11:48 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33397 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbeIKMLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:11:48 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1364A34A;
        Tue, 11 Sep 2018 03:13:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 11 Sep 2018 03:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=VcGtBNM+1CmHXUUWFEMY1qpenFzBtA42hv2lkGceD
        Ns=; b=IacdYuIyBDuLkAjmrZ1IF6Jxk7eaDg/ZMtXak/nyeZDtLqIXDZx+iqDWo
        XDb28+xHN5MZFU1G4pqtnp9olPGS/Hywh0ytwWV2OyUu4Fv3AkeLoDRkc9uxSA+/
        cJmOubIbqY1vHwmLRKjYH+UUSkKfEfrgD4zFVAa9VkZH/Bivbup08hUfihaCqSL0
        qYwlJZf5464o5ThVWBQxRwDOk+OXAAb9F4w4a6lMAeIqfU3nH90AK/JvozG1AMSP
        0WtKZdLJqKtL0v3qMD7chcpc1K8uDFeo4pZW98MtdlEpMduCDIB7UwkF28BCQ0TS
        OXQB1CMfJxK+z3gpoJu5Mb0JwYcsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=VcGtBNM+1CmHXUUWF
        EMY1qpenFzBtA42hv2lkGceDNs=; b=SyUsL6uCgDEijkTRzl8N5IQunqu/DGHnA
        OxNS1KB4i4bQ6LIOcxvp2DmKciZuJJXXoSZ7PiWrzWZF33S0ha16DEO63E2mIPA7
        /9455rfX1eQI1BW7HsBnb6PuCQkjk/FPmlAGd4S/Ut7YmF7GhNd3Vq+PX+bU8Krw
        OvGRt3p4r4UU6jQ3w399fPI3w6QAkLAFNpdkdp1a4lPNkUU5DvhTN3DCofGU1A1y
        Ih9D9VfdhuW+9DvDnNhuNE03rmQV4uFFtMQQfsLnjyJm0rkRtEgleIX8ckXbt3mo
        ogfLMFqb8RYtp5kwSkgpYOlp6moD0SfrPUGvpI3P9d4CUJ/pJaETg==
X-ME-Proxy: <xmx:LGuXWxJrUP20HSrP3k6lKLnEvW0MVW1uXgcPMErYq91pAo1fa5D8OQ>
    <xmx:LGuXW5hC6KyuNoWsWEKpsnGDmyLuMqr93yPAIuLmv8BYFFcB0uZpcA>
    <xmx:LGuXW-J7lMFL9xQezxaIvY00jzYuesSNwOFL_d2xvX7BDJkmqdyzUw>
    <xmx:LGuXWwjgEotTckM0eh-52HaPZG9e-WqDfOfvSpCK6TSEWxs8UKn_Xw>
    <xmx:LGuXW00zd1BjDg_TdlXhCPzQmALCiSGgjvVYfXrHQ5-2jMsfeFQF9g>
    <xmx:LWuXWyn0eweNiqW-5fdM5sD0yha9uXcJLFgaRkneawxtUReZGmDYbQ>
X-ME-Sender: <xms:LGuXWz01MseFhKJqF0wr-1fYZtY5H8abBimiTavbc24ulMROz-ydzw>
Received: from localhost (ppp121-44-246-110.bras2.syd2.internode.on.net [121.44.246.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id C6A06E41E6;
        Tue, 11 Sep 2018 03:13:46 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND net-next] docs: net: Convert tcp.txt to RST format
Date:   Tue, 11 Sep 2018 17:13:24 +1000
Message-Id: <20180911071324.11199-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restructured text is the kernel documentation format of choice now.
Some text from tcp.txt is out of date, specifically the function
tcp_write() does not appear to be in the tree anymore.  Also the
following data members have been removed

	  sk->tcp_pend_event
	  sk->transmit_queue
	  sk->transmit_new
	  sk->transmit_end
	  sk->tcp_last_tx_ack
	  sk->tcp_dup_ack

Remove section 'How the new TCP output machine [nyi] works'.  This
leaves only a single section so we can name the document with that
section heading now.

Convert tcp.txt to RST format.  Add GPLv2 SPDX tag.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

This is v1 re-sending since I sent the original during the merge window :(

CC'd Eric as maintainer of TCP (according to MAINTAINERS)

I was going to ask a question on netdev list as to whether this file was
out of date.  I just removed the suspect section and did the patch
instead.  I am not sure if it is correct to remove it or if the
structure documented has just been changed.  Please see bottom section
of removed text ('How the new TCP output machine [nyi] works').

Also please note this file is not covered by MAINTAINERS, should it be?

thanks,
Tobin.

 Documentation/networking/00-INDEX  |   2 -
 Documentation/networking/index.rst |   1 +
 Documentation/networking/tcp.rst   |  71 ++++++++++++++++++++
 Documentation/networking/tcp.txt   | 101 -----------------------------
 4 files changed, 72 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/networking/tcp.rst
 delete mode 100644 Documentation/networking/tcp.txt

diff --git a/Documentation/networking/00-INDEX b/Documentation/networking/00-INDEX
index 02a323c43261..dcbccae4043e 100644
--- a/Documentation/networking/00-INDEX
+++ b/Documentation/networking/00-INDEX
@@ -198,8 +198,6 @@ tc-actions-env-rules.txt
 	- rules for traffic control (tc) actions.
 timestamping.txt
 	- overview of network packet timestamping variants.
-tcp.txt
-	- short blurb on how TCP output takes place.
 tcp-thin.txt
 	- kernel tuning options for low rate 'thin' TCP streams.
 team.txt
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index fcd710f2cc7a..1cb9bcc36dd7 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -21,6 +21,7 @@ Contents:
    net_failover
    alias
    bridge
+   tcp
 
 .. only::  subproject
 
diff --git a/Documentation/networking/tcp.rst b/Documentation/networking/tcp.rst
new file mode 100644
index 000000000000..ae2094fc5de3
--- /dev/null
+++ b/Documentation/networking/tcp.rst
@@ -0,0 +1,71 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+TCP Congestion Control
+======================
+
+The following variables are used in the tcp_sock for congestion control
+
+.. flat-table:: Congestion Control
+    :widths: 1 2
+
+    * - tcp_sock struct member
+      - Usage
+
+    * - snd_cwnd
+      - The size of the congestion window
+
+    * - snd_ssthresh
+      - Slow start threshold.  We are in slow start if snd_cwnd is less
+	than this.
+
+    * - snd_cwnd_cnt
+      - A counter used to slow down the rate of increase once we exceed
+	slow start threshold.
+
+    * - snd_cwnd_clamp
+      - This is the maximum size that snd_cwnd can grow to.
+
+    * - snd_cwnd_stamp
+      - Timestamp for when congestion window last validated.
+
+    * - snd_cwnd_used
+      - Used as a highwater mark for how much of the congestion window
+	is in use.  It is used to adjust snd_cwnd down when the link is
+	limited by the application rather than the network.
+
+As of 2.6.13, Linux supports pluggable congestion control algorithms.  A
+congestion control mechanism can be registered through functions in
+tcp_cong.c.  The functions used by the congestion control mechanism are
+registered via passing a tcp_congestion_ops struct to
+tcp_register_congestion_control.  As a minimum, the congestion control
+mechanism must provide a valid name and must implement either ssthresh,
+cong_avoid and undo_cwnd hooks or the "omnipotent" cong_control hook.
+
+Private data for a congestion control mechanism is stored in
+tp->ca_priv.  tcp_ca(tp) returns a pointer to this space.  This is
+preallocated space - it is important to check the size of your private
+data will fit this space, or alternatively, space could be allocated
+elsewhere and a pointer to it could be stored here.
+
+There are three kinds of congestion control algorithms currently: The
+simplest ones are derived from TCP reno (highspeed, scalable) and just
+provide an alternative congestion window calculation.  More complex ones
+like BIC try to look at other events to provide better heuristics.
+There are also round trip time based algorithms like Vegas and
+Westwood+.
+
+Good TCP congestion control is a complex problem because the algorithm
+needs to maintain fairness and performance.  Please review current
+research and RFC's before developing new modules.
+
+The default congestion control mechanism is chosen based on the
+DEFAULT_TCP_CONG Kconfig parameter.  If you really want a particular
+default value then you can set it using sysctl
+net.ipv4.tcp_congestion_control.  The module will be autoloaded if
+needed and you will get the expected protocol.  If you ask for an
+unknown congestion method, then the sysctl attempt will fail.
+
+If you remove a TCP congestion control module, then you will get the
+next available one.  Since reno cannot be built as a module, and cannot
+be removed, it will always be available.
diff --git a/Documentation/networking/tcp.txt b/Documentation/networking/tcp.txt
deleted file mode 100644
index 9c7139d57e57..000000000000
--- a/Documentation/networking/tcp.txt
+++ /dev/null
@@ -1,101 +0,0 @@
-TCP protocol
-============
-
-Last updated: 3 June 2017
-
-Contents
-========
-
-- Congestion control
-- How the new TCP output machine [nyi] works
-
-Congestion control
-==================
-
-The following variables are used in the tcp_sock for congestion control:
-snd_cwnd		The size of the congestion window
-snd_ssthresh		Slow start threshold. We are in slow start if
-			snd_cwnd is less than this.
-snd_cwnd_cnt		A counter used to slow down the rate of increase
-			once we exceed slow start threshold.
-snd_cwnd_clamp		This is the maximum size that snd_cwnd can grow to.
-snd_cwnd_stamp		Timestamp for when congestion window last validated.
-snd_cwnd_used		Used as a highwater mark for how much of the
-			congestion window is in use. It is used to adjust
-			snd_cwnd down when the link is limited by the
-			application rather than the network.
-
-As of 2.6.13, Linux supports pluggable congestion control algorithms.
-A congestion control mechanism can be registered through functions in
-tcp_cong.c. The functions used by the congestion control mechanism are
-registered via passing a tcp_congestion_ops struct to
-tcp_register_congestion_control. As a minimum, the congestion control
-mechanism must provide a valid name and must implement either ssthresh,
-cong_avoid and undo_cwnd hooks or the "omnipotent" cong_control hook.
-
-Private data for a congestion control mechanism is stored in tp->ca_priv.
-tcp_ca(tp) returns a pointer to this space.  This is preallocated space - it
-is important to check the size of your private data will fit this space, or
-alternatively, space could be allocated elsewhere and a pointer to it could
-be stored here.
-
-There are three kinds of congestion control algorithms currently: The
-simplest ones are derived from TCP reno (highspeed, scalable) and just
-provide an alternative congestion window calculation. More complex
-ones like BIC try to look at other events to provide better
-heuristics.  There are also round trip time based algorithms like
-Vegas and Westwood+.
-
-Good TCP congestion control is a complex problem because the algorithm
-needs to maintain fairness and performance. Please review current
-research and RFC's before developing new modules.
-
-The default congestion control mechanism is chosen based on the
-DEFAULT_TCP_CONG Kconfig parameter. If you really want a particular default
-value then you can set it using sysctl net.ipv4.tcp_congestion_control. The
-module will be autoloaded if needed and you will get the expected protocol. If
-you ask for an unknown congestion method, then the sysctl attempt will fail.
-
-If you remove a TCP congestion control module, then you will get the next
-available one. Since reno cannot be built as a module, and cannot be
-removed, it will always be available.
-
-How the new TCP output machine [nyi] works.
-===========================================
-
-Data is kept on a single queue. The skb->users flag tells us if the frame is
-one that has been queued already. To add a frame we throw it on the end. Ack
-walks down the list from the start.
-
-We keep a set of control flags
-
-
-	sk->tcp_pend_event
-
-		TCP_PEND_ACK			Ack needed
-		TCP_ACK_NOW			Needed now
-		TCP_WINDOW			Window update check
-		TCP_WINZERO			Zero probing
-
-
-	sk->transmit_queue		The transmission frame begin
-	sk->transmit_new		First new frame pointer
-	sk->transmit_end		Where to add frames
-
-	sk->tcp_last_tx_ack		Last ack seen
-	sk->tcp_dup_ack			Dup ack count for fast retransmit
-
-
-Frames are queued for output by tcp_write. We do our best to send the frames
-off immediately if possible, but otherwise queue and compute the body
-checksum in the copy. 
-
-When a write is done we try to clear any pending events and piggy back them.
-If the window is full we queue full sized frames. On the first timeout in
-zero window we split this.
-
-On a timer we walk the retransmit list to send any retransmits, update the
-backoff timers etc. A change of route table stamp causes a change of header
-and recompute. We add any new tcp level headers and refinish the checksum
-before sending. 
-
-- 
2.17.1

