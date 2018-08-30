Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84A6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5111A2082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5111A2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeH3NRy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:17:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51220 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbeH3NRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:17:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D8F5222A39; Thu, 30 Aug 2018 11:16:41 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 97529206A6;
        Thu, 30 Aug 2018 11:16:31 +0200 (CEST)
Date:   Thu, 30 Aug 2018 11:16:30 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v5] spi: spi-mem: Adjust op len based on
 message/transfer size limitations
Message-ID: <20180830111630.19ab2fc4@bbrezillon>
In-Reply-To: <AM6PR04MB4357DA161E8FCDB7B0B5C42697080@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <1535618604-21706-1-git-send-email-chuanhua.han@nxp.com>
        <20180830104729.5c7fefad@bbrezillon>
        <AM6PR04MB4357DA161E8FCDB7B0B5C42697080@AM6PR04MB4357.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 09:13:03 +0000
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> > -----Original Message-----
> > From: Boris Brezillon <boris.brezillon@bootlin.com>
> > Sent: 2018年8月30日 16:47
> > To: Chuanhua Han <chuanhua.han@nxp.com>
> > Cc: broonie@kernel.org; linux-spi@vger.kernel.org;
> > linux-kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH v5] spi: spi-mem: Adjust op len based on message/transfer
> > size limitations
> > 
> > Hi Chuanhua,
> > 
> > On Thu, 30 Aug 2018 16:43:24 +0800
> > Chuanhua Han <chuanhua.han@nxp.com> wrote:
> >   
> > > We need that to adjust the len of the 2nd transfer (called data in
> > > spi-mem) if it's too long to fit in a SPI message or SPI transfer.  
> > 
> > You already sent this email a few days back. Please wait a bit before sending it
> > again. And when you do so and nothing changed in the patch please use the
> > [PATCH RESEND vX] prefix and explain why you resend it.  
> I have modified the patch for the comment you mentioned last time. Do you need any other modification？

Oops, sorry. Looks like the previous one was only sent to me, not the
ML and the SPI maintainer.
