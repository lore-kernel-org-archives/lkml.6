Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9461AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C43241A7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C43241A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeGEGct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:32:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45913 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbeGEGcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:32:48 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1faxog-0006WM-Vk; Thu, 05 Jul 2018 08:32:34 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1faxob-0001Y4-Oq; Thu, 05 Jul 2018 08:32:29 +0200
Date:   Thu, 5 Jul 2018 08:32:29 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Esben Haabendal <esben.haabendal@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Phil Reid <preid@electromag.com.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Wei Jinhua <wei.jinhua1@zte.com.cn>,
        Michail Georgios Etairidis <m.etairidis@beck-ipc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] i2c: imx: Fix race condition in dma read
Message-ID: <20180705063229.sr6jplg63ybyzxta@pengutronix.de>
References: <20180523095623.3347-1-esben.haabendal@gmail.com>
 <20180523095623.3347-3-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180523095623.3347-3-esben.haabendal@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 11:56:21AM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> This fixes a race condition, where the DMAEN bit ends up being set after
> I2C slave has transmitted a byte following the dummy read.  When that
> happens, an interrupt is generated instead, and no DMA request is generated
> to kickstart the DMA read, and a timeout happens after DMA_TIMEOUT (1 sec).
> 
> Fixed by setting the DMAEN bit before the dummy read.

Does this fix the problem or just narrow the race window?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
