Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C81C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF862208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvdIvnja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF862208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933507AbeGIWkD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:40:03 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39292 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933399AbeGIWj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:39:56 -0400
Received: by mail-pf0-f193.google.com with SMTP id s21-v6so14666298pfm.6;
        Mon, 09 Jul 2018 15:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V7rvTuqNA94DrffJJmk/435Bqkq35Kd9IVvvcWlCh3Y=;
        b=JvdIvnjawvi6l2gNwDjrSoVBHPJ/ESch/xgGUTV7X67tKKALpZmLgiak+yb/mbxwXt
         PDoSHbJv3vyD0ABoOsJ0rGo7zaG0n5lZf2T1yFVovlcuaeBvu992OZBxGcO5n3Oumuse
         1p3a8EuY9ySfTOpX4IVT6h0FyGjZu91k3/LcAlu/L6LW87I9pFFiRmlbgqBZ0TSLnbwD
         xruiYzN6HLT6FRDI6hHtBPpFItJCiA89++MhzK8z+sMI5vdKhTWUHHfR9QcXiXJzsMci
         FA0SMJIMsM8I++rsZiRjIeveHM/yCnI1s4DjiOqkZchRPnaXClyLcir5sgJeSMoi4dBx
         3wKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V7rvTuqNA94DrffJJmk/435Bqkq35Kd9IVvvcWlCh3Y=;
        b=txdZ12gfbSJuL/6Q0+ApxyuwpNDQEfCQeeE+iAIpRP1Dj2NpStH998LHRjflubUk6W
         52RfTHijqHwFJ9Va9/M20v+WktqM73tIQphDV4QvWlYYbg3w3vr0Q90szuKHit23+SOX
         C7wFvzLeX++PgEO1fepjtjQ6fd5pFhGIGaSzNyZe41zQVDN1k9FBSaBvPNYPjaIRMFbV
         mh7xboxtefJtFbZvuKBKO7eIUaqv3fJwzrtEcVcRcVc59aslceHtGG8hIbZWmHIAzP9f
         x66SMISe6kxba94ZC3+YMl9wz1CbWIaB6NAiU5fOpJRHhZNswTLXgcTu1/edZEvxo5wm
         ZAdw==
X-Gm-Message-State: APt69E1sMGH2VR/G1cw7DEbU6vZyS2Igammwg/uayWl8kYHZcQcTCyjG
        KioIthfS0ICu7/obKHOUO9LcAw==
X-Google-Smtp-Source: AAOMgpfAlyx0e/YFJpoWZzU9oVQJYok6V9L3DtNGtbRrVvuA1M8IENJVqGqueIgoaJZg77B/gOGN+g==
X-Received: by 2002:a63:bd51:: with SMTP id d17-v6mr20973478pgp.42.1531175995310;
        Mon, 09 Jul 2018 15:39:55 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id r16-v6sm30143804pfe.173.2018.07.09.15.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 15:39:54 -0700 (PDT)
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
Subject: [PATCH v6 10/17] media: staging/imx: of: Remove recursive graph walk
Date:   Mon,  9 Jul 2018 15:39:10 -0700
Message-Id: <1531175957-1973-11-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After moving to subdev notifiers, it's no longer necessary to recursively
walk the OF graph, because the subdev notifiers will discover and add
devices from the graph for us.

So the recursive of_parse_subdev() function is gone, replaced with
of_add_csi() which adds only the CSI port fwnodes to the imx-media
root notifier.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-media-of.c | 106 +++----------------------------
 1 file changed, 8 insertions(+), 98 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-of.c b/drivers/staging/media/imx/imx-media-of.c
index acde372..1c91754 100644
--- a/drivers/staging/media/imx/imx-media-of.c
+++ b/drivers/staging/media/imx/imx-media-of.c
@@ -20,74 +20,19 @@
 #include <video/imx-ipu-v3.h>
 #include "imx-media.h"
 
-static int of_get_port_count(const struct device_node *np)
+static int of_add_csi(struct imx_media_dev *imxmd, struct device_node *csi_np)
 {
-	struct device_node *ports, *child;
-	int num = 0;
-
-	/* check if this node has a ports subnode */
-	ports = of_get_child_by_name(np, "ports");
-	if (ports)
-		np = ports;
-
-	for_each_child_of_node(np, child)
-		if (of_node_cmp(child->name, "port") == 0)
-			num++;
-
-	of_node_put(ports);
-	return num;
-}
-
-/*
- * find the remote device node given local endpoint node
- */
-static bool of_get_remote(struct device_node *epnode,
-			  struct device_node **remote_node)
-{
-	struct device_node *rp, *rpp;
-	struct device_node *remote;
-	bool is_csi_port;
-
-	rp = of_graph_get_remote_port(epnode);
-	rpp = of_graph_get_remote_port_parent(epnode);
-
-	if (of_device_is_compatible(rpp, "fsl,imx6q-ipu")) {
-		/* the remote is one of the CSI ports */
-		remote = rp;
-		of_node_put(rpp);
-		is_csi_port = true;
-	} else {
-		remote = rpp;
-		of_node_put(rp);
-		is_csi_port = false;
-	}
-
-	if (!of_device_is_available(remote)) {
-		of_node_put(remote);
-		*remote_node = NULL;
-	} else {
-		*remote_node = remote;
-	}
-
-	return is_csi_port;
-}
-
-static int
-of_parse_subdev(struct imx_media_dev *imxmd, struct device_node *sd_np,
-		bool is_csi_port)
-{
-	int i, num_ports, ret;
+	int ret;
 
-	if (!of_device_is_available(sd_np)) {
+	if (!of_device_is_available(csi_np)) {
 		dev_dbg(imxmd->md.dev, "%s: %s not enabled\n", __func__,
-			sd_np->name);
+			csi_np->name);
 		/* unavailable is not an error */
 		return 0;
 	}
 
-	/* register this subdev with async notifier */
-	ret = imx_media_add_async_subdev(imxmd, of_fwnode_handle(sd_np),
-					 NULL);
+	/* add CSI fwnode to async notifier */
+	ret = imx_media_add_async_subdev(imxmd, of_fwnode_handle(csi_np), NULL);
 	if (ret) {
 		if (ret == -EEXIST) {
 			/* already added, everything is fine */
@@ -98,42 +43,7 @@ of_parse_subdev(struct imx_media_dev *imxmd, struct device_node *sd_np,
 		return ret;
 	}
 
-	/*
-	 * the ipu-csi has one sink port. The source pads are not
-	 * represented in the device tree by port nodes, but are
-	 * described by the internal pads and links later.
-	 */
-	num_ports = is_csi_port ? 1 : of_get_port_count(sd_np);
-
-	for (i = 0; i < num_ports; i++) {
-		struct device_node *epnode = NULL, *port, *remote_np;
-
-		port = is_csi_port ? sd_np : of_graph_get_port_by_id(sd_np, i);
-		if (!port)
-			continue;
-
-		for_each_child_of_node(port, epnode) {
-			bool remote_is_csi;
-
-			remote_is_csi = of_get_remote(epnode, &remote_np);
-			if (!remote_np)
-				continue;
-
-			ret = of_parse_subdev(imxmd, remote_np, remote_is_csi);
-			of_node_put(remote_np);
-			if (ret)
-				break;
-		}
-
-		if (port != sd_np)
-			of_node_put(port);
-		if (ret) {
-			of_node_put(epnode);
-			break;
-		}
-	}
-
-	return ret;
+	return 0;
 }
 
 int imx_media_add_of_subdevs(struct imx_media_dev *imxmd,
@@ -147,7 +57,7 @@ int imx_media_add_of_subdevs(struct imx_media_dev *imxmd,
 		if (!csi_np)
 			break;
 
-		ret = of_parse_subdev(imxmd, csi_np, true);
+		ret = of_add_csi(imxmd, csi_np);
 		of_node_put(csi_np);
 		if (ret)
 			return ret;
-- 
2.7.4

