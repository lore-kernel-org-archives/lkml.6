Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0EBC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969E0204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5e7x0XS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969E0204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbeGYUJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:09:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34672 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbeGYUJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:09:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so8379673wrt.1;
        Wed, 25 Jul 2018 11:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oJxrfVe1uDDH5M0hxVnH68FAhp+MBnBnp10Zrsvodyc=;
        b=M5e7x0XSdxNqjnmN6LUMXooAsU8zhICc4RvskDgSRAeGhqgpveZtGpzzZcRewaGGh7
         Xu3O1zr7cQdm/qDe+Jwl3uOIfHjEO+VEwheM0Edjzof9O+LPA7GZw+4GdoW9wMAueiUt
         h5ldmLRR1qAShaDjLwAHYd5Iu10Lv7EYPdsE2AITeG62jjmQ6Sy1gof9/rmsUpKuTs7B
         yCzNtzt2V0lb5CK7ElS3dRbB9Je/P8vv6GustaCWYJ72WuSMSaOtYNEfvIAfFsqVeo2v
         CWsgtc08YBaUqufdRvs5Q4ZP9UXEPY/mvON2IikeiHghJbDQd3NlrinQTEauMSURz9rl
         2Ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oJxrfVe1uDDH5M0hxVnH68FAhp+MBnBnp10Zrsvodyc=;
        b=WGyEVUAFbAUeUHhGWhEcy9y4YQ3tZelTQ5FhKY72x185dszmGniUnMfp6rTQhsukIl
         o7qyqc1ISwOJBe2aSDSHmKKjBxbg02G8SYDU/NjnNaP27bFEiXHqmLqtQzvLUnEVCpQS
         tD1i/pbsAVwcrXHeTL5r+w9XXY7leQG8FbPOUotKz2mtCurrVYzTVmSYvtAgAuXfaskS
         FM6ahRZ7rMdpaThPkU8/BsgPeZsXfx7HCz3WBmcdyODP6cyy7toza79gqQxhtKcsGzlo
         jGIicthu2GaAie67tduFyjPmBkWw0WlCzm6G4qC3Msy9k/VaODZOwxoLF1uDlOKNtbhp
         9pSQ==
X-Gm-Message-State: AOUpUlH71ftnVcpuXktGWctw6W/2N/7SK+4Gsf1Sv6SxqPs8Z6kkpbj3
        033qn09z3v4yQ6H7nFgLA64=
X-Google-Smtp-Source: AAOMgpeP6bEs334X1wkS5Nt/Qol6vIeWWDseyaJfDhAgRpjC9zufH0Y57tsyBCp4pb9wi9WUe90D4w==
X-Received: by 2002:adf:fc86:: with SMTP id g6-v6mr15061829wrr.216.1532545007954;
        Wed, 25 Jul 2018 11:56:47 -0700 (PDT)
Received: from euri.wifirst.net (eth-west-pareq2-46-193-2-21.wb.wifirst.net. [46.193.2.21])
        by smtp.googlemail.com with ESMTPSA id w8-v6sm14912243wrp.72.2018.07.25.11.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 11:56:47 -0700 (PDT)
From:   Varsha Rao <rvarsha016@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH] net: wireless: brcmsmac: Remove extra parentheses
Date:   Wed, 25 Jul 2018 20:56:22 +0200
Message-Id: <20180725185625.4220-1-rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary parentheses to fix the clang warning of
extraneous parentheses.

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
index 1a187557982e..4deba3075083 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -25453,12 +25453,12 @@ void wlc_phy_cal_perical_nphy_run(struct brcms_phy *pi, u8 caltype)
 			(pi->cal_type_override ==
 			 PHY_PERICAL_FULL) ? true : false;
 
-	if ((pi->mphase_cal_phase_id > MPHASE_CAL_STATE_INIT)) {
+	if (pi->mphase_cal_phase_id > MPHASE_CAL_STATE_INIT) {
 		if (pi->nphy_txiqlocal_chanspec != pi->radio_chanspec)
 			wlc_phy_cal_perical_mphase_restart(pi);
 	}
 
-	if ((pi->mphase_cal_phase_id == MPHASE_CAL_STATE_RXCAL))
+	if (pi->mphase_cal_phase_id == MPHASE_CAL_STATE_RXCAL)
 		wlapi_bmac_write_shm(pi->sh->physhim, M_CTS_DURATION, 10000);
 
 	wlapi_suspend_mac_and_wait(pi->sh->physhim);
-- 
2.17.0

