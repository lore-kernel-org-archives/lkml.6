Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeDILRr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:17:47 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38800 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeDILRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:17:45 -0400
Date: Mon, 9 Apr 2018 12:17:33 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] Add tda998x (HDMI) support to atmel-hlcdc
Message-ID: <20180409111733.GP16141@n2100.armlinux.org.uk>
References: <20180409105918.20792-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409105918.20792-1-peda@axentia.se>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 12:59:13PM +0200, Peter Rosin wrote:
> During this, I found that the tda998x driver never sets the format in
> the connector display_info. Thus, the atmel-hlcdc driver fails to select
> output format. Since I had similar problems with ds90c185 lvds encoder
> I added patches to override the atmel-hlcdc output format via a DT
> property and things start to play together.

That sounds like a hack.  The tda998x driver doesn't set the format
because it pre-dates the addition of this information in the display
info structure, and none of its current users require that information.

As you're the first to require it, rather than working around the
driver by adding stuff to DT, it would be much better to improve the
driver by adding this information.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
