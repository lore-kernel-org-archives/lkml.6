Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeEJUGI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 16:06:08 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36642 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeEJUGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 16:06:06 -0400
Date: Thu, 10 May 2018 16:06:05 -0400 (EDT)
Message-Id: <20180510.160605.647342025298485325.davem@davemloft.net>
To: dmurphy@ti.com
Cc: andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: phy: DP83TC811: Introduce support for the
 DP83TC811 phy
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180509140902.16636-1-dmurphy@ti.com>
References: <20180509140902.16636-1-dmurphy@ti.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>
Date: Wed, 9 May 2018 09:09:02 -0500

> Add support for the DP83811 phy.
> 
> The DP83811 supports both rgmii and sgmii interfaces.
> There are 2 part numbers for this the DP83TC811R does not
> reliably support the SGMII interface but the DP83TC811S will.
> 
> There is not a way to differentiate these parts from the
> hardware or register set.  So this is controlled via the DT
> to indicate which phy mode is required.  Or the part can be
> strapped to a certain interface.
> 
> Data sheet can be found here:
> http://www.ti.com/product/DP83TC811S-Q1/description
> http://www.ti.com/product/DP83TC811R-Q1/description
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v2 - Remove extra config_init in reset, update config_init call back function
> fix a checkpatch alignment issue, add SGMII check in autoneg api - https://patchwork.kernel.org/patch/10389323/

Hello Dan, just a few coding style fixes:

> +static int dp83811_set_wol(struct phy_device *phydev,
> +			   struct ethtool_wolinfo *wol)
> +{
> +	struct net_device *ndev = phydev->attached_dev;
> +	u16 value;
> +	const u8 *mac;

Please order local variables longest to shortest line.

> +static void dp83811_get_wol(struct phy_device *phydev,
> +			    struct ethtool_wolinfo *wol)
> +{
> +	int value;
> +	u16 sopass_val;

Likewise.

> +static int dp83811_config_aneg(struct phy_device *phydev)
> +{
> +	int err;
> +	int value;

Likewise.

However, I would recommend that in these functions having two
integer local variables that you just declare them both on the
same line like:

	int err, value;

> +static int dp83811_config_init(struct phy_device *phydev)
> +{
> +	int err;
> +	int value;

Likewise.

Thank you.
