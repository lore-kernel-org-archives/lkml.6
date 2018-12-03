Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3D7C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211FB2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlRhN/5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211FB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeLCSSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:18:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbeLCSSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:18:18 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AFB520850;
        Mon,  3 Dec 2018 18:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543861093;
        bh=wRz3UVbx7BBjgXWuqnpGCv8nebTx5Lm0H+z556CvfsQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=TlRhN/5Kik1c3gufxdPXThrKKQ0WV/LFw7UyWItzjrgnJ035xumjD8BO9s54tpOnt
         poEB6rkD8FVXgQn898/PnRubWVTedaFJgEXR0Lp1EK7lGZTRn9z+ok+6EkQsxpGqqy
         QKI5uFfeYOgyJoE/IW+TLiUjKzTBIw7PM1Zp3Fsw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1543661502-18573-6-git-send-email-abel.vesa@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
References: <1543661502-18573-1-git-send-email-abel.vesa@nxp.com>
 <1543661502-18573-6-git-send-email-abel.vesa@nxp.com>
Message-ID: <154386109297.88331.12375261013738475965@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v15 5/5] clk: imx: Add clock driver for i.MX8MQ CCM
Date:   Mon, 03 Dec 2018 10:18:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-12-01 02:52:15)
> Add driver for the Clock Control Module found on i.MX8MQ.
> =

> Signed-off-by: Anson Huang <anson.huang@nxp.com>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Applied to clk-next

but checkpatch complains about the parent arrays being const char *
const instead of const char *. Can you send a followup to fix that?

