Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF22C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759992146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgMlZJ1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759992146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeK3Sda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:33:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbeK3Sda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:33:30 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAB2A20863;
        Fri, 30 Nov 2018 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543562708;
        bh=fq1oEIovxHpkJ1uMug5WWBHXM47wP0Jfq5qx+KHDIaE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=tgMlZJ1ITqkEwtUGEn5hZ32PcgonirgUmeij8uXcWm24H5uxYO1eyX5QmARSolMby
         c81/3QMQDS1ZTqgjHuQ7tUOvm4RV/sePlmsdlh5RldsMcNYCdxLOnNXvud2lTOU4px
         mDhgpskDfywmoE3wAMSHCoe65OZ2SEa3mnDspac4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1543562288-28638-1-git-send-email-Anson.Huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1543562288-28638-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <154356270811.88331.17520386069332746427@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: imx6sl: ensure MMDC CH0 handshake is bypassed
Date:   Thu, 29 Nov 2018 23:25:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-11-29 23:23:47)
> Same as other i.MX6 SoCs, ensure unused MMDC channel's
> handshake is bypassed, this is to make sure no request
> signal will be generated when periphe_clk_sel is changed
> or SRC warm reset is triggered.
> =

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Does this need a fixes tag?

