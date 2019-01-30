Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D3AC282D6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B422184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548839584;
	bh=sdltaOneXD1+5DSuFhRXUvQNGeCoZP5tFHwf7+PS8aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GWOy4FYj95gfW2MJPQgQrKZHjGMM3qGdEnT+r4N6AOA2iw2aNHxH0Lss5bW5gmbN/
	 nGrqcc6o/BcQl+/mOnCPyCYFu79J6DFME3zfy3bCeEDDpeY3NTnwcesJNLlT0HfZk6
	 Wgv1KwqjaNmwSmb+hOtZ1U5acVy7jnnDF/1fvgr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfA3JND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:13:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46203 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbfA3JNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:13:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so19996624ljh.13;
        Wed, 30 Jan 2019 01:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lqotxjbK76cv/Qj1r776CfOAYGu2nY20LaOdD9DQ39E=;
        b=PEHpX8FjqA4PecyqWrmimXtgBNmgVqVk728IGuH3Qt/LhkOdqAKzGzaVTQtbhoeCHC
         5IV99ethFomnD/dlcvBT0vVMVzyIVV6Nmq3M9DEwED3eqNfcjzCTjyuN/noqXAA+Rq7W
         fQCe7VAZ5n/cRz3qevpOxyfvi3MyCeNoaVSy4bwQN3jr6sgeHY/F3/5kPscPJydGIsH1
         fJATEXgaDPmIsx4hW7lqWL3kIPjkJBgHr7K2JSHciJLJ2+FFiVHvt8CR5cZ+v5AY7guy
         1CNq6H0lbEobEv1ueVXu7FebvAJ8VtYLS47LlnQq7ZOjyB5L6BVhPWg0GgdsF1JTHUYC
         zWkw==
X-Gm-Message-State: AJcUukePzqjWB5s4yl3jEbd6Fh00/PsXkZheVpTdPoJbF4ohEVazIBqH
        9xWHsiBm3SHRFndERFnc1Ls=
X-Google-Smtp-Source: ALg8bN6ZZcqNwuTJYA/DmBNoXanBQYLOYdZxQU+Q5+sq6psr6oaJGT2nAGJikracexuvUug5E9sJjw==
X-Received: by 2002:a2e:910d:: with SMTP id m13-v6mr23298512ljg.187.1548839579742;
        Wed, 30 Jan 2019 01:12:59 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b25-v6sm173215lji.94.2019.01.30.01.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:12:58 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1golvS-0000xa-Vm; Wed, 30 Jan 2019 10:12:55 +0100
Date:   Wed, 30 Jan 2019 10:12:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, jic23@jic23.retrosnub.co.uk
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: chemical: pms7003: add device
 tree support
Message-ID: <20190130091254.GN3691@localhost>
References: <20190127181916.19948-1-tduszyns@gmail.com>
 <20190127181916.19948-4-tduszyns@gmail.com>
 <20190128075819.GK3691@localhost>
 <20190128184332.GA25627@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128184332.GA25627@arch>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 07:43:33PM +0100, Tomasz Duszynski wrote:
> On Mon, Jan 28, 2019 at 08:58:19AM +0100, Johan Hovold wrote:
> > On Sun, Jan 27, 2019 at 07:19:16PM +0100, Tomasz Duszynski wrote:
> > > Add device tree support for Plantower PMS7003 particulate matter sensor.
> > >
> > > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > > ---
> > >  .../iio/chemical/plantower,pms7003.txt        | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > > new file mode 100644
> > > index 000000000000..e4c7f2fb1e30
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > > @@ -0,0 +1,19 @@
> > > +* Plantower PMS7003 particulate matter sensor
> > > +
> > > +Required properties:
> > > +- compatible: must be "plantower,pms7003"
> > > +
> > > +Optional properties:
> > > +- vcc-supply: phandle to the regulator that provides power to the sensor
> >
> > Shouldn't this one be a required property?
> >
> 
> Driver does not use regulator framework hence to me this property fits
> here better.

The device tree describes hardware, not any particular driver.

That said, there is a bit of an on-going debate on whether mandatory
supplies (from a hardware perspective) should always be represented in
device tree or not.

	https://lore.kernel.org/lkml/20181123133126.GF2089@sirena.org.uk/T/#u
        https://lore.kernel.org/lkml/20180409102244.GB11532@sirena.org.uk/T/#u
	https://lore.kernel.org/lkml/20180425171123.xhyoay3nu463btoq@rob-hp-laptop/T/#u

> > > +- set-gpios: phandle to the GPIO connected to the SET line
> > > +- reset-gpios: phandle to the GPIO connected to the RESET line
> > > +
> > > +Refer to serial/slave-device.txt for generic serial attached device bindings.
> > > +
> > > +Example:
> > > +
> > > +&uart0 {
> > > +	pms7003 {
> >
> > The node name should be generic and reflect the functionality rather
> > than model. Perhaps "pms" will do here.
> 
> Agree, ideally we should have a generic dt name for this kind of sensors
> (something like air-pollution-sensor perhaps?). But unfortunately there isn't
> anything available now so I guess compatible part name should be okay
> (besides this is the type of naming commonly used in other iio bindings).

What's wrong with particulate matter sensor ("pms")?

Seems like a better fix than any particular model name to me at least.

> > > +		compatible = "plantower,pms7003";
> > > +	};
> > > +};

Johan
