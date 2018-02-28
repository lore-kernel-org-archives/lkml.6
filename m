Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2827508-1519777084-2-12164310968625229636
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519777084; b=tpRYBXcoxxo73dXpv/lqIQIqYMxshtfK0xk9vicrEzSD1YN
    dYKIar2ajqAtZuU6xYOt8w/Doo8wGQtPUc+/dnvveBiaAqIGhOF8isbo0ikJY8yX
    0x7YtGSUEKU0d7aG9yS5QV3o9T+S2L5Orttc+5nblbmrk7xb8OZLGWN8dKqOHgOg
    dXR10KhP0Eg3L/c2jyWYmo3RbggVx21GZXKHf9fX8tfMfTwhw77OGmrhBpyNpyOY
    tp71MH0phiGr9ea3P842jagKSqRcgvdQO9NXKYSxe7CZMq39s5W/iD4gi6yaA6gr
    Lm4KEAbBvveviPaFDiYc2hE1QMYRuYwAu0cX3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519777084; bh=U/QkfmC2c4JdWu1eX+drVfbbyf
    LPRt4bxC/tLhKPUi0=; b=Jkciojrf3SBU+z9xtD7I5/6Azsfh0sDwkEi1fask2i
    nQ88SC/TfLgjaG7ALRW6rzZz0ILX7/g3U5buiQUTl6Ac+07QFObWXJQJUf9Wh969
    NKp9c0pzssQjoLSLvqGUZfYh9clt8VWSR8ygjAi4GEtW8Ra+PGyWJ4kHeiqA8QIG
    bE7INjt1TUlHGEeLblB/YZkoXiA71lmMg+ZrQXupXEZMILj56dI2dZFUNw/WoBWH
    8malNP+W2pdTEpZq2i1oat5trVbduTpg/d3KNx80lmzrfgw9UbR2FSSmsaVeE6ic
    /a3NP6IukcAgJsMilWjd9xM3F+OJ59SyO+YuchDEI5mA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=goyDT/Iw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YjPbNuAV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=goyDT/Iw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YjPbNuAV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeB1ASB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 19:18:01 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46015 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbeB1ARm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 19:17:42 -0500
X-Google-Smtp-Source: AH8x227tkA5OQIXslOkz/0oJwt/T0nkeq1un9am6U7z2swxDgRbshXrw42R0QhKUFnTKa7SBLsIirw==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btqcomsmd: Fix channel open check
Date: Tue, 27 Feb 2018 16:17:38 -0800
Message-Id: <20180228001738.11131-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

rpmsg_create_ept() returns NULL on error and as such
qcom_wcnss_open_channel() does the same. Clarify this in the
kernel-doc and correct the error checks in btqcomsmd.

Fixes: 1511cc750c3d ("Bluetooth: Introduce Qualcomm WCNSS SMD based HCI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/bluetooth/btqcomsmd.c | 8 ++++----
 drivers/soc/qcom/wcnss_ctrl.c | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 2c9a5fc9137d..24f702927875 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -151,13 +151,13 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 
 	btq->acl_channel = qcom_wcnss_open_channel(wcnss, "APPS_RIVA_BT_ACL",
 						   btqcomsmd_acl_callback, btq);
-	if (IS_ERR(btq->acl_channel))
-		return PTR_ERR(btq->acl_channel);
+	if (!btq->acl_channel)
+		return -ENOENT;
 
 	btq->cmd_channel = qcom_wcnss_open_channel(wcnss, "APPS_RIVA_BT_CMD",
 						   btqcomsmd_cmd_callback, btq);
-	if (IS_ERR(btq->cmd_channel))
-		return PTR_ERR(btq->cmd_channel);
+	if (!btq->cmd_channel)
+		return -ENOENT;
 
 	/* The local-bd-address property is usually injected by the
 	 * bootloader which has access to the allocated BD address.
diff --git a/drivers/soc/qcom/wcnss_ctrl.c b/drivers/soc/qcom/wcnss_ctrl.c
index d008e5b82db4..e968559b0fc4 100644
--- a/drivers/soc/qcom/wcnss_ctrl.c
+++ b/drivers/soc/qcom/wcnss_ctrl.c
@@ -275,6 +275,8 @@ static int wcnss_download_nv(struct wcnss_ctrl *wcnss, bool *expect_cbc)
  * @wcnss:	wcnss handle, retrieved from drvdata
  * @name:	SMD channel name
  * @cb:		callback to handle incoming data on the channel
+ *
+ * Return: rpmsg_endpoint object on success, NULL on error
  */
 struct rpmsg_endpoint *qcom_wcnss_open_channel(void *wcnss, const char *name, rpmsg_rx_cb_t cb, void *priv)
 {
-- 
2.16.2
