Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AD7ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C53214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C53214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeIQREt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:04:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35839 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbeIQREt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:04:49 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 97C882075C; Mon, 17 Sep 2018 13:37:51 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 510AB204AE;
        Mon, 17 Sep 2018 13:37:51 +0200 (CEST)
Date:   Mon, 17 Sep 2018 13:37:51 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Message-ID: <20180917133751.453ea6ed@bbrezillon>
In-Reply-To: <1537177710-9379-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1537177710-9379-2-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

On Mon, 17 Sep 2018 15:18:26 +0530
Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> +
> +	/*
> +	 * R/W functions for big- or little-endian registers:
> +	 * The FSPI controller's endianness is independent of
> +	 * the CPU core's endianness. So far, although the CPU
> +	 * core is little-endian the FSPI controller can use
> +	 * big-endian or little-endian.
> +	 */
> +	if (of_property_read_bool(np, "big-endian")) {
> +		f->write = fspi_writel_be;
> +		f->read = fspi_readl_be;
> +	} else {
> +		f->write = fspi_writel;
> +		f->read = fspi_readl;
> +	}

Hm, isn't it something you can extract from the compatible string? I'd
rather not allow users to set that in their DT if it's not something
you can change.

Regards,

Boris
