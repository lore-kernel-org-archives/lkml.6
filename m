Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5F0C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32C92086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JI1syW+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32C92086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeKHKPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 05:15:22 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49456 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeKHKPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 05:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=el+2X9GjGB7/TK25hQe9aQnDcc1Ul3bzoa1BfeVgask=; b=JI1syW+yF1YCaYp5BgXeX9wDH
        jJTbD2/qc2fNRnYB4VlvQjy8oVJ5ESoXY21f2w0fhiPom+hmj71rnF/ka/5uDkVa5XTtf4YN+if1W
        kWtCleBYeDiY2E1kJytUkfhGvyMpIpJfhwQ/cOafYYh1me9qkg7Ci3VrdqihwmvIUuTM4=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:53564)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gKYOj-0000v3-8r; Thu, 08 Nov 2018 00:42:13 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gKYOa-00015U-TQ; Thu, 08 Nov 2018 00:42:05 +0000
Date:   Thu, 8 Nov 2018 00:42:00 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>, netdev@vger.kernel.org,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/5] phy: core: add PHY_MODE_ETHERNET
Message-ID: <20181108004200.GW30658@n2100.armlinux.org.uk>
References: <20181108003617.10334-1-grygorii.strashko@ti.com>
 <20181108003617.10334-3-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108003617.10334-3-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 06:36:14PM -0600, Grygorii Strashko wrote:
> Add new PHY's mode to be used by Ethernet PHY interface drivers or
> multipurpose PHYs like serdes. It will be reused in further changes.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  include/linux/phy/phy.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index b17e770..02c9ef0 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -42,6 +42,7 @@ enum phy_mode {
>  	PHY_MODE_UFS_HS_A,
>  	PHY_MODE_UFS_HS_B,
>  	PHY_MODE_PCIE,
> +	PHY_MODE_ETHERNET,

Are you sure about this - we already have a bunch of "ethernet" modes
that are more specific, like PHY_MODE_SGMII, PHY_MODE_2500SGMII and
PHY_MODE_10GKR which require PHYs to be configured differently.  Having
a very generic "ethernet" mode brings up questions about when it should
be used vs the more specific modes.

(I've already mentioned that the SGMII modes are mis-named, since
they also apply to 1000base-X and 2500base-X - the only difference
is how one 16-bit word in the data stream is used which has no effect
on the PHY.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
