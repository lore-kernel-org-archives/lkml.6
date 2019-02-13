Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C05C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D103120835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026461;
	bh=JTqfmv3GQSPbzfiajPqVW5BzLqL133mgimg029Hvh9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ao1eU0EUBv2rXefZjcYXLC2Lyv0RI4gmmC8mTEC/hxSfVy16ZsNQHjT65WsNsLgqx
	 JO/VdbW604ncnJGXYChBzGRgHzSe9KJjxfsQ3xcsqejy2hH3qy7Nm+V+ZtMiiYJjZf
	 7keKS1GEhPLSyVma7c5EoqECG+Y2r7XtN0Z7FJoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbfBMChz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:37:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbfBMChv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:37:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37C9F206B6;
        Wed, 13 Feb 2019 02:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025471;
        bh=JTqfmv3GQSPbzfiajPqVW5BzLqL133mgimg029Hvh9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wldk1ZNO+nTNSbELl9ntTo+C6L79m5TMsWgcG2+vvbiQvaZm7E4sFVx/hH5v7sJc2
         j28YY5B8aB49GU58CWMSvOTAcpec54XV2Mj6F4lDLM5xxFpBMTOUQsNT6i1MY11YuB
         0YhlkUA+EpWI2z3bvWVHOj5cQOcYX+tzz6Q55nHE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 31/83] selftests: forwarding: Add a test for VLAN deletion
Date:   Tue, 12 Feb 2019 21:36:09 -0500
Message-Id: <20190213023701.20286-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 4fabf3bf93a194c7fa5288da3e0af37e4b943cf3 ]

Add a VLAN on a bridge port, delete it and make sure the PVID VLAN is
not affected.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/net/forwarding/bridge_vlan_aware.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
index d8313d0438b7..04c6431b2bd8 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding"
+ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding vlan_deletion"
 NUM_NETIFS=4
 CHECK_TC="yes"
 source lib.sh
@@ -96,6 +96,19 @@ flooding()
 	flood_test $swp2 $h1 $h2
 }
 
+vlan_deletion()
+{
+	# Test that the deletion of a VLAN on a bridge port does not affect
+	# the PVID VLAN
+	log_info "Add and delete a VLAN on bridge port $swp1"
+
+	bridge vlan add vid 10 dev $swp1
+	bridge vlan del vid 10 dev $swp1
+
+	ping_ipv4
+	ping_ipv6
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.19.1

