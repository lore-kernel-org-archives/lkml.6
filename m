Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1A2C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022BF21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690452;
	bh=CA+QPLjO++aOy0VzhAoNLdz9etZq3KqzIzVQv1s4p4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PXFlfx9bsEy4aGhowbMpWlJg5b24w7aQIC2fIdWp5akzHVFDF5ISj0mt4zYk57gpP
	 l87a5a2+Fpv/Hi0q/Va34ccQX6wS2g/wCAFYNDzivlPOuBQPt4N8HRQ8wTutL2TahC
	 SYXhxfcieO9X8bfLqQWsvfMngggghNkPRPL5CuI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfA1Pra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:47:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbfA1PrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:47:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC0062175B;
        Mon, 28 Jan 2019 15:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690445;
        bh=CA+QPLjO++aOy0VzhAoNLdz9etZq3KqzIzVQv1s4p4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMCzjXQ2BSPBcDe8vty3SV1yS220+FFfZ4PghUhQyuIrDuL9w7GXwnM8hnQ/OdbXV
         8HEROUm32jiY9jZWddKwSRH7BuG+S3h8qQveaa40ZmPVt5lBeJaeX4OnvqTddANJk6
         REgrZhWYEwPmpL2jNHZx0dAeLllP23T/T0qhWfmg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 090/304] i2c: sh_mobile: add support for r8a77990 (R-Car E3)
Date:   Mon, 28 Jan 2019 10:40:07 -0500
Message-Id: <20190128154341.47195-90-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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
index a7a7a9c3bc7c..28db6b59c4ca 100644
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

