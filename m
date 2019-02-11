Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693E5C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B49B222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896099;
	bh=98r8Q1nvq3BLYGzhi5v+vEipbgQpTigxPcRg4C2HoI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UGf1uUGY1tHAoQe+yKgLs68JxODQsfja/XqGfEH8MVckSM5X565Uxu92D3VBaQpe5
	 wTRD77QS4UM+RrErKn1t4j6XOJV6y0ET7/IZckwJNRBf2r+6WLXLZym5XpZPeU321a
	 T1ue18YKvGl0muuNwmb4YBiHd6IdP7Fx2hhH18Q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbfBKOlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:41:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732258AbfBKOld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:41:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71E26222A2;
        Mon, 11 Feb 2019 14:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896093;
        bh=98r8Q1nvq3BLYGzhi5v+vEipbgQpTigxPcRg4C2HoI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qkwTAwTOyX3vZ82+8h5XDC11YIkUpgpomJeCAdZtP65My3j2zjGor1C4J2LvSuybl
         A4By2w9SHu+Lu/gn8yCPKE51WqbpBFZhvCApLyx+CT6JJu2k45VGm0kCuaYj9b7lTH
         W9iaezbMNpsmu8FE3iufb8FE+nFFfEQUdHxrJTYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 071/313] i2c: sh_mobile: add support for r8a77990 (R-Car E3)
Date:   Mon, 11 Feb 2019 15:15:51 +0100
Message-Id: <20190211141858.602150911@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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



