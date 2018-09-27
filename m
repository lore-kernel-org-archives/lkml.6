Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584E0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D57A21571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja9ZEvs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D57A21571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeI0VfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:35:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41590 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeI0VfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:35:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id j15-v6so3038135wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sFhsOSSet0cFG+jbwNNmumecwkJ8dJXbZxTzRaPi2/A=;
        b=Ja9ZEvs1/888JvXBBHG7VYXCLOaPdKiTOJnSyT6E6OeluskaddBCs/qD8nbm4vYTY0
         GF9wYomFXR9BkEYjbXvpHfigw/+12ks3xZ3bNm2Y4Jt8KMPrUziGpyfT+Pj5Yy2HewS2
         8LFOimXVXD8OGktTB75dLXQqw1fESVMUyzrLUj2gr6OQWpfVBTaMsXYJ+ctrSnbbb5Fl
         gUu814jmCpXH0GZ8RQBRaqXrTNLM1K3no+5Vo8OqTFVpX3m5WRVZGBjmMQffu3tEWch6
         otdmCYDQLJhPmTHAgNw5uK45UDjQN1aSr/N8epewbJAt2rHiir3OnFv01eDmXued+Bgc
         Ahlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sFhsOSSet0cFG+jbwNNmumecwkJ8dJXbZxTzRaPi2/A=;
        b=jOn7FzvEE3MZ0SM38bIyaDAlOJMpadLk5pQjiXSOJQhXRHmUApTDv6RiiPyVW6vRwN
         mpDKqoGqzpdqkK2iZJ/BTquF3I5Ar7Bou+QXUNfW3t0b+EY2zjhY+N0gzD4NgrOqJwzB
         tvNtZUswNDiNL9EEYZQxuJliDqCDcngoqCjU6AwB0uBmZPg+9OJBtsm9iJNKavbL1siu
         v5LiOThIaVE38ydPcLks5sgP1S6uC3MMgRAozOObVTxr9V0Qa+iIFKf1wxXg/qkD3Wsx
         8yDmjaI0vi7vfu+V4XAzuhLPtxk1cKEPSm2Xq7hczCvxnbYW2S8dL64RMDkGwJ+FSZAy
         ELwg==
X-Gm-Message-State: ABuFfojZFeU1D6Qkro6xR0bil1avlpGpv27rgC3Sfml9WxgK8xQrke0U
        wSCuJU12NEfOmJlaQOI+HZE=
X-Google-Smtp-Source: ACcGV62agyRGn2nizm3mlVI9Gzh4Z7Bg0lPUhJf5waXlhdG+sOYc83VqniJHGsZSMfncH5NchCyrHw==
X-Received: by 2002:a05:6000:124e:: with SMTP id j14mr959893wrx.315.1538061376741;
        Thu, 27 Sep 2018 08:16:16 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:5])
        by smtp.gmail.com with ESMTPSA id x5-v6sm2536592wmi.37.2018.09.27.08.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 08:16:15 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Aymen Qader <qader.aymen@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: ks7010: Add null pointer check for skb
Date:   Thu, 27 Sep 2018 16:16:13 +0100
Message-Id: <20180927151614.25470-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
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
v3: Style fix

 drivers/staging/ks7010/ks_hostif.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 0e554e3359b5..95b6c7557e84 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1011,6 +1011,11 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 	size_t size;
 	int ret;
 
+	if (!skb) {
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

