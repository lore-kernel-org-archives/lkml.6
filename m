Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29A1C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740E7216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRLULhc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740E7216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeI0VYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:24:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35761 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeI0VYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:24:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id o18-v6so6353138wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VVGZLwXeE0i1LIHH1gUNgYMOYwc94MYsfYS79VjlR3E=;
        b=eRLULhc2+lkMmlXO4nU3VENn5xoEGZVFL6PgpPEMxJ2Id/vgcpNSRtuFqg2bQbM4Hz
         6Enq3OlgmLTCDLo5Lutdk0xWVFLqaVDHt8ScRTiJ9W6FTLNO55GW9h89UjpP4maI7l8U
         CYOJNMkA7QmPYRgw1yFA+QvkpV1Ns94vnXzqVA+joOSTVQW6Dz1tRKmDHAZHAsuvdV/3
         2rqy1YqO3yOc/nleB/o2TrCL3fIeCU/wh3UDYdki12hVoJFp8MSO/mXbmDU5FdLN8VFX
         dypvu+vUD/DK4mSIDKf9uBMhJKxExSRXz8GpPZta3ENAVwLbJdWwsPzxQN2IHpOwsMMi
         VHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VVGZLwXeE0i1LIHH1gUNgYMOYwc94MYsfYS79VjlR3E=;
        b=TS45GG9gLcyqKunJcM9zzgslSo6C3NI+kP8nk9klU47JXD+Ru/IANdq300Td4fsmfg
         aeDIbdluOu5DMnlizB+Tl9Q6VQxja9rOnwBC/yVZotAS6WNeh+KDY9AyNu16CpMTTAqo
         fJqQd3QRxrV4vv3D7zW3LHz+MQxkdY+sJWZu8LwAf1OaSMpIIHk+cIR5WYK03eKTTZak
         LmSLdRCV3g2Ajpc3qz3iV/ZbfNjSsNnsHRHn0N0xgQa1dra6GwPFMAfDZk6+QjbQcNyo
         +5pgGDHjdzNM4FzHkMBIwfw1gmfjYysV28kG2CE5A6Qi4g3VjXAu++7WPxcGV1HoIdDV
         3VUg==
X-Gm-Message-State: ABuFfogX2CEliAD514qLLxQGKX5ZRQ7XKj0S+CyUM0t4cYafUzc/E+zZ
        AzFm1IEuJU3KZj/o2f1oBu2ky+I3Bsk=
X-Google-Smtp-Source: ACcGV60+arJaVEI9TZ7KXKGN67yxrB4EiLx7zM+mzcy6r+7uNS7fAdQcrvPzeq5JO8W1mXuzP0UM+Q==
X-Received: by 2002:a1c:603:: with SMTP id 3-v6mr1127514wmg.64.1538060756215;
        Thu, 27 Sep 2018 08:05:56 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:5])
        by smtp.gmail.com with ESMTPSA id x65-v6sm2581658wmg.39.2018.09.27.08.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 08:05:55 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Aymen Qader <qader.aymen@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ks7010: Add null pointer check for skb
Date:   Thu, 27 Sep 2018 16:05:44 +0100
Message-Id: <20180927150544.14632-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a null pointer check for the socket buffer in ks_hostif.c to avoid a
possible null pointer deference.

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/ks7010/ks_hostif.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 0e554e3359b5..4a5bc7858ef7 100644
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
-- 
2.17.1

