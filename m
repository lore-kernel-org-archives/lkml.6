Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE35EECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A9920693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLCv0oF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A9920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbeGQVmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:42:03 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44330 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbeGQVjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:22 -0400
Received: by mail-pl0-f67.google.com with SMTP id m16-v6so982356pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xAi+tz1xR+vTMPZHa4TPt80jizzIjIj8dZU0G1ekIfQ=;
        b=oLCv0oF/ga+9lXx7LLhPysi6QlHE+pKMQ5YWDOhIKkxZxhWmcEDCEIWQOnUC/DrlXd
         S7mJ8R6tuGGvQB27ERUYlGhpzO6kcx/LJJPXxcfffdBfmoB82aLue4Wk/s0Q8g6/5t5B
         WrXFmx1v/kuasLtRIn1ZdSIn1jotF74/efcCti7dQsKdI2WM4zBYm/f6ljBy/yViyEVp
         yYreTVbzU643Kymh0jiVV1xmv+fodi8cJ+ip5n9b23IMs/977Cf6SE4H7Xd1N7IL82BJ
         5rcUzuL076uOEmgYyYwx0IkiqlWmkBxOeh6CLzltWlQ67POAMsVkxiK3lVHlM2y/xVxJ
         K3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xAi+tz1xR+vTMPZHa4TPt80jizzIjIj8dZU0G1ekIfQ=;
        b=b1maXD1YFq7iP7D2PKbdO2cysWrRitRGkxQ9SQ8+qCykq99Xsj1WEo7X4JXlC6O1gL
         j6kL+ThsRQEEo7xFcaMHQ2vQLw41UuoEmkE/v2qFIsqmwJFGyve42N4miGnHExr5en2R
         DMGVPMVXDZ+TeNADu6oSVDrlPR7rQF0uYnRGcoyUQUCe6VGUIW0ZRpZogV4Js2EC2nQe
         v0qV6a6j2VisoVmguhEtOtEnx06RtX+daIAi5xCpXU2IqjH2bzFNY2Msi+9RgQ5zRoH5
         E3WC/e8GIdEMbOqOAnQylcMCiUls+a5Lx8WbdxR7Bly7ubtX0uw2Gt93QpThbMAYp4vB
         QI2w==
X-Gm-Message-State: AOUpUlHbVm1hiG1V2SGkdkX2qsbOCplJtksp76VPEJBHFTsAcXWODfIi
        y7pTw7kwE8pRpL6lWbDVdYI=
X-Google-Smtp-Source: AAOMgpc34UJNj3fjZOIy9nT0DlyWIiF2GD5fGZM0RuF6GJ/NNYiiV21JssMtfxw965WeVcV9mODzCQ==
X-Received: by 2002:a17:902:7b97:: with SMTP id w23-v6mr3175859pll.66.1531861494691;
        Tue, 17 Jul 2018 14:04:54 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:04:54 -0700 (PDT)
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
Subject: [PATCH 08/32] staging: gasket: Remove stale pointers on error allocating attr array
Date:   Tue, 17 Jul 2018 13:56:48 -0700
Message-Id: <20180717205712.29495-9-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

If gasket_sysfs_create_mapping() hits errors allocating the attribute
array, remove stale pointers to device info from the mapping object.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index dd4d3aaa57e2f..1c5f7502e0d5e 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -225,6 +225,8 @@ int gasket_sysfs_create_mapping(
 	mapping->attribute_count = 0;
 	if (!mapping->attributes) {
 		gasket_nodev_error("Unable to allocate sysfs attribute array.");
+		mapping->device = NULL;
+		mapping->gasket_dev = NULL;
 		mutex_unlock(&mapping->mutex);
 		mutex_unlock(&function_mutex);
 		return -ENOMEM;
-- 
2.18.0.203.gfac676dfb9-goog

