Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD27ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DC320847
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELoXrFZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DC320847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeJYWnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbeJYWnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:43:55 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4BDE2054F;
        Thu, 25 Oct 2018 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476659;
        bh=MPCeHQAwh0yKoP35Ko4SAVfo9UUme7RMUtYsWCuxmGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELoXrFZOia7iwuW229MkIrxg+PLi7X3/yAyMwH2/kPvI2yfL4MLfTldXLtnerVcFd
         Y3tPW2CYjQU4hJEGkz+grTcS+faB/AT6AjejBp+l4HnnOK9pYd+v+84MSsCKG+VxMj
         d4z+Y5uR21Yx2tyRvETsfofgby1QW81r7dfQnjds=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 03/46] iwlwifi: fix the ALIVE notification layout
Date:   Thu, 25 Oct 2018 10:10:10 -0400
Message-Id: <20181025141053.213330-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 5cd2d8fc6c6bca979ac5dd8ad0e41153f1f982f9 ]

The ucode_major and ucode_minor were swapped. This has
no practical consequences since those fields are not used.
Same goes for umac_major and umac_minor which were only
printed under certain debug flags.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
index 3684a3e180e5..007bfe7656a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
@@ -95,8 +95,8 @@ enum {
 #define IWL_ALIVE_FLG_RFKILL	BIT(0)
 
 struct iwl_lmac_alive {
-	__le32 ucode_minor;
 	__le32 ucode_major;
+	__le32 ucode_minor;
 	u8 ver_subtype;
 	u8 ver_type;
 	u8 mac;
@@ -113,8 +113,8 @@ struct iwl_lmac_alive {
 } __packed; /* UCODE_ALIVE_NTFY_API_S_VER_3 */
 
 struct iwl_umac_alive {
-	__le32 umac_minor;		/* UMAC version: minor */
 	__le32 umac_major;		/* UMAC version: major */
+	__le32 umac_minor;		/* UMAC version: minor */
 	__le32 error_info_addr;		/* SRAM address for UMAC error log */
 	__le32 dbg_print_buff_addr;
 } __packed; /* UMAC_ALIVE_DATA_API_S_VER_2 */
-- 
2.17.1

