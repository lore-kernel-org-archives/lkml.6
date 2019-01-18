Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AA3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD2D20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfARKGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:06:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48936 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfARKGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:06:12 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gkR2L-0003iN-1l; Fri, 18 Jan 2019 11:06:05 +0100
Date:   Fri, 18 Jan 2019 11:06:04 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Liming Sun <lsun@mellanox.com>
cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH v7 1/3] mmc: dw_mmc-bluefield: Add driver extension
In-Reply-To: <1525805210-15246-1-git-send-email-lsun@mellanox.com>
Message-ID: <alpine.DEB.2.21.1901181059100.1647@nanos.tec.linutronix.de>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com> <1525805210-15246-1-git-send-email-lsun@mellanox.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liming,

On Tue, 8 May 2018, Liming Sun wrote:
> index 0000000..54c3fbb
> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Mellanox Technologies.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */

This license information is broken. The SPDX license identifier and the
boiler plate text are contradicting. The SPDX id is GPL v2 only and the
boiler plate says v2 or later.

Please decide which version you want and fix ASAP. If you fix that up
please add a Fixes: tag and cc stable. While at it please remove the boiler
plate text as the SPDX id is sufficient and the boiler plate is redundant
information.

See Documentation/process/license-rules.txt

Thanks,

	tglx
