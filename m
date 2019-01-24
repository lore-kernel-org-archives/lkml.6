Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70F4C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943C0217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548361066;
	bh=RsC7Ui+KnjKPbrJt+Jaq4H6HMWLNYRFBgEGx1KifS10=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=PPcGbtUeN54jP2Ybo4RjgCMOBFFtoEqcPFomPXN0jV1BuULCPmp4WB7UuXR4Kwb9z
	 /X+WRYSYGHMPRCBieNcounIWNEEuh0ZiqDdR7ERtgj5OyVPaLRCLQiog6Bphs4BqVU
	 rAejK16XUYU0ti+QUug/BQuaSsWzQNyS8Vy7kKT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfAXURo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:17:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729694AbfAXTW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:22:56 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CEAE218E2;
        Thu, 24 Jan 2019 19:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357776;
        bh=RsC7Ui+KnjKPbrJt+Jaq4H6HMWLNYRFBgEGx1KifS10=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=DfZ0oglUMnIQE++2DkcmHGEgzXg7AhWStH1Dcg5nYRhaVhq0duEJZ6Gah7Gj9dFa8
         4UUtnAp499H5KBtdfF2XDotJEZeqHwWSN6196KEae7Wk5NDfP4SPC8B+s6PGKWLdJ8
         afKLoTrQ9SgDrW/5BlUe+yauFRjpHX0Ko/+8ZnAs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: qcom: Add MSM8976/56 Global Clock Controller (GCC) driver
References: <65fb363366f651e42d3e97792d5990185823cbc3.camel@gmail.com>
User-Agent: alot/0.8
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <65fb363366f651e42d3e97792d5990185823cbc3.camel@gmail.com>
Message-ID: <154835777525.136743.6424256006615217720@swboyd.mtv.corp.google.com>
To:     Andy Gross <andy.gross@linaro.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 24 Jan 2019 11:22:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2019-01-12 07:03:18)
> From 50465f2a4454625aac622bb84dbecdeaf5a50904 Mon Sep 17 00:00:00 2001
> From: "Angelo G. Del Regno" <kholk11@gmail.com>
> Date: Sat, 12 Jan 2019 10:52:18 +0100
> Subject: [PATCH] clk: qcom: Add MSM8976/56 Global Clock Controller (GCC)
>  driver
>=20
> Add support for the global clock controller found on MSM8976
> and MSM8976 SoCs.
> Since the multimedia clocks are actually in the GCC on these
> SoCs, this will allow drivers to probe and control basically
> all the required clocks.
>=20
> Signed-off-by: Angelo G. Del Regno <kholk11@gmail.com>

Are you going to send out DTS bits and provide platform support? I'm not
interested in merging the clk bits and then having to support a driver
that never gets used.

Also, is this copy/pasted from some downstream kernel sources? Would be
good to have a pointer to that so we can compare and see if you've
changed anything.

