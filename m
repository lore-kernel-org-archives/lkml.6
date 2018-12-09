Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45521C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 05:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F355920831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 05:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKQk2ahQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F355920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeLIFTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 00:19:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39292 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeLIFTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 00:19:03 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so3676906pld.6;
        Sat, 08 Dec 2018 21:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uCPeexdJ5AfMKP2nzbz+gP5I2yOBaGAIYFi/XL/QO7M=;
        b=sKQk2ahQPuOk36dz0Jz9S7nwtD97Fqtor0POPxWSr1VR+pN9LD13l1jwZ+EMIhhXO3
         BlGtAkH5AMPfcn2ZfeszTgBlR7mQV6BMaHinjjg8UkYqqgalCATwd2T0BLokUuKS9cIb
         z0ZjYb5JdHEMdG01AjxJyotkojx4iwDHlSrVt7bXlX/STb2CwN5ZmyaApQlYO6CFEE9b
         CVwTVFbO5cPk9n9FJO1ZHgIhKTaMzZKHeisnxiofZ2hvP+No/HIQw1QPp//UA2pXW5lY
         N8+pVUENOb8vJalymdG1tqrhuyXdlrDZFsybY3ZHdpL3TNAT19r9sr6ZezJsJDJi0kjL
         T9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uCPeexdJ5AfMKP2nzbz+gP5I2yOBaGAIYFi/XL/QO7M=;
        b=rGL3g95aRhUHCuz3x/dt4Z9Imim63nUHVXdh8nv4tv96IrVTig2s5h1veWR59eZDYy
         tH++U/wba4PVK1wVdqJvBUN1IpOEohrh5C4Zh44BAbPYZONSggEswxg1W8IUBEKRu1t1
         esOQmo2qbA34H3kbg/DseVxYe+RT/c/qO6cC2mAMMjp3W4N9ABJ31fkrhtC8kuVaaPA/
         w4CuYwrpnWPOz14Ft3VrVn3R5FJS/r0821SmO5P3J+Fv9km8d7j67oKGbTsBJTg3eeq4
         IVvhFsFkJMJS3B/ug9NX8Y+VcOCj1Pi4tUTfLJG/CTSUV4QLuuQLGF1IiCdZmBwGIurx
         dqrg==
X-Gm-Message-State: AA+aEWaXKUETaxLqhFUgwtI29hfjCQbQVTwV8/AFIlzD9lS5Mlt4+yDF
        KBYwSAOp6kKczjuPlhhG85U=
X-Google-Smtp-Source: AFSGD/XdZHUg09GAKXVsVDv0T9PM2gm87S4j2GLVIz6IYw2IXMT/T2zUCPfDrd9VH8vi+DO5A9Takg==
X-Received: by 2002:a17:902:5ac7:: with SMTP id g7mr7879955plm.212.1544332743252;
        Sat, 08 Dec 2018 21:19:03 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id n66sm11913025pfk.19.2018.12.08.21.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 21:19:02 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] Input: i8042 fix refcount leak
Date:   Sun,  9 Dec 2018 00:19:00 -0500
Message-Id: <20181209051900.19035-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/input/serio/i8042-sparcio.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 796289846204..cc6777b4c4ea 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -111,13 +111,17 @@ static int __init i8042_platform_init(void)
 	struct device_node *root = of_find_node_by_path("/");
 
 	if (!strcmp(root->name, "SUNW,JavaStation-1")) {
+		of_node_put(root);
 		/* Hardcoded values for MrCoffee.  */
 		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
 		kbd_iobase = ioremap(0x71300060, 8);
 		if (!kbd_iobase)
 			return -ENODEV;
 	} else {
-		int err = platform_driver_register(&sparc_i8042_driver);
+		int err;
+
+		of_node_put(root);
+		err = platform_driver_register(&sparc_i8042_driver);
 		if (err)
 			return err;
 
-- 
2.17.0

