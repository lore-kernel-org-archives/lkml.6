Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753479AbeDQM4d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:56:33 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59269 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753149AbeDQM4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:56:31 -0400
Date: Tue, 17 Apr 2018 14:56:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
Cc: robh@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, marcel@holtmann.org,
        devicetree@vger.kernel.org, alexandru.marginean@nxp.com,
        madalin.bucur@nxp.com
Subject: Re: [PATCH net-next 3/3] net: phy: Enable C45 PHYs with vendor
 specific address space
Message-ID: <20180417125627.GF2591@lunn.ch>
References: <20180417090233.21548-1-vicentiu.galanopulo@nxp.com>
 <20180417090233.21548-4-vicentiu.galanopulo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417090233.21548-4-vicentiu.galanopulo@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 04:02:33AM -0500, Vicentiu Galanopulo wrote:
> A search of the dev-addr property is done in of_mdiobus_register.
> If the property is found in the PHY node, of_mdiobus_register_vend_spec_phy()
> is called. This is a wrapper function for of_mdiobus_register_phy()
> which finds the device in package based on dev-addr, and fills
> devices_addrs, which is a new field added to phy_c45_device_ids.
> This new field will store the dev-addr property on the same index
> where the device in package has been found.
> 
> The of_mdiobus_register_phy() now contains an extra parameter,
> which is struct phy_c45_device_ids *c45_ids.
> If c45_ids is not NULL, get_vend_spec_addr_phy_device() is called
> and c45_ids are propagated all the way to get_phy_c45_ids().
> 
> Having dev-addr stored in devices_addrs, in get_phy_c45_ids(),
> when probing the identifiers, dev-addr can be extracted from
> devices_addrs and probed if devices_addrs[current_identifier] is not 0.

This still needs work. But i don't want David to see the two
Reviewed-by and think the series is O.K. So lets make it clear

NACK

More comments to follow.

    Andrew
