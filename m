Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD50FC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B3F20891
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mp7s2mRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B3F20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeG1JUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 05:20:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbeG1JUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 05:20:21 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28ACD20862;
        Sat, 28 Jul 2018 07:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532764486;
        bh=xsnNprk0nu6MxsTEUEtbYvEEi2DrEz6VtHqgJwFnRQE=;
        h=From:To:Cc:Subject:Date:From;
        b=Mp7s2mRyArGldfqR8GtDRJ5gcYZhmDdeVEH+if4IXcGTu7tSh/CB/SpZlatsaEcaQ
         hcUGL9Gh8k09DW5T3e/Sgf+p3IwfX7FbxU9+3fCJWokKJlfXdVcoghgbOeK9o9Cm69
         mhTo7hLz+ecLfNOfReSlkIuWfOs24dXGFC4GnnDU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Ofer Levi <oferle@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org,
        "Meir Lichtinger" <meirl@mellanox.com>
Subject: [PATCH RESEND] ARC: [plat-eznps] Add missing struct nps_host_reg_aux_dpc
Date:   Sat, 28 Jul 2018 10:54:41 +0300
Message-Id: <20180728075441.6950-1-leon@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofer Levi <oferle@mellanox.com>

Fixing compilation issue caused by missing struct nps_host_reg_aux_dpc
definition.

Fixes: 3f9cd874dcc87 ("ARC: [plat-eznps] avoid toggling of DPC register")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ofer Levi <oferle@mellanox.com>
---
 arch/arc/plat-eznps/include/plat/ctop.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arc/plat-eznps/include/plat/ctop.h b/arch/arc/plat-eznps/include/plat/ctop.h
index 0c7d110..bd34b96 100644
--- a/arch/arc/plat-eznps/include/plat/ctop.h
+++ b/arch/arc/plat-eznps/include/plat/ctop.h
@@ -143,6 +143,15 @@ struct nps_host_reg_gim_p_int_dst {
 };

 /* AUX registers definition */
+struct nps_host_reg_aux_dpc {
+	union {
+		struct {
+			u32 ien:1, men:1, hen:1, reserved:29;
+		};
+		u32 value;
+	};
+};
+
 struct nps_host_reg_aux_udmc {
 	union {
 		struct {
--
1.7.1

