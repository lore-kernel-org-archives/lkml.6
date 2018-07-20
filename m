Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3052ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EBC20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EBC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389754AbeGTN2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:28:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49972 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388697AbeGTN23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:28:29 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B3A0ABC1;
        Fri, 20 Jul 2018 12:37:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 035/101] qed: Fix use of incorrect size in memcpy call.
Date:   Fri, 20 Jul 2018 14:13:41 +0200
Message-Id: <20180720121424.459034699@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit cc9b27cdf7bd3c86df73439758ac1564bc8f5bbe ]

Use the correct size value while copying chassis/port id values.

Fixes: 6ad8c632e ("qed: Add support for query/config dcbx.")
Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
@@ -700,9 +700,9 @@ qed_dcbx_get_local_lldp_params(struct qe
 	p_local = &p_hwfn->p_dcbx_info->lldp_local[LLDP_NEAREST_BRIDGE];
 
 	memcpy(params->lldp_local.local_chassis_id, p_local->local_chassis_id,
-	       ARRAY_SIZE(p_local->local_chassis_id));
+	       sizeof(p_local->local_chassis_id));
 	memcpy(params->lldp_local.local_port_id, p_local->local_port_id,
-	       ARRAY_SIZE(p_local->local_port_id));
+	       sizeof(p_local->local_port_id));
 }
 
 static void
@@ -714,9 +714,9 @@ qed_dcbx_get_remote_lldp_params(struct q
 	p_remote = &p_hwfn->p_dcbx_info->lldp_remote[LLDP_NEAREST_BRIDGE];
 
 	memcpy(params->lldp_remote.peer_chassis_id, p_remote->peer_chassis_id,
-	       ARRAY_SIZE(p_remote->peer_chassis_id));
+	       sizeof(p_remote->peer_chassis_id));
 	memcpy(params->lldp_remote.peer_port_id, p_remote->peer_port_id,
-	       ARRAY_SIZE(p_remote->peer_port_id));
+	       sizeof(p_remote->peer_port_id));
 }
 
 static int


