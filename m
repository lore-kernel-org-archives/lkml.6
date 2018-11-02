Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C50EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4656D20837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wnqb48XN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4656D20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbeKCD6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbeKCD6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:58:34 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2660A2082D;
        Fri,  2 Nov 2018 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184619;
        bh=fTVNoCill6WDo0CgOeZiXPGRCyIOKhfoM9qrYluXVJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wnqb48XNLnSUHPh0Mgi4n+jIEOrRWfLi04mntimmqZRyQL1gvMDgdA54is++Sl6u6
         yaE+Y+PsjI1xTHm56xqi4Ba47BxCexNqMuaZQelcFK2LEY9G/bZ1WeYw+MfI8Ykpwc
         yp9kdRw8JfipNWv63PIm/F057lBZctmgSJluvwAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 052/143] iwlwifi: fix the ALIVE notification layout
Date:   Fri,  2 Nov 2018 19:33:57 +0100
Message-Id: <20181102182901.207155322@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



