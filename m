Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeEWAPL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:15:11 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41417 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751340AbeEWAPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:15:10 -0400
Date: Wed, 23 May 2018 02:15:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, arunp@broadcom.com,
        "David S. Miller" <davem@davemloft.net>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE"
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: phy: broadcom: Fix bcm_write_exp()
Message-ID: <20180523001503.GA16062@lunn.ch>
References: <20180523000450.9384-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523000450.9384-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 05:04:49PM -0700, Florian Fainelli wrote:
> On newer PHYs, we need to select the expansion register to write with
> setting bits [11:8] to 0xf. This was done correctly by bcm7xxx.c prior
> to being migrated to generic code under bcm-phy-lib.c which
> unfortunately used the older implementation from the BCM54xx days.

Hi Florian

Does selecting the expansion register affect access to the standard
registers? Does this need locking like the Marvell PHY has when
changing pages?

Thanks
	 Andrew
