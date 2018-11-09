Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E55C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B3720827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ACDrgTcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B3720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeKIV26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:28:58 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45410 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbeKIV26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=duI92rZn4qmaE2LHp1ohqvpxOI5kI5YGrt7tnkuzqjs=; b=ACDrgTcuzo8prgCbuI5bY1vsp
        6lrveJY8Kw7bb5umcvGpXNqUhm+ftgOccZJy7nmXrzFniwahxysyUSzU4Yo3KCC5ItP5UGJSeUhjl
        12m6UW1Ks1CK9w7gSSL0rSpUQVv9J6nSFErqAa6xDcna/38ldC9a8zDy4bkPgHwxrPqbU=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:43486)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gL5H0-0001ow-DA; Fri, 09 Nov 2018 11:48:26 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gL5Gw-0004kS-CH; Fri, 09 Nov 2018 11:48:23 +0000
Date:   Fri, 9 Nov 2018 11:48:19 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Borislav Petkov <bp@alien8.de>, jlu@pengutronix.de,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 5/9] dt-bindings: ARM: document marvell,ecc-enable
 binding
Message-ID: <20181109114818.GB30658@n2100.armlinux.org.uk>
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
 <20181109070349.20464-6-chris.packham@alliedtelesis.co.nz>
 <CAK8P3a3PNvBhyQw0bfGxKmxj+KeJB2_TXtDx2R1BpjTCYNqVkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3PNvBhyQw0bfGxKmxj+KeJB2_TXtDx2R1BpjTCYNqVkA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 12:40:06PM +0100, Arnd Bergmann wrote:
> On Fri, Nov 9, 2018 at 8:04 AM Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:
> >
> > Add documentation for the marvell,ecc-enable and marvell,ecc-disable
> > properties which can be used to enable/disable ECC on the Marvell aurora
> > cache.
> >
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> 
> Why do you need both enable and disable? Wouldn't one of them be enough here?

It isn't an "on when ecc-enable is present, off when not" because the
current behaviour is to preserve these bits in the control register.

If we were to implement it as "if no ecc-enable property, turn off
ECC" then that would drastically change the behaviour - systems which
were configured for ECC suddenly lose ECC support.

Since we don't know which have it and which don't, we can't implement
the option like that.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
