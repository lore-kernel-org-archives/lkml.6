Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeEQQGI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:06:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34952 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbeEQQGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:06:06 -0400
X-Google-Smtp-Source: AB8JxZqkd7VlUNRvgg3zpKZ16Q/3dUfJcHDXk2A4HsU8c3O91TApC4u2S+zMTKEFcGtxwwI+SQ4lAA==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: agross@codeaurora.org, broonie@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soc: qcom: apr: fix invalid msg_type check
Date: Thu, 17 May 2018 17:03:53 +0100
Message-Id: <20180517160353.27561-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed invalid msg_type check.
This also fixes below static checker warning:
apr.c:95:35: warning: comparison is always true due to limited range of
 data type [-Wtype-limits]
warn: always true condition '(msg_type != 69864) => (0-u16max != 69864)'

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soc/qcom/apr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 97f3622da535..57af8a537332 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -92,7 +92,7 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
 	}
 
 	msg_type = APR_HDR_FIELD_MT(hdr->hdr_field);
-	if (msg_type >= APR_MSG_TYPE_MAX && msg_type != APR_BASIC_RSP_RESULT) {
+	if (msg_type >= APR_MSG_TYPE_MAX) {
 		dev_err(apr->dev, "APR: Wrong message type: %d\n", msg_type);
 		return -EINVAL;
 	}
-- 
2.16.2
