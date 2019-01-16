Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EB3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADB7205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="aNhVun+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393319AbfAPOZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:25:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37546 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391350AbfAPOZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:25:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so3144975pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 06:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b+2IAnExCO9vokV2p16FJgeCx9M1JeLkxUVCmUw2Veg=;
        b=aNhVun+GvGu/C4cchsQwKDtrElSmzsfw5WZ+yZQN5x4sKMzLo0WwzDeQcSYkpJwipM
         TvNXdA5J4nLYzn42XCXlCQPz4qE+tYJ0PuCETstvg3whY1wkVlaH10IESnNzz99Evn/d
         M+fuIub6/JWfUwojYH+vLBIypXJtnuKOsHK7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b+2IAnExCO9vokV2p16FJgeCx9M1JeLkxUVCmUw2Veg=;
        b=rGfYLruOq8psNTD1+kVkbbRIPxjAPRqHXjiheQErnmfoIiR0SvKaYz8kojAiaWXJVr
         iVPNJuCbjSEuWqWhXdqNmlR7Q4JuWh9BZ5O4e/9qLSv+YszPuDhbtNpHYsOs4eFvor/p
         tg+ZnptV+j7rnE2MVLPz/U1PMvlKvfVEPiQUTy958FJSUoySnRz9UmSG9La1AncNGm4a
         zkVBYCajb6wZKB7JPKH5ws0Rs2yR2Y5Ev0Lk6bX4PL4V7QisuSifjcb0MzorGLG/5fJe
         2oDaMH8d+fEKftpCSHqkTGr2cY2FAl1aZ8zzyzHVHfa+iZHf65MrCG3XXzCDXRH4iqgL
         zjOA==
X-Gm-Message-State: AJcUukeSXObRC8Wxvp6mmyjaEDCnUpkIvzDGbqzTq3fc03JgACKT0yMU
        U8T9qO4n1Os5LHAiMRjll13/iw==
X-Google-Smtp-Source: ALg8bN5i780L0PkW8ABkomT860ra9KrnM3Wsk5woRqpcv+l1z092ltGQZb+HhhPTFyHp2FlIaf9i6A==
X-Received: by 2002:a63:c748:: with SMTP id v8mr9277797pgg.108.1547648733633;
        Wed, 16 Jan 2019 06:25:33 -0800 (PST)
Received: from starnight.local ([150.116.255.181])
        by smtp.gmail.com with ESMTPSA id a17sm9211783pgm.26.2019.01.16.06.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 06:25:33 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     Ben Whitten <ben.whitten@lairdtech.com>,
        linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [RFC PATCH 2/5] net: lorawan: Remove unused lrw_dev_hard_header function
Date:   Wed, 16 Jan 2019 22:24:56 +0800
Message-Id: <20190116142458.19542-2-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
References: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lorawan module is an abastraction layer over the LoRaWAN soft and
hard MAC.  It passes the original buffer to the real MAC layer.  So,
this patch removes the lrw_dev_hard_header function.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
 net/lorawan/socket.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/lorawan/socket.c b/net/lorawan/socket.c
index 0ec2d2bf1682..9c0722379e25 100644
--- a/net/lorawan/socket.c
+++ b/net/lorawan/socket.c
@@ -115,14 +115,6 @@ dgram_bind(struct sock *sk, struct sockaddr *uaddr, int len)
 	return ret;
 }
 
-static int
-lrw_dev_hard_header(struct sk_buff *skb, struct net_device *ndev,
-		    const u32 src_devaddr, size_t len)
-{
-	/* TODO: Prepare the LoRaWAN sending header here */
-	return 0;
-}
-
 static int
 dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 {
@@ -176,10 +168,6 @@ dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	skb_reserve(skb, hlen);
 	skb_reset_network_header(skb);
 
-	ret = lrw_dev_hard_header(skb, ndev, 0, size);
-	if (ret < 0)
-		goto dgram_sendmsg_no_skb;
-
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (ret > 0)
 		goto dgram_sendmsg_err_skb;
-- 
2.20.1

