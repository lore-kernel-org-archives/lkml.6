Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07BBC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8985221855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895402;
	bh=0D5LEYDQ58Y3XDiTLc/gnNLCc0pm1eSiDcenF0Gs8ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QYa0DLBSG1FIEUht/UH2VOVAkbO5h13krkYcRGgaOjc8HhVinbzVMCkPGKrVQtL5j
	 mHLBRDHxNl7KgEVPw40fZcopY+iU0vZyJA37BhxANnA1+96Sa4pxp3fevw6K6uX8Ir
	 HUE6nkFuMFq+e11fSflqKuH3colIWxC6lnaooFuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfBKOaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:30:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729664AbfBKO3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:29:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 870952075C;
        Mon, 11 Feb 2019 14:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895394;
        bh=0D5LEYDQ58Y3XDiTLc/gnNLCc0pm1eSiDcenF0Gs8ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CE6MdGpFRU3MxsFAeTaJBzCnyj66KXEYCQfraPtf5gD+YzVk6w82IxaiudU+0vlDN
         oOtYGiJYZXluYTbADxy/i68E72VsaYmOj2rGfugetIiNzOYOeGzWBarVtiXZgkU4pH
         IAyynIj+riecqvnXvcJK7HeJvCY3T9QXy1cqsXZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 191/352] i2c: sh_mobile: Add support for r8a774c0 (RZ/G2E)
Date:   Mon, 11 Feb 2019 15:16:58 +0100
Message-Id: <20190211141859.271365864@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit 51243b73455f2d12cb82abffa7bc9028aec656e0 ]

Similarly to R-Car E3, RZ/G2E doesn't come with automatic
transmission registers, as such it is not considered compatible
with the existing fallback bindings.

Add SoC specific binding compatibility to allow for later
support for automatic transmission.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 28db6b59c4ca..a64f2ff3cb49 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -800,6 +800,7 @@ static const struct sh_mobile_dt_config r8a7740_dt_config = {
 static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 	{ .compatible = "renesas,iic-r8a73a4", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7740", .data = &r8a7740_dt_config },
+	{ .compatible = "renesas,iic-r8a774c0", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7790", .data = &v2_freq_calc_dt_config },
 	{ .compatible = "renesas,iic-r8a7791", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7792", .data = &fast_clock_dt_config },
-- 
2.19.1



