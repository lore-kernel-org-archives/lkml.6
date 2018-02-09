Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeBIUIN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 15:08:13 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:46445 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbeBIUIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 15:08:12 -0500
X-Google-Smtp-Source: AH8x225SWWfhggof1tw6wknQR96u9YHdgBAYAWv2HwHu8smhwHTWtZG/mgAAXOzwvczgTZQak5VpshYKCX3lXDphYHI=
MIME-Version: 1.0
In-Reply-To: <20180209170358.7227-2-sebastian.reichel@collabora.co.uk>
References: <20180209170358.7227-1-sebastian.reichel@collabora.co.uk> <20180209170358.7227-2-sebastian.reichel@collabora.co.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 9 Feb 2018 18:08:11 -0200
Message-ID: <CAOMZO5BvV8W0ORUG4K6OXE8OuZRn6Az6PeYd8niHe=RgzWJskw@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] ARM: imx53: add secure-reg-access support for PMU
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, kernel@collabora.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 3:03 PM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:

> +       gpc_reg = ioremap(MXC_CORTEXA8_PLAT_GPC, 4);
> +       if (!gpc_reg) {
> +               pr_warning("unable to map GPC to enable perf\n");
> +               return;
> +       }
> +
> +       gpc = __raw_readl(gpc_reg);

You could use readl_relaxed() instead.

> +       gpc |= GPC_DBG_EN;
> +       __raw_writel(gpc, gpc_reg);

You could use writel_relaxed() instead.

> +
> +       return;

This 'return' can be removed.

> +}
