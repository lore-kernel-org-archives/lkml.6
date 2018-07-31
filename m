Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCF4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B574A20894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3hTm2b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B574A20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbeGaWHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:07:55 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44263 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731233AbeGaWH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:26 -0400
Received: by mail-pl0-f67.google.com with SMTP id m16-v6so7654032pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLMzWm7i3oFuGw0KXBBSlXXODJyzmrDH5+Ji/KzIjy8=;
        b=G3hTm2b4M1denmGknuUmRKlurp6Y0rnPByeyEGokCneJu6z/4mk2Dv6tn/+ifLIMwW
         rdrcKZ5fC4ytQceE/rrhuwPsD/KEPQfARJrUICt9p8usasKkshLq+mP7bEVpX/iMufIZ
         vfEQoDHbZPcT3vlZCaTgmzOoubllkMP1VeMHNuyRshW64a0wQc5lu3wHXnjk1DEc4Kjy
         AujwP5EdN5X5P8SzGIKvv5m5SVmcuBmCNQYmcyfALzMrTd0poEiQyXGsIA578P1vwE9S
         jM9elTgdQK57n93vXakKHmZKnFfyVQ8pe9YL8eFe1895VEClSPDqKkNz7IDuMEV41pC/
         Ub3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLMzWm7i3oFuGw0KXBBSlXXODJyzmrDH5+Ji/KzIjy8=;
        b=uR8Mv7h4m0Ttivo2U5vIq1Gvxok6a/q5sYsp73SwbyaRB/JLmDWGsAJl07HnykAUZH
         ueUfuu5lEJLasU5IwYy0QhZ3kcfQvNbF4ngWckJEMquU277qy/jsrsQPNfhaQg8WuqIL
         0G7HrQISVGxKkGWbvF0g8SyCVHB/FC4Wb5hIZ613k5KuuQR/gcZn5if0LF4l1saFXZcs
         rh/Uq1deBEzis7/zCbicpAsKTyt9SF6N0jDYvf9RfemJpWCdQ0lCpVmVzsstOw9ymt3E
         9zRzJThG9YRfOtfnXzpFW0f6PshKHD5SFsnavEfDqXWDxjghAFUlyJ4Ovd5HNWLM0yJ/
         KjbQ==
X-Gm-Message-State: AOUpUlFqbpHndQJwn6o6utMUfZN6C8slvPAQUR3M3NOJt0tUXhtrzw93
        5zd93opnDPA0nlLFv8ZTkK4=
X-Google-Smtp-Source: AAOMgpdLLp5eulw87lJ0kHClou4MPB+IcvvtWXD62cGYW6PqOWpVS7bWqkz7zAgO0KtwZ5gaA2vh+A==
X-Received: by 2002:a17:902:9681:: with SMTP id n1-v6mr22495493plp.244.1533068722640;
        Tue, 31 Jul 2018 13:25:22 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:22 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 11/15] staging: gasket: TODO: remove entry for multi-line alignment style
Date:   Tue, 31 Jul 2018 13:24:44 -0700
Message-Id: <20180731202448.229487-12-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180731202448.229487-1-toddpoynor@gmail.com>
References: <20180731202448.229487-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Multi-line alignment formatting issues fixed, remove the TODO entry for
this.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/TODO | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/gasket/TODO b/drivers/staging/gasket/TODO
index 6aa2a7f6bc4b..6ff8e01b04cc 100644
--- a/drivers/staging/gasket/TODO
+++ b/drivers/staging/gasket/TODO
@@ -4,9 +4,6 @@ staging directory.
 - Use misc interface instead of major number for driver version description.
 - Add descriptions of module_param's
 - apex_get_status() should actually check status.
-- Fix multi-line alignment formatting to look like:
-      int ret = long_function_name(device, VARIABLE1, VARIABLE2,
-                                   VARIABLE3, VARIABLE4);
 - "drivers" should never be dealing with "raw" sysfs calls or mess around with
   kobjects at all. The driver core should handle all of this for you
   automaically. There should not be a need for raw attribute macros.
-- 
2.18.0.345.g5c9ce644c3-goog

