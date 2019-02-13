Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5A1C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C9D222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025274;
	bh=JTqfmv3GQSPbzfiajPqVW5BzLqL133mgimg029Hvh9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dz6c5/sM9gv3aJ7bZTr9g5x3gfbtaQoGP/+m8OkfKOiUHJmCtSUn44KFbEss5j8jr
	 i7gT1NaJUKiraisvBOaXIiVcjA847vx3L0DiQVvILL5aRiZe23JS0ZHlJ7M2ZzjKyv
	 kStfQ3ekeYM4+mgbNRD+u9TrJ1zmltDWrrXdTmc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbfBMCeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:34:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387675AbfBMCea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:34:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84CF3222C2;
        Wed, 13 Feb 2019 02:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025269;
        bh=JTqfmv3GQSPbzfiajPqVW5BzLqL133mgimg029Hvh9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7+VlF8hkQp8B/SOYo2QmsdvxAetObmi96wf7Iz5fnyRUMLmkmBQlZYYx8SmIMJAz
         PUvvy2VoRdu5dL/OmpcnI7sqiudRTsoDGA9h3funTkwPhVuIPvPaDvezwuC/zYjl/H
         DmryMTe0n6AgIN/gzE4Oc71XbAWsspcXUlwh7CSo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 037/105] selftests: forwarding: Add a test for VLAN deletion
Date:   Tue, 12 Feb 2019 21:32:28 -0500
Message-Id: <20190213023336.19019-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
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

