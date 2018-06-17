Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5E1C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B78208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3zDKDfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B78208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932547AbeFQHjo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 03:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932171AbeFQHjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 03:39:43 -0400
Received: from dragon (unknown [45.56.152.75])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 720A720896;
        Sun, 17 Jun 2018 07:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529221182;
        bh=kPp2pzVR2ggPRD2MlLt/zR9LQtwUEomneAytRY4VKR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3zDKDfpG/4dfPX1z+LCXE5Pe64FvncgA75Uxl+bWLviVg9v/MY3m7tYVlWNHF7xr
         9ka2De8c901drkkrfSwimLuTYj6I6a7HlL2spJTutjuWkE9DEtdtnxaNTTymHZhykD
         1MLjYG6VzwwVg942jCm61n5fAttpXd+xBkGFuKbE=
Date:   Sun, 17 Jun 2018 15:38:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, andrew.smirnov@gmail.com, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] soc: imx: gpcv2: correct PGC offset
Message-ID: <20180617073852.GR16091@dragon>
References: <1527643842-17643-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527643842-17643-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 09:30:42AM +0800, Anson Huang wrote:
> Correct MIPI/PCIe/USB_HSIC's PGC offset based on
> design RTL, the values in the Reference Manual
> (Rev. 1, 01/2018 and the older ones) are incorrect.
> 
> The correct offset values should be as below:
> 
> 0x800 ~ 0x83F: PGC for core0 of A7 platform;
> 0x840 ~ 0x87F: PGC for core1 of A7 platform;
> 0x880 ~ 0x8BF: PGC for SCU of A7 platform;
> 0xA00 ~ 0xA3F: PGC for fastmix/megamix;
> 0xC00 ~ 0xC3F: PGC for MIPI PHY;
> 0xC40 ~ 0xC7F: PGC for PCIe_PHY;
> 0xC80 ~ 0xCBF: PGC for USB OTG1 PHY;
> 0xCC0 ~ 0xCFF: PGC for USB OTG2 PHY;
> 0xD00 ~ 0xD3F: PGC for USB HSIC PHY;
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>

I added the Fixes tag below and applied it as a fix.

 Fixes: 03aa12629fc4 ("soc: imx: Add GPCv2 power gating driver")

Shawn
