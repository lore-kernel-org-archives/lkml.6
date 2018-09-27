Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358BFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E310F216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCbXQuxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E310F216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeI0V2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:28:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32790 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeI0V2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:28:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id r1-v6so17695031wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xu2xhdnDezjhMJD/wLCR6gy6Nz5fU1zGMz5qYikZBZA=;
        b=qCbXQuxyweSlMOS3fG1cDYYRZozX4xXZXiw1ZwGVrESPoIqyE7zGMyRAsa6avMQlk0
         C2DwZe+0Crt7PHD9b3Q4hAYMWgCR/YaBYCJrMtbirmusLRtwVcmN0O7ad8B/IqazyJIL
         o2K8mKZhwimZF1X7EsH7hHGKDOW1A/K+pnL/HztpNgSRadAFkt1a9Ka6yOzAr+re++8g
         6i5ZhEe7N5HZIYvCfAM0DfClFm5KkmUNiz0rfNddwh7BquOSPqPgyj0fHxeFir4KIQOS
         NwbQY+DVozeku4CNvvqo3anrcWNpQ+5XYPi4Xzrz272F9r2RUcNjklJxZ5pjzguojK5I
         EU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xu2xhdnDezjhMJD/wLCR6gy6Nz5fU1zGMz5qYikZBZA=;
        b=UwmySBcrNMg2IhKQLsjmBPYCCVdB0lGX+Hvp9Fli8kN64Xu5mocfoiWqjfj464htM2
         M1EOFcPCUnvb96VdPXxeuHO9nde7lyVOyb6mI2jZM6e9txz6Ertmkg1xe3/ljHL7FbNe
         kqWwGPsdRRafSKWCVSwZo4rhIRbhDig8qPiPPiKrnR9uyq129Wh1BwZ5uZPOs2MDUpA1
         eeYPRQg1LjniOshFBC9Fi4jdCw26JhcATGe1DLXkn6qe6Ob+iH+fkDm8eMRVa6cpCgYi
         g1u1MZsgSsl74+z/w8uVnNmdHqrgsiBks8GFVM/J7n6qNj4d+LLKsvVDt9IHQ42Prkfp
         emTQ==
X-Gm-Message-State: ABuFfoghLtfJiPC0coFmXdxcYOqxzeDbHs21/Jz3lobKiAfGh4RGzoNe
        hWqKGLadQf+A+dERLhH9YHk=
X-Google-Smtp-Source: ACcGV63ypQGfbCRvLX1dQTgpJAdBWnhnluxNT02ZehHRds/1dILPQeOlF4oBFu2K92Yl/D+DpkXqnA==
X-Received: by 2002:a1c:1ec5:: with SMTP id e188-v6mr8382325wme.1.1538060977113;
        Thu, 27 Sep 2018 08:09:37 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:5])
        by smtp.gmail.com with ESMTPSA id b193-v6sm2381895wmb.31.2018.09.27.08.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 08:09:36 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Aymen Qader <qader.aymen@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: ks7010: Add null pointer check for skb
Date:   Thu, 27 Sep 2018 16:09:34 +0100
Message-Id: <20180927150934.17207-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927150544.14632-1-qader.aymen@gmail.com>
References: <20180927150544.14632-1-qader.aymen@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a null pointer check for the socket buffer in ks_hostif.c to avoid a
possible null pointer deference, and remove a later now-redundant null
pointer check.

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
v2: Remove redundant pointer check

 drivers/staging/ks7010/ks_hostif.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 0e554e3359b5..fdfee760a54f 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1011,6 +1011,11 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 	size_t size;
 	int ret;
 
+	if(!skb) {
+		ret = -ENOMEM;
+		goto err_kfree;
+	}
+
 	skb_len = skb->len;
 	if (skb_len > ETH_FRAME_LEN) {
 		netdev_err(priv->net_dev, "bad length skb_len=%d\n", skb_len);
@@ -1023,7 +1028,6 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 	    priv->wpa.mic_failure.stop) {
 		if (netif_queue_stopped(priv->net_dev))
 			netif_wake_queue(priv->net_dev);
-		if (skb)
 			dev_kfree_skb(skb);
 
 		return 0;
-- 
2.17.1

