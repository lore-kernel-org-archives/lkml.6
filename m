Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053D0C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F562081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F562081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbeLCIFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:05:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49497 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeLCIFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:05:00 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F37B520787; Mon,  3 Dec 2018 09:04:54 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9C15220CFA;
        Mon,  3 Dec 2018 09:04:44 +0100 (CET)
Date:   Mon, 3 Dec 2018 09:04:44 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/7] spi: add support for octo mode I/O data transfer
Message-ID: <20181203090444.0c37efa7@bbrezillon>
In-Reply-To: <1542863544-21257-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1542863544-21257-2-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

On Thu, 22 Nov 2018 05:14:31 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Add flags for Octo mode I/O data transfer
> Required for the SPI controller which can do the data transfer (TX/RX)
> on 8 data lines e.g. NXP FlexSPI controller.
>  SPI_TX_OCTO: transmit with 8 wires
>  SPI_RX_OCTO: receive with 8 wires
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Changes for v4:
> - Rebase on top of v4.20-rc2
> Changes for v3:
> - Modified string 'octal' with 'octo'.

When I listed the differences between your version and mine, I
mentioned the OCTO vs OCTAL name, but I didn't say my decision was the
correct one :-). Looks like OCTAL is the term employed almost
everywhere, and it's also consistent with DUAL. Would you mind
sending a new version reverting the name to OCTAL.

Sorry for the unclear statement in my previous review.

Regards,

Boris
