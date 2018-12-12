Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5B1C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAD520849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iCwqRPoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DAD520849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeLLVxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:53:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52442 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbeLLVxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:53:51 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBCLgncQ013807
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:53:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=UCF37w1IQAbjhdvxGw99Y/GiQMjqbkJa5cRUu3Akncs=;
 b=iCwqRPoUH/CTJHI3n4vR5Rzh8Jt0BGRu/UjO3ujQq2cO32/prjW1n5QYBSrFQ4Xd8H29
 BNg9ZSpiVQ1yQHDZAb9OMH68ldsOLWYnBJbvDh2i6yRdpvIsLwykGYpxpGIJGH8qVGvX
 1u4qQEn2R07I352QbWhPHnSyTmRKnKLP42s= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pb8kcrequ-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:53:50 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 12 Dec 2018 13:53:13 -0800
Received: by devvm24792.prn1.facebook.com (Postfix, from userid 150176)
        id 56AC092A7340; Wed, 12 Dec 2018 13:53:07 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Tao Ren <taoren@fb.com>
Smtp-Origin-Hostname: devvm24792.prn1.facebook.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
CC:     Tao Ren <taoren@fb.com>
Smtp-Origin-Cluster: prn1c35
Subject: [PATCH] gpio: aspeed: remove duplicated statement
Date:   Wed, 12 Dec 2018 13:53:05 -0800
Message-ID: <20181212215305.3852170-1-taoren@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated assignment statement from aspeed_gpio_probe() function.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 drivers/gpio/gpio-aspeed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 2342e154029b..854bce4fb9e7 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1185,7 +1185,6 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 
 	gpio->chip.parent = &pdev->dev;
 	gpio->chip.ngpio = gpio->config->nr_gpios;
-	gpio->chip.parent = &pdev->dev;
 	gpio->chip.direction_input = aspeed_gpio_dir_in;
 	gpio->chip.direction_output = aspeed_gpio_dir_out;
 	gpio->chip.get_direction = aspeed_gpio_get_direction;
-- 
2.17.1

