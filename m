Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED52C5ACCD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB7D2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/jYhGf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB7D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJQGK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeJQGK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:10:26 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B83B42145D;
        Tue, 16 Oct 2018 22:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539728277;
        bh=FZopIYyPNdkMYYJwxslFigvv6B1DXqYWqD8RnzllB1E=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=S/jYhGf4eybWAOMzWXt8cW5dAysaoJjkWYBHf9cMG6Rs9LY0NmJUPlhpUNKIOrwyd
         bPWxMVkfTp6mbUamAopunjGlXrUC92MBti/ghT3ERYOARNusVuFODE3JuOHtKsDmAz
         sm2fWk5g+6OdnC0go3jIkU/yuR/L/Z1XXNdRIYcQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181010145138.17185-3-vkoul@kernel.org>
Cc:     Shefali Jain <shefjain@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
References: <20181010145138.17185-1-vkoul@kernel.org>
 <20181010145138.17185-3-vkoul@kernel.org>
Message-ID: <153972827704.5275.5606344004932442164@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/2] clk: qcom: gcc: Add global clock controller driver for
 QCS404
Date:   Tue, 16 Oct 2018 15:17:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2018-10-10 07:51:38)
> From: Shefali Jain <shefjain@codeaurora.org>
> =

> Add the clocks supported in global clock controller which clock the
> peripherals like BLSPs, SDCC, USB, MDSS etc. Register all the clocks
> to the clock framework for the clients to be able to request for them.
> =

> Signed-off-by: Shefali Jain <shefjain@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Co-developed-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
> [bamse, vkoul: rebase and tidyup for upstream]
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Applied to clk-next with some minor cosmetic touches.

