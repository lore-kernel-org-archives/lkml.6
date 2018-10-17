Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4782CECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0727A21470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0727A21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeJRD3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:29:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40489 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbeJRD3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:29:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id w67so27385740ota.7;
        Wed, 17 Oct 2018 12:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bRfIOOQqIpbbcYYAO2xm5FknE0r92A5bwijAdEBAPKM=;
        b=pNbjX26/8iAYE1DOFCQ4ph0bo3ZTyJkrwzzGjA7vy52pXrRZG+biv7V1wg/717LJsW
         Q5HD14FC6sVhcr7G8oxJ8QKMfLJvRzdTuotggnT07ceUFjGQ0UIubSGwGTOiw9dkL0/+
         pmfjVT95VH2GQJSn3JfJcyuJg/qvfZ92Yd0d/U8gZeWVj7tZC4tD7nFX697ySG5lCrqD
         sozOvIlgV4VchhWNcocsVrS5VeWAly9Mhwulw/YvOomnnK7mbRQjMFTbvCNB7g+xTEnX
         tTaC5DV7Nf3c3BpU19+tsYjrocYG+/dBldXg+EX3ln1XlIbAuRJhivC0ZurdOSsja1i8
         TUkg==
X-Gm-Message-State: ABuFfohRdSXb7NxIoxemnJ8LVv2WDMTg5sGkzbw7WIECf0qDJdad0wX+
        neBokRlTs/wFAe/3AYv4T+gR+Mk=
X-Google-Smtp-Source: ACcGV63O81CaH0ImvUonSGUz5zLtOuNaitsmYIC0slqOg5IFkmT68MCphiOoAGvJFDFK1/JZMY51dg==
X-Received: by 2002:a9d:3203:: with SMTP id t3mr16608386otc.187.1539804740442;
        Wed, 17 Oct 2018 12:32:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l56sm5822935otb.65.2018.10.17.12.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 12:32:19 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:32:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/11] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
Message-ID: <20181017193218.GA8853@bogus>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-2-lkundrak@v3.sk>
 <20181011142719.GE25351@sirena.org.uk>
 <8cafa3f97fbe2a01ccf968b39469751b449e324b.camel@v3.sk>
 <20181012170002.GJ2340@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012170002.GJ2340@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 07:00:02PM +0200, Mark Brown wrote:
> On Thu, Oct 11, 2018 at 07:59:15PM +0200, Lubomir Rintel wrote:
> > On Thu, 2018-10-11 at 15:27 +0100, Mark Brown wrote:
> 
> > > Please use subject lines matching the style for the subsystem.  This
> > > makes it easier for people to identify relevant patches.
> 
> > Thanks for the response.
> 
> > I'm a little confused here. Why I chose this subject line is because I
> > did this:
> 
> >   git log --no-merges Documentation/devicetree/bindings/
> 
> Try Documentation/devicetree/bindings/spi instead :)

Just so you know, pretty much everything else except SPI, regulators, 
and ASoC follows 'dt-bindings: <binding dir>:' these days.

I don't really care so much about the difference, but it is tribal 
knowledge that submitters have to learn. 

Really, this could all be solved with tooling using MAINTAINERS and 
get_maintainers.pl, but limping around in checkpatch.pl occasionally is 
enough perl for me.

> > to figure out what's the typical subject for the DT binding changes.
> 
> > I also believed that's the right way to get Rob Herring's and Mark
> > Rutland's attention. 

All that matters is CC'ing the DT list really. And Mark R is pretty much
AWOL. Reviewing bindings in front of your own will get yours reviewed 
faster. :)

> Do the device tree binding documentation typically
> 
> There *is* some debate for the DT bindings unfortunately.
> 
> > go in with the associated drivers, or via their tree ("OPEN FIRMWARE
> > AND FLATTENED DEVICE TREE BINDINGS" in MAINTIANERS)?
> 
> They usually go in with the drivers.  This one isn't so bad since it
> does mention SPI, it's a worse problem when that's not present at all.

Right.

I generally only take single patches not in a series with dts or driver 
changes and when/if the subsystem maintainer doesn't pick them up. Or 
any standalone fixes I'll take.

Rob
