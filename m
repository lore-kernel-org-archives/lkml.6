Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A835ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 18:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AC020936
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 18:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z11FApUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AC020936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeGOStj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 14:49:39 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37738 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeGOStj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 14:49:39 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so14279357plc.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZZJ+kwiY5LJJKrf//5OZeYU9+yJgPwO027h2JSZ16uQ=;
        b=Z11FApUJdFmU2XG80olwHEWFOhH07ym9bN4SKw0F4JVM7ECsRw/Z36Jyl0Yyx9qWr5
         m8uA7ap2ctXeAp+/PoIMmasLPVH3wTJe+UHSUtxuYvIqVCTxdoTXV28QjT9L4BWfOJyC
         THvkCQu0bIu0VgCpFlBFDCIzWqEuHBtf6AenqTuY9jADFbNGrnu3CJSGiZ+NCa0SFbPG
         VmV1uEH54mBWHkBiblfC0PQBIup/7LrZND2Dr23AvntxZrDyzDuFawcpOn5AuGGijJ1k
         rE5I17pmLlmtxSm3TaLze00aOWlpAyiYyNbB5ITEZt35LsqOHbMpCe7qNSfMKKWO0Cbm
         dNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZZJ+kwiY5LJJKrf//5OZeYU9+yJgPwO027h2JSZ16uQ=;
        b=klTiQje2Sk1NfarEQ/P9LLiiCNYR3LsAjDRJbH3jPrBLIXOvvt0DHHuPqBiBDlIqE6
         cx/pYDtAXwNhEwYqmRtq4zvJEWlaLORefJCBXUuauUJfTupWs8eMTvG3j7hAfdd+v+9D
         XN/HRvBxRv7c9QcW4GgtyC5a8FFjKmBLS+aoDyTu4npN4bixXUpGMk/3+SNp8fgnWrqH
         XEe81ddSrB9v29ndq9wfTEcm9dv1vQmfU2wfsfTwu2mu3ZY+X449Zr90IaKrBtoDIFuy
         YO+DSQObMkNhiVjECJGW+q4CyE4iaQUsCpplPJ6NgNbpWvtOj1yaL+6vbEBsfBNDZEeG
         1NFw==
X-Gm-Message-State: AOUpUlFqKoUkSYmx7cc1Tg824GJsAgeyHpIfFblCx5uivU2eGIVnAQSA
        W5FPiz5ET5Vu9x1I+3QgmiCMBu3W
X-Google-Smtp-Source: AAOMgpc393I6g94txG5MEqGrkG4UKcim21XNaICCkBWA36JyD3C0KYKUZJKJzrJVqWPIzgHGvAhvDA==
X-Received: by 2002:a17:902:76c4:: with SMTP id j4-v6mr13817132plt.19.1531679153853;
        Sun, 15 Jul 2018 11:25:53 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id e21-v6sm49760165pfl.187.2018.07.15.11.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 11:25:53 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>,
        Todd Poynor <toddpoynor@gmail.com>
Subject: [PATCH resend] staging: gasket: remove X86 Kconfig restriction
Date:   Sun, 15 Jul 2018 11:25:45 -0700
Message-Id: <20180715182545.187942-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The gasket and apex drivers are to be used on other architectures
besides X86.

Signed-off-by: Todd Poynor <toddpoynor@gmail.com>
---
 drivers/staging/gasket/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/Kconfig b/drivers/staging/gasket/Kconfig
index c836389c1402..ef40c4c75e0f 100644
--- a/drivers/staging/gasket/Kconfig
+++ b/drivers/staging/gasket/Kconfig
@@ -2,7 +2,7 @@ menu "Gasket devices"
 
 config STAGING_GASKET_FRAMEWORK
 	tristate "Gasket framework"
-	depends on PCI && X86_64
+	depends on PCI
 	help
 	  This framework supports Gasket-compatible devices, such as Apex.
 	  It is required for any of the following module(s).
-- 
2.18.0.203.gfac676dfb9-goog

Resending, extracted from the previous stack of patches that needs
other cleanups.
