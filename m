Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F77C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CD42086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzW+8hMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfA1SoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:44:02 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38220 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfA1Sn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:43:58 -0500
Received: by mail-lf1-f68.google.com with SMTP id a8so12658878lfk.5;
        Mon, 28 Jan 2019 10:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r4zUJqc+m8YUpL+Cj3RgPHO6l7vNeVHz7qug0AjpLNg=;
        b=hzW+8hMcGt7yih5v+ybRWRdyH/RAOBtryHacUjmSVEY+NLLg03U312TiA7Y0avdRvf
         RJu6hremQOcG0oZKxit32pgXu9ADBr9QS/C8MHJ8IKp7WQsYD6qBqfFAkXLvzZSWBHOv
         oGmkDLaDEyEEK3SVM4qZaQHRTOSzLynxJidgsNeQBmCW+p1QD0evHcI9bTPp32GJY8gS
         Rl2kxM/MNleLaR46mK+bK7IDFdb+hFrfJ9Ou38yfM2aGqVEqePScmHdJewegAFuENjej
         8nnYJzB7nUfV/GaHuf7fni40Z5sDVRSKDif07PixNKgg5xh/bvnBSRsbK51amj7TMasI
         pEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r4zUJqc+m8YUpL+Cj3RgPHO6l7vNeVHz7qug0AjpLNg=;
        b=Lf2hbdVvJ1PNmXt/qaYjr430i7KzVI8XipgDcwm9SYbVD2kJ2TGg0K6+KGtvbOa4fj
         8J9CL2Hdm2XAwfCMQ6KiarGR9UfuXmVR63k/M6iRO8AMT10Czpe9SKOrkcoEuYAWa70U
         Qj77IRLAvWLE3Lj/cnXeDB95vcCsAEFPiPgwSb4pKndquIJPlSEJ7u6uJngI8fjgJC/P
         hCDJ6ryjD2DHyJj936dfPRNSFqWgfTB5Lq4uPhzXpvw+eRH99mYVBzcRI6Jjr4SBvu6l
         ARVN9aiVnImdMvSYfUO74xK3C9R3Kt863eQ0i3FT/0IFdrx9xYBC79Cl3oFZgDAqC+Mt
         O0DQ==
X-Gm-Message-State: AJcUukcogbvu9XdqriNwtQ3TcnSOJyL2K++0NG3oWJM09bCUfCD7X3nl
        C0LWNPKfWzPO714ZjzhNpCBd/ajAM1w=
X-Google-Smtp-Source: ALg8bN6eV1Hh6O9iFZz/iIVUKoWXyuk09HDxPWZ+V6gVBZ1yCwDcgxistt27slDBWruFX/Svlb4v2A==
X-Received: by 2002:a19:9e11:: with SMTP id h17mr17219797lfe.73.1548701035998;
        Mon, 28 Jan 2019 10:43:55 -0800 (PST)
Received: from localhost (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id s17sm3430994lfk.9.2019.01.28.10.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:43:55 -0800 (PST)
Date:   Mon, 28 Jan 2019 19:43:33 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, jic23@jic23.retrosnub.co.uk
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: chemical: pms7003: add device
 tree support
Message-ID: <20190128184332.GA25627@arch>
References: <20190127181916.19948-1-tduszyns@gmail.com>
 <20190127181916.19948-4-tduszyns@gmail.com>
 <20190128075819.GK3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190128075819.GK3691@localhost>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 08:58:19AM +0100, Johan Hovold wrote:
> On Sun, Jan 27, 2019 at 07:19:16PM +0100, Tomasz Duszynski wrote:
> > Add device tree support for Plantower PMS7003 particulate matter sensor.
> >
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > ---
> >  .../iio/chemical/plantower,pms7003.txt        | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > new file mode 100644
> > index 000000000000..e4c7f2fb1e30
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > @@ -0,0 +1,19 @@
> > +* Plantower PMS7003 particulate matter sensor
> > +
> > +Required properties:
> > +- compatible: must be "plantower,pms7003"
> > +
> > +Optional properties:
> > +- vcc-supply: phandle to the regulator that provides power to the sensor
>
> Shouldn't this one be a required property?
>

Driver does not use regulator framework hence to me this property fits
here better.

> > +- set-gpios: phandle to the GPIO connected to the SET line
> > +- reset-gpios: phandle to the GPIO connected to the RESET line
> > +
> > +Refer to serial/slave-device.txt for generic serial attached device bindings.
> > +
> > +Example:
> > +
> > +&uart0 {
> > +	pms7003 {
>
> The node name should be generic and reflect the functionality rather
> than model. Perhaps "pms" will do here.
>

Agree, ideally we should have a generic dt name for this kind of sensors
(something like air-pollution-sensor perhaps?). But unfortunately there isn't
anything available now so I guess compatible part name should be okay
(besides this is the type of naming commonly used in other iio bindings).

> > +		compatible = "plantower,pms7003";
> > +	};
> > +};
>
> Johan
