Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeEOH7i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:59:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52872 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbeEOH7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:59:33 -0400
X-Google-Smtp-Source: AB8JxZpUQNBTDs5rtGwzIe96v8quwHhV2m/v0Y3NroBaXsfB0ONBOZ8eXrBF1eCgrbwy4HI9PDxxdQ==
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 05/29] venus: hfi: support session continue for 4xx version
Date: Tue, 15 May 2018 10:58:35 +0300
Message-Id: <20180515075859.17217-6-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
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
