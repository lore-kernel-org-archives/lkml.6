Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A67C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5761D20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEz56Px2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfAaUkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:40:31 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35707 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfAaUk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:40:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so3893755ljb.2;
        Thu, 31 Jan 2019 12:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eC8JUjjOWAciHy3n+5RBBqZC4Ht27IbaQAgjXb8i0r8=;
        b=IEz56Px2TElGN/HhHFKKm6Ije+9kD4c8xUaImpCq9StbAAsauuypzdBzSY4XbFI72v
         Vj+3vmnuNRLDDPFeIU8fGEhzsNZl4AnEZrxPXxSzedYip9l82OlAN779p4upI5h48nYa
         gSvVyuSde+BaWJLkhuIcHxT9syk2HeY3oV7bBTBGiYgsMQAe7WQkGoPC5D0ldXYO7uv1
         /EARsybBWjsvUuYQ49tr7yiki5bDhwTQpxQdq+RgFlwIxVN3cuqk5XWd+HMnxwzMjSoz
         0OOv6HLZZu74jUMXZJwPUUL2g6y4k2YoGbkCON1ODLGYeY1Ygi64dBFOblItNVMi26s1
         PDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eC8JUjjOWAciHy3n+5RBBqZC4Ht27IbaQAgjXb8i0r8=;
        b=hiaZKsdazlmtk9Hzwgw5FjUcpl9hca6Ti1sRrtSyRpK4AhDNK9qyNLjkb+Aq4V7Ar7
         G6Uco+J7EaA9qTx8KldNwvHnS75W46XaF+NBvSla7w8D5+j/hsAY9CrXHrGgxqKCYfWr
         K56NJm8XYdPTG2ok5fmOR6pYR+BFE3Zm0oy0UxEujoHpLFAmux/1QTQo021uNgr9WfxR
         8RYClL6CwrlAthJi/+y8NnQj757eGfsqFhT7ggp97EYRBNo/MJajzYj5AJ1KHeyReCN/
         N40o23MUO+7WMAAegrF9EwSlHkwRKyB/zHa1dSRuinvidYYbuoXaFS7bEcjM+H6vonKG
         PDBQ==
X-Gm-Message-State: AJcUukfvZoADBEy7JuBQZkuSbHlRvxxI7T+1n/VexHFLymVWvspl36I5
        jch+11tPFq6HtrJ0LW1BZiSAWrsa
X-Google-Smtp-Source: ALg8bN7bk4qVj+mM2fa5ut4Sn8uemYBzrVeLSwlRc2SVD22i2WQRrREXTo0L+/4WOrwsBe+F3IY3oA==
X-Received: by 2002:a2e:63cd:: with SMTP id s74-v6mr28553398lje.117.1548967227334;
        Thu, 31 Jan 2019 12:40:27 -0800 (PST)
Received: from localhost (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id h22-v6sm967100ljg.24.2019.01.31.12.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 12:40:26 -0800 (PST)
Date:   Thu, 31 Jan 2019 21:40:04 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, jic23@jic23.retrosnub.co.uk
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: chemical: pms7003: add device
 tree support
Message-ID: <20190131204000.GA14750@arch>
References: <20190127181916.19948-1-tduszyns@gmail.com>
 <20190127181916.19948-4-tduszyns@gmail.com>
 <20190128075819.GK3691@localhost>
 <20190128184332.GA25627@arch>
 <20190130091254.GN3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130091254.GN3691@localhost>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:12:54AM +0100, Johan Hovold wrote:
> On Mon, Jan 28, 2019 at 07:43:33PM +0100, Tomasz Duszynski wrote:
> > On Mon, Jan 28, 2019 at 08:58:19AM +0100, Johan Hovold wrote:
> > > On Sun, Jan 27, 2019 at 07:19:16PM +0100, Tomasz Duszynski wrote:
> > > > Add device tree support for Plantower PMS7003 particulate matter sensor.
> > > >
> > > > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > > > ---
> > > >  .../iio/chemical/plantower,pms7003.txt        | 19 +++++++++++++++++++
> > > >  1 file changed, 19 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > > > new file mode 100644
> > > > index 000000000000..e4c7f2fb1e30
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> > > > @@ -0,0 +1,19 @@
> > > > +* Plantower PMS7003 particulate matter sensor
> > > > +
> > > > +Required properties:
> > > > +- compatible: must be "plantower,pms7003"
> > > > +
> > > > +Optional properties:
> > > > +- vcc-supply: phandle to the regulator that provides power to the sensor
> > >
> > > Shouldn't this one be a required property?
> > >
> >
> > Driver does not use regulator framework hence to me this property fits
> > here better.
>
> The device tree describes hardware, not any particular driver.
>
> That said, there is a bit of an on-going debate on whether mandatory
> supplies (from a hardware perspective) should always be represented in
> device tree or not.
>
> 	https://lore.kernel.org/lkml/20181123133126.GF2089@sirena.org.uk/T/#u
>         https://lore.kernel.org/lkml/20180409102244.GB11532@sirena.org.uk/T/#u
> 	https://lore.kernel.org/lkml/20180425171123.xhyoay3nu463btoq@rob-hp-laptop/T/#u
>

Even after going through this threads I am still unconvinced that
vcc-supply should be a requirement. Making this a mandatory property
would automatically imply using *_regulator_get() in a driver code
(on condition one is adding regulator support). In case there
isn't any physically connected we end up with a dummy one and a warning.

Is it how this should work?

> > > > +- set-gpios: phandle to the GPIO connected to the SET line
> > > > +- reset-gpios: phandle to the GPIO connected to the RESET line
> > > > +
> > > > +Refer to serial/slave-device.txt for generic serial attached device bindings.
> > > > +
> > > > +Example:
> > > > +
> > > > +&uart0 {
> > > > +	pms7003 {
> > >
> > > The node name should be generic and reflect the functionality rather
> > > than model. Perhaps "pms" will do here.
> >
> > Agree, ideally we should have a generic dt name for this kind of sensors
> > (something like air-pollution-sensor perhaps?). But unfortunately there isn't
> > anything available now so I guess compatible part name should be okay
> > (besides this is the type of naming commonly used in other iio bindings).
>
> What's wrong with particulate matter sensor ("pms")?
>
> Seems like a better fix than any particular model name to me at least.
>

Personally I would vote for a more descriptive node name, for example:
particulate-matter-sensor or air-pollution-sensor or other name
which clearly shows what device we are dealing with.

> > > > +		compatible = "plantower,pms7003";
> > > > +	};
> > > > +};
>
> Johan
