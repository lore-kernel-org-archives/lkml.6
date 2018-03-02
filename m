Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423084AbeCBIpw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:45:52 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45389 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423071AbeCBIps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:45:48 -0500
X-Google-Smtp-Source: AG47ELuaL5VaPw4DHKU1ARtvX+TYC8AUOxh5KGbw+ZYFBF/u+nAl/+LO+6NvXjWEOvv8lvDwLfvUTQ==
Date: Fri, 2 Mar 2018 16:45:18 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Jianguo Sun <sunjianguo1@huawei.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pengcheng Li <lpc.li@hisilicon.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: add bindings doc for HiSilicon INNO
 USB2 PHY
Message-ID: <20180302084516.GD28619@dragon>
References: <1519888940-23235-1-git-send-email-shawn.guo@linaro.org>
 <1519888940-23235-2-git-send-email-shawn.guo@linaro.org>
 <c1f60df2-20d1-53ac-6cf7-9c81baea789c@ti.com>
 <20180302073740.GC28619@dragon>
 <05d00dd2-efe2-1166-d982-06df0e3b8611@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05d00dd2-efe2-1166-d982-06df0e3b8611@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 01:35:43PM +0530, Kishon Vijay Abraham I wrote:
> >>> diff --git a/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
> >>> new file mode 100644
> >>> index 000000000000..b563cf54ca7b
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
> >>> @@ -0,0 +1,52 @@
> >>> +HiSilicon INNO USB2 PHY
> >>> +
> >>> +Required properties:
> >>> +- compatible: Should be one of the following strings:
> >>> +	"hisilicon,inno-usb2-phy",
> >>> +	"hisilicon,hi3798cv200-usb2-phy".
> >>> +- reg: Should be the address space for PHY configuration register in peripheral
> >>> +  controller, e.g. PERI_USB0 for USB 2.0 PHY01 on Hi3798cv200 SoC.
> >>> +- #phy-cells: Should be 1. The specifier is the index of the PHY port to
> >>> +  reference.
> >>
> >> This can be '0' if the consumers directly use phandle to the subnodes.
> > 
> > Yes, I understand that for most of PHY devices #phy-cells is just 0, and
> > consumers simply use the phandle without any cell number.  But for this
> > inno-usb2-phy, every single device contains two PHY ports, and each port
> 
> Why not have a separate sub-node for each phy port? Then you can just use
> phandle to the subnode in the controller node.

It sounds like a sensible suggestion.  I will try to implement that and
see how it goes.  Thanks.

Shawn
