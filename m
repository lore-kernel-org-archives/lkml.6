Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbeFDVPw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:15:52 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:46690 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeFDVPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:15:50 -0400
X-Google-Smtp-Source: ADUXVKKhktmd4+1r6/FMf1Azqvdowp/4AXwkrw+lTBsXP2P0fWMTyTJiai1r9d4Qjpo4N7fJCo/hxQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>, Doug Berger <opendmb@gmail.com>,
        Justin Chen <justinpopo6@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] soc: bcm: brcmstb: Add missing DDR MEMC compatible strings
Date: Mon,  4 Jun 2018 14:15:46 -0700
Message-Id: <20180604211546.21349-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180511220242.837-3-f.fainelli@gmail.com>
References: <20180511220242.837-1-f.fainelli@gmail.com> <20180511220242.837-3-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2018 15:02:42 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
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

Applied to drivers/next, thanks!
--
Florian
