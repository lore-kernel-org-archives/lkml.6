Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907C2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4196F20836
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hREC/G1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4196F20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbeGQVkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:40:00 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33433 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731756AbeGQVj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:59 -0400
Received: by mail-pf0-f195.google.com with SMTP id b17-v6so1102224pfi.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AdYEwXDGkNEwJ0tqYsKpIFDGS3s4cMRgcqWzdwqu4Yc=;
        b=hREC/G1Pms+36fWjCYb/DZRwdXGxCsJyRboPMgM7un+lNDElV2VK8haWQuD86mAIfE
         pKBlSM6iCsrfekmB/vRP0B3MSlWLGQj2BLXOTwYxwHJVmKxMZUx3SKpxgV8Uda3JHhpT
         4AVUijpVVK8ZX65J936dX02+ch8ouaDzIhY68UrTfmPSUy2v56FDJSBUV+iK5yAAUMOa
         MKTghCF6Bz5HNRfNAHdC2DpFv2LDfP/Rx+K0dQLHeWczDUEsju+3usHfa3ee+zxUWzI2
         yKZ0kuP7Jt1ovXSRhmVBzQ9HeyH1NcKzYPFai9VU/R7sw8D4UdReebhoMbMW+gq17JvT
         zqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AdYEwXDGkNEwJ0tqYsKpIFDGS3s4cMRgcqWzdwqu4Yc=;
        b=lp52IvsMoz+h49Ape0cp4cCDVBpFAZJ0tTIwojx5DeaGxm1xnNlMSYjaA2CLs5o4wW
         o5yW3JUVwXfGKRmY4pE5yHTRldE3nFUlYAeUXTP88yMZ1+JlSCaP1zUiUrEi5i/iMnng
         0FES7VF0djaiJsuwuuiBcF3QKW52qwaL1kmMKop8f2S5mgchMti59fpihF05PLRLgTHo
         8QrhnleZEkilFtxtZTpYmZmigkJn6jQLEpxUFqz1vnBQApt8oqsAf/sMBSkBWQIpZiyN
         y+aiV5YarjO7E5XVGC5rwtL/ZaKNQRrIsFKnJYmwjKP5eTaRmvS11p7oS3M3W01exu4/
         xr0w==
X-Gm-Message-State: AOUpUlGaAPToJ9g/FQ0XPtxBxrEiy7rL0AWcQAu4LWsjNv2/HgZ1DhW7
        ghLZbs64e8hgdpJXEVvg6Mm05pIs
X-Google-Smtp-Source: AAOMgpdRxDd1O2f8l9ADp9YNyXZdqMZvRk1bdHUVXQtgOcqqeEcUxX0cX4hd52+kzp+wi0u1vtE4pQ==
X-Received: by 2002:a62:9541:: with SMTP id p62-v6mr2292540pfd.152.1531861531765;
        Tue, 17 Jul 2018 14:05:31 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:30 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 32/32] staging: gasket: fix multi-line comment syntax in gasket_core.h
Date:   Tue, 17 Jul 2018 13:57:12 -0700
Message-Id: <20180717205712.29495-33-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Use consistent kernel-style multi-line comment syntax.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 68b4d2ac9fd6c..c23764e8b8d91 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -54,7 +54,8 @@ enum gasket_interrupt_type {
 	PLATFORM_WIRE = 2,
 };
 
-/* Used to describe a Gasket interrupt. Contains an interrupt index, a register,
+/*
+ * Used to describe a Gasket interrupt. Contains an interrupt index, a register,
  * and packing data for that interrupt. The register and packing data
  * fields are relevant only for PCI_MSIX interrupt type and can be
  * set to 0 for everything else.
-- 
2.18.0.203.gfac676dfb9-goog

