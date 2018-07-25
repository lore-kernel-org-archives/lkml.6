Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812DEC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F0220843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F0220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeGYQni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:43:38 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34576 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbeGYQni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:43:38 -0400
Received: by mail-io0-f193.google.com with SMTP id l7-v6so6677583ioj.1;
        Wed, 25 Jul 2018 08:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F78w+V6NyR0UqKb6Hi40pmstqdiTDPRvgIzKRwZnhT4=;
        b=ppBLNOj/h8xCJmloB7vYqqoDJ74F2jQJ161M7KMRUG79ck7BtwYOH2fySaPtblhEXm
         cR1JJ/McRUWbYOVhQEzvku9Ej4OCYGZ7iR4QhlRD21A1czs9B01zW6bF/WokrN2O8Ee+
         Wbw/03rY+AssWYOMNPLK2ntbnWzyt+pdPL14vvfwrzmp7HV3OxkkErr6iE5CACyPi5mh
         41z5+0edgokpvP9xq8JRaYCB+oNi1Ksf9V/hN3/UIoXQ+aqcHlO5PuLGLAL6IddnU81b
         kpU72IgkwVUv8ItPEc1WG4BTeZ75Ok6ZJOvu7+dIr6Cj5KukNOsGPYloBYROJCTgTClw
         dPuw==
X-Gm-Message-State: AOUpUlFthYlTbZfsoEMVL9uxcjdB1MfaRgyHmFkp49sLxtsAY4JMZ0Vh
        unXx0N4F8JDoKf8uszhTzTovLjw=
X-Google-Smtp-Source: AAOMgpcM+4ufyO9yWPhUrRtTj9LAx355/6w558O/12mNoybWd+Z6zpEB4i6HH8qYA76Jy/10qWAFew==
X-Received: by 2002:a6b:5b0b:: with SMTP id v11-v6mr8128253ioh.39.1532532687239;
        Wed, 25 Jul 2018 08:31:27 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id c97-v6sm2969124itd.19.2018.07.25.08.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 08:31:26 -0700 (PDT)
Date:   Wed, 25 Jul 2018 09:31:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH v3 6/9] dt-bindings: phy: add binding for
 Allwinner USB3 PHY
Message-ID: <20180725153126.GA8350@rob-hp-laptop>
References: <20180722055739.26464-1-icenowy@aosc.io>
 <20180722055739.26464-7-icenowy@aosc.io>
 <CAGb2v65m6AEW=DO-cqLMyjfnaiZudm38hXufJL6LXdOrJqir_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v65m6AEW=DO-cqLMyjfnaiZudm38hXufJL6LXdOrJqir_g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 02:10:33PM +0800, Chen-Yu Tsai wrote:
> On Sun, Jul 22, 2018 at 1:57 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> > The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
> > external USB3 pins of the SoC.
> >
> > Add a device tree binding for the PHY.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> > Changes in v3:
> > - Added Chen-Yu's Review tag.
> >
> > Rob,
> > Although you mentioned that the supply is for the port, not the phy;
> > currently in USB situation "powering on the PHY" also indicates
> > "powering on the port" and nearly all usages of phy-supply is for Vbus.
> >
> > Maybe we should change the overall phy-supply to satisfy this.
> 
> Or maybe change it to vbus-supply, like we have for phy-sun4i-usb,
> until USB port power sequencing is added. (I remember there were
> patches for this. What happened?)

Once it is in the binding, we are stuck with it.

Connector bindings have landed. We should add vbus-supply to that. You 
don't have to have a property in the node associated with a driver. The 
phy driver can walk the tree and get the Vbus supply.

UniPhier has the same issue.

Rob
