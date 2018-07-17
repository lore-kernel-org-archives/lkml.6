Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3C5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B07206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJv8kVYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B07206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbeGQVjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:19 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38085 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQVjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:18 -0400
Received: by mail-pl0-f67.google.com with SMTP id b1-v6so985818pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=inPp99IyCggJ5JzoBgEQkIf2dCom/uUiaC1+Y2uOfNo=;
        b=FJv8kVYeu+5dNl+wA7gxtWrz6hQbiZNCNmatssGvL3o4/c3dYeKE1kPpZqcwxfc8Og
         Kj4/hlwTYYCD5+/l7NJmDzTHjmso2jT0RyaidiSy9pPG8dZUjEPOMLBHFsmyuXFuMztK
         2d5dTGwBXXW2bYpntuNU/MJgzt6w1wwJs9NwZ26eUZl+qwSWgFbweaiMS4PtTDndNZrT
         MRKDhnCpkeEGFvqDh4oamVqXlzFwllIgf2jwLXNfFGBUHX0tnELxbg+tNaShVWDxhJPl
         Rp8ObKANbMK6wB4ReoCr6O3EX7wHYfzRiEOvdTL/DYn16SUkB+/8x+It08zLfs0eabKu
         5ugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=inPp99IyCggJ5JzoBgEQkIf2dCom/uUiaC1+Y2uOfNo=;
        b=OmsdWGyWJpSoR19reUI9oYDHSyPl7JGay8Whvk/w5hORp94dwRulzl0wOCmGV9f85T
         77fr4m0PpxwnVIed8k4ha8je+JwQknwwPp5PoyEUv6mrq0vSOlm3wtb2jXWzUUj2VY+f
         fyScZ+8sCW50MnZPcEKjgAcG2QqyaWGRowMGnFNtR51KYYYpryZ0gdMEG6KAP1e0ZpOm
         rgtdqFdkwj1yEKGEBtOg8BmxHJ0bSaZIcNXdlAK7I0vr/ISzBHLIks6sheNye/gv+0IV
         RRgjLr63khYyeCvJ0w4LbR51myEiUcpVis3artNY3/MMImisU7heyD7aXVgJTIRaxHxI
         i0fA==
X-Gm-Message-State: AOUpUlH3+4HbRvA/Yvv597GNoNSe11CtsqJIh3ldelsQpntmy+6B2cgv
        3nD2mHrs1X2AGCGlZLfUKTQ=
X-Google-Smtp-Source: AAOMgpeM5+sTG89B0LOmiRCUzKNgtC+PUfz/Qdiopf/VNbrLpVrys6j5M8MoZODoApSlFHLnks3a7g==
X-Received: by 2002:a17:902:8ecb:: with SMTP id x11-v6mr3190159plo.308.1531861491168;
        Tue, 17 Jul 2018 14:04:51 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:04:50 -0700 (PDT)
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
Subject: [PATCH 05/32] staging: gasket: remove driver registration on class creation failure
Date:   Tue, 17 Jul 2018 13:56:45 -0700
Message-Id: <20180717205712.29495-6-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

If class_create() fails, remove the gasket driver from the global
registration table.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index b69b630f1b79b..cbadab7544c81 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -335,7 +335,8 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	if (IS_ERR_OR_NULL(internal->class)) {
 		gasket_nodev_error("Cannot register %s class [ret=%ld]",
 				   driver_desc->name, PTR_ERR(internal->class));
-		return PTR_ERR(internal->class);
+		ret = PTR_ERR(internal->class);
+		goto unregister_gasket_driver;
 	}
 
 	/*
@@ -369,6 +370,7 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 fail1:
 	class_destroy(internal->class);
 
+unregister_gasket_driver:
 	g_descs[desc_idx].driver_desc = NULL;
 	return ret;
 }
-- 
2.18.0.203.gfac676dfb9-goog

