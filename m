Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F46C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C551D20879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547350595;
	bh=bsAvnT/O+HhK0bVxJN/mwntmaRqADEppJty1Tdh41YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yr1Ux0yCdsPPwhS2Uy7AHU7lDzj1HFkIeIqRq0ePQoSNE8PkQdyN3Q8hq2cnDmbXm
	 CaO/SKQmnF0T6XAkyTjuTciTcVkxnFN2tguRCs1UERZJbo3Sa/N45bupBz43l4o64O
	 wXOcn6iAgiaBV2mWDun8dYTEqQ0ca1CX6np/ZD9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfAMDge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 22:36:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfAMDge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 22:36:34 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF9D20842;
        Sun, 13 Jan 2019 03:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547350594;
        bh=bsAvnT/O+HhK0bVxJN/mwntmaRqADEppJty1Tdh41YA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SW/gjgdVJdYa+WujbnaZlQS1MWC1yBU0oNAmmuel/nKKsPSz0fHP2Fim8I9pfRjnB
         MlN7M1SS/H8pwmnx7NOanlLBh5qnwFcz0UlEF4u/WFpRaBT2m4XyHdTLf811urAVma
         jpaS3Fde5waPO/SoyeePk8uJISfu04kdoOVxcB0w=
Date:   Sun, 13 Jan 2019 11:36:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH RESEND] ARM: dts: imx6sx: Add DISPLAY power domain support
Message-ID: <20190113033615.GJ11426@dragon>
References: <ca5d7f6be8e1cf7ef9b5c8ef322fbcf1a14ae7fa.1546866930.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca5d7f6be8e1cf7ef9b5c8ef322fbcf1a14ae7fa.1546866930.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:28:48PM +0000, Leonard Crestez wrote:
> This was implemented in the driver but not actually defined and
> referenced in dts. This makes it always on.
> 
> From reference manual in section "10.4.1.4.1 Power Distribution":
> 
> "Display domain - The DISPLAY domain contains GIS, CSI, PXP, LCDIF,
> PCIe, DCIC, and LDB. It is supplied by internal regulator."
> 
> The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is
> actually inside the DISPLAY domain. Handle this by adding the pcie node
> in both power domains.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
