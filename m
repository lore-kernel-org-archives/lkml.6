Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70313C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 08:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEB52075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 08:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiMJxHD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEB52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbeI3PG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 11:06:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40459 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeI3PG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 11:06:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8-v6so10506301wrh.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 01:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O03SNQopYVqWnmt6VQndAGbPdcYqY8a+hbNGWhQupxY=;
        b=iiMJxHD+BIyV0t+PD1q71KdAObmRoh+mDgpsCxlRdZibvqnuDbYzVDifWIDO8WDLwO
         beeQnvT32F8gvh0u/3Y4qAfXBaHYBP7JjqdMwXa4L0nucCTyiQVhW5Hf+u7573Nf0PL8
         groAuarFBi05s++tz8+v21NcygGbA0MICP2i5v4rqNBimzIlF/geiP9Bft3dCmPbBvvl
         47vfB6Y3VrJsL0Zsk29F1HZ1+2vqln+CqciIAgYwAU+hpyK3DqDlvkj21wG0V6nIHi0a
         iGvqo+Erd0+TdARNfVaoJFe5R52j/sElk3HEeJ5ZW7mKilXa7QEPqh0hXW5hi1eQp3bO
         FvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O03SNQopYVqWnmt6VQndAGbPdcYqY8a+hbNGWhQupxY=;
        b=dk9EznvG+251Cq7MLt0QSXyw5miKRzhIvFvSXBQ8YCW82A8WTmLPaHmhKGQQfZeakt
         pI+FUjkckKN9l/OVafq2VUA+lvw3azeoF8EJxftlwuWKKyJE5B8FzVCWWLn6Mksu6oJ2
         5tdRIlT+SQLGDHWTXB2phtQ6IWNn8OcEznpPJHVtZUro3u0naDqVE2mZh4Z63tCweWUw
         jxAQ+Q2Wc+06B0b1AVgnxd3C+pNetTZZsmIUVpjyMuopJy0KkPEyF306fseHI4GALb7o
         DU7MMh7j+ih1HBilC1mCzQ5jW6DYxuY/OMMXwjNklSnzqWkm+o5NH5xb6A49OOyYFfkS
         TQzw==
X-Gm-Message-State: ABuFfoh7ufKYR/XZ96V0VXw+AsPSHBQy2KZVah2fl/3HaM5/uVXJnwKl
        srZMwMd09PeyogI3/MjGedM=
X-Google-Smtp-Source: ACcGV60fMMhy6L1hNqFk8lNK7cj9LCEmP6Hfh1a7Zcw7C2fofOPvXktBMXOQdhPukqJlRvC50PU6Dg==
X-Received: by 2002:adf:9a62:: with SMTP id z89-v6mr3489301wrb.53.1538296493802;
        Sun, 30 Sep 2018 01:34:53 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:4])
        by smtp.gmail.com with ESMTPSA id a18sm3828950wrx.55.2018.09.30.01.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 01:34:53 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Aymen Qader <qader.aymen@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ks7010: Remove unnecessary null check
Date:   Sun, 30 Sep 2018 09:34:21 +0100
Message-Id: <20180930083421.5967-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary socket buffer null check in hostif_data_request.
There is already an appropriate null check in the calling function:

(ks_wlan_net.c) ks_wlan_start_xmit

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/ks7010/ks_hostif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 0e554e3359b5..ca030d3f609f 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1023,8 +1023,8 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 	    priv->wpa.mic_failure.stop) {
 		if (netif_queue_stopped(priv->net_dev))
 			netif_wake_queue(priv->net_dev);
-		if (skb)
-			dev_kfree_skb(skb);
+
+		dev_kfree_skb(skb);
 
 		return 0;
 	}
-- 
2.17.1

