Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753391AbeBUJc3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:32:29 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34248 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753200AbeBUJ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:12 -0500
X-Google-Smtp-Source: AH8x226W1dxyrxJkaprdtBD7IoYbeKGaW5l8b0U4YLLni1uiV7GKwunBY5DB+ij2tMa/IFIfVRhOYw==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 02/20] lightnvm: add controller capabilities to 2.0
Date: Wed, 21 Feb 2018 10:26:40 +0100
Message-Id: <1519205218-26994-3-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign missing mccap value on 2.0 path

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index c81e64cc20d7..969bb874850c 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -392,6 +392,8 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	dev_geo->c.ws_opt = le32_to_cpu(id->ws_opt);
 	dev_geo->c.mw_cunits = le32_to_cpu(id->mw_cunits);
 
+	dev_geo->c.mccap = le32_to_cpu(id->mccap);
+
 	dev_geo->c.trdt = le32_to_cpu(id->trdt);
 	dev_geo->c.trdm = le32_to_cpu(id->trdm);
 	dev_geo->c.tprt = le32_to_cpu(id->twrt);
-- 
2.7.4
