Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71E0ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2A52087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uu2JDqPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2A52087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbeGMRqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:46:01 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35323 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731958AbeGMRqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:46:00 -0400
Received: by mail-pf0-f193.google.com with SMTP id q7-v6so21904204pff.2;
        Fri, 13 Jul 2018 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/k2QY2JFM9/KcDJVDIg38YKX+fbFvcJgf25kHKfv3pg=;
        b=uu2JDqPGRC+XsVs25jsA/SyFa+VZ3Dk0CdGgyBf7/tdWdXakXtAaK4MyFBbDK3SIsz
         Dfz7UPrYrKYAxd3q92iOy3xUJzeNKylJbfYX/AdZlp2z2Hjb1MKsnag/xsfTyjo018RC
         CbZWTVa5T50y+xJAbRxim1drt7QiW3pIGSIZcPjXEML3ajWCfCLOUSa8em8lySBSPAe9
         Lxn9RXRA3oCCHshUSd4EDO7PZTCoM3Gq1cfsPtL9pwXXXAVlJ0z8KCQYNgKE8I5VCTsT
         2ZPefzzTVm00uz8macsI++4lfKl4ium7AWgTKSMtbhMm1Mg3yRZf3Fo6ceNhdoZasG0v
         pUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/k2QY2JFM9/KcDJVDIg38YKX+fbFvcJgf25kHKfv3pg=;
        b=LS0csi35uBN8YeZsWpPOsNmBml0dWFtaj2IOE/p0SKaWTEpkr+AGgJruiNzVjHbeg5
         1rMqtJ8Q5z+Pjo0LzIPPLqp787QKpiFpEOQCQZEnSvyV/S4AkFNAxaDkcessysLGijT8
         wEz652IKn83gUUN17WvtPQ3hc9nN3ZeyC8CRS7LeZeorNybdvIUcxquLYZv2tILXhgXO
         GAmZj5h5NY1FiRC3I+FN/GhY66yd85lOKr24flKfxtxYQce/q/g8Yd7/FMxBfg6PkYqf
         /57HoToWJuW/QnOgty60svz/oGWTFp3AosA2jV9Nh5ZbKl3LL+BnqWwZEMP9hmsLPvQ0
         rUGQ==
X-Gm-Message-State: AOUpUlGygYc8ajfppd84AFfbOc/yRlbTzpb7gu21jt+RzMQsMd5XElJW
        QYoXNeVV6xfAWim4h90Tx64=
X-Google-Smtp-Source: AAOMgpfDjVQlBbBXzFVZppX9SJ7/5JztwduNgmG2jlPkzFoceV7gIe0hQAOlRbQepx0HfR79vE03UA==
X-Received: by 2002:a65:608c:: with SMTP id t12-v6mr7041366pgu.159.1531503026051;
        Fri, 13 Jul 2018 10:30:26 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id s12-v6sm38371547pfm.41.2018.07.13.10.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 10:30:25 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>, cphealy@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 2/2] ARM: dts: imx51-zii-scu3-esb: Fix RAVE SP watchdog compatible string
Date:   Fri, 13 Jul 2018 10:30:05 -0700
Message-Id: <20180713173005.19552-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180713173005.19552-1-andrew.smirnov@gmail.com>
References: <20180713173005.19552-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like I made a nasty typo in the original patch which resulted
in missing watchdog device. Fix it.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: cphealy@gmail.com
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
index 0bb42c00d72b..dffb761a1cc8 100644
--- a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
+++ b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
@@ -325,7 +325,7 @@
 		#size-cells = <1>;		
 
 		watchdog {
-			compatible = "zii,rave-sp-watchodg-legacy";
+			compatible = "zii,rave-sp-watchdog-legacy";
 		};
 
 		eeprom@a4 {
-- 
2.17.1

