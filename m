Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161256AbeBNReJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:34:09 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55795 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161026AbeBNReI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:34:08 -0500
Date: Wed, 14 Feb 2018 18:34:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Miller <davem@davemloft.net>
Cc: hau@realtek.com, netdev@vger.kernel.org, nic_swsd@realtek.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH net-next] r8169: add module param for control of
 ASPM disable.
Message-ID: <20180214173403.GI12307@lunn.ch>
References: <1518598965-3593-1-git-send-email-hau@realtek.com>
 <20180214134040.GB22014@lunn.ch>
 <20180214.122202.330947258009140771.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214.122202.330947258009140771.davem@davemloft.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 12:22:02PM -0500, David Miller wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> Date: Wed, 14 Feb 2018 14:40:40 +0100
> 
> > linux/drivers$ grep -ir aspm * | grep MODULE_
> > gpu/drm/amd/amdgpu/amdgpu_drv.c:MODULE_PARM_DESC(aspm, "ASPM support (1 = enable, 0 = disable, -1 = auto)");
> > gpu/drm/radeon/radeon_drv.c:MODULE_PARM_DESC(aspm, "ASPM support (1 = enable, 0 = disable, -1 = auto)");
> > infiniband/hw/hfi1/pcie.c:MODULE_PARM_DESC(aspm, "PCIe ASPM: 0: disable, 1: enable, 2: dynamic");
> > net/wireless/realtek/rtlwifi/rtl8192ee/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
> > net/wireless/realtek/rtlwifi/rtl8188ee/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
> > net/wireless/realtek/rtlwifi/rtl8821ae/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
> > net/wireless/realtek/rtlwifi/rtl8192se/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
> > net/wireless/realtek/rtlwifi/rtl8192ce/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
> > net/wireless/realtek/rtlwifi/rtl8723be/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
> > net/wireless/realtek/rtlwifi/rtl8192de/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
> > net/wireless/realtek/rtlwifi/rtl8723ae/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
> > staging/rts5208/rtsx.c:MODULE_PARM_DESC(aspm_l0s_l1_en, "enable device aspm");
> > staging/rtlwifi/rtl8822be/sw.c:MODULE_PARM_DESC(aspm, "Set to 1 to enable ASPM (default 1)\n");
> > 
> > This patch seems to have the exact opposite of everybody else already
> > does.
> > 
> > Maybe you can follow the AMD example, and default to -1, since you are
> > proposing to mostly have it enabled, but disabled in one case?
> 
> This is just another good reminder of why module parameters are a
> terrible user experience for just about anything device configuration
> related.

Agreed.

I took a look at see if there was some other way to do this. Maybe the
pcie core had a callback or something. Nope.

> For users, this leads to misery.

At least in this case, the misery is mostly limited to realtek
users. Nearly everybody else seems to get it right and not need such a
hack.

	Andrew
