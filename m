Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D386EC63685
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966962086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966962086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeINBjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 21:39:39 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:44189 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeINBji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 21:39:38 -0400
Received: by mail-oi0-f54.google.com with SMTP id l82-v6so10688775oih.11;
        Thu, 13 Sep 2018 13:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CIGZC6tKjvF57c8/im+HJDPdF2dQ6tBvjTQvWqmnb8A=;
        b=POcI0YhK1WKSeey40XKUWrT6w3xIIUJEViyWKVXHkUJMAsNtjKXArbo/+1qfUV7Orm
         JiyK3e0s61UkcBXbPFLZKBTufhZG/s8kBJ0lcN9OmDprqIm0od5jFZrvbq3CdEcnbjIR
         MYkvE5OaSZl2iCaRTPzO0bdOgzaNP5vkqt6qg3Y76MvKs+onifU5D3viE/jS83IWWG4Y
         GxaU5V8NpnhOG/pG6hfNH6SLgTVB/+LwKAdt6mUfOzm3udx7rjxyBuQxn3nQTJHjEQhg
         xn597pE1Z2HlicJojXBHEh6hKxkU/9bj141Sy8e8RPDELsJDDub3oS9wRvWJbABvZX1v
         +9mA==
X-Gm-Message-State: APzg51CCmCo0rxU+8cgxjRn8jMsczTBoel4hEYbYLbdgIa+YfAQYhG05
        CJZLJ0m6C+0fl+CDD7SWtZ5N5xY=
X-Google-Smtp-Source: ANB0VdZcf9sIokw42XfsvwlMACIqKWZQjSLq3d/wjWZnKTd7UCbwl5YtH7qGSj4NSbEgQnsQEaWCNg==
X-Received: by 2002:a54:4f94:: with SMTP id g20-v6mr7155799oiy.130.1536870512396;
        Thu, 13 Sep 2018 13:28:32 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h34-v6sm756745otb.71.2018.09.13.13.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 13:28:30 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 2/3] scripts/dtc: Add yamltree.c to dtc sources
Date:   Thu, 13 Sep 2018 15:28:27 -0500
Message-Id: <20180913202828.15372-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180913202828.15372-1-robh@kernel.org>
References: <20180913202828.15372-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtc has a new source file, yamltree.c, that needs to be copied when
syncing dtc sources.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/dtc/update-dtc-source.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/update-dtc-source.sh b/scripts/dtc/update-dtc-source.sh
index 1a009fd195d0..7dd29a0362b8 100755
--- a/scripts/dtc/update-dtc-source.sh
+++ b/scripts/dtc/update-dtc-source.sh
@@ -32,7 +32,7 @@ DTC_UPSTREAM_PATH=`pwd`/../dtc
 DTC_LINUX_PATH=`pwd`/scripts/dtc
 
 DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c \
-		srcpos.h treesource.c util.c util.h version_gen.h Makefile.dtc \
+		srcpos.h treesource.c util.c util.h version_gen.h yamltree.c Makefile.dtc \
 		dtc-lexer.l dtc-parser.y"
 LIBFDT_SOURCE="Makefile.libfdt fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
 		fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
-- 
2.17.1

