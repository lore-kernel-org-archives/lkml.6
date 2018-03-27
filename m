Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754658AbeC0RfW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:35:22 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44156 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752416AbeC0RfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:35:19 -0400
Date: Tue, 27 Mar 2018 19:35:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, ssantosh@kernel.org,
        malat@debian.org, w-kwok2@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v2 08/10] net: netcp: ethss: use
 of_get_phy_mode() to support different RGMII modes
Message-ID: <20180327173509.GQ5862@lunn.ch>
References: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
 <1522168309-12338-9-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522168309-12338-9-git-send-email-m-karicheri2@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	} else if (slave->link_interface == RGMII_LINK_MAC_PHY) {
> +		has_phy = true;
> +		phy_mode = of_get_phy_mode(slave->node);
> +		/* if phy-mode is not present, default to
> +		 * PHY_INTERFACE_MODE_RGMII
> +		 */
> +		if (phy_mode < 0)
> +			phy_mode = PHY_INTERFACE_MODE_RGMII;

Can only do RGMII? Maybe add a call here to
phy_interface_mode_is_rgmii() and return -EINVAL if DT contains
something which is not RGMII?

	  Andrew
