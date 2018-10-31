Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CCEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2BC2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2BC2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbeKADE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:04:29 -0400
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:46800 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729341AbeKADE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:04:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id EB3FF8368F02;
        Wed, 31 Oct 2018 18:05:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: vest13_11a97fcbaf013
X-Filterd-Recvd-Size: 2859
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Oct 2018 18:05:21 +0000 (UTC)
Message-ID: <0a6d5b7a21d4ad5b29295ac5695ada3d9f2133c4.camel@perches.com>
Subject: Re: [PATCH] tlclk: lean an indentation issue, remove extraneous tabs
From:   Joe Perches <joe@perches.com>
To:     Colin Ian King <colin.king@canonical.com>,
        Mark Gross <mark.gross@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Oct 2018 11:05:19 -0700
In-Reply-To: <aa09c138-854e-ad84-59eb-5613b8cd3f0e@canonical.com>
References: <20181030115650.21104-1-colin.king@canonical.com>
         <aa09c138-854e-ad84-59eb-5613b8cd3f0e@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-30 at 11:57 +0000, Colin Ian King wrote:
> $SUBJECT should be:
> 
> tlclk: clean an indentation issue, remove extraneous tabs

Perhaps add missing braces for the last else uses as well?

> On 30/10/2018 11:56, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
[]
> > diff --git a/drivers/char/tlclk.c b/drivers/char/tlclk.c
[]
> > +	if ((val == CLK_8kHz) || (val == CLK_16_384MHz)) {
> > +		SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x28);
> > +		SET_PORT_BITS(TLCLK_REG1, 0xfb, ~val);
> > +	} else if (val >= CLK_8_592MHz) {
> > +		SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x38);
> > +		switch (val) {
> > +		case CLK_8_592MHz:
> > +			SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
> > +			break;
> > +		case CLK_11_184MHz:
> > +			SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
> > +			break;
> > +		case CLK_34_368MHz:
> > +			SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
> > +			break;
> > +		case CLK_44_736MHz:
> > +			SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);.
> > +			break;
> > +		}
> > +	} else
> > +		SET_PORT_BITS(TLCLK_REG3, 0xc7, val << 3);

here.

> > @@ -548,27 +548,27 @@ static ssize_t store_select_amcb1_transmit_clock(struct device *d,
[]
> > +	if ((val == CLK_8kHz) || (val == CLK_16_384MHz)) {
> > +		SET_PORT_BITS(TLCLK_REG3, 0xf8, 0x5);
> > +		SET_PORT_BITS(TLCLK_REG1, 0xfb, ~val);
> > +	} else if (val >= CLK_8_592MHz) {
> > +		SET_PORT_BITS(TLCLK_REG3, 0xf8, 0x7);
> > +		switch (val) {
> > +		case CLK_8_592MHz:
> > +			SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
> > +			break;
> > +		case CLK_11_184MHz:
> > +			SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
> > +			break;
> > +		case CLK_34_368MHz:
> > +			SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
> > +			break;
> > +		case CLK_44_736MHz:
> > +			SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
> > +			break;
> > +		}
> > +	} else
> > +		SET_PORT_BITS(TLCLK_REG3, 0xf8, val);

and here.


