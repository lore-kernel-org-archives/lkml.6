Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16792C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35792184B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547126542;
	bh=OECq5171S9i76LcX8GhY6qNZdz8TO45DCOI9JThXBnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FUNrn6IOYSBRqOu+fKMnOT0lBrg4x+Fff0DGhyg+eIdmh1Ep80s3mVu0vc9uUs3f2
	 /95uciRCK1U/2u1J3oAP0OUggB7pbAPQmRp5M4GZMMFuvMxSq0ogl31rZBGnsbCI/6
	 4fuglCwGt6nXD5VS8LiyrZ2JGnYRzOjVyBVA1dOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfAJNWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:22:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbfAJNWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:22:21 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2235D214DA;
        Thu, 10 Jan 2019 13:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547126540;
        bh=OECq5171S9i76LcX8GhY6qNZdz8TO45DCOI9JThXBnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QNPy61wYrXLXZlpLNsrTlouHOgDXHM5NTaWfwCrMjLfVYE80q3alIGubwnpzYd4t0
         38zAinaCBPmKZUVSBR+ohKU7C11k8PHPQbSzFOa3OF+fdKu5QXgK2tFl9XSAp9XDvE
         d3aMO6c3peTcD2oWmpLuoDOtkYyrZahT5jFieWRA=
Date:   Thu, 10 Jan 2019 21:22:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH v2] ARM: dts: vf610-bk4: Provide support for reading ID
 code from MVB device
Message-ID: <20190110132209.GA30487@dragon>
References: <20181113121213.14296-1-lukma@denx.de>
 <20181209215056.22027-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209215056.22027-1-lukma@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 10:50:56PM +0100, Lukasz Majewski wrote:
> The procedure to read this ID value is as follows:
> 
> rmmod spi_fsl_dspi
> insmod spi-gpio.ko
> 
> echo 504 > /sys/class/gpio/export
> cat /sys/class/gpio/gpio504/value
> ...
> echo 511 > /sys/class/gpio/export
> cat /sys/class/gpio/gpio511/value
> 
> rmmod spi-gpio.ko
> insmod spi_fsl_dspi
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Applied, thanks.
