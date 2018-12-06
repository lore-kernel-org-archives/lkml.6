Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A0BC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70A620700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544062911;
	bh=XGYqxKhIAn4Ydw+ilNgQAMK8PTyjozTe/Ce2LjWztg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tYRi2N65XigelOuDoIbc/69Rf4AQil0V3zTVhc86J5Ip0Lus0EIuDvXgXOP4gBXV2
	 /4sDDYIxeRP+TkyQ8Nr493XkmNh9PAqmsuHg2i9NVdHQ5AeuwStzG1OFlLuh/TiE/X
	 pVSZeloX37NjDSZPmFcJldHjwSzEOmhA7HY3m13g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70A620700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbeLFCVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:21:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbeLFCVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 21:21:50 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CD3A214C1;
        Thu,  6 Dec 2018 02:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544062909;
        bh=XGYqxKhIAn4Ydw+ilNgQAMK8PTyjozTe/Ce2LjWztg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hI6dPT30M9laF4oLHiHBI8LkL1mNNFglfiHBOpv9XBEfzwYKnmd0D/juyw081YYZa
         Bc7TPP8cANq8/isjPm0x5q1ZumNQgoXS2Qx5gP9TwkSaRdkTppfq22VwsFf9X3FgVS
         lwF80Ay5pUPwLm5PEyLgNWxCuK0T2NSW96MWhb4Y=
Date:   Thu, 6 Dec 2018 10:21:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RESEND V2 0/4] ARM: dts: imx: Add flexcan stop mode wake
Message-ID: <20181206022108.GY3987@dragon>
References: <20181203051753.1532-1-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203051753.1532-1-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 05:20:16AM +0000, Joakim Zhang wrote:
> This patchset intends to add flexcan stop mode wakeup support on IMX6/7 platforms.
> 
> ChangeLog:
> V1->V2:
> 	*update stop mode property(stop-mode -> fsl,stop-mode).
> 
> Hi Shawn,
>    This property has been merged both flexcan bindings doc and kernel
>    driver.
> 
> Best Regards,
> Joakim Zhang
> 
> Aisheng Dong (4):
>   ARM: dts: imx6sx: Add flexcan stop mode wakeup support
>   ARM: dts: imx6qdl: Add flexcan stop mode wakeup support
>   ARM: dts: imx6ul: Add flexcan stop mode wakeup support
>   ARM: dts: imx7s: Add flexcan stop mode wakeup support

Applied all, thanks.
