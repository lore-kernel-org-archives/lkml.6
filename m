Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063F7C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BB0207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BB0207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeJXXDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:03:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41963 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeJXXDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:03:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id c32so5226837otb.8;
        Wed, 24 Oct 2018 07:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l2Q9ZcGYjc4V2J/SgluOMRWf7eCkp1JtA2wQ09il7Ng=;
        b=T8nj2jeE21cC1Ij202fefGvsbaDxHYliNKlTNYHye6cID68TCA1V7OC9K/NbAI8hbm
         AzCnP2yVE23dt8/IxwQd7kBVTgbvpR6NFI6nJsj74jx97Ej4OmNdVZRIdNeMPEBd+0qe
         1ym90zbZx9gARYUTLPbRMvkuLRtRKqABF4uzWjvHG3SD9tLh/YNjZP8Gdpn+/rmKJjMj
         LPzwZhIIVd8AHU0WStzxYoINVS3kgZCnw60z/pxGgxlAmSKjMosiaLd+wJ3TdrI7TyUD
         jfvEjLaBuLmS5ho5OOr/UhtAZaieFrZiz4VaP82SA2n07dQtnbCa2otFn9CIzQQIv0XS
         hW7w==
X-Gm-Message-State: AGRZ1gLR7mFVdwZmfA4eYpgscvMe4GEwZuIeEAwYyNcdHQXwvQFmnZQk
        cFiWAGbN5NT2WkaV1d7dIA==
X-Google-Smtp-Source: AJdET5ebHXrhtC6b876NkzNb2K3Q4T7GYxboV/PCOGJVPed7CXferAHdkPBTFuhYu1Q/PCx4qg7DAg==
X-Received: by 2002:a9d:5617:: with SMTP id e23mr1914387oti.228.1540391708648;
        Wed, 24 Oct 2018 07:35:08 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v124-v6sm1554241oie.48.2018.10.24.07.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 07:35:07 -0700 (PDT)
Date:   Wed, 24 Oct 2018 09:35:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>, jacek.anaszewski@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, lee.jones@linaro.org, tony@atomide.com
Subject: Re: [PATCH v4 5/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3633
Message-ID: <20181024143506.GA9327@bogus>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-5-dmurphy@ti.com>
 <20181024092328.GD24997@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024092328.GD24997@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 11:23:28AM +0200, Pavel Machek wrote:
> On Tue 2018-10-23 12:06:21, Dan Murphy wrote:
> > The LM3633 is a single function LED driver. The single function LED
> > driver needs to reside in the LED directory as a dedicated LED driver
> > and not as a MFD device.  The device does have common brightness and ramp
> > features and those can be accomodated by a TI LMU framework.
> > 
> > The LM3633 dt binding needs to be moved from the ti-lmu.txt and a dedicated
> > LED dt binding needs to be added.  The new LM3633 LED dt binding will then
> > reside in the Documentation/devicetree/bindings/leds directory and follow the
> > current LED and general bindings guidelines.
> 
> What?
> 
> >  .../devicetree/bindings/leds/leds-lm3633.txt  | 102 ++++++++++++++++++
> >  .../devicetree/bindings/mfd/ti-lmu.txt        |  48 ---------
> >  2 files changed, 102 insertions(+), 48 deletions(-)
> >  create mode 100644
> >  Documentation/devicetree/bindings/leds/leds-lm3633.txt
> 
> > index 920f910be4e9..573e88578d3d 100644
> > --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> > +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> > @@ -7,7 +7,6 @@ TI LMU driver supports lighting devices below.
> >    LM3532       Backlight
> >    LM3631       Backlight and regulator
> >    LM3632       Backlight and regulator
> > -  LM3633       Backlight, LED and fault monitor
> >    LM3695       Backlight
> 
> Are you seriously proposing to take one binding and split it into 6
> copy&pasted ones?
> 
> That's not the way we do development. NAK.
> 
> We don't want to have copy & pasted code. We also don't want to have
> copy & pasted bindings. Nor changelogs, for that matter.

I looked at the LM3633 and LM3632 datasheets. They look quite different 
to me and should be separate IMO. Just looking at different LED 
functions and GPIO control lines is enough to make that determination. 
The LM3697 looks like a subset of LM3633 at least at a schematic 
diagram level, so maybe those can be shared.

While we could litter the binding with conditions on properties 
depending on specific compatible strings (such as which GPIO properties 
apply to which compatible), that is going to be problematic down the 
line when we convert to json-schema[1].

Rob

[1] https://lkml.org/lkml/2018/10/5/883
