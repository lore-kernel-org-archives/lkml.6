Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E335C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04D920853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3eqkJnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04D920853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeINNXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:23:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33115 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbeINNXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:23:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id v90-v6so9448147wrc.0;
        Fri, 14 Sep 2018 01:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fG7kJIrrRMQXij0Y3eIpZWYGGAdS/d4p+JmzLCUS5dM=;
        b=s3eqkJnU75KrMphVvJSgHCkiwden+AvFIraq3QbvJxQD2bGH4Be0mpI0f3Zou5OxlG
         Za26QL41J0mdUD9BlfqnWrkkWAuyPrOQf6EO7quj3hAxv1IXTePD7ztyukjQFU89rW1y
         z8SnlgdKZqf5y4aqapfCQG8iYsKL3KyyKXzFNgh8NSDPIT5Vq8qg9KpDEydNMBUQajGJ
         RSFQsJLt4e9IcRlo0GC77s6T5uQy/jvqHahU1hDDFjg2hso5bql1Wu5yRUfxq+6+Hk1T
         dHU7yNB4acz/YqUSGI/HSap0uss4YFfuse6ab73s2SaxRwkbyLQuf9E/uv5Qw6mhrt9Q
         GM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fG7kJIrrRMQXij0Y3eIpZWYGGAdS/d4p+JmzLCUS5dM=;
        b=FjteHADF1sMiyFDgFksgCApkwmP4n4SVQmv0a8GZ3RBfKp0yVK6DpmY84cs2D/Po8e
         5/6ukGVWBDzfDoynAgdlS6pT9ZInHh0ScIFrWW/lMOzpMmR67zWxwUB8erREt+pbjvvt
         2lobU7dgOUVOKDqPctf1c6kpJ8PU+A6eT3FqxT8s18m8qz6EbS6taYQJdLD+IF4spyc4
         2E/81//puEaaTZAsLhVPZlZIFrjF4GquCLD2e96WJ6T2Avihz1Zu7+VNHlwC8gkH56OP
         yJIFwR3CwX++Dn48fMNW2fHiCDzt4JqxC5e5hb/8hXEpGUTlWJLYzqhuRVcNbwKYLzeu
         lqvA==
X-Gm-Message-State: APzg51DAIQI3WWd8d9Zk8EPcO4mnrHUw6HeWQz6DpbfYZllk2j7wv+uF
        B9XqQIS/SH6yXgjJ0wvKAJs=
X-Google-Smtp-Source: ANB0Vda0455pfBKZ70cg1baffaH/2dO/mOgE/v+HfbMJVMOG3BYKsaF86SyEHaTialR+QdIMlmU2Kg==
X-Received: by 2002:adf:a4d1:: with SMTP id h17-v6mr7857174wrb.167.1536912625859;
        Fri, 14 Sep 2018 01:10:25 -0700 (PDT)
Received: from localhost (p2E5BE549.dip0.t-ipconnect.de. [46.91.229.73])
        by smtp.gmail.com with ESMTPSA id d18-v6sm786278wmb.33.2018.09.14.01.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 01:10:24 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:10:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Multi-parent IRQ domains
Message-ID: <20180914081023.GA22750@ulmo>
References: <20180913155945.GA19903@ulmo>
 <ea9261a9-2c4d-7ca4-6dca-73f385aa46d5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <ea9261a9-2c4d-7ca4-6dca-73f385aa46d5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 13, 2018 at 02:50:21PM -0700, Florian Fainelli wrote:
>=20
>=20
> On 09/13/18 08:59, Thierry Reding wrote:
> > Hi everyone,
> >=20
> > I've been trying to implement a feature on recent Tegra chips that's
> > called "wake events". These wake events are implemented as part of the
> > power management controller (PMC) and they control which events can be
> > used to wake the system from suspend. Events include things like an
> > alarm interrupt from an RTC, or the GPIO interrupt hooked up to a
> > power button for example.
> >=20
> > We already have a driver for a couple of other things that the PMC does,
> > so I thought it'd be natural to implement this functionality as an IRQ
> > chip in the PMC driver. The way that this would work is that for all the
> > devices that are wakeup sources, we'd end up specifying the PMC as the
> > interrupt parent and the PMC would then itself have the main GIC as its
> > parent. That way, the hierarchical IRQ domain infrastructure would take
> > care of pretty much everything.
> >=20
> > Unfortunately I've run into some issues here. One problem that I'm
> > facing is that PMC could have more than one parent. For example, the RTC
> > alarm interrupt goes straight to the GIC, but the power button GPIO goes
> > through the GPIO controller first and then to the GIC. This doesn't seem
> > to be something that's currently possible.
> >=20
> > The way I imagine this to work from a DT perspective is as follows:
>=20
> There is an interrupts-extended property which as a first cell takes a
> phandle to the parent interrupt controller, e.g:
>=20
> interrupts-extended =3D <&gic 73 GIPC_SPI IRQ_TYPE_LEVEL_HIGH>,
> 			<&pmc 10>;
>=20
> (provided that I understood your problem and example correctly). We have
> a similar use case on our STB chips where we have "main" interrupts
> wired to the ARM GIC and wake-up interrupts wired to a specific wake-up
> interrupt controller in an always-on domain. The two controllers have a
> different #interrupt-cells specifier.
>=20
> The interrupt infrastructure in Linux already knows how to deal with
> that and whether you use of_get_irq() or platform_get_irq() you should
> obtain the correct virtual interrupt numbers that you expected, parented
> to the appropriate interrupt controller.

Yeah, I had looked at the interrupts-extended property as well, but
while I think it might work, one issue with that is that we'd be
modelling the regular IRQ and wakeup IRQ as two different IRQs. On
Tegra, however, the wakeup interrupt is the same as the regular
interrupt, except that the bits to enable the wake logic is in a
different hardware block. So the PMC acts more like an additional
mux for a subset of the interrupts in the system.

In addition to that, if I were to model the interrupts separately, I'd
also have to modify existing drivers for all the wakeup-able devices to
deal with two separate interrupts, which is rather undesirable.

Thierry

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlubbO0ACgkQ3SOs138+
s6Eo4w/8CFdu6waD5JsOQH7TrFv98Q/Fsq9TLrsUvPHL/wEacrne8/PLtbidu4pv
RohmWSf4br1GhN8+3D/U3gFw/uI5I8oD3lqHXHHRxCc297gK5t+tXXhNOZeuaZ0l
NyuRqZ8o47EPxAkOrDsu+ZfBc1u2m9l4zYMA1OB0X3NIjT2w3Rt7msPZQapZrxlV
mp9Iw/d6ArOegaukW0l98YtmZnSmpg4tbqB6pGzoCMfAtRsf3jf+DUuhdn36t0VD
eBUqhRo6MVqECi3NiELGpZ+ya3rrgKn94PzU65aVDX/6K9AquOz5GdNaYR++/UsK
zHfppn31Ecr6Y9LW9mrP8yj2k7hMAbMnlKcYcS0G23xUf++N9dc7d8aR/RWP74Q5
CxmiIGhLttnFyTcEhU2p07+dKZOTzkNpd3ZVpNNp0OV3e43IpjUL4QpCK+IaWlWp
zFDFtbhrCL3A2FVAW+bQcozzC2vtMalBMuiwVRIOBExSd/yLg5vZdHlJVXWU5jgT
Xc7KBPDbGCG42im7nzF6Bt7bW/af8pLG0d+U88OKShX3drQFxRJWY5hmfTrjoq4v
7JBJD25vDgACnHoWVwUuiiOuui5RD1WdMQQqqoe3HyHaINMjn4iroKpDWFeQ64EK
cW2Wu5eOCizrvPxOM3C87outtt3n0OTJmlZQWFmhEp6D5Xj04yU=
=Y+K7
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
