Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36492C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF0A2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="NJMkGmZc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N/Lj/5xF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF0A2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeILNS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:18:26 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46933 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbeILNS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:18:26 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D533820FAD;
        Wed, 12 Sep 2018 04:15:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 12 Sep 2018 04:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=XUPSE9qLHhade0YC+6tTZrS5gYod5rzOfb3DiE9WC
        Sg=; b=NJMkGmZcA0bpI+qXeOVLjJ+XMOQKhZRXsC1lnQQyaqJZxI8juulLOXhUM
        2Wdb0bAeOUwjFF8gjf2ShLIDu7RGSRHCsPTMHjU9yCJzyVKh65GlHNuHUXuk9NNQ
        u0W2E+1sFUR65VyR3HoohgTBGOfqwE7LlLGeLDMrjh2XDu13jePn2HKCyJjy6ICY
        sdVLr91ZshV5OXKOFK7upIOAZpfsy4RKGImcqiWAHJbUV9NvS/XSV5h0N9LCF/at
        0vp5WfB5IJ60OKLXFgZwovJJVXQiCPZSVMn2Bnifz739cAiilf3+Q7PmZsqHMCFs
        Dx5nX83C6akZsoSZch+f9k+Dlm2eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=XUPSE9qLHhade0YC+
        6tTZrS5gYod5rzOfb3DiE9WCSg=; b=N/Lj/5xFrRBTyQGNMpsQGB9edQcaBxYf2
        XbnbmtcKZN2DYXbW6EfnUXFWpUxuABpJ7cGzE9JCUk5GXlNc5FBC1Q3HVM0zXWiE
        C/7SKfx2o6swVMyUeFspJ+7OUn0WJuKpf32P+TLc+RiAMPdclE7S4Y+uqkDsgokk
        NyXu+EJXGTa4l01On/LiJ1yvvHLtixqj2XK/5ZaWFaJKuNUmWXk5S7b0Idooaepq
        0rBjxlruT5Gwe8LsaLqBhK/+1MLq9HXtRi9QBWg056r8GAB85IAwDwXHqOPYuE0N
        THppZTvFoS7VOrMmNJbb2UdQm6UBI76YDYLwXDgl14V7BB44+h1GA==
X-ME-Proxy: <xmx:BcuYWyCCrCdl1VuU8GOF0wJQmOB_oGGMP_gBjBB-6YrAh6IF5kKsrQ>
    <xmx:BcuYW8sdJctR8XPjt3KSIVelvcK_aUlTf8h-dFu4gYYp_-BaNTVh5w>
    <xmx:BcuYW3ZakIBj2sUmcZD2xvV_Mwe9mlbLm6EMHe_sfZUyog_UrW4o9w>
    <xmx:BcuYW_UFSxFU3PEIxQAlG8l9dgel9uZE14VSpG5uZmAGJaf5KbjevA>
    <xmx:BcuYW76Sv1XvXsfBaireVILHcjg7YSsCh7YyMBrz3GmiKK4JogLTlQ>
    <xmx:BcuYW71W8qLpXE2mdCHusLZRzNr-gpUWuJUGiCS1JfQbnrsKJwsQnA>
X-ME-Sender: <xms:BMuYW4tOEaO8PWLlM-Ellfqqgg4aJ9DThyzqruAgaad6i5Cnxg-5zQ>
Received: from localhost (ppp121-44-246-110.bras2.syd2.internode.on.net [121.44.246.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 43CD8E455F;
        Wed, 12 Sep 2018 04:15:00 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: net: Remove TCP congestion document
Date:   Wed, 12 Sep 2018 18:14:44 +1000
Message-Id: <20180912081444.17258-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document is stale, let's remove it.

Remove TCP congestion document.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

Previous patch converted this file to rst.

 [PATCH RESEND net-next] docs: net: Convert tcp.txt to RST format

Response to that patch on LKML by Eric:

 I dunno, this 'doc' is probably useless and should be deleted.

Removing as suggested.

thanks,
Tobin.

 Documentation/networking/00-INDEX |   2 -
 Documentation/networking/tcp.txt  | 101 ------------------------------
 2 files changed, 103 deletions(-)
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

