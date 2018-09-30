Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE17C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0B0208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDTnvgMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0B0208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeJAC2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:28:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34987 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbeJAC14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id o18-v6so6642504wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NLhYSn4vrHKiXSi3ZrcY1XJB9V1pZ6HSsYBhv/h/tRk=;
        b=LDTnvgMpsJWoP1XwutBEOD/mxV4kjMWaCzsduVNtV5p/9uMVl0ILYPE7jhA8gHKUlS
         zJ3h4hwBxGZ4MPyWjBboZBZjYy/JOBJGTnTcD3dEx4iFpC94eX2h6fsrNqy34ZdnTzTb
         k3L/OwSpJW8H9al4thfryKs1/C1TUsh8Jwutn0JTdmWbye3Y2heeD1jFG5laiT25e3QG
         0LZ9KLB7DMySSHG1yApB4i3FlCF408byVvMyC4fmv0D3sotT75GIHIJRzOSvOJIxpeB0
         pNCIhar3qLAC0PzCAbGRn3CEjrhQ0PcNm1WbqZKmnRqFDajmYf+LeHfVfgHxDp5fduGX
         nryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NLhYSn4vrHKiXSi3ZrcY1XJB9V1pZ6HSsYBhv/h/tRk=;
        b=SXXD3pJWOl+XlYLTC8LxLlzGMfRSx+hnb93Mp932dJHhkLzkrwpqKnVHigbE3QxHAJ
         d/Kg6pC0LxKuviDqHMISY8vq2RyxoCVMMBugqO4hua1auHUS7VsVkbWlzoao+cMD4Ofa
         dhwthw0Nm8QzGtGCK4gqh1txnvrwAWKNn7T1RrwOwGhcmxqm5KnVkvDEQeNSOqbBSWEM
         Zv2VmbVkMMVyvXO83jKRSuQqPvW+DBdeiYxkSKl+4fvCHCgdMg+B4p6FoxvsliCNdFCJ
         CfiIumvzTr8GWhIPy8NCtUrvm0II4S+w2WmzvB7HLbaCxx0lpECSimyDR9jEGgoqBuqB
         E1hg==
X-Gm-Message-State: ABuFfohYxNn+c7ponA7oMlp7qxYtjf6mu54FYltptPVmFTz273I/Yh9B
        GPh0/yq2+/dbxhxKot9Y56M=
X-Google-Smtp-Source: ACcGV63ZXf7GQdLrGjYHZ++ADS7qHS8KuBKzOtjosDDnYzfhnT3sr52K+CNPpCWLPy5xiPoW9YDi/A==
X-Received: by 2002:a1c:e157:: with SMTP id y84-v6mr6684119wmg.22.1538337216132;
        Sun, 30 Sep 2018 12:53:36 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 17/19] staging: rtl8188eu: remove unnecessary parentheses in odm_rtl8188e.c
Date:   Sun, 30 Sep 2018 21:53:08 +0200
Message-Id: <20180930195310.1531-17-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in odm_rtl8188e.c.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
index d5001920f77c..f42668eb37e4 100644
--- a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
+++ b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
@@ -13,7 +13,7 @@ static void dm_rx_hw_antena_div_init(struct odm_dm_struct *dm_odm)
 	struct adapter *adapter = dm_odm->Adapter;
 	u32 value32;
 
-	if (*(dm_odm->mp_mode) == 1) {
+	if (*dm_odm->mp_mode == 1) {
 		dm_odm->AntDivType = CGCS_RX_SW_ANTDIV;
 		phy_set_bb_reg(adapter, ODM_REG_IGI_A_11N, BIT(7), 0);
 		phy_set_bb_reg(adapter, ODM_REG_LNA_SWITCH_11N, BIT(31), 1);
@@ -44,7 +44,7 @@ static void dm_trx_hw_antenna_div_init(struct odm_dm_struct *dm_odm)
 	struct adapter *adapter = dm_odm->Adapter;
 	u32	value32;
 
-	if (*(dm_odm->mp_mode) == 1) {
+	if (*dm_odm->mp_mode == 1) {
 		dm_odm->AntDivType = CGCS_RX_SW_ANTDIV;
 		phy_set_bb_reg(adapter, ODM_REG_IGI_A_11N, BIT(7), 0);
 		phy_set_bb_reg(adapter, ODM_REG_RX_ANT_CTRL_11N,
@@ -90,7 +90,7 @@ static void dm_fast_training_init(struct odm_dm_struct *dm_odm)
 	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
 	u32 AntCombination = 2;
 
-	if (*(dm_odm->mp_mode) == 1) {
+	if (*dm_odm->mp_mode == 1) {
 		return;
 	}
 
-- 
2.19.0

