Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933003AbeDXMp0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:45:26 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36557 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757799AbeDXMpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:45:13 -0400
X-Google-Smtp-Source: AIpwx4+dn68kWzPFyYIENNR3VbPOQj/AOM8rC1Kopu3s/52WVEUOsdlBpDL97zOFu1ckWv/EvpCQfQ==
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 05/28] venus: hfi: support session continue for 4xx version
Date: Tue, 24 Apr 2018 15:44:13 +0300
Message-Id: <20180424124436.26955-6-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180424124436.26955-1-stanimir.varbanov@linaro.org>
References: <20180424124436.26955-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes possible to handle session_continue for 4xx as well.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index bca894a00c07..cbc6fad05e47 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -312,7 +312,7 @@ int hfi_session_continue(struct venus_inst *inst)
 {
 	struct venus_core *core = inst->core;
 
-	if (core->res->hfi_version != HFI_VERSION_3XX)
+	if (core->res->hfi_version == HFI_VERSION_1XX)
 		return 0;
 
 	return core->ops->session_continue(inst);
-- 
2.14.1
