Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCFBECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7406620833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkTT/gjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7406620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeGTEgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44219 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeGTEgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so5612057pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dDYm/GYvgblowb8y9wEtGkebDS1Mrgd/QdjFu9nk2O4=;
        b=DkTT/gjgV61jfHZGYnMytREO4PH+7acXFxAMhvbh0rxpAJGH14zJ2pI1dfzB9W866h
         fHGl4OcLJGZBnkWdmOhFsG+vEaCgKavPz40MkU9UgRsj8oZmJ0xnscu0iO7F0fZoR6KO
         k5sC8CPnhpnA7Tq4PUGDYqjIdkeoi14HHcnwxWCFZaW9eKrmvRjJTkfml2YyNn+Le4FZ
         MFaihSNvC8cCDrg1aPbeoeK1jlZ15BNPAD8YwuB50KnBYrOygQtFhUpyJM93TV1c3hgA
         C5XaElQ17plhEvlEIPzBdoUH9Ba1amLix4FFNuBJRryrnT/47ARpgMM1EqLUUajstlFr
         Mx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dDYm/GYvgblowb8y9wEtGkebDS1Mrgd/QdjFu9nk2O4=;
        b=d3+Qf4hBoR88H053YaUK32yUn75pBHQ24TIh+R+WIpN0mPBF3Koen+wDRnPOb807Cj
         lecLMdL/xVnLgXkXlEnhOACJIyabjxQ+OzRVxFggPEnoPXm9+rETQzWyQsOL4fBF9LHQ
         4n+/t+d7cL2qRl0uoD/vgMSSbyGvIXOOKYWUAQRrnOYinILi+xxaNTpg6aXDX9BpNtWI
         /QVfwOfySgl4uKRnJWJMLD83InnCKG/S62X7pXmBBVRSO/m6PeC3PYQRuOTP+JVm5II3
         88jJQhvxbtfdd9pTYe7m2Xos1mY8u3g5ONkG9wQF/a/PwrqXQQH2EOC8qcdXmWAYFeVY
         WSxw==
X-Gm-Message-State: AOUpUlE5Wv2edmDnQl2C0To/VCSWJR1KPzvB+I2Cu9QHG6kyxRq1wEyd
        68gQd6zFV6nHysYj70/HgUk=
X-Google-Smtp-Source: AAOMgpdDRdMJ87WIkyDDSXnNSJ0lerh5BveGIOK4nbnUdjBRSJHzOe+VRgAN+1KupQLCRNl9H5mcRg==
X-Received: by 2002:a62:f0d:: with SMTP id x13-v6mr440517pfi.123.1532058590438;
        Thu, 19 Jul 2018 20:49:50 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:49:50 -0700 (PDT)
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
Subject: [PATCH 01/20] staging: gasket: allow compile for ARM64 in Kconfig
Date:   Thu, 19 Jul 2018 20:49:01 -0700
Message-Id: <20180720034920.77320-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The gasket and apex drivers are also to be used on ARM64 architectures.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/Kconfig b/drivers/staging/gasket/Kconfig
index c836389c1402d..970e299046c37 100644
--- a/drivers/staging/gasket/Kconfig
+++ b/drivers/staging/gasket/Kconfig
@@ -2,7 +2,7 @@ menu "Gasket devices"
 
 config STAGING_GASKET_FRAMEWORK
 	tristate "Gasket framework"
-	depends on PCI && X86_64
+	depends on PCI && (X86_64 || ARM64)
 	help
 	  This framework supports Gasket-compatible devices, such as Apex.
 	  It is required for any of the following module(s).
-- 
2.18.0.233.g985f88cf7e-goog

