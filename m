Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeC0Nru (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:47:50 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43599 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752538AbeC0Nrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:47:47 -0400
Date: Tue, 27 Mar 2018 15:47:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, ssantosh@kernel.org,
        malat@debian.org, w-kwok2@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [net-next PATCH 3/5] net: netcp: ethss enhancements to support
 2u cpsw h/w on K2G SoC
Message-ID: <20180327134736.GJ5862@lunn.ch>
References: <1522095312-23249-1-git-send-email-m-karicheri2@ti.com>
 <1522095312-23249-4-git-send-email-m-karicheri2@ti.com>
 <20180326202842.GB5862@lunn.ch>
 <be58cf50-2148-cbfa-c7a2-8f4fbe6930e5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be58cf50-2148-cbfa-c7a2-8f4fbe6930e5@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello Andrew,
> 
> Thanks for the comment. But I am not sure how to break this up as this is 
> an enhancement to the driver to support a newer version of the cspw 
> hardware. Without all these pieces together, the driver can't
> function.

Hi Murali

A few things to consider.

1) You can introduce new features needed by the new hardware one piece
at a time. The new hardware will then work when all the pieces have
been added. This is fine, the new hardware never worked before, so you
are not breaking anything.

2) Your changes could break the old hardware. By having lots of small
changes, you can do a git bissect and find which of the small changes
broke it.

3) It is much easier to review 10 small obviously correct patches than
one huge complex patch, which is not obvious.

> Probably I can make the below break up based on different functions
> added. Let me know if this looks good to you. Beware that patch #2 and
> #3 are small patches and majority of code change will be in patch #1
> which has to go together. 
> 
> Patch #1. Add support new link interface, RGMII_LINK_MAC_PHY, for K2G
>           - Most of the code is for this
> Patch #2. Add support for configuring phy_mode 
>           - This just add phy_mode handling code 
> Patch #3. map all vlan priorities to flow id 0

That sounds better.

Thanks
	Andrew
