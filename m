Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6E6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963CB206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLsIFARE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963CB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbeGQVjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:22 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34518 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQVjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:20 -0400
Received: by mail-pl0-f66.google.com with SMTP id f6-v6so996347plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TftPCUPwfmc5ZcdU96Tn9M0gpvgY383LiLn7FPvDdEE=;
        b=jLsIFAREOyjzounBGKXUEE2Teqx4mKd51V7ZLe8PdXkuGCLRfJadbLCIrD8nNyVmcW
         0bfYJdI6geUnkc8NtZy6WtCizGQc4BCc9vTJzLiOJiw8Px8358q/46Y/q1t4AnleVaVc
         0cAr8Ny7UQF5uwWnU+8U2PCPG++aif0hLpT3DR2Y8Z0kriFsHjIgAYMLvcGODkjDSUiP
         u8RE3iAqbwoRROOzV56X5XuSvD0ZYoCgIGistx0n1U3SKLMMHykQxttj7Vq1+aoxiRz9
         z9Dj9bGkbTGnDxh4mK4pp4uVDT+R8Dd2qarSSk0J+2uWrqmgg+gf9DiClV+mB5/smdOk
         DIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TftPCUPwfmc5ZcdU96Tn9M0gpvgY383LiLn7FPvDdEE=;
        b=cgiduwsP9gwRJ8ZhnyF9sDxYkpeMq/ZWeQhKDMeVzhDVtodMGEB1EvfOzHBB+twRPc
         4mxdEFN9ope5CYrtMoxgRJbZ/r6rjsGqbI7947ZEuOOAIJv9bzwILJRfhsN9zYLW99Lr
         AJWeHe3nQ0Ox1F0PTczhHdDBbxwEAz2y17hnXw168hYXjnN+7sb6gPSIg/velZTDo0Wa
         gm+W1VK9DoQBcflLOkYSw059O1gPiFhLjeW2rh9lUy5ypeAKbjWthNxFasqmZZJeENUt
         JKstzmURkvzqoldqStepv6TK1VRl+Adg2orGEpjfSqvqVR43aWJFQc7hjoabYz/qcgH1
         cmiQ==
X-Gm-Message-State: AOUpUlGVFo7hg/W+t9EeaWrs8EpIywRDRhuQpNZjhFgrHuJUFd99UoOv
        anYBJOxKRV7zxNv3BGVuzDA=
X-Google-Smtp-Source: AAOMgpfiA2C60gf9Dv0dI42V37WZ9xloCDzt69klOZ8BsUHhsqKfu0Spoqyb/z8jKstWVHreeEOwnA==
X-Received: by 2002:a17:902:9690:: with SMTP id n16-v6mr3110347plp.94.1531861492379;
        Tue, 17 Jul 2018 14:04:52 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:04:51 -0700 (PDT)
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
Subject: [PATCH 06/32] staging: gasket: hold mutex on gasket driver unregistration
Date:   Tue, 17 Jul 2018 13:56:46 -0700
Message-Id: <20180717205712.29495-7-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Take the global mutex on driver unregistration updates for proper
ordering of updates and consistent access procedures.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index cbadab7544c81..2ff328652356a 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -371,7 +371,9 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	class_destroy(internal->class);
 
 unregister_gasket_driver:
+	mutex_lock(&g_mutex);
 	g_descs[desc_idx].driver_desc = NULL;
+	mutex_unlock(&g_mutex);
 	return ret;
 }
 EXPORT_SYMBOL(gasket_register_device);
@@ -408,7 +410,9 @@ void gasket_unregister_device(const struct gasket_driver_desc *driver_desc)
 	class_destroy(internal_desc->class);
 
 	/* Finally, effectively "remove" the driver. */
+	mutex_lock(&g_mutex);
 	g_descs[desc_idx].driver_desc = NULL;
+	mutex_unlock(&g_mutex);
 
 	gasket_nodev_info("removed %s driver", driver_desc->name);
 }
-- 
2.18.0.203.gfac676dfb9-goog

