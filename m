Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeEQMlh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:41:37 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34489 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbeEQMlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:41:36 -0400
Date: Thu, 17 May 2018 14:41:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next 1/2] net: phy: sfp: make the i2c-bus property
 really optional
Message-ID: <20180517124127.GG8547@lunn.ch>
References: <20180517082907.14420-1-antoine.tenart@bootlin.com>
 <20180517082907.14420-2-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517082907.14420-2-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 10:29:06AM +0200, Antoine Tenart wrote:
> The SFF,SFP documentation is clear about making all the DT properties,
> with the exception of the compatible, optional. In practice this is not
> the case and without an i2c-bus property provided the SFP code will
> throw NULL pointer exceptions.
> 
> This patch is an attempt to fix this.

Hi Antoine, Russell

How usable is an SFF/SFP module without access to the i2c EEPROM? I
guess this comes down to link speed. Can it be manually configured?

I'm just wondering if we want to make this mandatory? Fail the probe
if it is not listed?

	Andrew
