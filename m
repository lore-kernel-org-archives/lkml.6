Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 91947C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529DD208E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529DD208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936213AbeFNQMB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:12:01 -0400
Received: from osg.samsung.com ([64.30.133.232]:57072 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935116AbeFNQJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:09:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id EDA2320F85;
        Thu, 14 Jun 2018 09:09:40 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zZ0G9hPcawCQ; Thu, 14 Jun 2018 09:09:40 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.114.220.dynamic.adsl.gvt.net.br [177.41.114.220])
        by osg.samsung.com (Postfix) with ESMTPSA id B4EC320EB8;
        Thu, 14 Jun 2018 09:09:16 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fTUoE-0005Tf-FD; Thu, 14 Jun 2018 13:09:14 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v3 20/27] MAINTAINERS: fix location of DT npcm files
Date:   Thu, 14 Jun 2018 13:09:05 -0300
Message-Id: <69aaf98a253e93d02763c55e2d8b4472bc090bc1.1528990947.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
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

