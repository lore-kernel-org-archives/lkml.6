Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237FCECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 18:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD81320858
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 18:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io/dZQjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD81320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbeGOTCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 15:02:12 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39650 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeGOTCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 15:02:11 -0400
Received: by mail-pf0-f196.google.com with SMTP id j8-v6so560105pff.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rzaIwXqzHU5RwIHoioeMCSQbAXyjSjbEWuDwInOE1Ac=;
        b=io/dZQjOL4BREfwan5sBHhR692xwUtwyvmG1oLGm7oiMNfZeFSuunUArPycvbzeLZp
         o76NzpJFyYNAg52Y46+LhcEyF+xVovIR390epN8RwckmF3Vq7qX11k82vVui+96tH/ik
         /zM/QxLKXaXFWxBkMp9h0GZSgpR6cZDPvGrV/e5qNlijZ0LAIS8oG0SOKwDlWX0A/umr
         M3TWgLICjHwcRfbf2H2VrenRWl3P7dWYh71natAiF9XHV7/OGQEXjNx9seCcl5dNht6T
         oXO4f++8vqSc/ReeVWgOjVExWxN0w/bfQMOWWAaMO7Ahr9sao9Rg/oNBnnl9a3RuHdzw
         ObjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rzaIwXqzHU5RwIHoioeMCSQbAXyjSjbEWuDwInOE1Ac=;
        b=rCAbItF743z4zWEoPV7PyKsDi0WEZMUeuzv9Ej2shVxZ+LFoBVUFe5HYnf2GKCTjfG
         aU5FOSqGVyIIykkbwd13WJM8A/2Q0H8x5sNLST1rnUtNb0bQXwK1Q0M/MdsYANTEX/GB
         PWYxCtHlw1GPN1kZTssqA45ttsJ47n4lOv3+NPvPgS0sNCr5hcD4kyZKHSaFd1XZ6ZEG
         hK7P+up/eHa4XRvsYuz6RZKB1T7lcoP5HmbNmZR/BylU//v/v7FJ7m/fsoFyf5dVv6cv
         +i20JUDK7UNNtsTMqOpq6bSfWy5X7I61GoLXO7H0z3TQOnv+Gl/PUJyHYZauBHG1ucUN
         8sJg==
X-Gm-Message-State: AOUpUlG/+9v0Zjhluih1B4OvVrX2JQd32UeUFb/3vFhgsp3AZ75fsjEz
        qyg/R6s7LJfKdAiJgl2571c=
X-Google-Smtp-Source: AAOMgpe+FJSTs/zBIMcFDVXnNzT8axBIicdawNBXY7uiaeSwZ51a2exN82LMNe2FOt14UJP1O/lh2g==
X-Received: by 2002:a65:660a:: with SMTP id w10-v6mr12766445pgv.366.1531679904249;
        Sun, 15 Jul 2018 11:38:24 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m82-v6sm16191976pfk.149.2018.07.15.11.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 11:38:23 -0700 (PDT)
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
Subject: [PATCH resend] staging: gasket: fix class create bug handling
Date:   Sun, 15 Jul 2018 11:38:16 -0700
Message-Id: <20180715183816.190819-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

class_create() never returns NULL, and this driver should never return
PTR_ERR(NULL) anyway.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index b69b630f1b79..20da6bdb7a73 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -332,7 +332,7 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	internal->class =
 		class_create(driver_desc->module, driver_desc->name);
 
-	if (IS_ERR_OR_NULL(internal->class)) {
+	if (IS_ERR(internal->class)) {
 		gasket_nodev_error("Cannot register %s class [ret=%ld]",
 				   driver_desc->name, PTR_ERR(internal->class));
 		return PTR_ERR(internal->class);
-- 
2.18.0.203.gfac676dfb9-goog

Resending, extracted from the previous stack of patches that needs
other cleanups.
