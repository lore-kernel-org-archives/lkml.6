Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA51AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B56420871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KLqx1G7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B56420871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeFTGc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:32:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:37242 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbeFTGcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=G4gbKSe1h+lamzfspMEaf0bXM4LZ2DuCoS/0qNPy/Mg=;
        b=KLqx1G7Kg/0X34vxUffhKkLKSoD+g93qztIpNBJyoT/8VU7XjYaGgfBCwtchgKIPmT5rxxLU3YjzpvGHGpcjGQqoDb9jovkAj4fY60SGGk4rg7IlsK/PyZzfhUtv6FKTm6ICH8lnlkbgnUwaISU+GhnRu/u71w2yG72QNHT7Vg8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fVWfg-0002Ue-61; Wed, 20 Jun 2018 08:32:48 +0200
Date:   Wed, 20 Jun 2018 08:32:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mdio-mux-gpio: Remove VLA usage
Message-ID: <20180620063248.GA9303@lunn.ch>
References: <20180530204830.GA24884@beast>
 <20180530205712.GB16286@lunn.ch>
 <CAGXu5j+sh-gSXvGg25oN9Xsyw1W=i177=52ZXPV3OvEym6nr7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+sh-gSXvGg25oN9Xsyw1W=i177=52ZXPV3OvEym6nr7g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 09:44:27PM -0700, Kees Cook wrote:
> On Wed, May 30, 2018 at 1:57 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> > On Wed, May 30, 2018 at 01:48:30PM -0700, Kees Cook wrote:
> >> In the quest to remove all stack VLA usage from the kernel[1], this
> >> moves the allocation into struct mdio_mux_gpio_state during probe.
> >>
> >> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >> ---
> >> v2: allocate array as part of structure (Andrew Lunn)
> >
> > Hi Kees
> >
> > This looks much better, thanks.
> >
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> Thanks! Who can take this patch? Linus?

David Miller.

Does it cleanly apply to net-next?

     Andrew
 
