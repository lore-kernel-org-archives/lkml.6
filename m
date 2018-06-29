Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A48C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40A92762F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi8guhcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40A92762F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936632AbeF2Sus (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:50:48 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33347 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933750AbeF2Sup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:50:45 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so4875429plb.0;
        Fri, 29 Jun 2018 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=daAGUryBL3RdvbMUgo3/LStjtYJ4e6G+2boyDX/13xM=;
        b=Zi8guhcROwaKjI4xbFbsvaWfLFfRZwsddVxVJqOk1Z5IX1tF1fOJu6NwpCP2TRWftb
         Zd0nCOoUDMgJcMgWVzxXKVJKWHf/3hbqQ4INVHXq0xPcoXbQWb2YKXIXePpPn3qnS38m
         DkRECA2I43ep8PuOgpRiLMm6c+NgB6CCi2xqJ54XFT4GpEr820ttLPj7tOhwMZ8SF9y1
         0Q22pIKE5buEp6yPar5NqcOV+Smkwxm4OqFm7FWObj+0KbVaFK7hRu3H0oRWpAAbLOP/
         BIc6J1xv3ELZHIYT2d8z41iAQ6qKJdAmtodYbdnHl3GruyrqmX8otLJ400R3wy6pG5kT
         CmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=daAGUryBL3RdvbMUgo3/LStjtYJ4e6G+2boyDX/13xM=;
        b=EdUpNrjfulNj65aSlqLdqfbUEuzIPNb/VY2aHywMkvqesi8tHEYgoKNwSwo5HRsRWQ
         tDDVL5PtDe8W5+z9LD1Rlhn4mXO8WSQoX++LiKVPq3UJCFt5NDjEosUEYirSgbQtX91E
         rBKWNQiE8ZI1XdOSXhWdgXgNoefqrKyMOR+an1uqaQD/rzV594pxRbFY3gIdcpeg5IwS
         WsFCbpAcldomaVVAUKXhecyvflsdqpSLPiXWuUrTAF443N4Ad4t5xSQb0L0OQpKvawpy
         G07fSxLVjw6EEd9lcCAweMgswZgr0r6SndyhhjuRm3a3+VYWlFsgvsu3iL7CXY4zvfRP
         mOkw==
X-Gm-Message-State: APt69E2BeDdxKcoZ+y/Ebsffffwzi7H8/56GfrG/m36O3Gt23M78DGkt
        r6XVSRg8PXbPaOsoV4rT9UJG1Q==
X-Google-Smtp-Source: ADUXVKKC7nXXBgp7Gk2e5aoPA785zb9jPqUZ7AAgcFKUY4y3NAW9meBZRQGKrroPGy2R9aXItMaddw==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21-v6mr16120631plp.168.1530298245100;
        Fri, 29 Jun 2018 11:50:45 -0700 (PDT)
Received: from mappy.world.mentorg.com ([2602:306:cc3b:f020:7cd8:9ad7:a375:e853])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm27672308pfg.130.2018.06.29.11.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 11:50:44 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/17] media: v4l2-fwnode: ignore endpoints that have no remote port parent
Date:   Fri, 29 Jun 2018 11:49:45 -0700
Message-Id: <1530298220-5097-2-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
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

