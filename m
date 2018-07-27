Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3BBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945FA20893
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DycbC6mN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945FA20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbeG0KCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:02:02 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41718 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbeG0KCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:02:01 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so2026111ply.8;
        Fri, 27 Jul 2018 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XGmq/x6P7K2Cm+nsR2uCIe5Myu9pfo9b8TAre9jUuvM=;
        b=DycbC6mNe5Dn2fKKN9kdGAO0a/45yfB5EhWdSCyiMX6HQBH8+rE9qR/5/TGevrhz7p
         bNzXzlzwlHo/jPI3SZFUV2BOvBu/Kor0TdFIYG1W+DI0AW0kp2HixitcDYgUAYpz9mCo
         IgKX3NjpcM9rjy6I1JGomZDuBvn8Qk+Bmu30/sFsePTMeSc8dm4VH8syDcTcr4it+7IO
         oQ6S2L/Msqk6w56QiQZ44CZev28HiAIBND3VLwCzNll7ULOlZWi8nmF7jIHVf5j6UHRK
         2P0Cq87/lMJSL9mxJXnSMn43Ns8/HnfddNfuhD5cs04yPHMu3Z2n3jNnWIYoudIafKGs
         E9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XGmq/x6P7K2Cm+nsR2uCIe5Myu9pfo9b8TAre9jUuvM=;
        b=XWreVlimN2p9MRMA2z25PhMrhsIA4nN1kz3ispLzJA6F1JLpAtQ5Cvn00Gi9gbpZ3w
         h3ZcbGg+jC+JJ7AqcWyHqb3FRtAOhjPcc22m4brROOESnxL6kOoTkuy5wsjg1KJaouRr
         fMTtCjjus+6j8XUjODpjy9XsfpaTJo6+9cie67FkJzHAaLSol4uxPEb+CppolV/Q7k2m
         FHAXdc+iKe2OBQCvPjtz1Ha94S3+3USEaDSXRwhYGz5YB3du07VpHFavAHERnCYlxdmw
         XZPK5O33yXTGsUFrP3T47w4jKxVyuFJ3M8fIpX2DHAcCLWBQfG33bnEzvXVZGYgbB/zx
         JhNQ==
X-Gm-Message-State: AOUpUlESA6Ku0US3rQ5peW3+4g/WW52qtSk7IiX6nRygV0YZjefw8z31
        Qn2IZYW/1nmgaWtXlWZaFjOBcdm4
X-Google-Smtp-Source: AAOMgpcs5jhxRmUKw/WOPuA8LTX9dL/bC+BwAidLNva4z8AAaM9GL9DSoRsQU+opzu8lpcxwYJnNxQ==
X-Received: by 2002:a17:902:bcc5:: with SMTP id o5-v6mr5156349pls.336.1532680870302;
        Fri, 27 Jul 2018 01:41:10 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:8ca7:1cde:b1e6:2647])
        by smtp.gmail.com with ESMTPSA id x2-v6sm7781921pfi.166.2018.07.27.01.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:41:09 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     liujunliang_ljl@163.com
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: usb: sr9700: Replace mdelay() with msleep() in sr9700_bind()
Date:   Fri, 27 Jul 2018 16:41:04 +0800
Message-Id: <20180727084104.29726-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sr9700_bind() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/usb/sr9700.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 2d316c1b851b..6ac232e52bf7 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -358,7 +358,7 @@ static int sr9700_bind(struct usbnet *dev, struct usb_interface *intf)
 	/* power up and reset phy */
 	sr_write_reg(dev, SR_PRR, PRR_PHY_RST);
 	/* at least 10ms, here 20ms for safe */
-	mdelay(20);
+	msleep(20);
 	sr_write_reg(dev, SR_PRR, 0);
 	/* at least 1ms, here 2ms for reading right register */
 	udelay(2 * 1000);
-- 
2.17.0

