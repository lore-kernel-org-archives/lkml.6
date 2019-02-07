Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C095C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2259A2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vDzAWah9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfBGNhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:37:48 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:42391 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfBGNhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AFU1wo7vU/eXBAmtLp0oQaHTIVWx8k7UVa17KbhNKLM=; b=vDzAWah9X29HB+kMZb1X4PB6Bo
        9aGlt+a/m9ihZxU5CV5soKFc2OUq0SdVpyEtsN3arrMefn7I9J4H86VejSyXwtCA8iQeqlIVP+CS0
        Jnb3dz0bO4VOBgbKsSTPwVsdQr34jyLY3MBJ1ZR+adpXZh3P0qe7uGUhzwsCk3wNVDnE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1grjs9-0006Sx-Uu; Thu, 07 Feb 2019 14:37:45 +0100
Date:   Thu, 7 Feb 2019 14:37:45 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Emeric Dupont <emeric.dupont@zii.aero>
Subject: Re: [PATCH v5] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20190207133745.GB23970@lunn.ch>
References: <20190207023731.13259-1-andrew@lunn.ch>
 <20190207102356.GB20638@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207102356.GB20638@dell>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +			dev_warn(dev, "GPIO interrupts not supported.\n");
> 
> Do you know why they wouldn't be supported?
> 
> Isn't that the point of the device?

Hi Lee

I don't know the history of this device, but i suspect it has been
through a number of revisions. The vendor driver suggests some
versions support interrupts from the I2C bus master, but the version i
have does not. As a result the i2c bus master has to do polled
IO. GPIO interrupts are optional in the GPIO world. So it could be
some versions don't support it. But the version i have does.

It seems like if you write to bits of the interrupt configuration
register on a revision which don't support interrupts, the write does
not stick. So reading it back then lets you know this. The GPIO still
works for plain I and O, but don't expect interrupts to work.

      Andrew
