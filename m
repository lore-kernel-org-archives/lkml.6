Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F1DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7057520890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mfnWgNXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7057520890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbeG3Uml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:42:41 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50789 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730125AbeG3Umk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=kWnBL8t/Gl/PCH8OKcTcCqLMmfiIsacpkQDKDyjN9OM=;
        b=mfnWgNXsQxaVeSnSKfD0yC2USySVcMKPoZGzD5UEfuQIOwbTfbUYslOwQgR8NJht26hYs8ImXVawRhLn9P9pQFheler8lAyVOfcGo9wWQn07Ptn2ixhNrma9vDKTgg4vwl5qtvnwk9EQDZum4gpk2m61cCgXR9okAkO1JCCb3xc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fkDUk-0002Xu-4u; Mon, 30 Jul 2018 21:06:14 +0200
Date:   Mon, 30 Jul 2018 21:06:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC PATCH net-next v2 10/17] ethtool: implement GET_SETTINGS
 message
Message-ID: <20180730190614.GK2983@lunn.ch>
References: <cover.1532953989.git.mkubecek@suse.cz>
 <67d3b68a50e95db9612cc96e42a52ce332f716a9.1532953989.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d3b68a50e95db9612cc96e42a52ce332f716a9.1532953989.git.mkubecek@suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +    ETHA_SETTINGS_MDIO_SUPPORT	(bitfield32)	MDIO support flags

Now might be a good time to drop this. The mdio drivers don't have
this information. There is no API between the MAC driver and the MDIO
driver to ask for it. Only a couple of drivers which ignore the kernel
MDIO code set this.

     Andrew
