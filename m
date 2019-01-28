Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292EEC282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2B32148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YveQTyQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbfA1QN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:13:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56076 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387518AbfA1QNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so14488751wmc.5;
        Mon, 28 Jan 2019 08:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YBHXHHgSpmktvhhZLNppFJSU9VEAE5bW3T4VPQodZvQ=;
        b=YveQTyQRrB6K1EdAFcTo7hcmsTKE+mNtyQySaqqf0tJ9GkYtFOOTANvAIjTIqevZHK
         Aw1SgHL/2xB/67/8VzlaxFq4DSbeFr2BbDENuqXCsXttwbP7HxvSZKj97FL5gcWPi7jX
         NGj48ZNdNK9NoCx1Hx6MSiF0VKdWk1YZvZp+oDQxn6Op4/lkwDAtyyyvQgkU3ggfhLBS
         Py1hzhyC/+dcXHB6TvdPcu0QTvu2JX3c3+7+DpivoNyuIs91ToOu4YoerBXiKuxx3Jdn
         MBsw/gY8SaIikUSssyt0d5ciTrZ9iXQ+qAQxaaHaXu1TEMyXnfkjJPepA4ggenoY7nA0
         TBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=YBHXHHgSpmktvhhZLNppFJSU9VEAE5bW3T4VPQodZvQ=;
        b=H4+V5Oy9Sh5wYjMKhCBHVzVhGmMDm0V6POVnPdmi8UzdUZkT+Po3qr/HdzHAotMsxr
         OnjJy74fXc/dbtiRJrVvK8s4EphN0OUMNjNGdjxKJrskn3xhF6H+HV2iYJzxXuVfLuY3
         cEj8CGcIpk5fpE0PJIQnReDd/xyCQ3cRdufl7vlRD38BxSBGNTSlWhyqMK9Gt0wJV6tH
         bYSZo3qAFWoM15nQDwSNA2YUi8F8z5i7zemdKSGsnThgBo4c6ic87zsUj5e/+c+UShK7
         r9M5BNJz6MG5x9JaSyEBIu0jsGGxn0qYDL7RGLQl0oF4MCGhUZec3HPRTDxjGJx1AthQ
         loFA==
X-Gm-Message-State: AJcUuke/ldM5bNJDmItWbtJ5nWBIRDXCxLkBUkd+CaDKGPM23u4E1woo
        kx088YQLsWEE37a9tPQsImdt+4y17M5BnA==
X-Google-Smtp-Source: ALg8bN4B+p+JRWrLKToi2goBVgWc2IS6Ox7QMF9Exp5CTbDTbpaLFCxPSlz9n7rCDQe3yANiaodgpg==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr16497235wmt.99.1548692032494;
        Mon, 28 Jan 2019 08:13:52 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id l20sm246445944wrb.93.2019.01.28.08.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:13:51 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH lora-next 06/11] net: lora: sx130x: add detail to TODO in setup
Date:   Mon, 28 Jan 2019 16:13:00 +0000
Message-Id: <20190128161306.27805-7-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128161306.27805-1-ben.whitten@lairdtech.com>
References: <20190128161306.27805-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

Setup requires a more steps to be complete, call these out specifically
so they are not missed.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 drivers/net/lora/sx130x.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 18acfc8e934d..88932fbbb598 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -688,7 +688,17 @@ static int sx130x_loradev_open(struct net_device *netdev)
 	if (ret)
 		goto err_calibrate;
 
-	/* TODO */
+	/* TODO Load constant adjustments, patches */
+
+	/* TODO Frequency time drift */
+
+	/* TODO Configure lora multi demods, bitfield of active */
+
+	/* TODO Load concentrator multi channel frequencies */
+
+	/* TODO enable the correlator on enabled frequencies */
+
+	/* TODO PPM, and modem enable */
 
 	ret = sx130x_load_all_firmware(priv);
 	if (ret)
-- 
2.17.1

