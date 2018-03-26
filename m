Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeCZU25 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:28:57 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42660 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751134AbeCZU2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:28:55 -0400
Date: Mon, 26 Mar 2018 22:28:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, ssantosh@kernel.org,
        malat@debian.org, w-kwok2@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [net-next PATCH 3/5] net: netcp: ethss enhancements to support
 2u cpsw h/w on K2G SoC
Message-ID: <20180326202842.GB5862@lunn.ch>
References: <1522095312-23249-1-git-send-email-m-karicheri2@ti.com>
 <1522095312-23249-4-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522095312-23249-4-git-send-email-m-karicheri2@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 04:15:10PM -0400, Murali Karicheri wrote:
> K2G SoC uses 2u cpsw h/w. It uses RGMII instead of SGMII to interface with
> Phy. This patch enhances the driver to check RGMII status instead of SGMII
> status for link state determination. Also map all of the vlan priorities
> to zero as the packet DMA is enabled to receive only flow id 0 which maps
> to priority zero.
> 
> Additionally, When a phy with rgmii interface requires internal delay, the
> same is set in the phy driver. To support such phy devices, add a phy-mode
> handling code in the driver using of_get_phy_mode() and pass the obtained
> phy mode to of_phy_connect()

Hi Murali

Please break this patch up. One patch should do one thing. That makes
it easy to review. There are too many things going on at once here.

   Andrew
