Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39572C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4FF21834
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Wv9KkZRS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rFTp+R+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4FF21834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeHMKBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:01:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53967 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726577AbeHMKBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:01:55 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 650C520F50;
        Mon, 13 Aug 2018 03:20:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 13 Aug 2018 03:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=pmqlO72+fn1/w3xncuetMD2Xnk9dwm23/uJNfVYBs
        SA=; b=Wv9KkZRS5LSI5egVvQNHypEUCydjmYFhkFF64aBacYmBMO8EZQ45FO/rT
        WGYW7uHMat3dyGiMvodj33u8lYjyBVl4pCycRJ/YlCvbokHv4KbZ09EpGA4KUFRy
        C7JRWX1HAg78sRXHQxEylffuwn5pHXIyhTXt0GZJS8rUdbshaQ2mkO8RL9BrN8+i
        s5WeSsReo+86DfBkSeBTBEERyfg8UcwkYC6y8pe7VdhWKD2iPpphpb8oaq/KXsoj
        1RBwkT1fX9EhOEKwiItufA6Wjm+NmcQ65nyeXdSHV88bYhYCfczziBhTmPjf66aE
        ciXPDpbFDsRpavRdNcGVAugEyskCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=pmqlO72+fn1/w3xnc
        uetMD2Xnk9dwm23/uJNfVYBsSA=; b=rFTp+R+qdGorGWWV1bih4I1f/ahfrWzpb
        8zvWxsuNZA3nFt334OGaH6yW+oFU1g5VEM3WZsYA53TH20Jebg1YcVR5DglVs4RS
        WG/GBU0uFsb2Pm9ClFoYcySfnXxDNdxl9GbmGBF+Xx9KbTm6x85bOvuSNNRmsXjO
        bsFBgZF/3XvPGTIVjIdQ59PS7kJKG2crmzNgfHQKcpPUvTTidrBPFEy/q/GqK5g+
        4pnR3/8cIaj1GWZ44gRWjMr6bMtXnpZhbZT8xAtjcX5FuJ0+tZWs3qkJxhIeSq3/
        gp4fn7hSoAYgllWegQureDe4c9pgjoWLFVZEEGvA1TjaotckONT/Q==
X-ME-Proxy: <xmx:VjFxW_o07YhJ8VNZOlsnqdQkAeuYI33YANKQkRjaO0WjGRV0h6EAXw>
    <xmx:VjFxW1V4E6I8cceSj9wEEWSh1t2NLOIDfJNBy3SBJqpJaQzvztuI6A>
    <xmx:VjFxW_03_t4rTPgWa6cO3oeeba1WIQPZ7bW55xzNKoxOcBtOI1aIhA>
    <xmx:VjFxWzLzyEhJ0gOSIynMXPsWrBgSV8bSvlrD7OPfN5wsnn7JI12EFQ>
    <xmx:VjFxW869TAG46iC-ydCt2DTNuYzoDDjmEkxbWyHCRlPT4hx0rQ-e5A>
    <xmx:VzFxW6jKYtZgbm9ROz5NzXjxAS3OdruJA0IyVHDFX85xGRexSEYBnw>
X-ME-Sender: <xms:VjFxW4DlVJHF4KOsFoBKyxMafxsRhf0g7xKHHD6W9NLJQ5h8h9CxVw>
Received: from localhost (ppp121-44-213-101.bras1.syd2.internode.on.net [121.44.213.101])
        by mail.messagingengine.com (Postfix) with ESMTPA id B8656E405D;
        Mon, 13 Aug 2018 03:20:53 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] docs: net: Convert tcp.txt to RST format
Date:   Mon, 13 Aug 2018 17:20:48 +1000
Message-Id: <20180813072048.15064-1-me@tobin.cc>
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

