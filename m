Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E89C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8120B2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O8nXH21x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfBSUG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:06:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34126 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbfBSUGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:06:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so10648668pgd.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 12:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dV4n54u4Vk8nQPIidEsBnddfIzKpZiU37Lp+GMapMQM=;
        b=O8nXH21xvSsrX1OsDJizzomvsSoTUNm6Z8wxdx3GPRef4zxxMrT5Hw2rBVCnSsUbLP
         OnkWNZXT9o5Wxd047B4AdPMKRWt+66i0PbfL0w0D3/4h551wtKVf4ko6SQoOOrf/w328
         dishnro/qOLVq4LAXLHyXHBFKWFYOl6qvjzvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dV4n54u4Vk8nQPIidEsBnddfIzKpZiU37Lp+GMapMQM=;
        b=mntX1KqB/FbX+BIqIbCyT4k2oyNJ8jOlDFQH49Ol6zI4hR2jtodr7NQj3nddjNYBuk
         wDOhn4N47Yl7JUeIfB82OpXAWyjPGHY6O5M+E7sEc+7u0VpdgDHBPHUS0Gmc++sTCmBo
         DNgql1rKDFyLx3nxR6R0LHcyTByNvZ3JV/9rhn4xdltsZJoDad0QNvZ+dn81lvsUnj4d
         720y/nULcgfxNzTBRiKIvEhYkd8ctnOIW03Q1gQa+BeDxe+xtXb24bgiIBlMK2iVSdHO
         DauBAYj2m00CBZRsr6hoQkuVJTnrS/lIgLitkuKbUiMOoXVvaaZaJ44Pbh90eJ8OOB9g
         H10w==
X-Gm-Message-State: AHQUAuad1ESruxwH4UC+jozeyPA1gOtbClmoY/J9ZsdVuxO4nvrYMrMH
        JB+kh+yjg6pLjVgrHNDrfQpPNg==
X-Google-Smtp-Source: AHgI3IaziTruyfWBp7Vrqn1lWKCI19vVykxfzVF3UrkKad5S+8MtakmXc+6R+vcrRj2z6+M4dxIIMg==
X-Received: by 2002:a62:442:: with SMTP id 63mr30538068pfe.156.1550606799734;
        Tue, 19 Feb 2019 12:06:39 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id s73sm50115476pfi.124.2019.02.19.12.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 12:06:39 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 2/3] Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY
Date:   Tue, 19 Feb 2019 12:05:58 -0800
Message-Id: <20190219200559.13079-3-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190219200559.13079-1-mka@chromium.org>
References: <20190219200559.13079-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the HCI_QUIRK_USE_BDADDR_PROPERTY quirk to let the HCI
core handle the reading of 'local-bd-address'. With this there
is no need to set HCI_QUIRK_INVALID_BDADDR, the case of a
non-existing or invalid fwnode property is handled by the core
code.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v4:
- btqcomsmd_setup(): removed unused variables 'err' and 'btq'

Changes in v3:
- none

Changes in v2:
- removed now unused field 'bdaddr' from struct btqcomsmd
- added 'Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>' tag
---
 drivers/bluetooth/btqcomsmd.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 7df3eed1ef5e9..e0d4c6f1d3ab6 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -28,7 +28,6 @@
 struct btqcomsmd {
 	struct hci_dev *hdev;
 
-	bdaddr_t bdaddr;
 	struct rpmsg_endpoint *acl_channel;
 	struct rpmsg_endpoint *cmd_channel;
 };
@@ -116,32 +115,17 @@ static int btqcomsmd_close(struct hci_dev *hdev)
 
 static int btqcomsmd_setup(struct hci_dev *hdev)
 {
-	struct btqcomsmd *btq = hci_get_drvdata(hdev);
 	struct sk_buff *skb;
-	int err;
 
 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 	kfree_skb(skb);
 
-	/* Devices do not have persistent storage for BD address. If no
-	 * BD address has been retrieved during probe, mark the device
-	 * as having an invalid BD address.
-	 */
-	if (!bacmp(&btq->bdaddr, BDADDR_ANY)) {
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-		return 0;
-	}
-
-	/* When setting a configured BD address fails, mark the device
-	 * as having an invalid BD address.
+	/* Devices do not have persistent storage for BD address. Retrieve
+	 * it from the firmware node property.
 	 */
-	err = qca_set_bdaddr_rome(hdev, &btq->bdaddr);
-	if (err) {
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-		return 0;
-	}
+	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 
 	return 0;
 }
@@ -169,15 +153,6 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	if (IS_ERR(btq->cmd_channel))
 		return PTR_ERR(btq->cmd_channel);
 
-	/* The local-bd-address property is usually injected by the
-	 * bootloader which has access to the allocated BD address.
-	 */
-	if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
-				       (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
-		dev_info(&pdev->dev, "BD address %pMR retrieved from device-tree",
-			 &btq->bdaddr);
-	}
-
 	hdev = hci_alloc_dev();
 	if (!hdev)
 		return -ENOMEM;
-- 
2.21.0.rc0.258.g878e2cd30e-goog

