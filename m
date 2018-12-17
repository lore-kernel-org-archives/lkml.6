Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37C4C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA38217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbeLQJ0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:26:22 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47821 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeLQJ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:26:21 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gYpAH-000311-5X; Mon, 17 Dec 2018 10:26:17 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gYpAG-0007Su-LU; Mon, 17 Dec 2018 10:26:16 +0100
Date:   Mon, 17 Dec 2018 10:26:16 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] ARM i.MX: Fix a kernel panic in
 i2c_imx_clk_notifier_call().
Message-ID: <20181217092616.sd4yv4ezu72xzlxb@pengutronix.de>
References: <m3o9a2hni5.fsf@t19.piap.pl>
 <CAOMZO5Bhe9t0x0Ke0VJTR3BaeT+ww9vCZBit-8ubyRQjtjM4=Q@mail.gmail.com>
 <m3va3sh5zl.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3va3sh5zl.fsf@t19.piap.pl>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 10:12:14AM +0100, Krzysztof Hałasa wrote:
> 90ad2cbe88c22d0215225ab9594eeead0eb24fde changed the i.MX I2C bus driver
> to use a notifier whenever the base clock ("ipg" - 66 MHz peripheral
> clock) rate changes.
> 
> Unfortunately one can't use the container_of() macro this way - the
> first argument has to point to a member of the bigger struct (last
> argument). Merely pointing to the same value isn't enough (the clk
> variable which has its address passed to the macro is the clk in
> notifier_block, not the one in imx_i2c_struct, even though both pointers
> point to the same clk struct).
> 
> This bug causes kernel panic when the IPG clock rate changes (e.g. if
> any clock derived from IPG changes).
> 
> Signed-off-by: Krzysztof Halasa <khalasa@piap.pl>

I didn't look at the patch, but I suggest a Fixes: line here à la:

Fixes: 90ad2cbe88c2 ("i2c: imx: use clk notifier for rate changes")

Best regards
Uwe
 
-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
