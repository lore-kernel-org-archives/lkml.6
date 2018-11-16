Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA58C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D47208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tWP8SZhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D47208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389326AbeKPSEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:04:38 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:37117 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeKPSEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=wRsSbnIUHbAJsj/ck8ozE6A4xc13r93NxRGHiYZaowI=;
        b=tWP8SZhGSqOewS6E63DQfgrh3qlxEXMpCh/WYN+3QhzhTqtE1kI0dC7DpN9NhOnr/3/FO5TZw/Noo2vvklirHKr/E/TmnB+a9fzHV/mXRSXAhakbDp3se/qcxioIvbSGl20T2wv4VoQz9RIeMKrr+H5iegJLF9d0KXCRz3XegnA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gNYwI-0004BK-Ku; Fri, 16 Nov 2018 08:53:18 +0100
Date:   Fri, 16 Nov 2018 08:53:18 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Martin Schiller <ms@dev.tdt.de>
Cc:     sergei.shtylyov@cogentembedded.com, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] net: phy: mdio-gpio: Fix working over slow can_sleep
 GPIOs
Message-ID: <20181116075318.GF14933@lunn.ch>
References: <20181114061703.11026-1-ms@dev.tdt.de>
 <20181116073836.6013-1-ms@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116073836.6013-1-ms@dev.tdt.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 08:38:36AM +0100, Martin Schiller wrote:
> Up until commit 7e5fbd1e0700 ("net: mdio-gpio: Convert to use gpiod
> functions where possible"), the _cansleep variants of the gpio_ API was
> used. After that commit and the change to gpiod_ API, the _cansleep()
> was dropped. This then results in WARN_ON() when used with GPIO
> devices which do sleep. Add back the _cansleep() to avoid this.
> 
> Fixes: 7e5fbd1e0700 ("net: mdio-gpio: Convert to use gpiod functions where possible")
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
