Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E00C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFD62086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG3PKddL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFD62086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933255AbeGIWje (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:39:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39536 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932798AbeGIWjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:39:33 -0400
Received: by mail-pl0-f68.google.com with SMTP id s24-v6so6675691plq.6;
        Mon, 09 Jul 2018 15:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ckvGkgSzMQGoRIaVJELL2IMAccg8EtGCjP69WQOWceM=;
        b=MG3PKddLBzft6Mu5umJrq2bqSCHUyiMP3+eaCOrMXZNMAHajEkDNIkyPdMikEmIUFa
         N5YrWFsB4OxD/4nCeoUDvmHBTvcdaNS5kjOHpAJoEAtK9STc14Ja4gvvnNUKh5KJ7a50
         DfOKo9B+ig7rhdbsPPwmRBZJMmmGnahz9lzkAaR9gm7Dj9O8X6/uOa6dyKuzShC3FmzP
         2FhhqcOsklsoIj9TE+2Iekp/PEMqbZJlc3kpFDgB2jam896k3b86x5eL/wRHKAaKrtaf
         Wr7wKb9sTFnjSNj7vA52bGD/nU/9slHCMUbp7JpkWk1qcYrA/bOWxCXBEWSyNBbDmGqY
         WIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ckvGkgSzMQGoRIaVJELL2IMAccg8EtGCjP69WQOWceM=;
        b=lnS6GYACstz3qzl7gbddfYnoitQZVH/QArmK7eTK9nryyBYNzDbl1npPZkTTvt5l/h
         x4pYhQ64FbQioQlkgBn3THbjeU3WB//LPje9+jvogSsBhY8l2ZwXRxGmPs9/GVexp1gG
         KEVRLWOSXTe6Rt9FkQvZqnEe3sV6vOCQbawpG7rBotvwMT3bvlKJTl6lgBOrBMvLXmbS
         dbWvjvYooAdR+D+1w0AXmCnpdLpnoIT52fv32SD2gqZG4chQSfap+3SqJ2MGDdV8c9Dh
         0XzqdPIegQJTNxpZPEJPvDpcATIZyvmeMzklWDoxFzWlG/oXq0vckjNX6CY+p3H+de1O
         m9lQ==
X-Gm-Message-State: APt69E2eavXux/oJ+JBuQB9intqnfyhtLG5WGDmrRDFf07qn0HQH29aH
        4AbsaYuhfalbndJS47EzkZRkOg==
X-Google-Smtp-Source: AAOMgpdsRYnlyboQV8VEyB49p0OyHk1cfn88HfbQ9BW9lJH+ZSCyLA9l0OvnKX6k6bs20LLxXaSvtw==
X-Received: by 2002:a17:902:7e43:: with SMTP id a3-v6mr22035578pln.151.1531175972049;
        Mon, 09 Jul 2018 15:39:32 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id r16-v6sm30143804pfe.173.2018.07.09.15.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 15:39:31 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 01/17] media: v4l2-fwnode: ignore endpoints that have no remote port parent
Date:   Mon,  9 Jul 2018 15:39:01 -0700
Message-Id: <1531175957-1973-2-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
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

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
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
index 3f77aa3..3240c2a 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -363,7 +363,7 @@ static int v4l2_async_notifier_fwnode_parse_endpoint(
 		fwnode_graph_get_remote_port_parent(endpoint);
 	if (!asd->match.fwnode) {
 		dev_warn(dev, "bad remote port parent\n");
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out_err;
 	}
 
-- 
2.7.4

