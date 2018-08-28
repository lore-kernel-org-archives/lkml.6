Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FADC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D36208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D36208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeH1Fnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:43:33 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45858 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeH1FmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:18 -0400
Received: by mail-oi0-f68.google.com with SMTP id t68-v6so1692247oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hErohiAO5ZceD9Qr7QOcf9gK+QVsa4hua5KEImGBF6Y=;
        b=iekDPeJDVyEPIakeg86FRy2Yb7rrT/4klEeL9HR9KeuUAE99+GXlK4J2IDb7za/l2Q
         if8hu5t5aT5I4wrfet5WlMGsUPexd0CdH//sIxDjOwc0cVyjZWIC5oyCngE7xRTFdKNc
         xywyS4G9rkvuq+iuIMJby5oeCxMW49oBIDETq1GM3oxBpXf+4M4sgauz1MokopFnzXyO
         BGbOYJFT8QvEEH+I5tB1hDfy+eBNVQeMMz5szIkAvpLeRMVeprhUvYqjIBrZAs7rIXBQ
         RAJygr5w8gz0+LPMY1QFgtVhYf6odxClrvRySOXJ1oBhhwI1rCkxIO11VzTYVlI0qw/S
         eOXw==
X-Gm-Message-State: APzg51ACmwCORWLukl/uNQVjNd5ATpiTyAeywk2aaGajhcSI7WLF9LXV
        uGykGo5Wb4lKbXCcumyYJCm36i0=
X-Google-Smtp-Source: ANB0VdaAwpy1mAsQPrI5CfGPtThMeJXskYO4vDXLY+nVXmEgZjn3dGdtByUUE090qMhLtOpdwL1JTQ==
X-Received: by 2002:a54:448b:: with SMTP id v11-v6mr1168018oiv.208.1535421183532;
        Mon, 27 Aug 2018 18:53:03 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:53:02 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH] bus: fsl-mc: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:11 -0500
Message-Id: <20180828015252.28511-10-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 5d8266c6571f..85a567c987cc 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -693,8 +693,8 @@ static int parse_mc_ranges(struct device *dev,
 	*ranges_start = of_get_property(mc_node, "ranges", &ranges_len);
 	if (!(*ranges_start) || !ranges_len) {
 		dev_warn(dev,
-			 "missing or empty ranges property for device tree node '%s'\n",
-			 mc_node->name);
+			 "missing or empty ranges property for device tree node '%pOFn'\n",
+			 mc_node);
 		return 0;
 	}
 
@@ -717,7 +717,7 @@ static int parse_mc_ranges(struct device *dev,
 
 	tuple_len = range_tuple_cell_count * sizeof(__be32);
 	if (ranges_len % tuple_len != 0) {
-		dev_err(dev, "malformed ranges property '%s'\n", mc_node->name);
+		dev_err(dev, "malformed ranges property '%pOFn'\n", mc_node);
 		return -EINVAL;
 	}
 
-- 
2.17.1

