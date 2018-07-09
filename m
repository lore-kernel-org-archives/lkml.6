Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18D1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E042086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6fdvp3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E042086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933557AbeGIWkt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:40:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37714 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933438AbeGIWkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:40:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id n15-v6so1551413pgv.4;
        Mon, 09 Jul 2018 15:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uPKujOQMnvKU1077V5CGc8/sTd+S/PEORaQoe1sBY8c=;
        b=W6fdvp3XWSjl9EWhAEfqQ/N7khhZNtoE/QR3ZCOu62TNhxvCSc+pAJ8Y9L0pZTsG9+
         jyCQjX1LJgaycnomSUZGBVktbA2Bmk8/nOhMHhKD8ym9UBxRN1TG7KQNBCUj73Vl4iYZ
         Ff9y8cKQA4HiQM4/xN93pnDv336GjbDlwbnuAlu0i6zI1JaigkZQbFivTDGAqpffTlC1
         hfFFodoCxhk/ikDyd9jZ5JvU2Iiw8PqhXXgRm1fMOO4ihhS7mEcScaIlgLFhUo7du8sh
         zE4i/39ceL/67fOlDt6IfhLFyBpzNpeMS2aTDUh+PuVU7IJAw6kcrWxGQ/EtbaRFHWD7
         qpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uPKujOQMnvKU1077V5CGc8/sTd+S/PEORaQoe1sBY8c=;
        b=Hnt/px8Neju30BQGbK0TQwpdEVNmQMjKIe9xAUWKx9glizpr13/sPWMcc7u5qou42p
         vCHc5JRTTK4zu9gGiEtq8uzC9NrFyCnXEruvUbthbSeRGXMUyxcRJs/IFcUdjCIdndCE
         Zco1LvkwcXG+wQLqYUS7XfgD1y9sVit1CaB56M0WuQhDsGTFh72W+eaD+u3iQmiTDcwI
         k6Xx2doCyHBnh+ca01QId5cBr+CZjnQgDmQ5GkqVTYof0+zMCZq3tju1N4OHmq1SfF0Y
         w/l+WRQufb+ALbcyRzV9+wuuYFJnYOXYmI3iha+GXV+QjfKFlqdAXcpm+mGneFNXx6BZ
         72gA==
X-Gm-Message-State: APt69E3f8cUPVW3oLY3k9y8xqW3OmSxawP9GYuvwqa9O19v6WAObAy6o
        yzIIyNBEo/uM4IefMGQXO93YvQ==
X-Google-Smtp-Source: AAOMgpfLCxxYnRtAbdsoEb0HQjhBnXeYDTotza5zfH58+P1EGYObW8O7RyJ7Ae9RunIuQ07W6sekuQ==
X-Received: by 2002:a62:3f44:: with SMTP id m65-v6mr22903705pfa.98.1531176001464;
        Mon, 09 Jul 2018 15:40:01 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id r16-v6sm30143804pfe.173.2018.07.09.15.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 15:40:00 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 14/17] media: staging/imx: TODO: Remove one assumption about OF graph parsing
Date:   Mon,  9 Jul 2018 15:39:14 -0700
Message-Id: <1531175957-1973-15-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
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

