Return-Path: <anders.roxell@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520327517; cv=none;
        d=google.com; s=arc-20160816;
        b=VEl5TGWLrjmACamtEoL40hHiz4wO04YSM/vvTHLmK1/yREdJ0Og18P159PwN3b6E6X
         KLBtCZre/ziuAmYRatJNYJqPGRTuxYh7x5fS36aqvh7TAUCXub3z/IbRwk5/Qv4sXv1U
         DCzW91YHnoLluUdz4QJ9gDpZXqAiPKHqJScHxTqHCQ5wB+RoeVRCPRAg/hBPFnHjAj2c
         8FdphxOgaKqaGb9e1a6IXr3f5IEnRFU/qZuhJQci1jBUAvgjBo+TAiO/U2DHezyn3uxX
         sJAXSVyhIk57X1waHWbI7jg3T+AMkbAuhrpSdpjLV16oxfRHwhn/s+JRnl4Sgq3qbMOC
         g8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=a0/vF64vAyAs/wxPNP9Nt/STG2EIcOu+zk8ER0A0WEQ=;
        b=iBPdK9K++2qIZhfHrwqEMTg9iKNMIr111vnqtdOZeVDss6K1hDNKP7t6NFVpI7KgEU
         UnvZ6snMNHwK9VFPm9cp3EGE+fjQ+eMsNV81Q0Mvw+/4TVA4DQYsjielbfVAxaPsz9M0
         7Gi2GRkrVuWGlVcMU9AwG423zR7rS7v6Dn5AXZ+8LF4IphvctSTZiZC53u+326fixSrD
         jaA59GPeb8D5boqo4QItHVpRPgYFnvLPqA1xQuhDpfY3AC+IMxgOxR6KOqmWZStRNLmn
         /bGOS+8cKxNfOjELQAe+Ej0zHjOhKq6j9tcvr0kNFUYj74Rf/tOU7rBFFZeG7vgMT7n2
         JY2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ULnVG0ER;
       spf=pass (google.com: domain of anders.roxell@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=anders.roxell@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ULnVG0ER;
       spf=pass (google.com: domain of anders.roxell@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=anders.roxell@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtZrckPh2PEnTjU5j3MEDgOY96PCvowqhKATls4xklzvaNEKmXjub5G+ZmKz9VeSbXkNjPiHw==
From: Anders Roxell <anders.roxell@linaro.org>
To: Roy.Pledge@nxp.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] staging: fsl-mc/dpio: remove unused function
Date: Tue,  6 Mar 2018 10:11:50 +0100
Message-Id: <20180306091150.24463-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594178946754266663?=
X-GMAIL-MSGID: =?utf-8?q?1594178946754266663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

gcc warns that function 'qbman_pull_desc_set_token' is not used.

drivers/staging/fsl-mc/bus/dpio/qbman-portal.c:525:13: warning: ‘qbman_pull_desc_set_token’ defined but not used [-Wunused-function]

In the current code we remove that function.

Fixes: 321eecb06bfb ("bus: fsl-mc: dpio: add QBMan portal APIs for DPAA2")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
index 7b75c934b201..3522b9c0106b 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
+++ b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
@@ -522,11 +522,6 @@ void qbman_pull_desc_set_numframes(struct qbman_pull_desc *d, u8 numframes)
 	d->numf = numframes - 1;
 }
 
-static void qbman_pull_desc_set_token(struct qbman_pull_desc *d, u8 token)
-{
-	d->tok = token;
-}
-
 /*
  * Exactly one of the following descriptor "actions" should be set. (Calling any
  * one of these will replace the effect of any prior call to one of these.)
-- 
2.11.0
