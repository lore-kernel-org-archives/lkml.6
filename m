Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeC0OYR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:24:17 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43729 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752305AbeC0OYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:24:16 -0400
Date: Tue, 27 Mar 2018 16:24:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?VmljZW7Fo2l1?= Galanopulo <vicentiu.galanopulo@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>
Subject: Re: [RFC PATCH v2] net: phy: Added device tree binding for dev-addr
 and dev-addr code check-up
Message-ID: <20180327142408.GL5862@lunn.ch>
References: <20180323150522.9603-1-vicentiu.galanopulo@nxp.com>
 <20180326222509.ppt5aqzqdarhm44d@rob-hp-laptop>
 <HE1PR0402MB3578B3D33160EBE59C2FD7D7EEAC0@HE1PR0402MB3578.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0402MB3578B3D33160EBE59C2FD7D7EEAC0@HE1PR0402MB3578.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is a 2nd MDIO address, right? Can't you just append this to reg property?

Hi Rob

It is a sub address.

There are two different MDIO addressing schemes. Clause 22 allowed for
32 different addresses on an MDIO bus. Clause 45 extended that. You
have the existing 32 addresses for a package. However, within a
package, you can have 32 devices.

You are supposed to be able to look are registers inside the package,
and it will tell you which devices in the packages are in use. You can
then look at those devices and figure out what they are using ID
registers.

However some vendors get this wrong, they don't fill in the devices in
package information. So the generic probe code never finds them. We
need to pass it a hint, go looking at this specific device in the
package.

You can mix Clause 22 and Clause 45 on the same bus. Does DT allow two
different reg formats to be used at once? Can we have some reg
properties with a single value, and some with two values? I thought
#address-cells = <1> means there should be a single address in reg.

	Andrew
