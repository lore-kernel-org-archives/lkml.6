Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A18CC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D775F204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D775F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeJPHxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 03:53:41 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:39182 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726440AbeJPHxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 03:53:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E08BC182CED5B;
        Tue, 16 Oct 2018 00:06:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jam60_3537c4a442962
X-Filterd-Recvd-Size: 1401
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 16 Oct 2018 00:06:05 +0000 (UTC)
Message-ID: <f9ef58fa27419258de32c26d3a80c9e086522221.camel@perches.com>
Subject: Re: [PATCH] staging: add nrf24 driver
From:   Joe Perches <joe@perches.com>
To:     Marcin Ciupak <marcin.s.ciupak@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Date:   Mon, 15 Oct 2018 17:06:04 -0700
In-Reply-To: <20181015231743.k3roxxjwt66lc3lx@metis.ciupak.eu>
References: <20181015231743.k3roxxjwt66lc3lx@metis.ciupak.eu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-16 at 01:17 +0200, Marcin Ciupak wrote:
> This patch adds driver for Nordic Semiconductor nRF24L01+ radio module.

[]
> diff --git a/drivers/staging/nrf24/nrf24_hal.c b/drivers/staging/nrf24/nrf24_hal.c

[]
> +static ssize_t nrf24_read_reg(struct spi_device *spi, u8 addr)
> +{
> +	ssize_t ret;
> +
> +	ret = spi_w8r8(spi, addr);
> +
> +	if (ret < 0)
> +		dev_dbg(&spi->dev, "%s: read 0x%X FAILED", __func__, addr);

Please add terminating newlines to all logging formats

		dev_dbg(&spi->dev, "%s: read 0x%X FAILED\n", __func__, addr);

etc...


