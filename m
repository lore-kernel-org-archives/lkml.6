Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933799AbeB1Tng (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:43:36 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47672 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932778AbeB1Tnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:43:35 -0500
Date: Wed, 28 Feb 2018 19:43:23 +0000
From: Russell King <rmk@armlinux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/5] net: phy: Export gen10g_* functions
Message-ID: <20180228194323.GA30733@flint.armlinux.org.uk>
References: <20180228193612.29409-1-f.fainelli@gmail.com>
 <20180228193612.29409-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228193612.29409-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 11:36:09AM -0800, Florian Fainelli wrote:
> In order to remove a fair amount of duplication in the different 10G PHY
> drivers, export all gen10g_* functions to be able to make use of those.

The gen10g functions tend to be barely functional - for example,
gen10g_soft_reset() doesn't do the soft-reset thing, which could be
argued to be a bug, as there's a generic way to do that.

However, doing that for the Marvell 10G driver would be a big mistake.
The PHY crashes if you try to set the reset bit in any of the control
register 1s.

-- 
Russell King
