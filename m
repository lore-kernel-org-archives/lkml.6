Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D07C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF0221906
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497791;
	bh=MfioDp7ea0Bw5rmAFwRpeWGDO3YowNu5XCZzVCnm1yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mbJRvh7MvJ5AWWQER8O3Jc4HGWbsn87W8WNKBR2IfyKVH9VwhPGhj2wrVJYJ0XdFg
	 SLiWbxMR56htpRDD6kBCKlY4yuHf1ksT3eBLuv359qpzV8xRvCMOwsVBkCK5nPMN62
	 Q4pFsLWizLVcornU7wbtxJxXx8xiwINb2sGztaOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbfBRNtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:49:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732079AbfBRNtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:49:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6C2E21901;
        Mon, 18 Feb 2019 13:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497785;
        bh=MfioDp7ea0Bw5rmAFwRpeWGDO3YowNu5XCZzVCnm1yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkueuUQOHevueema28lJin8jDzWtLQSnaqUwTynQkSCcSBRTjyd2FbrVILWK5gJIJ
         qBCxSI/qKugyIC/babIIkkX3xTjTBd0RPbSS+PNHarIA1X0g+HklzWcJRMg/BVsrNJ
         UDv0YgoUWhX2r7txmrkpxWO1rVKPzycfsMPXEKx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Bunk <bunk@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 01/85] dt-bindings: eeprom: at24: add "atmel,24c2048" compatible string
Date:   Mon, 18 Feb 2019 14:42:27 +0100
Message-Id: <20190218133459.917563861@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6c0c5dc33ff42af49243e94842d0ebdb153189ea ]

Add new compatible to the device tree bindings.

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index aededdbc262b..f9a7c984274c 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -27,6 +27,7 @@ Required properties:
                 "atmel,24c256",
                 "atmel,24c512",
                 "atmel,24c1024",
+                "atmel,24c2048",
 
                 If <manufacturer> is not "atmel", then a fallback must be used
                 with the same <model> and "atmel" as manufacturer.
-- 
2.19.1



