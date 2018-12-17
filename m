Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4BCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0ED206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D9artyLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbeLQOgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:36:52 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54494 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbeLQOgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ULRHLz4h6TClbDra72V0KnlyqFRdAtyCuNZWuGF6Ieg=; b=D9artyLG2qJA5yM7RElvhs3Ep
        j33PYOHwGWI/GSX7Ej115bnx4rbEQDxB8ticBQmfJUM+205lGVP7oIwTHUnzyAnJ54RJxcbX1M5IJ
        rVFNSKuNvlPm62khwTvF4RcfQcwMBWnEHf5xfHJMZOUPoqX97SUP2ZQMsi5iOUgF/l/Uk=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:58346)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gYu0c-0000kg-OG; Mon, 17 Dec 2018 14:36:38 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gYu0Z-0002jA-Q5; Mon, 17 Dec 2018 14:36:35 +0000
Date:   Mon, 17 Dec 2018 14:36:34 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Weiwei Deng <dengweiwei@huawei.com>,
        "Yisen.Zhuang@huawei.com" <Yisen.Zhuang@huawei.com>,
        "huangdaode@hisilicon.com" <huangdaode@hisilicon.com>,
        "lipeng321@huawei.com" <lipeng321@huawei.com>,
        "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
        lijianhua 00216010 <lijianhua@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question: pause mode disabled for marvell 88e151x phy
Message-ID: <20181217143633.GH26090@n2100.armlinux.org.uk>
References: <04b323d7-2a30-eaa5-8268-a7d3f30d989c@huawei.com>
 <20181215103736.GG26090@n2100.armlinux.org.uk>
 <1b4d7886-06c4-9d15-ef72-83318419b30e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b4d7886-06c4-9d15-ef72-83318419b30e@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 05:42:20PM +0800, Yunsheng Lin wrote:
> On 2018/12/15 18:37, Russell King - ARM Linux wrote:
> > On Sat, Dec 15, 2018 at 04:07:42PM +0800, Yunsheng Lin wrote:
> >> There seems to be some problem with pause subsequent negotiation.
> >> We reverted the above patch and tried to reproduce the above problem
> >> by triggering another negotiation by reconnection of the cable, using
> >> ethtool -a cmd shows both still have tx and rx pause enable.
> > 
> > That's where the problem is - as far as the network device and Linux
> > is concerned, pause was successfully negotiated.  However, as the
> > advertisment register has ended up with the pause mode bits cleared,
> > Linux doesn't realise that what we conveyed to the partner was an
> > advertisment containing no pause mode bits.
> > 
> > ethtool doesn't read the PHY advertisment register when displaying
> > what we advertised, it returns what's in phydev->advertising - it
> > gives you the cached value not the this-is-what-the-hardware-is-doing
> > value.
> > 
> >> 1. Does all the 88e151x supporting SGMII-to-Copper have the above problem?
> > 
> > Unknown.
> > 
> >> 2. If not, can we use revision id field in phydev->phy_id to only disable
> >>    the pause support for specific 88e151x phy? We can not find some useful
> >>    revision info in datasheet, and by printing the phy id when phy init, we
> >>    are able to find that the phy we are using has a phy id as 0x1d10dd1,
> >>    which has revision id as 0x1.
> > 
> > 0x01d10dd1 doesn't look to be a Marvell part - Marvell parts generally
> > start with 0x0141....  Is your 0x1d1 a typo?  My device is 0x01410dd1.
> 
> Sorry, 0x1d1 is a typo.
> My device is also 0x01410dd1.
> 
> > 
> >> 3. Does this problem only happen marvel 88e1512 phy with some specific partner
> >>    phy? We are unable to reproduce this problem, so any suggestion to reproduce
> >>    this would be very helpful to us too.
> > 
> > I don't think you've proven that you do not have a problem (see below
> > for how to do this.)
> > 
> >> 4. Also the commit disables the pause support completely, if using revision id
> >>    can not aviod this problem, can we only disable pause support when negotiation
> >>    by only clearing pause support in phydev->advertising, but not phydev->supported?
> > 
> > No comment at present.
> > 
> > 
> > I think you first need to ensure that your observations are correct.
> > You are basing your assumptions on ethtool -a's output, which is
> > definitely wrong as I've mentioned above.
> > 
> > You need to read directly from the hardware using mii-diag -v ethN
> > and manually decode the advertisment register (register 4) checking
> > bits 11 and 10 (the pause mode bits).  My observation is that Linux
> > can set these bits, but then both bits clear during the negotiation
> > process.
> 
> Thanks for the info.
> 
> Using arm64 with marvel 88e1512 phy connected to a X86 with intel phy,
> The 88e1512 phy' advertisment register did change after negotiation:
> 
> arm64 with marvel 88e1512 phy:
>  MII PHY #1 transceiver registers:
>    3100 796d 0141 0dd1 05e1 cde1 000d 2001
>    4006 0200 3800 0000 0000 0003 0000 3000
>    3060 af08 0000 0000 0020 0000 0000 0000
>    0000 0000 0040 0000 0000 0000 0000 0000
> 
> X86 with intel phy:
>    1140 796d 0154 03b1 0de1 c5e1 000d 2001
>    6801 0600 7800 0000 0000 0000 0000 3000
>    0000 000a 840a 1075 0000 000c ff08 3048
>    0000 816c 1ac6 0003 210a 1f55 0000 c064
> 
> But ethtool -a on both arm64 and X86 shows that tx and rx pause are
> both enabled.

I'll say this again, ignore ethtool when it comes to this problem.
ethtool uses cached information to compute the pause settings.

> And in include/linux/mii.h, we have:
> /**
>  * mii_resolve_flowctrl_fdx
>  * @lcladv: value of MII ADVERTISE register
>  * @rmtadv: value of MII LPA register
>  *
>  * Resolve full duplex flow control as per IEEE 802.3-2005 table 28B-3
>  */
> static inline u8 mii_resolve_flowctrl_fdx(u16 lcladv, u16 rmtadv)
> {
> 	u8 cap = 0;
> 
> 	if (lcladv & rmtadv & ADVERTISE_PAUSE_CAP) {
> 		cap = FLOW_CTRL_TX | FLOW_CTRL_RX;
> 	} else if (lcladv & rmtadv & ADVERTISE_PAUSE_ASYM) {
> 		if (lcladv & ADVERTISE_PAUSE_CAP)
> 			cap = FLOW_CTRL_RX;
> 		else if (rmtadv & ADVERTISE_PAUSE_CAP)
> 			cap = FLOW_CTRL_TX;
> 	}
> 
> 	return cap;
> }

Not used by the marvell PHY driver.  It uses this code instead:

                if (phydev->duplex == DUPLEX_FULL) {
                        phydev->pause = lpa & LPA_PAUSE_CAP ? 1 : 0;
                        phydev->asym_pause = lpa & LPA_PAUSE_ASYM ? 1 : 0;
                }

and then its up to the network driver to decide what to do with
phydev->pause and phydev->asym_pause.


> As the comment has pointed to IEEE 802.3-2005 table 28B-3:
> http://www.ismlab.usf.edu/dcom/Ch3_802.3-2005_section2.pdf
> 
> ADVERTISE_PAUSE_ASYM on local and remote is a "Don’t care"
> bit when they both support ADVERTISE_PAUSE_CAP, so maybe it is ok
> that marvel phy clears the ADVERTISE_PAUSE_ASYM bit.

As I've previously stated, the behaviour I've seen is _both_ pause bits
clear:

If I set bit 10 (pause), and read back to confirm:

  MII PHY #0 transceiver registers:
   1000 796d 0141 0dd1 05e1 c5e1 000d 2001
                       ^^^^
   4806 0200 3800 0000 0000 0003 0000 3000
   3060 af48 0000 7c40 0020 0000 0000 0000
   0000 0000 0040 0000 0000 0000 0000 0000.

Now if I trigger a renegotiation of any kind, and read-back the registers:

 MII PHY #0 transceiver registers:
   1000 7949 0141 0dd1 01e1 0000 0004 2001
                       ^^^^
   0000 0200 0000 0000 0000 0003 0000 3000
   3060 8000 0000 0040 0020 0000 0000 0000
   0000 0000 0040 0000 0000 0000 0000 0000.
...
 MII PHY #0 transceiver registers:
   1000 796d 0141 0dd1 01e1 c5e1 000d 2001
                       ^^^^
   4806 0200 3800 0000 0000 0003 0000 3000
   3060 af48 0000 7c40 0020 0000 0000 0000
   0000 0000 0040 0000 0000 0000 0000 0000.

See that register 4 now has the pause bit cleared.

I don't know what causes it, other than the fact it does occur.  My
supposition is that it's something to do with the SGMII connection to
the MAC, possibly a Marvell extension that somehow causes the copper
advertisment register to adopt values from the SGMII side, maybe bits
in the config word embedded in the SGMII stream.  If that is the case,
it's likely to be MAC specific.

I don't have anything further beyond the observed behaviour right now,
and the fact that if the bits are set, then we end up with a mismatched
pause negotiation status (pause apparently negotiated as far as _we_
are concerned, but _not_ as far as the link partner is concerned.)

I'll try to do further diagnosis over Christmas in case I've missed
something, but I suspect it may be one of those "weird behaviour" issues
where the safest action is to disable pause mode as per my commit -
which is far saner than having mismatched pause status on either end
of a link.  However, given that Marvell specs are all NDA-only, it's
very difficult to investigate beyond "this is the observed behaviour".

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
