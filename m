Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DA8C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B3D20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894936;
	bh=F3hdFsiNZ5gxs62tsLl7NDbkUz6RZKGc/Gwh2HbVGAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EHmWenn9jRYB+VfgwpCc+ejKX/76OVHVfa0fV7KEKzPDEcV2ZlW6+m5V5nrf6mX08
	 F/bZUEHRvTWN4iRwqWlZesJ7KsqDaU/VVHyCabGjNvrOV61TzHsOHU1eNnlag57ePJ
	 Zuj1pKqsxtB9MIgVdC28TnORlI/Knm3uY2DeTKRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfBKOWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:22:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbfBKOWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:22:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FFB9222A1;
        Mon, 11 Feb 2019 14:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894932;
        bh=F3hdFsiNZ5gxs62tsLl7NDbkUz6RZKGc/Gwh2HbVGAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTN40pjOSc+Q7gWEig53pqkbw5T7GjHBHohenzxRNLsJq2VpXz7oV3UeXdiqFTgOd
         diLBF1CbiDykGaVEEfvqHbuZZPrYBbnCvrH3cXm33DOmH3o2VzPsYStkhnjwQkhosN
         /o26BuTeJKNqYtAbhODx+pB66jUPWpqZk5OI+MNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Naftali Goldstein <naftali.goldstein@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 035/352] iwlwifi: fw: do not set sgi bits for HE connection
Date:   Mon, 11 Feb 2019 15:14:22 +0100
Message-Id: <20190211141848.573801604@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5c2dbebb446539eb9640bf59a02756d6e7f1fc53 ]

If the association supports HE, HT/VHT rates will never be used for Tx
and therefore there's no need to set the sgi-per-channel-width-support
bits, so don't set them in this case.

Fixes: 110b32f065f3 ("iwlwifi: mvm: rs: add basic implementation of the new RS API handlers")
Signed-off-by: Naftali Goldstein <naftali.goldstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 7a98e1a1dc40..dabbc04853ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -98,8 +98,12 @@ static u8 rs_fw_sgi_cw_support(struct ieee80211_sta *sta)
 {
 	struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
+	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
 	u8 supp = 0;
 
+	if (he_cap && he_cap->has_he)
+		return 0;
+
 	if (ht_cap->cap & IEEE80211_HT_CAP_SGI_20)
 		supp |= BIT(IWL_TLC_MNG_CH_WIDTH_20MHZ);
 	if (ht_cap->cap & IEEE80211_HT_CAP_SGI_40)
-- 
2.19.1



