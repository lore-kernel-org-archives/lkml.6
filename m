Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033291AbeBNREX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:04:23 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36478 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032907AbeBNREU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:04:20 -0500
X-Google-Smtp-Source: AH8x226iRTxYMQyNMO1//5mGwdIO/RrTt9PrWJRK4Ikijyz4x1HZE+bWVqolwPmLHM3K8KUYfDKeOA==
Date: Wed, 14 Feb 2018 09:04:12 -0800
In-Reply-To: <1518624432-15110-1-git-send-email-d.schultz@phytec.de>
References: <1518624432-15110-1-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v3 1/2] net: phy: dp83867: Add binding for the CLK_OUT pin muxing option
To: Daniel Schultz <d.schultz@phytec.de>, robh+dt@kernel.org,
        mark.rutland@arm.com, andrew@lunn.ch, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
CC: w.egorov@phytec.de
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4CCCD320-91E4-4FCD-A467-FD323BAB2427@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1EH4UNE017570

On February 14, 2018 8:07:11 AM PST, Daniel Schultz <d.schultz@phytec.de> wrote:
>From: Wadim Egorov <w.egorov@phytec.de>
>
>The DP83867 has a muxing option for the CLK_OUT pin. It is possible
>to set CLK_OUT for different channels.
>Create a binding to select a specific clock for CLK_OUT pin.
>
>Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>---
>Changes:
>	v2:
>	  Added check if clk_output_sel has a valid value
>	  Only write the clock ouput register if a musing is desired
>	v3:
>	  -
>
> drivers/net/phy/dp83867.c            | 19 +++++++++++++++++++
> include/dt-bindings/net/ti-dp83867.h | 14 ++++++++++++++
> 2 files changed, 33 insertions(+)
>
>diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
>index c1ab976..a862194 100644
>--- a/drivers/net/phy/dp83867.c
>+++ b/drivers/net/phy/dp83867.c
>@@ -75,6 +75,8 @@
> 
> #define DP83867_IO_MUX_CFG_IO_IMPEDANCE_MAX	0x0
> #define DP83867_IO_MUX_CFG_IO_IMPEDANCE_MIN	0x1f
>+#define DP83867_IO_MUX_CFG_CLK_O_SEL_MASK	(0x1f << 8)
>+#define DP83867_IO_MUX_CFG_CLK_O_SEL_SHIFT	8
> 

Nit: it looks like you could use the shift constant you define for defining the mask as well.

Other than that:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

-- 
Florian
