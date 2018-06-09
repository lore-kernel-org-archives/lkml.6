Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BlaFHdhrG1svRgAAmS7hNA
	; Sat, 09 Jun 2018 05:55:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 69C89608B8; Sat,  9 Jun 2018 05:55:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E807B607A4;
	Sat,  9 Jun 2018 05:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E807B607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeFIFze (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 01:55:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50232 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751363AbeFIFzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 01:55:32 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3FC0E207CA; Sat,  9 Jun 2018 07:55:30 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id A6FEE203EC;
        Sat,  9 Jun 2018 07:55:29 +0200 (CEST)
Date: Sat, 9 Jun 2018 07:55:29 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Stefan Agner <stefan@agner.ch>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, digetx@gmail.com, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
Message-ID: <20180609075529.23be0658@bbrezillon>
In-Reply-To: <20180531221637.6017-5-stefan@agner.ch>
References: <20180531221637.6017-1-stefan@agner.ch>
        <20180531221637.6017-5-stefan@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Jun 2018 00:16:35 +0200
Stefan Agner <stefan@agner.ch> wrote:

> +
> +static const struct of_device_id tegra_nand_of_match[] = {
> +	{ .compatible = "nvidia,tegra20-nand" },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver tegra_nand_driver = {
> +	.driver = {
> +		.name = "tegra-nand",
> +		.of_match_table = tegra_nand_of_match,
> +	},
> +	.probe = tegra_nand_probe,
> +	.remove = tegra_nand_remove,
> +};
> +module_platform_driver(tegra_nand_driver);
> +
> +MODULE_DESCRIPTION("NVIDIA Tegra NAND driver");
> +MODULE_AUTHOR("Thierry Reding <thierry.reding@nvidia.com>");
> +MODULE_AUTHOR("Lucas Stach <dev@lynxeye.de>");
> +MODULE_AUTHOR("Stefan Agner <stefan@agner.ch>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DEVICE_TABLE(of, tegra_nand_of_match);

Just a nitpick: can you move this MODULE_DEVICE_TABLE() just after the
tegra_nand_of_match declaration?
