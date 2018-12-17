Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5BEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A4920874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbvNfFN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbeLQPCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:02:36 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35223 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387645AbeLQPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:02:32 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so11023305edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eV2weuyk5OyQZb9H3UE7xJciTIyZU6QfT44kxxzQjbY=;
        b=vbvNfFN9xRUywUIiWVRytStbtP5eLcL1j8psxyXDZE+bYoSMqINgbVDkBSyCPorLtp
         NlSxW3P/FNNW0XVA8Qcj9KPJGIr+PNwaIPaOSt7cg1vxpQ87Okc+maV/7ang05mTn47b
         gVQg+dHrsp9HTNYa4Nbni7wSxoECpllaBEWQ76/9ntUs/V8OG4uPzqkxKzkgh/mL/SLN
         SHRJsJeKpp3XuojGLFImxb3Wgsj/tWEiKzlNFdp8fZV0u8GgQcy7vDif0JLYuOx8R7T/
         72T6aKNVk0Agpk9Dv6QXNTYOhEHeazAs971/Vvuwn7RM69A+vBbQrE+rlEkaMzqG7KiJ
         tvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eV2weuyk5OyQZb9H3UE7xJciTIyZU6QfT44kxxzQjbY=;
        b=MeV9O6e8dx6CdM6RlJ+6VRrT/ejaxq2pNMTBwFcgi3sArJfVtc4091U/4m0mPEbGVD
         uOi6aQh2Sfay3y+o1YTOLu/SLtEHmoynh2929Fqm/j5Mknkiu/4eiDz5ml77frFgsykV
         1+UPO0CBoZnxK43Qt3bTHAapqaT+1bz5ZfGEKnJ//BCKBY4laIlDNiFRgUjiHH4l4ei+
         oxuQdfuem4CCPA8HHXPm1SFkeCgYE4VvgfaZ6wrG9OwY7akUr8uH8QNliuEDBrZy18dK
         RRd2jc4yMSMfVkdgVgwJmkMQmfho3DjMdCeQa12di/6wX9K33JvQ9QNGw9ONOxdGwWCQ
         oX4Q==
X-Gm-Message-State: AA+aEWZjuBAEBj8fcNE+++pKEzQp3ny+g8UFXvpV01bOT937SWrq7RMg
        ZvR2GuSgYOLWHPrPTQVRSpU=
X-Google-Smtp-Source: AFSGD/Vn8Zf433AhWjHG41wCYxMj1eMwjC3HFEF1av1I7jTiceFWEt0KaQmH8AmbTZkBXmaARN0OGg==
X-Received: by 2002:a17:906:5c9:: with SMTP id t9-v6mr10585491ejt.111.1545058950801;
        Mon, 17 Dec 2018 07:02:30 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id n16-v6sm1861750eja.6.2018.12.17.07.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:02:29 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Steve Lin <steven.lin1@broadcom.com>,
        Jon Mason <jon.mason@broadcom.com>,
        Rob Rice <rob.rice@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>
Subject: [PATCH v2 05/19] mailbox: bcm-pdc: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:03 +0100
Message-Id: <20181217150217.32435-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217150217.32435-1-thierry.reding@gmail.com>
References: <20181217150217.32435-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Steve Lin <steven.lin1@broadcom.com>
Cc: Jon Mason <jon.mason@broadcom.com>
Cc: Rob Rice <rob.rice@broadcom.com>
Cc: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/bcm-pdc-mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index 4fe7be0bdd11..ccf3d62af7e7 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -1471,7 +1471,7 @@ static int pdc_mb_init(struct pdc_state *pdcs)
 		mbc->chans[chan_index].con_priv = pdcs;
 
 	/* Register mailbox controller */
-	err = mbox_controller_register(mbc);
+	err = devm_mbox_controller_register(dev, mbc);
 	if (err) {
 		dev_crit(dev,
 			 "Failed to register PDC mailbox controller. Error %d.",
@@ -1641,8 +1641,6 @@ static int pdc_remove(struct platform_device *pdev)
 
 	pdc_hw_disable(pdcs);
 
-	mbox_controller_unregister(&pdcs->mbc);
-
 	dma_pool_destroy(pdcs->rx_buf_pool);
 	dma_pool_destroy(pdcs->ring_pool);
 	return 0;
-- 
2.19.1

