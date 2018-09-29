Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52E5C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B612073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO3FyjyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B612073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbeI3CYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:24:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38051 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeI3CYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:24:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id r77-v6so6772377pgr.5;
        Sat, 29 Sep 2018 12:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vhmN50C9sktsUnQ0DqCK715HpG76rwFyWm3Q6vCbPtY=;
        b=mO3FyjyYptjEAJ++6jXEHZN5VdartMJnHMu3KHKwOYVc4SBx4ELpPDcLOxgVowrXvE
         mowgSPf/sMuaEiXe2VBBSjETuEwvCf3r4aWcQiwpv976z1mVckU6DREGYTx+7dMJYmTI
         ePKdUT0KxC0G+gI8hAQVsGfrnGrjQhh5D7YvNhA80TSLOoO+kj3qg8dOFQtQ2R8D8v7p
         CzdFe9FS/cccpX8Ij/0zxkhBolUoCyb3vyLbU8X4Gw2YPOIGwtllOfK+8DO5+jB20AkK
         kc/vPirqe9gmkrFOZLXaUkFo9nOj5RhJSTI0T6Vi1kSsPrVvAwwZxibh8sauqZwaaVRD
         IsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vhmN50C9sktsUnQ0DqCK715HpG76rwFyWm3Q6vCbPtY=;
        b=L02x+fZpWd+SAF0aQkifYJDsYKSiX+z2s0Pe+V+c8C/SuarKeiN6K9LNvKFOqT3NBM
         gI/DTnZ9Dg1ZKE6n5quVJc3ILy7HX2W6jbOESCaHZsrOsKgfi+iM55Sk6ICZ2eUVVjsI
         gCRMnXafj7ovKgQV5eRvtJA4UJ7UnM1ICTZ7xXTCMkocf39Kf9bdirk7Q7Ip/a9Gt0iS
         Gl7HujfCrbZHWL4g3W9jM4RTUOmse1ls6wI+wh0chhP2gzYCE+3ZEWd+J7kxC2pc3mR4
         09loCjU/l5xJVR//G5CrtxFk99o4Yn8oXtAewnwq32aXQ93ZtkKgIdYHoibZ5NArTjxM
         3SQw==
X-Gm-Message-State: ABuFfogt2+I7S0zYo8GqeoGkbXeLp7pfEUqXAnEHzP59WHscfzCzsW5/
        H8SPekLvCNKg7s3wOeph2mU22lFV
X-Google-Smtp-Source: ACcGV60zRyZPccSUNHc1UCET1WgAxAMrI78O/PKIzcqJQmspSyx4lGHKfceliUBtCzF/vHbRJkDluA==
X-Received: by 2002:a63:1c1b:: with SMTP id c27-v6mr3906619pgc.351.1538250873709;
        Sat, 29 Sep 2018 12:54:33 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id b126-v6sm18371946pga.49.2018.09.29.12.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:54:32 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sebastian Reichel <sre@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v7 01/17] media: v4l2-fwnode: ignore endpoints that have no remote port parent
Date:   Sat, 29 Sep 2018 12:54:04 -0700
Message-Id: <20180929195420.28579-2-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929195420.28579-1-slongerbeam@gmail.com>
References: <20180929195420.28579-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/devicetree/bindings/media/video-interfaces.txt states that
the 'remote-endpoint' property is optional.

So v4l2_async_notifier_fwnode_parse_endpoint() should not return error
if the endpoint has no remote port parent. Just ignore the endpoint,
skip adding an asd to the notifier and return 0.
__v4l2_async_notifier_parse_fwnode_endpoints() will then continue
parsing the remaining port endpoints of the device.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
Changes since v6:
- none
Changes since v5:
- none
Changes since v4:
- none
Changes since v3:
- none
Changes since v2:
- none
Changes since v1:
- don't pass an empty endpoint to the parse_endpoint callback,
  v4l2_async_notifier_fwnode_parse_endpoint() now just ignores them
  and returns success. The current users of
  v4l2_async_notifier_parse_fwnode_endpoints() (omap3isp, rcar-vin,
  intel-ipu3) no longer need modification.
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 169bdbb1f61a..0b8c736b1606 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -367,7 +367,7 @@ static int v4l2_async_notifier_fwnode_parse_endpoint(
 		fwnode_graph_get_remote_port_parent(endpoint);
 	if (!asd->match.fwnode) {
 		dev_warn(dev, "bad remote port parent\n");
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out_err;
 	}
 
-- 
2.17.1

