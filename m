Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF93C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F602073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Syt8tRkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F602073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbeI3CYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:24:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44515 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbeI3CYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:24:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so6484059pff.11;
        Sat, 29 Sep 2018 12:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HJoejfDtzXxSTnkA5amJm1HGE5JZa+nGbAgbLRq57SE=;
        b=Syt8tRkFQG3RcwFAkUnWZD5MFjmspgWxn1OAESKjdY/+jgZ1Z1pR2DDsyPPm7C5VbS
         8chd6i6Gp9xzeQQPqgIKOtxGg3PbU6uCDUBJUEt4kJ5sK77LWnmngF9d5tTQ5kLphGNz
         hLbLPV+ZpcPFPgPYF+o5FA2Z37VMazjPWuMNI4af1gGF9OxDhtlO+s8XPZ3bwIePrsLR
         MJZCupuBRhvvP3jLRLVxdcYErwYAwwvAY1duiHa1Zet6ypf1P9/N8tfAAXbnuFU8IGD5
         YKckCxv7UEOFqkOTT93wtfB9tyAkt1yadf1QNgyCCt8Rc3HVamt5RW/qPs+Wgbe1Dl4X
         +M8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HJoejfDtzXxSTnkA5amJm1HGE5JZa+nGbAgbLRq57SE=;
        b=Kf1AgbJANKck/2ytdjcHpxbBBcXSszu0IpyOtmbR+TuARfr1/whnar7GT8R6S235VI
         KhCfEEu5zynI7Bf5nt9xye3ZxBxflYhhx+9DOaNOUr053+C5GOUI1Up/GxDk0eXJ14F0
         SiyLQSvYS5WlkheYMib3qMCwbY0FHnk0DroFuhtaBSWjOQlgtwOtZ1a/W2uRbFSjQ6KO
         7JkuepAXn7Bo4gieM/XuNhFAi2TB06lTlnQCrD3LAlU5C/G2lzJyin/BEFFcMcmmGOC5
         7tpCwCjsgVrpsZ4c41+Tm8n7JjKo2G77YT937CWXrErSB0+sDnDzt8E+JUB5ekYaWm4Q
         86Iw==
X-Gm-Message-State: ABuFfogLHqHiN7QttAAZ+QU+GtmJz+V+8mIukqVnkPfbDbHOlRrDBgDR
        KEDF3x3AuGOq5DTMuTUOoudD3k0f
X-Google-Smtp-Source: ACcGV60Y8aBVk0qhpM78dB0hRcCTRCDy4TZbWC4FK/T5GUTNiuAHdfmAcRsadLM6Ru/R7hH8q7Pk1g==
X-Received: by 2002:a63:2587:: with SMTP id l129-v6mr3985346pgl.29.1538250906868;
        Sat, 29 Sep 2018 12:55:06 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id b126-v6sm18371946pga.49.2018.09.29.12.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:55:06 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v7 14/17] media: staging/imx: TODO: Remove one assumption about OF graph parsing
Date:   Sat, 29 Sep 2018 12:54:17 -0700
Message-Id: <20180929195420.28579-15-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929195420.28579-1-slongerbeam@gmail.com>
References: <20180929195420.28579-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The move to subdev notifiers fixes one assumption of OF graph parsing.
If a subdevice has non-video related ports, the subdev driver knows not
to follow those ports when adding remote devices to its subdev notifier.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/staging/media/imx/TODO | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/media/imx/TODO b/drivers/staging/media/imx/TODO
index 9eb7326f3fc6..aeeb15494a49 100644
--- a/drivers/staging/media/imx/TODO
+++ b/drivers/staging/media/imx/TODO
@@ -17,29 +17,15 @@
   decided whether this feature is useful enough to make it generally
   available by exporting to v4l2-core.
 
-- The OF graph is walked at probe time to form the list of fwnodes to
-  be passed to v4l2_async_notifier_register(), starting from the IPU
-  CSI ports. And after all async subdevices have been bound,
-  v4l2_fwnode_parse_link() is used to form the media links between
-  the entities discovered by walking the OF graph.
+- After all async subdevices have been bound, v4l2_fwnode_parse_link()
+  is used to form the media links between the devices discovered in
+  the OF graph.
 
   While this approach allows support for arbitrary OF graphs, there
   are some assumptions for this to work:
 
-  1. All port parent nodes reachable in the graph from the IPU CSI
-     ports bind to V4L2 async subdevice drivers.
-
-     If a device has mixed-use ports such as video plus audio, the
-     endpoints from the audio ports are followed to devices that must
-     bind to V4L2 subdevice drivers, and not for example, to an ALSA
-     driver or a non-V4L2 media driver. If the device were bound to
-     such a driver, imx-media would never get an async completion
-     notification because the device fwnode was added to the async
-     list, but the driver does not interface with the V4L2 async
-     framework.
-
-  2. Every port reachable in the graph is treated as a media pad,
-     owned by the V4L2 subdevice that is bound to the port's parent.
+  1. If a port owned by a device in the graph has endpoint nodes, the
+     port is treated as a media pad.
 
      This presents problems for devices that don't make this port = pad
      assumption. Examples are SMIAPP compatible cameras which define only
@@ -54,9 +40,8 @@
      possible long-term solution is to implement a subdev API that
      maps a port id to a media pad index.
 
-  3. Every endpoint of a port reachable in the graph is treated as
-     a media link, between V4L2 subdevices that are bound to the
-     port parents of the local and remote endpoints.
+  2. Every endpoint of a port owned by a device in the graph is treated
+     as a media link.
 
      Which means a port must not contain mixed-use endpoints, they
      must all refer to media links between V4L2 subdevices.
-- 
2.17.1

