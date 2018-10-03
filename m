Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4659AC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A277206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A277206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJDB07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:26:59 -0400
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:59135 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726851AbeJDB07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:26:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1F6488368EFC;
        Wed,  3 Oct 2018 18:37:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: paste21_7a19a7c376e08
X-Filterd-Recvd-Size: 3878
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Oct 2018 18:37:18 +0000 (UTC)
Message-ID: <c7b929a8c8ebaec7ce0f0e09f803e414e74f986b.camel@perches.com>
Subject: Re: [PATCH v8 05/10] dt-bindings: i3c: Add macros to help fill
 I3C/I2C device's reg property
From:   Joe Perches <joe@perches.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Date:   Wed, 03 Oct 2018 11:37:17 -0700
In-Reply-To: <20181003132212.12619-6-boris.brezillon@bootlin.com>
References: <20181003132212.12619-1-boris.brezillon@bootlin.com>
         <20181003132212.12619-6-boris.brezillon@bootlin.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-03 at 15:22 +0200, Boris Brezillon wrote:
> The reg property of devices connected to an I3C bus have 3 cells, and
> filling them manually is not trivial. Provides macros to help doing
> that.

This patch logic seems excessively fragile.

> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v8:
> - None
> 
> Changes in v5:
> - none
> ---
>  include/dt-bindings/i3c/i3c.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 include/dt-bindings/i3c/i3c.h
> 
> diff --git a/include/dt-bindings/i3c/i3c.h b/include/dt-bindings/i3c/i3c.h
> new file mode 100644
> index 000000000000..97448c546649
> --- /dev/null
> +++ b/include/dt-bindings/i3c/i3c.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2017 Cadence Design Systems Inc.
> + *
> + * Author: Boris Brezillon <boris.brezillon@bootlin.com>
> + */
> +
> +#ifndef _DT_BINDINGS_I3C_I3C_H
> +#define _DT_BINDINGS_I3C_I3C_H
> +
> +#define IS_I2C_DEV		0x80000000
> +
> +#define I2C_DEV(addr, lvr)					\
> +	(addr) (IS_I2C_DEV | (lvr)) 0x0

This looks to be missing surrounding parentheses.

> +
> +#define I3C_PID(manufid, partid, instid, extrainfo)		\
> +	((manufid) << 1)					\
> +	(((partid) << 16) | ((instid) << 12) | (extrainfo))

This macro doesn't make any sense.  Missing a shift and an or?

> +
> +#define I3C_DEV_WITH_STATIC_ADDR(addr, manufid, partid,		\
> +				 instid, extrainfo)		\
> +	(addr) I3C_PID(manufid, partid, instid, extrainfo)
> +
> +#define I3C_DEV(manufid, partid, instid, extrainfo)		\
> +	I3C_DEV_WITH_STATIC_ADDR(0x0, manufid, partid,		\
> +				 instid, extrainfo)
> +
> +#endif

