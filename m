Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C31DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4439820844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549012359;
	bh=G1+UTO8+QiHuuv2olre3TcX67rYIbY1iHpVGa6SLDD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ww0d142r2rLmxbs4CI7COLF9FSLwC/wDrkMpaGz+iL6crJ3dvyrVhrlUgCS831Kr2
	 Gt+oURzkDe/ZcNWfoE/vTEe/F1/6WZ5pqpY+2jb7536V/JWN+NLdQnTlO0kFZ3HDcw
	 GInFSzvfxFynoEzaiEyU5YUll6oFrGHbbCrYJh1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfBAJMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:12:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40530 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfBAJMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:12:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so5141097lji.7;
        Fri, 01 Feb 2019 01:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VcqXSixwk6cvoyaKn5rzK8VT1pE7Jslo9XGJlxuvi6w=;
        b=cPvNK0678t2i69xS8jtQZpeV9SPk0xoCCERres4SN7mL7LEjqYRp/ktcCGNALPsuUz
         jpnY+Tx9HU/HpW0MsOJ3Hif2mbU9WspzWsw/R96cBBNMOnBYpUzpB4GZFLqDPUEuiudZ
         ZQCTocQZ864BMj5N7t25XL5DL793o/zRl+GcE02buNzQKiLyIPRPdY4/xRmflw4YvVKt
         KPG7rHO+9AWADLOOjnTom3jGuS+16Frn1vyp5aGaow8i5Ke1jw8Ibt9l4VzCnKwR5oXo
         I6cIvfUPhNvUsojtvsCXn0xim/HHx2ZpWT1faIMSwYyTzfemNsb4Pr8jkTR95Ze5nKyk
         hZOA==
X-Gm-Message-State: AJcUukeuFYUY628ThLIiviMe66h8UnFePm0IXLAiBMGPCMBkXDpkSmdT
        DRgrOmYn3IfO68sSKvWqza4=
X-Google-Smtp-Source: ALg8bN7HzB5gaQTayQnMlLWcv/ADI3Lvkuq8cx8rFzmR9AHcBJmgQ31D9ST//giXJi8SCP8mBhb+SQ==
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr30537664ljh.135.1549012354573;
        Fri, 01 Feb 2019 01:12:34 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g11sm424460lfg.31.2019.02.01.01.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 01:12:33 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gpUsB-0003LP-Ad; Fri, 01 Feb 2019 10:12:31 +0100
Date:   Fri, 1 Feb 2019 10:12:31 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, jic23@jic23.retrosnub.co.uk
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: chemical: pms7003: add device
 tree support
Message-ID: <20190201091231.GZ3691@localhost>
References: <20190127181916.19948-1-tduszyns@gmail.com>
 <20190127181916.19948-4-tduszyns@gmail.com>
 <20190128075819.GK3691@localhost>
 <20190128184332.GA25627@arch>
 <20190130091254.GN3691@localhost>
 <20190131204000.GA14750@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131204000.GA14750@arch>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 09:40:04PM +0100, Tomasz Duszynski wrote:
> On Wed, Jan 30, 2019 at 10:12:54AM +0100, Johan Hovold wrote:
> > On Mon, Jan 28, 2019 at 07:43:33PM +0100, Tomasz Duszynski wrote:
> > > On Mon, Jan 28, 2019 at 08:58:19AM +0100, Johan Hovold wrote:
> > > > On Sun, Jan 27, 2019 at 07:19:16PM +0100, Tomasz Duszynski wrote:
> > > > > Add device tree support for Plantower PMS7003 particulate matter sensor.
> > > > >
> > > > > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > > > > ---
> > > > >  .../iio/chemical/plantower,pms7003.txt        | 19 +++++++++++++++++++
> > > > >  1 file changed, 19 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > > > > new file mode 100644
> > > > > index 000000000000..e4c7f2fb1e30
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > > > > @@ -0,0 +1,19 @@
> > > > > +* Plantower PMS7003 particulate matter sensor
> > > > > +
> > > > > +Required properties:
> > > > > +- compatible: must be "plantower,pms7003"
> > > > > +
> > > > > +Optional properties:
> > > > > +- vcc-supply: phandle to the regulator that provides power to the sensor
> > > >
> > > > Shouldn't this one be a required property?
> > > >
> > >
> > > Driver does not use regulator framework hence to me this property fits
> > > here better.
> >
> > The device tree describes hardware, not any particular driver.
> >
> > That said, there is a bit of an on-going debate on whether mandatory
> > supplies (from a hardware perspective) should always be represented in
> > device tree or not.
> >
> > 	https://lore.kernel.org/lkml/20181123133126.GF2089@sirena.org.uk/T/#u
> >         https://lore.kernel.org/lkml/20180409102244.GB11532@sirena.org.uk/T/#u
> > 	https://lore.kernel.org/lkml/20180425171123.xhyoay3nu463btoq@rob-hp-laptop/T/#u
> >
> 
> Even after going through this threads I am still unconvinced that
> vcc-supply should be a requirement. Making this a mandatory property
> would automatically imply using *_regulator_get() in a driver code
> (on condition one is adding regulator support). In case there
> isn't any physically connected we end up with a dummy one and a warning.

How would the device work at all without a physical vcc supply?

> Is it how this should work?

As Mark mentioned in the threads above, you could add a fixed,
always-on regulator for cases where the device is always powered.

Boards failing to describe this supply would still work on Linux, but
would end up with a dummy regulator and a warning.

> > > > > +- set-gpios: phandle to the GPIO connected to the SET line
> > > > > +- reset-gpios: phandle to the GPIO connected to the RESET line
> > > > > +
> > > > > +Refer to serial/slave-device.txt for generic serial attached device bindings.
> > > > > +
> > > > > +Example:
> > > > > +
> > > > > +&uart0 {
> > > > > +	pms7003 {
> > > >
> > > > The node name should be generic and reflect the functionality rather
> > > > than model. Perhaps "pms" will do here.
> > >
> > > Agree, ideally we should have a generic dt name for this kind of sensors
> > > (something like air-pollution-sensor perhaps?). But unfortunately there isn't
> > > anything available now so I guess compatible part name should be okay
> > > (besides this is the type of naming commonly used in other iio bindings).
> >
> > What's wrong with particulate matter sensor ("pms")?
> >
> > Seems like a better fix than any particular model name to me at least.
> >
> 
> Personally I would vote for a more descriptive node name, for example:
> particulate-matter-sensor or air-pollution-sensor or other name
> which clearly shows what device we are dealing with.

Spelling it out seems preferable, yes. You know the domain better than
I do; I only suggest you come up with a generic node name.

Johan
