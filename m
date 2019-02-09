Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361ACC169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 03:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CE3217D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 03:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XZFRcv2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBIDQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 22:16:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfBIDQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 22:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+M/KIA7oHKJASpClTHCCPaCY93Yj9tFfEld3hLFl45M=; b=XZFRcv2uBomMR5QXZXExD0xIF
        PtzShLOTksuyuQ9wyvFYwu6YUnldn3WYhkLtaU+qMnaNl5QsnLiIvFf+BiBCkIsuG5iqA7yFQ4exg
        qpyoVg3x1/U1XYrblDRGCE+eqUwTnRYdy5LHsjepU+NKNUNCjRCx4ss1CBvcgf8MrbQ6bwfYZOCrc
        zbs9Hl+V39XSHFjzprUEX0fL+TXof6rrciUOb5fCfnDlj/s3cKL364l+xhmEhRfolUl6Lb4QaUeg8
        qkirvesv/FrAcgUz9A95JPk583UXE+UC+WcwSKryx/JvcNjY46WfDp1P3vlFOndOLJSvqERe0NyP8
        gNlmDwQYQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gsJ7y-0004mZ-Tx; Sat, 09 Feb 2019 03:16:27 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -mmotm/-next] pinctrl: fix pxa2xx.c build warnings
Message-ID: <0024542e-cba9-8f13-6c18-32d0050a6007@infradead.org>
Date:   Fri, 8 Feb 2019 19:16:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Add #include of <linux/pinctrl/machine.h> to fix build
warnings in pinctrl-pxa2xx.c.  Fixes these warnings:

In file included from ../drivers/pinctrl/pxa/pinctrl-pxa2xx.c:24:0:
../drivers/pinctrl/pxa/../pinctrl-utils.h:36:8: warning: ‘enum pinctrl_map_type’ declared inside parameter list [enabled by default]
   enum pinctrl_map_type type);
        ^
../drivers/pinctrl/pxa/../pinctrl-utils.h:36:8: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org
---
Seen in linux-next and mmotm.

 drivers/pinctrl/pxa/pinctrl-pxa2xx.c |    1 +
 1 file changed, 1 insertion(+)

--- mmotm-2019-0208-1633.orig/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ mmotm-2019-0208-1633/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/module.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinmux.h>


