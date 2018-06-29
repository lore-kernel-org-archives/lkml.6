Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301E7C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD353217AB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4QoMFX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD353217AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936879AbeF2Sye (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:54:34 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46092 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966101AbeF2SxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:53:17 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so4862388pld.13;
        Fri, 29 Jun 2018 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uPKujOQMnvKU1077V5CGc8/sTd+S/PEORaQoe1sBY8c=;
        b=C4QoMFX0xDkcSredExc39/VvSzuZ20FlQabxE/WDlgVBS5lnv6nHfRZbh0g53+pdg9
         lasrUZF2u3vEEhUfm+jaduWJULU66msGEilgMy0e3shR3hke9J4GoNMO2yH+Mr+7fmiW
         FGXwVKkVEC0GRlILVdbc9tb1dKn5F1iguTcQmmCBIOqoc35m3mfz8Z4SEGQLhUpz0mJC
         SozTfFuc+upEiH1N6qXRsjTDonLKjRptIB38FY4BY9lX9g465Ut2gmu00Wjor0qx1Yp4
         2ipVhLCksipRX06OriF+6n8FcsjMl0wVi//+NwGpjJXLoluHDlJ+H53ZDW/XTbf5G3Ij
         B0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uPKujOQMnvKU1077V5CGc8/sTd+S/PEORaQoe1sBY8c=;
        b=Hb73Cr7yyaxp41Yo/a4Lea/pn0bvHJD3rYfhTuZBjsus52LiZSFXwdnLlYXf9+JyWh
         IP2Hg5Ms/WyNext/wBikppDX/ZP6aTBnXF01L48JHKsQDCNBoU+eV4SSqLn4YbmT+I76
         +VSRO5PHf1wI8hlVlUsj8loR18CPLe8OZJnlWDCvd5PQPIHwKT678CvCUWXZ2/ntr9xb
         ipiHmUjCawxOUkXDdqreG0hO5GMgYTkrIJ8+9qN2hMI28JWZERKIT+OojLlxk/mzl1ll
         Me7Jqo1CzLdQAtoQpC2AfJLRgh6A9AFtkHuwuHdM/dc2GgWsHTGcqjh4dx/3aAtB+wG/
         nPoA==
X-Gm-Message-State: APt69E1uo8uaRgGL9TiQxtJIDccghiKZbt3uGc0mdlPRhqdrEUSRmzj5
        ArJBpSbQ3hGbtsVT4R01sGOLtQ==
X-Google-Smtp-Source: ADUXVKISFRVu1C3c6Wb58nvUhdz9G9eeTYN6HzZU937GOW+CzlhGqp4ALr0PMf6x4dvfiGFylg6MnQ==
X-Received: by 2002:a17:902:4381:: with SMTP id j1-v6mr16110249pld.104.1530298397041;
        Fri, 29 Jun 2018 11:53:17 -0700 (PDT)
Received: from mappy.world.mentorg.com ([2602:306:cc3b:f020:7cd8:9ad7:a375:e853])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm27672308pfg.130.2018.06.29.11.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 11:53:16 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/17] media: staging/imx: TODO: Remove one assumption about OF graph parsing
Date:   Fri, 29 Jun 2018 11:49:58 -0700
Message-Id: <1530298220-5097-15-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The move to subdev notifiers fixes one assumption of OF graph parsing.
If a subdevice has non-video related ports, the subdev driver knows not
to follow those ports when adding remote devices to its subdev notifier.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/TODO | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/media/imx/TODO b/drivers/staging/media/imx/TODO
index 9eb7326..aeeb154 100644
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
2.7.4

