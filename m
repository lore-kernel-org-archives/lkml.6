Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA05CC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7318D21719
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpcYt414"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7318D21719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbeHCDn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 23:43:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42098 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbeHCDn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 23:43:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so2332737pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 18:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=POquWmug1aYuCeGv3DzX8EW7af7RAFFd0o0Hz8A+QyA=;
        b=qpcYt414E0k97SaUPpBZ7sqQ+MaW/FDfLbcH0pPq8qy2nuOsJ5hNtiElv4kfHajoQF
         jm9DeAN46lZ2XeA+f9zC17J4Nd92ekvvzkbt4speeCqewwyd5whshpS2zXfDCCKLhdUL
         3VEk+QkZFqL6lWdPrzwy0yy5b9Xa9d/NRaRJsGRu46q82R1pOxFgvcjDZXmwX0O/OCrA
         6P7Odr7U8kO/Pl2uZBF8tkpWpcX1xGfANjtKyJVGwGNC7cZFVKMp3U0d0i2Vdz3XhtQK
         fj4NiSBwO9tmDAm45I/Ldu3jQ0PDpfDEOVqsoDKbl/YNpDvaEZHQvIyY5bP/y2ijjNVK
         W01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POquWmug1aYuCeGv3DzX8EW7af7RAFFd0o0Hz8A+QyA=;
        b=SXJyA9DYeHFYplmOTzOLM2ejJGd4sMd50if7goSe63zlD4dcnLBaZlG0rwz1+0PzBb
         ADbqypWmVc617vpv4F9GWMjHkDxNi7Y34eVa/zy/RLk2dg9iR/KzqKFlQjj34OEizH86
         03PtNQTpMwdrupHKuPGQywgWKKiw36aLNsrZs2iNF7uylgduA8l8AVNAvCTbAB+ayEmt
         mqFgbw+wJ4oza7v1MM2C200dqiwL7WpDNcCZY0PfW+4vlrFIEc0StDPc2QOifZP4C11J
         Lr0N2FBl5AYWoBiqngZpVpTCqN8eeS4XmfuYfVERGniZmu/TfpnaOqmhijzKpeHfPcOY
         eSng==
X-Gm-Message-State: AOUpUlFigwJz3yZ+Sl94Vvvqah5/K43KhAGrKjP3v5tgkxBPx8c3tevy
        rX2v+uTj5wZkqDtgSipgfzs=
X-Google-Smtp-Source: AAOMgpfAwr4RnKaf3uzQiFQTVF5Szg1yLCbrDq2WsBc4NYm9N6Y7BJSkFaR1ekFUSyx81DSKEd2ksg==
X-Received: by 2002:a63:121a:: with SMTP id h26-v6mr1749063pgl.316.1533261004266;
        Thu, 02 Aug 2018 18:50:04 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m81-v6sm7348315pfa.188.2018.08.02.18.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 18:50:03 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 1/4] staging: gasket: core: remove registration logs
Date:   Thu,  2 Aug 2018 18:49:49 -0700
Message-Id: <20180803014952.104582-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180803014952.104582-1-toddpoynor@gmail.com>
References: <20180803014952.104582-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove logs for loading gasket drivers.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 2b75f100da4d3..fa477d0c3c74c 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1758,9 +1758,6 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	}
 	mutex_unlock(&g_mutex);
 
-	pr_info("Loaded %s driver, framework version %s\n",
-		driver_desc->name, GASKET_FRAMEWORK_VERSION);
-
 	if (desc_idx == -1) {
 		pr_err("Too many Gasket drivers loaded: %d\n",
 		       GASKET_FRAMEWORK_DESC_MAX);
@@ -1808,7 +1805,6 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 		goto fail2;
 	}
 
-	pr_info("Driver registered successfully.\n");
 	return 0;
 
 fail2:
-- 
2.18.0.597.ga71716f1ad-goog

