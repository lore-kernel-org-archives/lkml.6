Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430B6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091D120873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091D120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932928AbeGIMmA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:42:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35968 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932445AbeGIMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:41:58 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fcVUI-0007wV-DU; Mon, 09 Jul 2018 12:41:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@do-not-panic.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ath5k: remove redundant pointer rf
Date:   Mon,  9 Jul 2018 13:41:38 +0100
Message-Id: <20180709124138.14996-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer rf is being assigned but is never used hence it is redundant
and can be removed.

Cleans up two clang warnings:
warning: variable 'rf' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wireless/ath/ath5k/phy.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/phy.c b/drivers/net/wireless/ath/ath5k/phy.c
index b1b8bc326830..ae08572c4b58 100644
--- a/drivers/net/wireless/ath/ath5k/phy.c
+++ b/drivers/net/wireless/ath/ath5k/phy.c
@@ -483,7 +483,6 @@ static u32
 ath5k_hw_rf_gainf_corr(struct ath5k_hw *ah)
 {
 	u32 mix, step;
-	u32 *rf;
 	const struct ath5k_gain_opt *go;
 	const struct ath5k_gain_opt_step *g_step;
 	const struct ath5k_rf_reg *rf_regs;
@@ -502,7 +501,6 @@ ath5k_hw_rf_gainf_corr(struct ath5k_hw *ah)
 	if (ah->ah_rf_banks == NULL)
 		return 0;
 
-	rf = ah->ah_rf_banks;
 	ah->ah_gain.g_f_corr = 0;
 
 	/* No VGA (Variable Gain Amplifier) override, skip */
@@ -549,13 +547,10 @@ ath5k_hw_rf_check_gainf_readback(struct ath5k_hw *ah)
 {
 	const struct ath5k_rf_reg *rf_regs;
 	u32 step, mix_ovr, level[4];
-	u32 *rf;
 
 	if (ah->ah_rf_banks == NULL)
 		return false;
 
-	rf = ah->ah_rf_banks;
-
 	if (ah->ah_radio == AR5K_RF5111) {
 
 		rf_regs = rf_regs_5111;
-- 
2.17.1

