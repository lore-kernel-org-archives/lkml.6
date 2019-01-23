Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783FBC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCE421855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QgHpwjDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfAWWl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:41:58 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59178 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfAWWl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7FbRa8LdaBNYPzPBO45S/ysbGyJ6rpIiYHP30o/cmGk=; b=QgHpwjDyRnvfCqVQswg0IWD8w
        fxmUJSHBAUnoZyNBYbuVtExlG7lJkyHKuL59uUcH9fAdK7GntaIZTIT6YC/oGaWMDEN5sGSxK/yRo
        H3XJgW5bm1ExfuBDPbEhHcnqiliz+Z3yQlE3eHZ2KSQKUI5LkI2lK/Gg1kBtipQcOgZJ8=;
Received: from e5254000004ec.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49426 helo=shell.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gmRDN-0006Ie-If; Wed, 23 Jan 2019 22:41:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gmRDM-0002sh-No; Wed, 23 Jan 2019 22:41:44 +0000
Date:   Wed, 23 Jan 2019 22:41:44 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
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
Message-ID: <20190123224144.imzntelxqtf3xcuj@e5254000004ec.dyn.armlinux.org.uk>
References: <04b323d7-2a30-eaa5-8268-a7d3f30d989c@huawei.com>
 <20181215103736.GG26090@n2100.armlinux.org.uk>
 <1b4d7886-06c4-9d15-ef72-83318419b30e@huawei.com>
 <20181217143633.GH26090@n2100.armlinux.org.uk>
 <6e8034d9-cd60-2846-ef33-f8a04069e1ee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e8034d9-cd60-2846-ef33-f8a04069e1ee@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 11:28:19AM +0800, Yunsheng Lin wrote:
> On 2018/12/17 22:36, Russell King - ARM Linux wrote:
> > I'll try to do further diagnosis over Christmas in case I've missed
> > something, but I suspect it may be one of those "weird behaviour" issues
> > where the safest action is to disable pause mode as per my commit -
> > which is far saner than having mismatched pause status on either end
> > of a link.  However, given that Marvell specs are all NDA-only, it's
> > very difficult to investigate beyond "this is the observed behaviour".
> 
> Hi,
> 
> Is there any update on the further diagnosis?

Hi,

I've finally been able to do some further diagnosis (with a 'scope).
It would appear that the network adapter had PHY polling enabled,
which meant that it overwrote the PHYs advertisement register
during negotiation.  I thought I'd checked that scenario, but alas
clearing the PHY poll enable bit on its own doesn't stop it polling!

I'll send a revert for the commit shortly.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
