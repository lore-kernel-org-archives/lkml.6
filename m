Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F26C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831CF205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547503806;
	bh=sb6uN5X8IEdSGB5NUtQsserbDYpuwI3wT5Brvi+ZxBo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=CSFnN1ECs4e6N6BHHSQ0WosE5eIO7lmIlhPCoCkL+nOv2D+Aa2sHxuldQJpQ8aivl
	 JPp8Z1/ElOodcUTSiLPFzIKB3tTvADItBiPZS0sNNBvB/A0iUpQrL2bTqvYGwHCZoR
	 qg0SCD1b96dHZD6ZWY/GbMnJmeVYOnacGc0+OeUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfANWKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:10:05 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33816 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfANWKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:10:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NIv7FRd5qMooomDEccBdxx5EOc2s7GD6FXjXCoavcIw=; b=cuikkp5q9vxI
        JTKinbrfe96tkjC37SNbYxo5PcZplyHG6wUk+/bo5wYrpSGwnCZb4rT56uUKFCqhKLZhHY7dWdd+O
        qR+G799klPlFEJ9dc5SUFy36r8HHhNzpWOaxBDAvGZWz8jgwQrREQ0+cqndDnDVw3p1krzcstVNKC
        xNkaA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjAQh-0008Gu-2v; Mon, 14 Jan 2019 22:09:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B623E1127AD0; Mon, 14 Jan 2019 22:09:58 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spi-geni-qcom: Don't initialize completion for normal message" to the spi tree
In-Reply-To:  <20190110210253.23219-1-swboyd@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190114220958.B623E1127AD0@debutante.sirena.org.uk>
Date:   Mon, 14 Jan 2019 22:09:58 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-geni-qcom: Don't initialize completion for normal message

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 0357a3daada3236da59be5d692f02ae07e2a145e Mon Sep 17 00:00:00 2001
From: Stephen Boyd <swboyd@chromium.org>
Date: Thu, 10 Jan 2019 13:02:52 -0800
Subject: [PATCH] spi: spi-geni-qcom: Don't initialize completion for normal
 message

We only use this completion when we're doing something that isn't a
message transfer. For example, changing CS or aborting/canceling a
command. All of those situations properly reinitialize the completion
before sending the GENI the special command to change CS or cancel, etc.
Given that, let's remove the initialization here.

Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Dilip Kota <dkota@codeaurora.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index fdb7cb88fb56..c3e9464027d4 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -233,7 +233,6 @@ static int spi_geni_prepare_message(struct spi_master *spi,
 	struct geni_se *se = &mas->se;
 
 	geni_se_select_mode(se, GENI_SE_FIFO);
-	reinit_completion(&mas->xfer_done);
 	ret = setup_fifo_params(spi_msg->spi, spi);
 	if (ret)
 		dev_err(mas->dev, "Couldn't select mode %d\n", ret);
-- 
2.20.1

