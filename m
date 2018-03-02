Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934608AbeCBX1Q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:27:16 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:6767 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S934230AbeCBX1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:27:15 -0500
X-UUID: d2b64133b6474cf793904b76986f70aa-20180303
Message-ID: <1520033229.8089.198.camel@mtkswgap22>
Subject: Re: [PATCH v1 16/19] arm: dts: mt7623: fixup available memory size
 on bananapi-r2
From: Sean Wang <sean.wang@mediatek.com>
To: Rob Herring <robh@kernel.org>
CC: <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Sat, 3 Mar 2018 07:27:09 +0800
In-Reply-To: <20180302154215.xr3b2zlmuojw5i6l@rob-hp-laptop>
References: <cover.1519378871.git.sean.wang@mediatek.com>
         <e49485aac14bec85c14514c1953f8d7ea5401695.1519378872.git.sean.wang@mediatek.com>
         <20180302154215.xr3b2zlmuojw5i6l@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-02 at 09:42 -0600, Rob Herring wrote:
> On Fri, Feb 23, 2018 at 06:16:36PM +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > There is 2GB DDR3 available on bananapi-r2 board as [1] specified.
> > 
> > [1] http://www.banana-pi.org/r2.html
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> > index 140ff78..3e8d02c 100644
> > --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> > +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> > @@ -38,6 +38,11 @@
> >  			default-state = "off";
> >  		};
> >  	};
> > +
> > +	memory {
> 
> Unit address?
> 

If I did it with adding unit address

-       memory {
+       memory@80000000 {
                device_type = "memory";
                reg = <0 0x80000000 0 0x80000000>;
        };


bad dtc blob is being generated and contains two memory nodes, one is
memory and the other is memory@80000000 whose blob disassembly detail is
as the following.

      memory {
                device_type = "memory";
                reg = <0x0 0x0 0x0 0x0>;
        };



      memory@80000000 {
                device_type = "memory";
                reg = <0x0 0x80000000 0x0 0x80000000>;
        };


and bad memory node with size 0 would cause the boot fails.


is it a dtc compiler problem ?

> > +		device_type = "memory";
> > +		reg = <0 0x80000000 0 0x80000000>;
> > +	};
> >  };
> >  
> >  &afe {
> > -- 
> > 2.7.4
> > 
