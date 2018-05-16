Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeEPGov (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 02:44:51 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:50275 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeEPGot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 02:44:49 -0400
Date: Wed, 16 May 2018 08:44:45 +0200
From: Simon Horman <horms@verge.net.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: linux-next: manual merge of the rockchip tree with the renesas
 tree
Message-ID: <20180516064440.xpwm7liozhvx4aro@verge.net.au>
References: <20180503083654.625b1f9b@canb.auug.org.au>
 <20180516113918.1ccdd8ec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516113918.1ccdd8ec@canb.auug.org.au>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen,

On Wed, May 16, 2018 at 11:39:18AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 3 May 2018 08:36:54 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the rockchip tree got a conflict in:
> > 
> >   arch/arm64/configs/defconfig
> > 
> > between commits:
> > 
> >   93f7bfd930c0 ("arm64: defconfig: makes SND_SIMPLE_CARD to module")
> >   ddf3fa8b8a16 ("arm64: defconfig: Enable CONFIG_SND_AUDIO_GRAPH_CARD")
> > 
> > from the renesas tree and commit:
> > 
> >   e9cfce4195ec ("arm64: defconfig: Enable HID over I2C drivers")
> > 
> > from the rockchip tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.

The resolution looks correct to me.

As the renesas tree reaches Linus via the arm-soc tree I believe
this is likely best resolved by the arm-soc maintainers once I
send them a pull-request for the renesas tree. And I do not expect
it to bubble-up to Linus.

> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> > 
> > diff --cc arch/arm64/configs/defconfig
> > index 7930caf5dde4,34037d24fbf4..000000000000
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@@ -158,9 -157,9 +158,10 @@@ CONFIG_BT_HIDP=
> >   # CONFIG_BT_LE is not set
> >   CONFIG_BT_LEDS=y
> >   # CONFIG_BT_DEBUGFS is not set
> > + CONFIG_BT_HCIBTUSB=m
> >   CONFIG_BT_HCIUART=m
> >   CONFIG_BT_HCIUART_LL=y
> >  +CONFIG_BT_HCIUART_BCM=y
> >   CONFIG_CFG80211=m
> >   CONFIG_MAC80211=m
> >   CONFIG_MAC80211_LEDS=y
> > @@@ -443,8 -447,8 +451,9 @@@ CONFIG_SND_BCM2835_SOC_I2S=
> >   CONFIG_SND_SOC_SAMSUNG=y
> >   CONFIG_SND_SOC_RCAR=m
> >   CONFIG_SND_SOC_AK4613=m
> >  -CONFIG_SND_SIMPLE_CARD=y
> >  +CONFIG_SND_SIMPLE_CARD=m
> >  +CONFIG_SND_AUDIO_GRAPH_CARD=m
> > + CONFIG_I2C_HID=m
> >   CONFIG_USB=y
> >   CONFIG_USB_OTG=y
> >   CONFIG_USB_XHCI_HCD=y
> 
> This is now a conflict between the renesas tree and the arm-soc tree.
> 
> -- 
> Cheers,
> Stephen Rothwell
