Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA9DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC072146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="p+rMI5F6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dWkP89fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC072146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389180AbeGKVtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:49:21 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:57211 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732931AbeGKVtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:49:21 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 086CA23F;
        Wed, 11 Jul 2018 17:43:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 11 Jul 2018 17:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=jxY8z2PTwKLvSWS1W7Absq6jlCIImvnjta+qviwpz
        qw=; b=p+rMI5F6qokgyySFwI0yrKfKP2kOCz3yX8AlK1DxROwWBohQCHngxCSbO
        tz4CqlqXJoV8eEvEz1SUINfgqXOifqlj90tDJx0PneNiiX5PBMSz/0pAzaYRP9vR
        ig7wj2ivgeykmA3CnDp62aIU+S/Yz3k84tOQBK8Z5k5eifaBAQC6uggtt6xNkEgA
        q54dswS8Y7YVQ6ep54A0+0U7VAjtArDvzMW0BBELLWCWk7+PofHtDeS5DdbnDPQw
        Fu1dgxfnhNCf2EZjX6GaBlsN5vGLGgnWl4oTbI9nqHlZKUHRYt/y+bMtE0PUrIQ/
        CDDEqtFaHJyjOBbYtDTv2JvAJW9WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=jxY8z2PTwKLvSWS1W
        7Absq6jlCIImvnjta+qviwpzqw=; b=dWkP89fvPqYJb3omutVd99Kl8KVSo1/VJ
        zJpGafU1uOMf07Hbr9bo86tqvD5HxUFPPYEm9gQlfViz7rKeFVl0c7vHnOSkYtl9
        mwyoWvs1xWzOslYS6dW+b1VIrV4NMQr8mB5geSpEAVnfXdkcT7bhflJQ2K59if2w
        rMlxPK25B9fyIIZsThN1PfxLpnlEgqz2b7W330DuIdZxdvrDReJZv4fLiV7Mq9b7
        0KP6CwZerZzfcMFK9K/yETKUWGNDn8ZSgkGyMwoH+R/INPbRZUhScF9/UjJ1mdkE
        WaOVRM+H8SxTiO0ZHiUixagjJ0E02P8y0SGsDtCQD+Yao0bNhAfPQ==
X-ME-Proxy: <xmx:43lGW8X_6WhXxRWebiTPLzruOj4sIiC6ilWuRytVv9yTXHa5YRwE1g>
    <xmx:43lGWwzbUbsr0f-O1ko6LorBw7VXxUF1nkMGklbToqMiuzfJcJJRtQ>
    <xmx:43lGWyNVkcv5UIqQt1LjLYSekQKKeAPSJvTOQHCjlnikw7uHuvhIEw>
    <xmx:43lGW54vaf97Jb5dHFOU1SAXc-Kf-3VFgII0_4aIuUJjcyl7cKhGXw>
    <xmx:43lGW7Ml0ceUHjIR-DWuYRDDPaWeRhQIrha8rCEKHZlWS1aXQ5w3zw>
    <xmx:5HlGW7vTz1XqC2VFsr3PFqP4ODCk4zHElZbinyP9Y9EriGvFqWodzA>
X-ME-Sender: <xms:43lGW-Br_unG0Hd5wUW7jnIM67hWCFnah7eLDwAeH5OROVpy8UbwMg>
Received: from localhost (ppp121-44-208-89.bras1.syd2.internode.on.net [121.44.208.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id 07BD71026E;
        Wed, 11 Jul 2018 17:42:58 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] docs: Fix failover build warnings
Date:   Thu, 12 Jul 2018 07:42:48 +1000
Message-Id: <20180711214250.19039-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

This is my first patch set to net-next.  Please shout loud and clear if
I've botched anything.

Recently failover and net_failover modules were added to the mainline.
Documentation was included in rst format but they were not added to the
toctree in `networking/index.rst`.  Also building docs for net_failover
is currently emitting a few warnings.

Patch 1 adds failover and net_failover to the index toctree
Patch 2 fixes the build warnings for net_failover

I haven't been super active on netdev list so if there is some reason I
missed why these files are not in the index please do say so.

Has there been any discussion on preferred order for the toctree index
list?  I just added them to the bottom of the list.

thanks,
Tobin.


Tobin C. Harding (2):
  docs: networking: Add failover docs to index
  docs: networking: Fix failover build warnings

 Documentation/networking/index.rst        |   2 +
 Documentation/networking/net_failover.rst | 111 +++++++++++-----------
 2 files changed, 59 insertions(+), 54 deletions(-)

-- 
2.17.1

