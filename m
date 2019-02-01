Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B0DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3D3218F0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549035924;
	bh=1K/k12ABv52m0qd2+Gjk2G3Nr+pRmZ0USUlT5Q1Pg30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QzMqyX9rppgQ34fp2xM5g2p0JV/WavBOP/PcrCSa5AiiXuqWpgXnF7VSDjGGMRxb0
	 3LOSc9IdvaXV7zQvzH08hWbmfB4EnM4Wdcl9pEb0IAJfLrsCVm+gmdjXUBqpWfIY0u
	 DI2+Sz3c7u/qLf2IXVhsZ9b5Land/iG1LRF8kebg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfBAPpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:45:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbfBAPpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:45:20 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B8D20855;
        Fri,  1 Feb 2019 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549035920;
        bh=1K/k12ABv52m0qd2+Gjk2G3Nr+pRmZ0USUlT5Q1Pg30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OptQj0lKWEsy67XyHkIXeh9Sw1fvpLZ6rXPJxaZtCTetGDkppo/9YNmrFg9HtDp5y
         fmVlPt5pBcKiN04zMZcHPMLp/WOk9pl1KGRLr/Y35+CEZXqwKk9HEnyQUmCSTuVrEx
         xOidvpWILdjEZeLozsotqRPtTo3ThLNp0XlQ9wZE=
Date:   Fri, 1 Feb 2019 16:45:08 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 10/10] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Message-ID: <20190201164508.4d1b214d@bbrezillon>
In-Reply-To: <8b935a95-0aaa-3430-e2c2-f5793fd9cf11@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
        <20190131161515.21605-11-tudor.ambarus@microchip.com>
        <20190131173207.56481a42@bbrezillon>
        <947f148d-3fd8-4e7d-4301-9d67715fbf7d@microchip.com>
        <20190201085739.775add3f@bbrezillon>
        <8b935a95-0aaa-3430-e2c2-f5793fd9cf11@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 14:49:27 +0000
<Tudor.Ambarus@microchip.com> wrote:

> 
> >>>> +#define QSPI_IFR_APBTFRTYP_READ		BIT(24)  
> > 
> > And this one would be
> > 
> > define QSPI_IFR_SAM9X60_READ_TRSFR		BIT(24)  
> 
> I prefer letting this bit named as in the datasheet, QSPI_IFR_APBTFRTYP_READ,
> and change it if future versions of the IP will modify its sense. It is a READ
> transfer done on APB, it is more generic this way. If you have a strong opinion
> on this, please let me know.

As you wish.
