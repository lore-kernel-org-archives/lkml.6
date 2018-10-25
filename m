Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9132C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F29A2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iulTyQKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F29A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeJZHXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:23:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57078 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeJZHXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pM+Xcn+4adDcJHmGzJdonU1ttaL8FLOJt7+q8mcNbsE=; b=iulTyQKJt3k4ZbqC+ovpvwcvlz
        Da+rpamHZwB89zgrayevlE6d3g/33rP7SUy1P9hZCHCACHgFxMLYhglKcxWlPH6xbPxu21sd3xkNT
        uWcdxsHTx+rAP/4WXbdyoCDZCSkE5ntXqn7jBXeldG7oaZKQhSLYgr7UF/NnENr9BgY3zusRPXmwH
        HJVBSxp76hXFrf+MtGeNfvrYu79TF7TGqlBPkERn7n/6/cVJpIE+CcctEJWPR4Y/mVl/3yKJXd/ja
        tYdgzjCcBA7G4EwDfSyT00joZfeiLH8Wfc6/S7nUTmdlMYLDARq+KclstUDPBAFXDYzCAUbl44+Q7
        K0A6V0Eg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFoQV-00082O-UN; Thu, 25 Oct 2018 22:48:28 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] regulator: bd71837: add <linux/of.h> to fix build errors
Message-ID: <cf89bc2f-f7c0-0ed6-38d8-0c47a05ed706@infradead.org>
Date:   Thu, 25 Oct 2018 15:48:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build error due to missing header file:

drivers/regulator/bd71837-regulator.c:242:3: error: implicit declaration of function 'of_match_ptr' [-Werror=implicit-function-declaration]

Fixes: ba08799e90b5 ("regulator: bd71837: BD71837 PMIC regulator driver")

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd71837-regulator.c |    1 +
 1 file changed, 1 insertion(+)

--- lnx-419.orig/drivers/regulator/bd71837-regulator.c
+++ lnx-419/drivers/regulator/bd71837-regulator.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/rohm-bd718x7.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>


