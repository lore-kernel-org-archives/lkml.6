Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4632ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A2120684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WkcfxOJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A2120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbeGSScH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:32:07 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60182 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731733AbeGSScH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EO2Hbi1vBfGjI0LENgkjLqcytzhUgqwUuAObJ8ngMv8=; b=WkcfxOJYw/7/U/yheJJx6DqPt
        guZ0vBnggDejpgyVyIxYzAvSYt/5ZJrcHU+6bph7d4hXu58ev16tdWfRQpLkydmuFovRqN1OiGqd8
        heyf9eObRnHVVgepNJSgoHjQ63ZeU8UqNet0K4CoYCFnb6oGz9cI+Q19KeUBG1Gl8UQMU=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:37521)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fgD1Z-00070e-0P; Thu, 19 Jul 2018 18:47:33 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fgD1V-00069y-Vl; Thu, 19 Jul 2018 18:47:30 +0100
Date:   Thu, 19 Jul 2018 18:47:28 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 4/5] net: add support for nvmem to
 eth_platform_get_mac_address()
Message-ID: <20180719174728.GK6920@n2100.armlinux.org.uk>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718161035.7005-5-brgl@bgdev.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 06:10:34PM +0200, Bartosz Golaszewski wrote:
> @@ -544,6 +548,31 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  			from = "arch callback";
>  	}
>  
> +	if (!addr) {
> +		nvmem = nvmem_cell_get(dev, "mac-address");
> +		if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)

This is way too verbose.  To quote Al Viro from earlier today:

<viro> sigh...
<viro>         if (IS_ERR(link) && PTR_ERR(link) == -EEXIST)
<viro> what the hell is wrong with if (link == ERR_PTR(-EEXIST))?

I wonder why so many people haven't heard of pointer comparison... ;)

IS_ERR(ERR_PTR(-EPROBE_DEFER)) is always true - if it wasn't, then
we'd be in for problems.

So, if you're asserting that nvmem is ERR_PTR(-EPROBE_DEFER) then
there's no need to do the IS_ERR(nvmem) must also be true.  Hence, a
simple pointer comparison is sufficient:

		if (nvmem == ERR_PTR(-EPROBE_DEFER))
			return -EPROBE_DEFER;

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
