Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEC2C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4BD217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497499;
	bh=eewDB24sR8m/QWDDgNdeZrfP25pjznGywirO2QZScuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0fA1o3bQCnbxEgexNEcTztp1PB7olGUU3eZu15xoGEV76TESwKQKmafeYZgNjnz0M
	 Qcq8w8x4HZR+n1DlDGY+Lc/z0Gf5GfMlRnfat/nu3lwMtTD40DhlJ4O7n5Sc6ZsK+9
	 I54XFxv9gm9aXtHtam32f3kksqBNMu0xg+EoXx08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfBRNo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:44:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729609AbfBRNo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:44:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 496D5217F5;
        Mon, 18 Feb 2019 13:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497496;
        bh=eewDB24sR8m/QWDDgNdeZrfP25pjznGywirO2QZScuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWpYf6tqUsg/yLBjKxwFYK2dZzYhq7oGy2hTVFKPpVxBDpOxvA+UtUvDBYtV+cZDt
         VrqzsYJWWSfC3CNDaCBT48xrkGzXD81EzK1OZ0rGfpY9yVclHdXQSFsBfzEPY81O/Z
         UVixLaBvp6f3Z811n3EB/LrKyx1D9eKUvdinKGlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Bunk <bunk@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 01/92] dt-bindings: eeprom: at24: add "atmel,24c2048" compatible string
Date:   Mon, 18 Feb 2019 14:42:04 +0100
Message-Id: <20190218133454.792283446@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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



