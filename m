Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbeCWPot (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:44:49 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40207 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750789AbeCWPos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:44:48 -0400
Date: Fri, 23 Mar 2018 16:44:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        marcel@holtmann.org, devicetree@vger.kernel.org, madalin.bucur@nxp.com,
        alexandru.marginean@nxp.com
Subject: Re: [RFC PATCH v2] net: phy: Added device tree binding for dev-addr
 and dev-addr code check-up
Message-ID: <20180323154441.GE24361@lunn.ch>
References: <20180323150522.9603-1-vicentiu.galanopulo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323150522.9603-1-vicentiu.galanopulo@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/drivers/of/of_mdio.c
> +++ b/drivers/of/of_mdio.c
> @@ -24,6 +24,8 @@
>  
>  #define DEFAULT_GPIO_RESET_DELAY	10	/* in microseconds */
>  
> +struct phy_c45_device_ids mdio_c45_ids = {0};

You do know that Linux is multi-threaded. It could be probing two MDIO
busses at once.

	Andrew
