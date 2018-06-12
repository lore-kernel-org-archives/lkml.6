Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B4EAAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B0A208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gU9SBllu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TIMG71/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B0A208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934015AbeFLRJb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:09:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59050 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933439AbeFLRJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:09:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7791C608FD; Tue, 12 Jun 2018 17:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528823365;
        bh=NDFYvbW8toCWzVNVAeBpuTP06cPSwjqGcKg1xfgo5Ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gU9SBlluAwk57Xb2RfWH2rfOUiFwaHa9xeUw/alZ2mCIyZWYOXaxWdFrGQeDQ8Tby
         U9cdCXdD/7GWFqPncRe26v15G39gx+rf6PP6+yS2kyTPb3rFVAJ3A2trlITvV4ptIq
         xZl9upFZUktuJ+SjB1yrFeApG501hHyh80Pj74m0=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kramasub@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C96DA606DB;
        Tue, 12 Jun 2018 17:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528823364;
        bh=NDFYvbW8toCWzVNVAeBpuTP06cPSwjqGcKg1xfgo5Ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TIMG71/jJsccseHmZSoOI7PMoT2MgqFWsQD5CZrSZ011F80qjxRHhkhh0QsNG7qeH
         wil9EGA+nt3fvZeKzTsiLkwmdhCgdUnXu0w8zgaWedTkptEoLbcCBBuHZcx1ug60vL
         RaFhICgSFpiH2jdLXodF7p25Lc9HX5kOzj/DxV0w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C96DA606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kramasub@codeaurora.org
From:   Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        evgreen@chromium.org, acourbot@chromium.org, swboyd@chromium.org,
        dianders@chromium.org
Subject: [PATCH v7 2/4] MAINTAINERS: Add Qualcomm Generic Interface I2C driver maintainer
Date:   Tue, 12 Jun 2018 11:09:06 -0600
Message-Id: <1528823348-30532-3-git-send-email-kramasub@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org>
References: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Alok Chauhan and myself as maintainers for Qualcomm GENI I2C master
controller driver.

Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 868be4a..08a6b6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11814,6 +11814,14 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/qualcomm/emac/
 
+QUALCOMM GENERIC INTERFACE I2C DRIVER
+M:	Alok Chauhan <alokc@codeaurora.org>
+M:	Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
+L:	linux-i2c@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Supported
+F:	drivers/i2c/busses/i2c-qcom-geni.c
+
 QUALCOMM HEXAGON ARCHITECTURE
 M:	Richard Kuo <rkuo@codeaurora.org>
 L:	linux-hexagon@vger.kernel.org
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

