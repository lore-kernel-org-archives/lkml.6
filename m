Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D09C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4F920C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm46iD4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4F920C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390210AbeGKT2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:28:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45398 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbeGKT2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:28:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id i20-v6so6990514eds.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ICDys1njf55Fl2nuyNCKTPYnGeI1JOdSsdycZyFud4g=;
        b=Lm46iD4qMD3BQPCMrc/64YcI+SCZvyj9k6h+YTVzr+R6RAaaaNv9U3oenGIP4s0496
         UsxtH1BOVI1UjiU0reKZ+Eo5P17v31JAV6iEFE4wfA9JjyeN3Qi4OF3JN0licU34GaGt
         SCdxMk9jFiTVSEwSLAZGJ4PQswwaGbHKAp92xYL1T9lGuWSvwyaF70UxF00x/XsjDv3w
         erFaCAgQCer42May8RgiwYGqbxq4QCxffBwQxOWRxyvh5s/GOzI/O+cQg5w7xhUYtfNt
         P1DzO7D1pOWL5fNy9Tz680SsxInWQ12ObYpo8MpEGWRoxx2vv9COiVuaV6xTAzxU+dOK
         9ZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ICDys1njf55Fl2nuyNCKTPYnGeI1JOdSsdycZyFud4g=;
        b=DUCntw/Tm1yK9+PvsZXUa/Y2M3S0SMH6OeHts3/HWAF6YVOqX6RX5mBPOlWafG8teP
         vIil04NruQWQw8df8hdHMrrFV+iFGuLHsCRiPVq/xSFXaokFhPcswkKm9ihfjqAccfDi
         glVhxH0B2abtrej2CoWyLr4LhHeuHJ2ys2WyJsoO09adT2mhNq5XAQoEa50Rm2dfusq3
         XIR++tqolGhS83+xA5nFlqbXlQS4Lxj0HP50RR4tAG+1u5WdPbH6lYEdvPyUw9YpRxZ4
         mZlYQF5YWCPCODzjEetdvGBclcvuu1oi3hT5v00yQl4waCkzXZM2IZcBXHE7GzNxbHWr
         fccQ==
X-Gm-Message-State: APt69E04T1w8A7HzugkPf0JIckP/ezBC811ZPPw9xjpu7DEQQbgA3NhV
        02FtHeH2dd4TWQraek0L7t18hcO/
X-Google-Smtp-Source: AAOMgpcpa39mlpHpYw8Bsv93OuH4ij8doNDI/MJ/Ib2fTiHeyN/mKayN3u7RStZXPEGf5HjqTxLxKw==
X-Received: by 2002:a50:a2e5:: with SMTP id 92-v6mr31295500edm.106.1531336948546;
        Wed, 11 Jul 2018 12:22:28 -0700 (PDT)
Received: from localhost.localdomain ([109.77.228.66])
        by smtp.gmail.com with ESMTPSA id e9-v6sm7107787edc.37.2018.07.11.12.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:22:27 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/10] staging:rtl8192u: Rename file macro to avoid camel case - Coding Style
Date:   Wed, 11 Jul 2018 20:21:43 +0100
Message-Id: <20180711192149.21621-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711192149.21621-1-johnfwhitmore@gmail.com>
References: <20180711192149.21621-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple rename of the preprosessor switch, protecting against multiple
inclusion of the header file. Change to clear the checkpatch coding style
issue.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index a653a51f7b90..86cf3ef3a970 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -15,8 +15,8 @@
  * project Authors.
  */
 
-#ifndef R819xU_H
-#define R819xU_H
+#ifndef R819U_H
+#define R819U_H
 
 #include <linux/compiler.h>
 #include <linux/module.h>
-- 
2.18.0

