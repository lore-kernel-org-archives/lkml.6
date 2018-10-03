Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E973C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2580820835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bB3qf7Dq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2580820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeJDAHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:07:14 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:45581 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJDAHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:07:13 -0400
Received: by mail-io1-f73.google.com with SMTP id g133-v6so6040932ioa.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q5rtQuIMje/HQHlwJtt1CDkAv2ZQ1kv74GtS4i5PJSA=;
        b=bB3qf7DqXQXaBOVYcWH0Jla6FU1WfmOYdQ9jM8Sl4LP9EDYenyIoT6A3MtaFbBZm0g
         gpJML4SXOZyl4k0rHTM1iPayLIMvYAaI9XIGr+hxh02p8fwRwOD45hugROxdW+0gVJqm
         I0dDe9rqNijIsJqjO818ayT2zP//JcxN7UXpgULwAwPuOa8C8z0mV1z5omwFeD5Gxg0r
         waB15P/EH+0kQTeHuGyLGE/A3iItgo6EiqNlDYzqVMLgpSeVYJMpLetOEhPpcCNY3+/A
         VwD0Pf12BM4v28sZQsmT7L7PlKiVTBScJChcU983dOCkHtsrnj1po3eqmqq5SdqnP+fW
         DGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q5rtQuIMje/HQHlwJtt1CDkAv2ZQ1kv74GtS4i5PJSA=;
        b=CErjzfGTE1dJc7wagibJGQ/StyCdrDK+Cd3fheLxaFbeXqE2wnvJk3S6DovUEbr2rV
         7cwPmWnmEFNysQQal1ViWTHrkNpxVIEV5haSiSMvO1y2dSx0Os22tWOrbJUXWWRpnQGv
         VbPX63M4rBNgFr+PChMat9++TeZrggdrZ+E2L9xWYQuiMgKb7C51sjR3eU5THICQZFQS
         LkSjk4lymqqchFzKlsZmEsiitXqOJJJsoEJiwsmvonjxvfoeEdssoruX6FGDGVNf87/e
         P7Umv7E+EslW1B5+QTRjiyolrbycvGPSSKVelgmcDgNgLs8HeHt+HvK2DrQsWLcUJRLi
         awwg==
X-Gm-Message-State: ABuFfoiRAPkXHvGYQs77DCS8Ug6wpMmtVt9YNxEpsd67PFLDi+M9Zpt3
        zJj3Uzj9RZ4+VbmXhkMoQ9Nsd+Va
X-Google-Smtp-Source: ACcGV60BMuC6hqzrtGua4ymALaFkk4WNn7MrHi+0CR9IIcREV7P10x4au7S335/VtyrjSnvlWcsqrsuc
X-Received: by 2002:a24:2443:: with SMTP id f64-v6mr2119375ita.27.1538587076030;
 Wed, 03 Oct 2018 10:17:56 -0700 (PDT)
Date:   Wed,  3 Oct 2018 10:17:09 -0700
In-Reply-To: <20181003171720.169953-1-rkir@google.com>
Message-Id: <20181003171720.169953-4-rkir@google.com>
Mime-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 04/15] platform: goldfish: pipe: Call misc_deregister if
 init fails
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

Undo effects of misc_register if driver's init fails after
misc_register.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - No change.
Changes in v2:
 - No change.

 drivers/platform/goldfish/goldfish_pipe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 4013832f38fb..c386aaf40034 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -844,8 +844,10 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
 	dev->pipes_capacity = INITIAL_PIPES_CAPACITY;
 	dev->pipes = kcalloc(dev->pipes_capacity, sizeof(*dev->pipes),
 			     GFP_KERNEL);
-	if (!dev->pipes)
+	if (!dev->pipes) {
+		misc_deregister(&dev->miscdev);
 		return -ENOMEM;
+	}
 
 	/*
 	 * We're going to pass two buffers, open_command_params and
@@ -858,6 +860,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
 		__get_free_page(GFP_KERNEL);
 	if (!dev->buffers) {
 		kfree(dev->pipes);
+		misc_deregister(&dev->miscdev);
 		return -ENOMEM;
 	}
 
-- 
2.19.0.605.g01d371f741-goog

