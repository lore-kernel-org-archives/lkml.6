Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E6DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2472E21917
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691394;
	bh=2o5CzXbiV2lK/X86csF8RkTU8gIhseoVlQZwA6P7uc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hxrzBW5oWTubE3DJE3zefqKOsFo/ENpfgBl+OfaIfVKWuq0tm1IPTSk4jLHnQC6nv
	 xNgBdgwsD5kxnMhXSBN0BKvDLmsO5NWdhoe0woMBrY0pBg6ySQvDguvew63d5mXPvd
	 vzcWGI3xl+CcW7PRRE359M6C/TR7bHF1F9BQpSO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbfA1QDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:03:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbfA1QDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:03:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B6582082E;
        Mon, 28 Jan 2019 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691386;
        bh=2o5CzXbiV2lK/X86csF8RkTU8gIhseoVlQZwA6P7uc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2sw2+wM/rWN9zFCRoTpe/EQW4kPOyHD+uDMszEb0wIpYo+kXpmSowQFEqb098odyY
         OwFCUh2prMAl3tEyluwpIEAGOsF3iFMxGZQRcEi1NeFhqqlYvOjcc7ERPpm6ZGtdF+
         DRN3HDzhnxIr51iF8JnUUb72/aCD5F8KGQqtu0Ec=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 076/258] i2c: sh_mobile: add support for r8a77990 (R-Car E3)
Date:   Mon, 28 Jan 2019 10:56:22 -0500
Message-Id: <20190128155924.51521-76-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Horman <horms+renesas@verge.net.au>

[ Upstream commit 5eb316e636eb298c204f5b368526d4480b63c0ba ]

Add support for the IIC code for the r8a77990 (R-Car E3).

It is not considered compatible with existing fallback bindings
due to the documented absence of automatic transmission registers.

These registers are currently not used by the driver and
thus the provides the same behaviour for "renesas,iic-r8a77990" and
"renesas,rcar-gen3-iic". The point of declaring incompatibility is
to allow for automatic transmission register support to be added to
"renesas,iic-r8a77990" and "renesas,rcar-gen3-iic" in future.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 818cab14e87c..b3ed14f4eae9 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -808,6 +808,7 @@ static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 	{ .compatible = "renesas,rcar-gen2-iic", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7795", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,rcar-gen3-iic", .data = &fast_clock_dt_config },
+	{ .compatible = "renesas,iic-r8a77990", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-sh73a0", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,rmobile-iic", .data = &default_dt_config },
 	{},
-- 
2.19.1

