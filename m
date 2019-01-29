Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C072CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E91221848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfA2PFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:05:55 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46721 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbfA2PFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:05:53 -0500
X-Originating-IP: 109.213.138.65
Received: from localhost (alyon-652-1-35-65.w109-213.abo.wanadoo.fr [109.213.138.65])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 866486001A;
        Tue, 29 Jan 2019 15:05:50 +0000 (UTC)
Date:   Tue, 29 Jan 2019 16:05:49 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     Nicolas.Ferre@microchip.com, linux-kernel@vger.kernel.org,
        broonie@kernel.org, Ludovic.Desroches@microchip.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tudor.Ambarus@microchip.com
Subject: Re: [PATCH v4 2/2] spi-atmel: support inter-word delay
Message-ID: <20190129150549.GA19959@piout.net>
References: <20190129083844.20572-1-jonas@norrbonn.se>
 <20190129083844.20572-3-jonas@norrbonn.se>
 <995b3885-254b-7932-8d05-77271a2c070d@microchip.com>
 <7a6efd1a-5920-60e5-bc68-dfbe6866e522@norrbonn.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a6efd1a-5920-60e5-bc68-dfbe6866e522@norrbonn.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/01/2019 15:56:31+0100, Jonas Bonn wrote:
> On 29/01/2019 15:27, Nicolas.Ferre@microchip.com wrote:
> > On 29/01/2019 at 09:38, Jonas Bonn wrote:
> > > 
> > > +	/* DLYBCT adds delays between words.  This is useful for slow devices
> > > +	 * that need a bit of time to setup the next transfer.
> > > +	 */
> > > +	if (spi->word_delay_us) {
> > 
> > Well...
> > 
> > > +		csr |= SPI_BF(DLYBCT,
> > > +			clamp_t(u8,
> > > +				(as->spi_clk/1000000*spi->word_delay_us)>>5,
> > > +				1, 255));
> > 
> > ... why not simplifying to:
> > +				0, 255));
> > and remove the test altogether, after all?
> 
> Hmm... that seemed too easy!  This started out as something else and looking
> at it now I think even the clamp_t() is unnecessary.  The value is already
> 0-255 and the way SPI_BF works any overflow is already truncated...  I'll
> rework this and resubmit once I get some feedback on the word_delay_us bits.
> 

While at it, note that you need to add spaces around the operators.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
