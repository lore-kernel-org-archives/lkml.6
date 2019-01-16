Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8C7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB8E205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="ZHTioefZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393491AbfAPO0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:26:21 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44865 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391293AbfAPO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:26:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so3132305pfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 06:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A6tN3e+L8ccUqYJSG3UfdrqjaLGmj6h8YqE2TggOmsQ=;
        b=ZHTioefZ6UZDDkz5bSrjcB9KvWdTeYQRftOtPbMM4OcvRVGQkeXdi8NEh6GTUoVlBO
         mQ017XGOlotuG2/M4y8GsAFHXSl/jNwl8ybhZNOjnI621HFDR590HYKMAI8t6bch6/JM
         NZ2vAUR9rkWMLihLynewQ4YiCPQ2zrWxMdr0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A6tN3e+L8ccUqYJSG3UfdrqjaLGmj6h8YqE2TggOmsQ=;
        b=WcuiOe1H3//A30P+KkMXd4cW0VZmsuOZU8/GTbKrsqONTE+2QfDHSgMHUKSqsthU8m
         fCraWiAIH7oyoTzHcND5ohNI+tL42BLmdNIC0eW0Jv7LK6ELvIW+dAmD00W2CVMKT5+0
         AcuKnkFTz6XeVAA1kaKEm5M54rUQXY752heVIBbVcsSnSbfvI0r4LOlTttM6ErDrtMTS
         6Jfb2WhuhnJloFfthlctW8d3cv+EsyPa05qkOGoB7us9hhr5p7iERNb0qpiGiq6pOs5X
         /ukK1sACfpt0EFns1KNldF5lqeaugTasxTioRCdanT82F1+/sPQOWKazTY6PFDutSkBd
         grIQ==
X-Gm-Message-State: AJcUukfNdGMLbYepJR5TsGccYJm9su5snw/GKwSW+NW0JGL9AIJME2Wb
        +vvHd0l+DVyMEiNh6I0wYh+9aQ==
X-Google-Smtp-Source: ALg8bN6uYXSbuuXFsbeZmtMzOFU7+JXhKxbYqyL2VVoOw3dzPDprcGGPdlEznkbJYHbQmR6UZBVraA==
X-Received: by 2002:a63:fb4c:: with SMTP id w12mr9132328pgj.321.1547648779942;
        Wed, 16 Jan 2019 06:26:19 -0800 (PST)
Received: from starnight.local ([150.116.255.181])
        by smtp.gmail.com with ESMTPSA id a17sm9211783pgm.26.2019.01.16.06.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 06:26:19 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     Ben Whitten <ben.whitten@lairdtech.com>,
        linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [RFC PATCH 4/5] net: lorawan: Fulfill the help text of Kconfig
Date:   Wed, 16 Jan 2019 22:25:00 +0800
Message-Id: <20190116142458.19542-4-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
References: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mention the LoRaWAN network feature to distinguish it from other
Low-Power Wide-Area Network like Sigfox and NB-IoT.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
 net/lorawan/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/lorawan/Kconfig b/net/lorawan/Kconfig
index bf6c9b77573b..ce3ed6e6d11c 100644
--- a/net/lorawan/Kconfig
+++ b/net/lorawan/Kconfig
@@ -4,7 +4,8 @@ config LORAWAN
 	  LoRaWAN defines low data rate, low power and long range wireless
 	  wide area networks. It was designed to organize networks of automation
 	  devices, such as sensors, switches and actuators. It can operate
-	  multiple kilometers wide.
+	  multiple kilometers wide.  The network is client/server technology
+	  centered around gateways.
 
 	  Say Y here to compile LoRaWAN support into the kernel or say M to
 	  compile it as a module.
-- 
2.20.1

