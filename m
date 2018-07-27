Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6945DC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6DF20891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsTliRHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6DF20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbeG0J50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:57:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45269 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbeG0J50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:57:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id f1-v6so2820168pgq.12;
        Fri, 27 Jul 2018 01:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ua4GP1DxrV1sLFxG80m4lAKLpm8j2fKndJKiDrySTJE=;
        b=lsTliRHf/dxhQNHttcwGcCWbjO6yJXrD0tVRBeQ+BKtDiQafmyWxGrRhnFC6wkEVVE
         YY5t4KCfNPJUZkyHlbZzehaieOI9K4m7ijyEifaPwuf2SO6c7HP2ACS02HpayLTwOafv
         DMPnRI8jzMphmxfQZJjjbUsedyxtatCYgUEGS/HMLW4Bn2GHKyYbdWC4A810UykeTUza
         KJk1MYavFKJY4CrdOoX30XWDR99/6GEtQlNFnM3iLaZ4izGwi/7nxbRoSp6eAFPdSVEO
         Gv8junUQXiFlrHcEin+1wIzbgnm0qimf0sUvG5KwBiGkRFBIAtTLDdQSrixW/hPs4IZ1
         D+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ua4GP1DxrV1sLFxG80m4lAKLpm8j2fKndJKiDrySTJE=;
        b=XDPI5n821NogdS6tUVgE17zr5AWFHN+rXYlKpczsl0hpHp9M6yndAHdE4eAOpfSOrS
         LNNfOULqcrwJEcNv8RZDsMD3DAvER7NIe7eJtRZ9yRiTnF5Gf6ktavfBMYbakuh5aNN2
         crmDbdZuBv8JFpGM9kfA3pcI2G383tRfP1Ocgf1aUoqMEHLHIvx73zdSyAMQd0QTwtZG
         Fumm7qhPfJOD2r/aJpXP4+AEutv5u0UZoqkLa922jZrLUke3EJ5OQYlk++vb43g3dfVQ
         bMahuV9vn7L3SMm97a8Aphq2s9VgJO6XZQ2w0RtAqgIFX9MTtosaWtt/q02ih9JsRTEM
         prqA==
X-Gm-Message-State: AOUpUlH/Cv7jr6GjCI/g988yIR11u91dFdLaV9rP2YwihMy2J4OKbqjd
        CghBCGNtL8wPXU3QUCHFw4N7Ce5I
X-Google-Smtp-Source: AAOMgpczzNoDqVsrv4VYH9ycjFGbWR+nyPuFVY3ExSg9VhY+pO3esUanufiucRdjWsIYbT1AKnklqA==
X-Received: by 2002:a63:cf4a:: with SMTP id b10-v6mr5223589pgj.235.1532680596829;
        Fri, 27 Jul 2018 01:36:36 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:8ca7:1cde:b1e6:2647])
        by smtp.gmail.com with ESMTPSA id w70-v6sm4652558pgd.18.2018.07.27.01.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:36:36 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     petkan@nucleusys.com
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: usb: pegasus: Replace mdelay() with msleep() in setup_pegasus_II()
Date:   Fri, 27 Jul 2018 16:36:29 +0800
Message-Id: <20180727083629.18663-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

setup_pegasus_II() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/usb/pegasus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index 6514c86f043e..f4247b275e09 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -1067,7 +1067,7 @@ static inline void setup_pegasus_II(pegasus_t *pegasus)
 
 	set_register(pegasus, Reg1d, 0);
 	set_register(pegasus, Reg7b, 1);
-	mdelay(100);
+	msleep(100);
 	if ((pegasus->features & HAS_HOME_PNA) && mii_mode)
 		set_register(pegasus, Reg7b, 0);
 	else
-- 
2.17.0

