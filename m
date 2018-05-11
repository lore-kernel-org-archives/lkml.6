Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526037596; cv=none;
        d=google.com; s=arc-20160816;
        b=Ihhz2VuXffFfvt5ZKrXEvmgSV/HNUJZDCaNlAALvkVrihaWBN5HWlb+aeIdgtmWhjx
         wv32qwAzSGWbKsa06/cPyGQlKKWqKRFtVdvFOkrAYZx4dl6IIosNBhxK+h/IXhLEP6Zx
         cgAqFp8bo4YR7jnoyp2zTDcfJdrYuCkE7hVnLEDesM8qyKvWZRXHiAfVZ4c+U9esiBb6
         CsN71hgeAYq6HHUNT3vzqM2xmj/R7fNmqzc+ThasAuX+Aqi5l52vyou4pgb9kO6//SH5
         aiLcArvsSvzJtbF304zg4GjgWCc2Q44sAkShgkgu96BIGsyoS6w1vEQACa2U5BtPkjH8
         S2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Gvdv8c0jstww6fIwzmXV+em8qrnA7NpGMFs/d/h5h1U=;
        b=Yz/HeD2aIlLErSSEEu/Pe8DGkbh0qdWknqYHflAPkjySpJJWbI5Glo1ViqRDPma26J
         M5BmodyWSRNMp2RCOit63wcK8c90tz/7kqqKasPA/e9Q9XjBWHZHzWmwyJBMpFRDI/bR
         Fo1mxGJcEgyd/zm67WErRF2uru4iaElOLTz4EzhotI8JQbbjAAk8r2IF6a2oV1368WCp
         qARWc8cCYTCguQ98051K8jJF0TaKW7fbpJByixTliFey6JSq/Y5a0M/BCMY7qYryyp4+
         6TDLg3r5c6j0cdl8zsSaJX+25/Kv5dyAohBt1zaXzcmybjYXTmqiPmf3ckJMelx4kD/7
         rPSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Z8ULBRoU;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Z8ULBRoU;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZq+UkaeycDbdMgOtjBSG+GyZjr5dQG4qV2XATylopVRs50ttUC3ODtbgOGJVnQX72I4YgFAkQ==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org
Subject: [PATCH] slimbus: qcom: remove unused variable
Date: Fri, 11 May 2018 12:17:44 +0100
Message-Id: <20180511111744.12465-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600166399219383852?=
X-GMAIL-MSGID: =?utf-8?q?1600166399219383852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes below warning when driver is compiled with W=1
qcom-ctrl.c: In function 'qcom_slim_rxwq':
qcom-ctrl.c:442:13: warning: variable 'len' set but not used
 [-Wunused-but-set-variable]

len seems to be unused in this function, so remove it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index ffb46f915334..bb36a8fbc9b1 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -439,13 +439,12 @@ static int slim_get_current_rxbuf(struct qcom_slim_ctrl *ctrl, void *buf)
 static void qcom_slim_rxwq(struct work_struct *work)
 {
 	u8 buf[SLIM_MSGQ_BUF_LEN];
-	u8 mc, mt, len;
+	u8 mc, mt;
 	int ret;
 	struct qcom_slim_ctrl *ctrl = container_of(work, struct qcom_slim_ctrl,
 						 wd);
 
 	while ((slim_get_current_rxbuf(ctrl, buf)) != -ENODATA) {
-		len = SLIM_HEADER_GET_RL(buf[0]);
 		mt = SLIM_HEADER_GET_MT(buf[0]);
 		mc = SLIM_HEADER_GET_MC(buf[1]);
 		if (mt == SLIM_MSG_MT_CORE &&
-- 
2.16.2
