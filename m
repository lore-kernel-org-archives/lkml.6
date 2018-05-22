Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753444AbeEVWbi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 18:31:38 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36535 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbeEVWbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 18:31:35 -0400
X-Google-Smtp-Source: AB8JxZqAFgEIHR4TWLtKSdEn+jnbg7SNXUf8YPKZHi9/Mz7x3xQhH63Dc2Sb+MkSQze4mWar4ibiLg==
Date: Tue, 22 May 2018 17:31:33 -0500
From: Rob Herring <robh@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
        <bcm-kernel-feedback-list@broadcom.com>,
        Doug Berger <opendmb@gmail.com>, Justin Chen <justinpopo6@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] soc: bcm: brcmstb: Add missing DDR MEMC compatible
 strings
Message-ID: <20180522223133.GA11292@rob-hp-laptop>
References: <20180511220242.837-1-f.fainelli@gmail.com>
 <20180511220242.837-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511220242.837-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 03:02:42PM -0700, Florian Fainelli wrote:
> We would not be matching the following chip/compatible strings
> combinations, which would lead to not setting the warm boot flag
> correctly, fix that:
> 
>     7260A0/B0: brcm,brcmstb-memc-ddr-rev-b.2.1
>     7255A0: brcm,brcmstb-memc-ddr-rev-b.2.3
>     7278Bx: brcm,brcmstb-memc-ddr-rev-b.3.1
> 
> The B2.1 core (which is in 7260 A0 and B0) doesn't have the
> SHIMPHY_ADDR_CNTL_0_DDR_PAD_CNTRL setup in the memsys init code, nor
> does it have the warm boot flag re-definition on entry. Those changes
> were for B2.2 and later MEMSYS cores. Fall back to the previous S2/S3
> entry method for these specific chips.
> 
> Fixes: 0b741b8234c8 ("soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt |  3 +++
>  drivers/soc/bcm/brcmstb/pm/pm-arm.c                        | 12 ++++++++++++
>  2 files changed, 15 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
