Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02521C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC70E206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfBVUz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:55:26 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49725 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfBVUz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:55:26 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gxHqs-0003kw-67; Fri, 22 Feb 2019 21:55:22 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gxHqq-0000VC-8O; Fri, 22 Feb 2019 21:55:20 +0100
Date:   Fri, 22 Feb 2019 21:55:20 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Christina Quast <cquast@hanoverdisplays.com>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] tty/serial/imx.c: Rename URTX0 to UTXD0
Message-ID: <20190222205520.fvqpttlzq5lycbvu@pengutronix.de>
References: <20190222163127.10172-1-cquast@hanoverdisplays.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190222163127.10172-1-cquast@hanoverdisplays.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 04:31:27PM +0000, Christina Quast wrote:
> Rename to be coherent with the datasheet.
> 
> Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
> ---
>  drivers/tty/serial/imx.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index dff75dc94731..a405e0d21ec9 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -40,7 +40,7 @@
>  
>  /* Register definitions */
>  #define URXD0 0x0  /* Receiver Register */
> -#define URTX0 0x40 /* Transmitter Register */
> +#define UTXD0 0x40 /* Transmitter Register */

Oh wow, I never noticed this and it was wrong ever since the kernel is
tracked in git (back in 1da177e4c3f4 the definition was in
include/asm-arm/arch-imx/imx-regs.h)---I didn't check further.

Also I checked the i.MX1, i.MX25 and i.MX6 manuals and the transmit
register was never called RTX, in all three manuals it is named UTXD.

I suggest to also drop the 0 from both URXD0 and UTXD0.

If you send a v2 I recommend adding the imx people (from MAINTAINERS) to
Cc.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
