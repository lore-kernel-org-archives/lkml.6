Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A790C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2981721480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2981721480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389968AbeHPLU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:20:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47137 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeHPLU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:20:58 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fqDZT-0002GO-Jp; Thu, 16 Aug 2018 10:23:55 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fqDZM-0002Y9-78; Thu, 16 Aug 2018 10:23:48 +0200
Date:   Thu, 16 Aug 2018 10:23:48 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Esben Haabendal <esben.haabendal@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Wei Jinhua <wei.jinhua1@zte.com.cn>,
        Phil Reid <preid@electromag.com.au>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] i2c: imx: Simplify stopped state tracking
Message-ID: <20180816082348.wei7fnbqbzowe6er@pengutronix.de>
References: <20180809123207.9732-1-esben.haabendal@gmail.com>
 <20180809123207.9732-3-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180809123207.9732-3-esben.haabendal@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 02:32:06PM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> Always update the stopped state when busy status have been checked.
> This is identical to what was done before, with the exception of error
> handling.
> Without this change, some errors cause the stopped state to be left in
> incorrect state in i2c_imx_stop(), i2c_imx_dma_read(), i2c_imx_read() and
> i2c_imx_xfer().
> 
> Signed-off-by: Esben Haabendal <eha@deif.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
