Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_75_100,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B587C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1531120652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1531120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbeIMTMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:12:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731104AbeIMTMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:12:34 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B00F7D2E;
        Thu, 13 Sep 2018 14:02:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        Rex Zhu <Rex.Zhu@amd.com>
Subject: [PATCH 4.18 161/197] drm/amd/pp/Polaris12: Fix a chunk of registers missed to program
Date:   Thu, 13 Sep 2018 15:31:50 +0200
Message-Id: <20180913131847.994518606@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rex Zhu <rex.zhu@amd.com>

commit 2d227ec2c11c568910299e8f913bac2dda47397c upstream.

DIDTConfig_Polaris12[] table missed a big chunk of data.

Pointed by aidan.fabius <aidan.fabius@coreavi.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c |   43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c
@@ -403,6 +403,49 @@ static const struct gpu_pt_config_reg DI
 	{   ixDIDT_SQ_CTRL1,                   DIDT_SQ_CTRL1__MAX_POWER_MASK,                      DIDT_SQ_CTRL1__MAX_POWER__SHIFT,                    0xffff,     GPU_CONFIGREG_DIDT_IND },
 
 	{   ixDIDT_SQ_CTRL_OCP,                DIDT_SQ_CTRL_OCP__UNUSED_0_MASK,                    DIDT_SQ_CTRL_OCP__UNUSED_0__SHIFT,                  0x0000,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_CTRL_OCP,                DIDT_SQ_CTRL_OCP__OCP_MAX_POWER_MASK,               DIDT_SQ_CTRL_OCP__OCP_MAX_POWER__SHIFT,             0xffff,     GPU_CONFIGREG_DIDT_IND },
+
+	{   ixDIDT_SQ_CTRL2,                   DIDT_SQ_CTRL2__MAX_POWER_DELTA_MASK,                DIDT_SQ_CTRL2__MAX_POWER_DELTA__SHIFT,              0x3853,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_CTRL2,                   DIDT_SQ_CTRL2__UNUSED_0_MASK,                       DIDT_SQ_CTRL2__UNUSED_0__SHIFT,                     0x0000,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_CTRL2,                   DIDT_SQ_CTRL2__SHORT_TERM_INTERVAL_SIZE_MASK,       DIDT_SQ_CTRL2__SHORT_TERM_INTERVAL_SIZE__SHIFT,     0x005a,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_CTRL2,                   DIDT_SQ_CTRL2__UNUSED_1_MASK,                       DIDT_SQ_CTRL2__UNUSED_1__SHIFT,                     0x0000,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_CTRL2,                   DIDT_SQ_CTRL2__LONG_TERM_INTERVAL_RATIO_MASK,       DIDT_SQ_CTRL2__LONG_TERM_INTERVAL_RATIO__SHIFT,     0x0000,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_CTRL2,                   DIDT_SQ_CTRL2__UNUSED_2_MASK,                       DIDT_SQ_CTRL2__UNUSED_2__SHIFT,                     0x0000,     GPU_CONFIGREG_DIDT_IND },
+
+	{   ixDIDT_SQ_STALL_CTRL,              DIDT_SQ_STALL_CTRL__DIDT_STALL_CTRL_ENABLE_MASK,    DIDT_SQ_STALL_CTRL__DIDT_STALL_CTRL_ENABLE__SHIFT,  0x0001,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_STALL_CTRL,              DIDT_SQ_STALL_CTRL__DIDT_STALL_DELAY_HI_MASK,       DIDT_SQ_STALL_CTRL__DIDT_STALL_DELAY_HI__SHIFT,     0x0001,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_STALL_CTRL,              DIDT_SQ_STALL_CTRL__DIDT_STALL_DELAY_LO_MASK,       DIDT_SQ_STALL_CTRL__DIDT_STALL_DELAY_LO__SHIFT,     0x0001,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_STALL_CTRL,              DIDT_SQ_STALL_CTRL__DIDT_HI_POWER_THRESHOLD_MASK,   DIDT_SQ_STALL_CTRL__DIDT_HI_POWER_THRESHOLD__SHIFT, 0x0ebb,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_STALL_CTRL,              DIDT_SQ_STALL_CTRL__UNUSED_0_MASK,                  DIDT_SQ_STALL_CTRL__UNUSED_0__SHIFT,                0x0000,     GPU_CONFIGREG_DIDT_IND },
+
+	{   ixDIDT_SQ_TUNING_CTRL,             DIDT_SQ_TUNING_CTRL__DIDT_TUNING_ENABLE_MASK,       DIDT_SQ_TUNING_CTRL__DIDT_TUNING_ENABLE__SHIFT,     0x0001,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_TUNING_CTRL,             DIDT_SQ_TUNING_CTRL__MAX_POWER_DELTA_HI_MASK,       DIDT_SQ_TUNING_CTRL__MAX_POWER_DELTA_HI__SHIFT,     0x3853,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_TUNING_CTRL,             DIDT_SQ_TUNING_CTRL__MAX_POWER_DELTA_LO_MASK,       DIDT_SQ_TUNING_CTRL__MAX_POWER_DELTA_LO__SHIFT,     0x3153,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_TUNING_CTRL,             DIDT_SQ_TUNING_CTRL__UNUSED_0_MASK,                 DIDT_SQ_TUNING_CTRL__UNUSED_0__SHIFT,               0x0000,     GPU_CONFIGREG_DIDT_IND },
+
+	{   ixDIDT_SQ_CTRL0,                   DIDT_SQ_CTRL0__DIDT_CTRL_EN_MASK,                   DIDT_SQ_CTRL0__DIDT_CTRL_EN__SHIFT,                 0x0001,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_CTRL0,                   DIDT_SQ_CTRL0__USE_REF_CLOCK_MASK,                  DIDT_SQ_CTRL0__USE_REF_CLOCK__SHIFT,                0x0000,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_CTRL0,                   DIDT_SQ_CTRL0__PHASE_OFFSET_MASK,                   DIDT_SQ_CTRL0__PHASE_OFFSET__SHIFT,                 0x0000,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_CTRL0,                   DIDT_SQ_CTRL0__DIDT_CTRL_RST_MASK,                  DIDT_SQ_CTRL0__DIDT_CTRL_RST__SHIFT,                0x0000,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_CTRL0,                   DIDT_SQ_CTRL0__DIDT_CLK_EN_OVERRIDE_MASK,           DIDT_SQ_CTRL0__DIDT_CLK_EN_OVERRIDE__SHIFT,         0x0000,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_CTRL0,                   DIDT_SQ_CTRL0__DIDT_MAX_STALLS_ALLOWED_HI_MASK,     DIDT_SQ_CTRL0__DIDT_MAX_STALLS_ALLOWED_HI__SHIFT,   0x0010,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_CTRL0,                   DIDT_SQ_CTRL0__DIDT_MAX_STALLS_ALLOWED_LO_MASK,     DIDT_SQ_CTRL0__DIDT_MAX_STALLS_ALLOWED_LO__SHIFT,   0x0010,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_SQ_CTRL0,                   DIDT_SQ_CTRL0__UNUSED_0_MASK,                       DIDT_SQ_CTRL0__UNUSED_0__SHIFT,                     0x0000,     GPU_CONFIGREG_DIDT_IND },
+
+	{   ixDIDT_TD_WEIGHT0_3,               DIDT_TD_WEIGHT0_3__WEIGHT0_MASK,                    DIDT_TD_WEIGHT0_3__WEIGHT0__SHIFT,                  0x000a,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_TD_WEIGHT0_3,               DIDT_TD_WEIGHT0_3__WEIGHT1_MASK,                    DIDT_TD_WEIGHT0_3__WEIGHT1__SHIFT,                  0x0010,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_TD_WEIGHT0_3,               DIDT_TD_WEIGHT0_3__WEIGHT2_MASK,                    DIDT_TD_WEIGHT0_3__WEIGHT2__SHIFT,                  0x0017,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_TD_WEIGHT0_3,               DIDT_TD_WEIGHT0_3__WEIGHT3_MASK,                    DIDT_TD_WEIGHT0_3__WEIGHT3__SHIFT,                  0x002f,     GPU_CONFIGREG_DIDT_IND },
+
+	{   ixDIDT_TD_WEIGHT4_7,               DIDT_TD_WEIGHT4_7__WEIGHT4_MASK,                    DIDT_TD_WEIGHT4_7__WEIGHT4__SHIFT,                  0x0046,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_TD_WEIGHT4_7,               DIDT_TD_WEIGHT4_7__WEIGHT5_MASK,                    DIDT_TD_WEIGHT4_7__WEIGHT5__SHIFT,                  0x005d,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_TD_WEIGHT4_7,               DIDT_TD_WEIGHT4_7__WEIGHT6_MASK,                    DIDT_TD_WEIGHT4_7__WEIGHT6__SHIFT,                  0x0000,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_TD_WEIGHT4_7,               DIDT_TD_WEIGHT4_7__WEIGHT7_MASK,                    DIDT_TD_WEIGHT4_7__WEIGHT7__SHIFT,                  0x0000,     GPU_CONFIGREG_DIDT_IND },
+
+	{   ixDIDT_TD_CTRL1,                   DIDT_TD_CTRL1__MIN_POWER_MASK,                      DIDT_TD_CTRL1__MIN_POWER__SHIFT,                    0x0000,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_TD_CTRL1,                   DIDT_TD_CTRL1__MAX_POWER_MASK,                      DIDT_TD_CTRL1__MAX_POWER__SHIFT,                    0xffff,     GPU_CONFIGREG_DIDT_IND },
+
+	{   ixDIDT_TD_CTRL_OCP,                DIDT_TD_CTRL_OCP__UNUSED_0_MASK,                    DIDT_TD_CTRL_OCP__UNUSED_0__SHIFT,                  0x0000,     GPU_CONFIGREG_DIDT_IND },
 	{   ixDIDT_TD_CTRL_OCP,                DIDT_TD_CTRL_OCP__OCP_MAX_POWER_MASK,               DIDT_TD_CTRL_OCP__OCP_MAX_POWER__SHIFT,             0x00ff,     GPU_CONFIGREG_DIDT_IND },
 
 	{   ixDIDT_TD_CTRL2,                   DIDT_TD_CTRL2__MAX_POWER_DELTA_MASK,                DIDT_TD_CTRL2__MAX_POWER_DELTA__SHIFT,              0x3fff,     GPU_CONFIGREG_DIDT_IND },


