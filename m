Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E02C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E15221721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548135184;
	bh=QvrJ5ME28jfdXtWn4H3bM8SCpSPS9qd47OEn4hVR/4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HJsrMi/QNMxR7TwAuZjTx7GzkS+CNMAGBa99qHcJksMvG8/QBOcpA9LD4ygN2Y+k9
	 mQ1f6Z8rTdYHPszuCtTxmU3OjQRw6Fu8MU+Y+9ZR6MPm/xMbc6SA12xxFfP9HHkXJo
	 Fropi0SiaG7q5ALSdtSH/ihU+G1TZenX+Yn8C/TE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfAVFdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:33:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAVFdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:33:02 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0600520861;
        Tue, 22 Jan 2019 05:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548135182;
        bh=QvrJ5ME28jfdXtWn4H3bM8SCpSPS9qd47OEn4hVR/4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OulJnrcp9bP05VgpGIm6Zm081/srUpIkA0bJ+rnTMJC3zc+cO6PW+Ty7wky2fucVb
         uSA8LVndcpK+KerUPhqk/thaTxYOBZW0x9KnFLKeh5nwomyAeIbb/S1QwLvPY82wN1
         Wj1q0Rbuq4TLrIhLbL/RpAJc/hYSM9zuHN2wGzk0=
Date:   Tue, 22 Jan 2019 13:32:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     s.hauer@pengutronix.de, max.krummenacher@toradex.com,
        marcel.ziswiler@toradex.com, dev@pschenker.ch,
        kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6*-apalis/-colibri: mark I2C recovery GPIOs
 as open drain
Message-ID: <20190122053220.GE19233@dragon>
References: <20190118133113.19484-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118133113.19484-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 02:31:13PM +0100, Stefan Agner wrote:
> Since commit d2d0ad2aec4a ("i2c: imx: use open drain for recovery
> GPIO") GPIO lib expects this GPIO to be configured as open drain.
> Make sure we define this GPIO as open drain in the device tree.
> This gets rid of the following warning:
>   gpio-81 (scl): enforced open drain please flag it properly in DT/ACPI DSDT/board file
> 
> Note that currently the i.MX pinctrl driver does not support
> enabling open drain directly, so this patch has no effect in
> practice. Open drain is enabled by the fixed pinmux entry.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
