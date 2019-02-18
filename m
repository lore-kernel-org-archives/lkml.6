Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414A3C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071F721901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498257;
	bh=SJ2agaOkS/T0FKNypWBMu1WXC11Cvpctte+x3VBYx4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FBDBQK7blGl6nY9vLkdCxGBP/Z4oOfEguVgb54LAXW/LBqkbIJ+aHSorPQHN+bdjO
	 qpYnpSiVoldQ1FRs1oXmLCSksvFAc1PjUi8R9qxs4Nwmn+7M671Z3hpec0k8NxlYs3
	 nYkcXett2ftwYlRuHd3QaU+6qrgiaqjq2yWNnffY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbfBRN5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:57:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733308AbfBRN5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:57:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49AE121901;
        Mon, 18 Feb 2019 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498251;
        bh=SJ2agaOkS/T0FKNypWBMu1WXC11Cvpctte+x3VBYx4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PN/zvm+vTD3bmMBLBLUhMXIWvGneSdwqgInvbNMRv/KqmoJ5xtJXC+ynmx9jj50P1
         ezRnhdKzWRBaztMmQwqgWnvNjuJNrs8HURGmPwcPPnpqanVvscVi8sSwgF61IHFu7K
         zByTvQtuqxrvVoP2Nya0Gqo+zt3uP/iH1umqB03s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Bunk <bunk@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 01/58] dt-bindings: eeprom: at24: add "atmel,24c2048" compatible string
Date:   Mon, 18 Feb 2019 14:43:22 +0100
Message-Id: <20190218133508.681919652@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 6c0c5dc33ff42af49243e94842d0ebdb153189ea upstream.

Add new compatible to the device tree bindings.

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/eeprom/eeprom.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
index 735bc94444bb..4dcce8ee5cee 100644
--- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
@@ -6,7 +6,8 @@ Required properties:
 
 	"atmel,24c00", "atmel,24c01", "atmel,24c02", "atmel,24c04",
 	"atmel,24c08", "atmel,24c16", "atmel,24c32", "atmel,24c64",
-	"atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024"
+	"atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024",
+	"atmel,24c2048"
 
 	"catalyst,24c32"
 
@@ -17,7 +18,7 @@ Required properties:
 	 If there is no specific driver for <manufacturer>, a generic
 	 driver based on <type> is selected. Possible types are:
 	 "24c00", "24c01", "24c02", "24c04", "24c08", "24c16", "24c32", "24c64",
-	 "24c128", "24c256", "24c512", "24c1024", "spd"
+	 "24c128", "24c256", "24c512", "24c1024", "24c2048", "spd"
 
   - reg : the I2C address of the EEPROM
 
-- 
2.19.1



