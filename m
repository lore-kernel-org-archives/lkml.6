Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB308C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF99A208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF99A208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966144AbeFOQbN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:31:13 -0400
Received: from osg.samsung.com ([64.30.133.232]:60991 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966002AbeFOQbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:31:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 2FA1122BE9;
        Fri, 15 Jun 2018 09:31:10 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vmL2Ab8zeX_N; Fri, 15 Jun 2018 09:31:09 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.114.220.dynamic.adsl.gvt.net.br [177.41.114.220])
        by osg.samsung.com (Postfix) with ESMTPSA id AF5EB22B55;
        Fri, 15 Jun 2018 09:30:58 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fTrcm-00084a-IP; Fri, 15 Jun 2018 13:30:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v4 20/26] MAINTAINERS: fix location of DT npcm files
Date:   Fri, 15 Jun 2018 13:30:48 -0300
Message-Id: <e2dd817624888a42984c07722f47a9ab1a0f01e9.1529079120.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The specified locations are not right. Fix the wildcard logic
to point to the correct directories.

Without that, get-maintainer won't get things right:

	$ ./scripts/get_maintainer.pl --no-git-fallback --no-r --no-n --no-l -f Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm750-smp
	robh+dt@kernel.org (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
	mark.rutland@arm.com (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)

After the patch, it will properly point to NPCM arch maintainers:
	$ ./scripts/get_maintainer.pl --no-git-fallback --no-r --no-n --no-l -f Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm750-smp
	avifishman70@gmail.com (supporter:ARM/NUVOTON NPCM ARCHITECTURE)
	tmaimon77@gmail.com (supporter:ARM/NUVOTON NPCM ARCHITECTURE)
	robh+dt@kernel.org (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
	mark.rutland@arm.com (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)

Cc: Avi Fishman <avifishman70@gmail.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>
Cc: Patrick Venture <venture@google.com>
Cc: Nancy Yuen <yuenn@google.com>
Cc: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43eee2fb8798..783ce44b3e7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1732,7 +1732,8 @@ F:	arch/arm/mach-npcm/
 F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
 F:	drivers/*/*npcm*
-F:	Documentation/*/*npcm*
+F:	Documentation/devicetree/bindings/*/*npcm*
+F:	Documentation/devicetree/bindings/*/*/*npcm*
 
 ARM/NUVOTON W90X900 ARM ARCHITECTURE
 M:	Wan ZongShun <mcuos.com@gmail.com>
-- 
2.17.1

