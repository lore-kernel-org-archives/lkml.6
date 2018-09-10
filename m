Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDDBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36ED42064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4pn44nF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36ED42064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeIJHV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbeIJHV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:21:56 -0400
Received: from dragon (unknown [45.56.155.51])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 392D520892;
        Mon, 10 Sep 2018 01:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536541847;
        bh=q37KoTt4lx1wTpbCHAyVVKu+0teSRm9a1d0vpJOTdT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u4pn44nF+04t5kIdkPLJy6Oc2B5QfqawV68dZlG+rV/jPKhlhRTXrUIvye5cSCnp7
         lmt5Cdc+HwgxiqaWA7uBRbYNb2X09pCV0vrEbgkuIUbM5GlszgeJ/c3/cYvjKK3J9S
         PITCq8oCK76rZkL4+M9+R6GyGZE5+hdekiTT3FJ0=
Date:   Mon, 10 Sep 2018 09:09:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     s.hauer@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6q-apalis: mux RESET_MOCI# signal
Message-ID: <20180910010913.GD21992@dragon>
References: <20180906234658.12205-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906234658.12205-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 04:46:58PM -0700, Stefan Agner wrote:
> The pinctrl properties on the IOMUXC node get overwritten by the
> carrier board level device tree, hence the pinctrl_reset_moci
> pinctrl does not get applied.
> 
> Associate the pinctrl_reset_moci pinctrl with the PCIe node where
> we also make use of the pin as a reset GPIO.
> 
> Since the pin is muxed as a GPIO by default not muxing it explicitly
> worked fine in practise.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
