Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E63C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5862184A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pTU3EHmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeLRKIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:08:46 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39564 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRKIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OUCiSjoChwo6pFqvAnFruLEN7MYvs3SxtRQrk2w6LkE=; b=pTU3EHmrrvfwFX0Ev8iRaBgIm
        zB/p/0G3AC7h7UNnRi7tklBp2LdRcX0Rvz3MH3otxCM/B3NgLhKr53xatef86Vd3X0IB2ZKL4Pq16
        nE9P3ldS0fFCKOwC9H8YgyK3MYKe2wcfy9o7GGZY5lqBdoWSzj5iB7W6cjRp9MidqfjZE=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:43020)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gZCIl-0005Un-Dr; Tue, 18 Dec 2018 10:08:35 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gZCIi-0005oe-4Z; Tue, 18 Dec 2018 10:08:32 +0000
Date:   Tue, 18 Dec 2018 10:08:30 +0000
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
Message-ID: <20181218100830.GK26090@n2100.armlinux.org.uk>
References: <04b323d7-2a30-eaa5-8268-a7d3f30d989c@huawei.com>
 <20181215103736.GG26090@n2100.armlinux.org.uk>
 <1b4d7886-06c4-9d15-ef72-83318419b30e@huawei.com>
 <20181217143633.GH26090@n2100.armlinux.org.uk>
 <35342e11-cfb9-00ab-0abd-448054bd7564@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35342e11-cfb9-00ab-0abd-448054bd7564@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 05:34:27PM +0800, Yunsheng Lin wrote:
> On 2018/12/17 22:36, Russell King - ARM Linux wrote:
> > As I've previously stated, the behaviour I've seen is _both_ pause bits
> > clear:
> > 
> > If I set bit 10 (pause), and read back to confirm:
> > 
> >   MII PHY #0 transceiver registers:
> >    1000 796d 0141 0dd1 05e1 c5e1 000d 2001
> >                        ^^^^
> >    4806 0200 3800 0000 0000 0003 0000 3000
> >    3060 af48 0000 7c40 0020 0000 0000 0000
> >    0000 0000 0040 0000 0000 0000 0000 0000.
> > 
> > Now if I trigger a renegotiation of any kind, and read-back the registers:
> > 
> >  MII PHY #0 transceiver registers:
> >    1000 7949 0141 0dd1 01e1 0000 0004 2001
> >                        ^^^^
> >    0000 0200 0000 0000 0000 0003 0000 3000
> >    3060 8000 0000 0040 0020 0000 0000 0000
> >    0000 0000 0040 0000 0000 0000 0000 0000.
> > ...
> >  MII PHY #0 transceiver registers:
> >    1000 796d 0141 0dd1 01e1 c5e1 000d 2001
> >                        ^^^^
> >    4806 0200 3800 0000 0000 0003 0000 3000
> >    3060 af48 0000 7c40 0020 0000 0000 0000
> >    0000 0000 0040 0000 0000 0000 0000 0000.
> > 
> > See that register 4 now has the pause bit cleared.
> 
> I wonder when the the pause bit was clear, is it during negotiation
> process or after negotiation? if the partner phy see the pause bit before
> the pause bit is clear?

As was stated in the original commit:

    While these bits may be correctly conveyed to the link partner on the
    first negotiation, a subsequent negotiation (eg, due to negotiation
    restart by the link partner, or reconnection of the cable) will result
    in the link partner seeing these bits as zero, while the kernel
    believes that it has advertised pause modes.

To state in a different way:

    On the _first_ negotiation, the pause bits as seen by the link partner
    will be what we wrote into the register.  However, during that
    negotiation the bits in the register clear _after_ the base page has
    been sent to the link partner.

    A subsequent negotiation will send the now-clear pause bits to the
    link partner.

I hope that's now clear.

> Also, it seems the phy driver always set the pause bit back before
> begining a negotiation. But I am not sure it makes a difference here.

There is a world of difference between asking the kernel to do a
renegotiation, and unplugging/replugging the cable, or asking the
link partner to do a renegotiation.

In the former case, yes, the kernel will reprogram the advertisement
register.  In the latter two cases, the kernel does not and this is
where the problem occurs.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
