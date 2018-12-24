Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF79C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C062173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NOWHHIQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbeLXKor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 05:44:47 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:56468 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbeLXKor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 05:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=rMpay41w6pvtZV6NuF6Lr9HZoycb9WEyKcZkJXEZxf8=;
        b=NOWHHIQHMbEZxn7wUrs7h0VuJ/LZqzeA9RfVQyP1t6oAWbqOUuPXvJBFnHA6685s4r2dbnAOhWYmtfdnPAMX1EBnKX+CYho9kvV0+MEHcZDdIh7z288291QcI5frrqYifA5tRdHT+LCtNbeHTnhJ3GCVOek9JbjsFWyvBfUuBh4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gbNj2-0003p5-D6; Mon, 24 Dec 2018 11:44:44 +0100
Date:   Mon, 24 Dec 2018 11:44:44 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20181224104444.GA13866@lunn.ch>
References: <1545152036-23239-1-git-send-email-andrew@lunn.ch>
 <20181221143505.GQ13248@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221143505.GQ13248@dell>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 02:35:05PM +0000, Lee Jones wrote:
> > +	if (ioeic_val) {
> > +		tqmx86_writeb(pld, ioeic_val, TQMX86_IOEIC);
> > +		if (tqmx86_readb(pld, TQMX86_IOEIC) != ioeic_val) {
> > +			dev_warn(pld->dev,
> > +				 "i2c/gpio interrupts not supported.\n");
> > +			gpio_irq = 0;
> > +		}
> > +	}
> > +
> > +	if (pld->info.i2c_type == I2C_KIND_SOFT) {
> > +		ocores_platfom_data.clock_khz = pld->pld_clock;
> > +		devs[i++] = tqmx86_devs[TQMX86_I2C_SOFT];
> > +	}
> 
> See other drivers to see how they handle optional cells.

Hi Lee

Could you give an example driver i can copy. My grep foo is not
finding anything useful.

Thanks
	Andrew
