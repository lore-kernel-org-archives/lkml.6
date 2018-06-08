Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /CfgE/7iGVtuTQAAmS7hNA
	; Fri, 08 Jun 2018 01:59:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2FD7F606DD; Fri,  8 Jun 2018 01:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528423166;
	bh=LfNdJIt6pzTNRXJmPb2LKUMFl7qx3gRraSWxSOMojpc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hiOH8ut5qyJB5NRC/wRy16VUIFXdPWkzyFLb17zYxhKbZ60aPeLwgjbVaM+/TSTZ+
	 EkTIbvGK08QIXPqj1syW1Zrvzx7jd80mMmCacDdkp68aiTABkmrRxoFolAq8HOSri8
	 OJun6UYa0fJ0K091GHXDQnXyRVc4iJHGUIeN3p2M=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A4401606FA;
	Fri,  8 Jun 2018 01:59:25 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i41NT58w";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o98tDozC"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4401606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeFHB7X (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 21:59:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53808 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbeFHB7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 21:59:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4CCAC606FA; Fri,  8 Jun 2018 01:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528423161;
        bh=LfNdJIt6pzTNRXJmPb2LKUMFl7qx3gRraSWxSOMojpc=;
        h=From:To:Cc:Subject:Date:From;
        b=i41NT58w6vbNSQIoTMU3hBEve/EFdlkxfL75cPtzFQFdvnJOyMY9m2XravBpSSEvI
         nLJx2Mp3W7CSmgpnm1rmh372sE7tg5ORxUNgiuDH17IQrLpoMkYNixadoYHacImanG
         3sCaRZzDV/clf+z7twJm6JAGcDQSGGsrgL/QCFi4=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgoswami@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 920F1606FA;
        Fri,  8 Jun 2018 01:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528423160;
        bh=LfNdJIt6pzTNRXJmPb2LKUMFl7qx3gRraSWxSOMojpc=;
        h=From:To:Cc:Subject:Date:From;
        b=o98tDozCzR8HByvrkGa9txL18zcRb+8oUar1SLgJnOI/JrWFKopPZ05VJGXxmDVDU
         V1MSvr51TiYw3DHmA6t8oa1HAEayjrrvIW1z01GP5FJK0S62W85T8t8G4sllmR8wJV
         tYFx2kN7WtpIVf0WvxFOg0btSfQXk+TueYHFZZWw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 920F1606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
From: bgoswami@codeaurora.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org,
        Banajit Goswami <bgoswami@codeaurora.org>
Subject: [PATCH] component: enhance handling of devres group for master
Date: Thu,  7 Jun 2018 18:59:18 -0700
Message-Id: <1528423158-27429-1-git-send-email-bgoswami@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Banajit Goswami <bgoswami@codeaurora.org>

The devres group opened for a master is left open-ended (without
devres_group_close) even after bind() is complete. Similarly, while
releasing the devres resources for master, the most recently opened
devres group is selected, and released without identifying the
targeted group. As the devres group opened before master bind was
never closed, there may have unintended consequences of releasing
devres resources that were allocated after master bind() function
was complete.

Change adds a devres_group_close() after bind() call to master, to
encapsulate the resources allocated during bind, and then use a
group ID to specifically identify the group in release, so that
during master unbind, only the resources that are part of that
specific devres group, are released.

Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 drivers/base/component.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 89b032f..f9ce937 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -155,17 +155,19 @@ static int try_to_bring_up_master(struct master *master,
 		return 0;
 	}
 
-	if (!devres_open_group(master->dev, NULL, GFP_KERNEL))
+	if (!devres_open_group(master->dev, master, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* Found all components */
 	ret = master->ops->bind(master->dev);
 	if (ret < 0) {
-		devres_release_group(master->dev, NULL);
+		devres_release_group(master->dev, master);
 		dev_info(master->dev, "master bind failed: %d\n", ret);
 		return ret;
 	}
 
+	devres_close_group(master->dev, master);
+
 	master->bound = true;
 	return 1;
 }
@@ -190,7 +192,7 @@ static void take_down_master(struct master *master)
 {
 	if (master->bound) {
 		master->ops->unbind(master->dev);
-		devres_release_group(master->dev, NULL);
+		devres_release_group(master->dev, master);
 		master->bound = false;
 	}
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
