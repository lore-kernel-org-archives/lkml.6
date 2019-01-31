Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7965BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E5220881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4m9svUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbfAaQBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:01:42 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:39852 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387875AbfAaQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:01:42 -0500
Received: by mail-wr1-f44.google.com with SMTP id t27so3891087wra.6;
        Thu, 31 Jan 2019 08:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PZuzktOGuo4MVYSwTXt0kim+BZzUXQ5yBh1uZOx5pGc=;
        b=N4m9svUfJfDpv5qbdnFCplPy58/Bn+ok5h55a3xzEYL9C18zfTQ7/++5bRNIec+Dln
         FqT0T9GfxGVY+UtSOhPC+ciFy/vOktmgnTnKGRceirCO0P6Clsoqpl6U5N051XXXq2dv
         ygzVyG5AIEVOrW24KSXW4bvEW88aUdg9he6oEm6Om7x7c+LoWxoxjWgtBOKQ14DL4Yu7
         UpKkYzkQY5cHN1nRCoSRrLGi4FzMkmP3e1dz3i3cLHPcWgDxNQTs1be7wuVGJw6cVVog
         bJxm6WGGk5D6qa7J3O8pDT/xYLAmdQZojeRWZiXOucxDOLoytgU8kml/Rt9N1TRwu1Rv
         ZR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZuzktOGuo4MVYSwTXt0kim+BZzUXQ5yBh1uZOx5pGc=;
        b=Zh1NQ/UdxjK1rLgrvp+Xs6+0D03fanFRIvl2m9DSNI3bj3sAiQDLMSfv2CTXUrPCAv
         lzaCj+fzr9w5qhfZIusu2L/3KjNFg2bfcZiY1fKn5RVoMf1hP/MJAHMl1HGcHdIUJrHc
         Yrcj5uN3wnrrXf026ikfflIgELm0aQtLqUWKJ7VKobcpqFeWJhZFDM4hSHOzCL4x16eY
         mYRYB5+AnKylFBtftejkq2x/kg+iX8vUdDKxiSW+vLEyjd65fmf2TXtNejNfvyse7jse
         KcrxW+DzL3gesQ6XD1rXc9YXZg/FLy9p0h3BwjWFRMjvlXNA03LAen6yJpLUEdYaZbJi
         zKlA==
X-Gm-Message-State: AJcUukeDiCX75r2D9e9zsu1zf205V/EHt4ZuRPBJ0qoSxuNFNQs7ZoCF
        fIsrIIUgtg7I4yjxpbNyIjg=
X-Google-Smtp-Source: ALg8bN4Az/SnIXpZZoFs52XpI3a4AJQutyGMuXZvB1fpoaSFBGj3JFWXGH4rpetwgIbimYuCMFa9Nw==
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr33213861wrx.259.1548950499203;
        Thu, 31 Jan 2019 08:01:39 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id 200sm9745169wmw.31.2019.01.31.08.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 08:01:38 -0800 (PST)
Date:   Thu, 31 Jan 2019 17:01:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V7 3/5] i2c: tegra: Add DMA Support
Message-ID: <20190131160137.GA31126@ulmo>
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
 <1548864096-20974-3-git-send-email-skomatineni@nvidia.com>
 <1f10cb76-59a1-93c5-ae03-ccc0cd8db1a3@gmail.com>
 <20190131120640.GF23438@ulmo>
 <0e832fa6-f143-7b24-2685-b88a55e77e51@gmail.com>
 <20190131144344.GP23438@ulmo>
 <bdb5ab9f-b047-6b9e-696a-8d6ef4065c77@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <bdb5ab9f-b047-6b9e-696a-8d6ef4065c77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 06:02:45PM +0300, Dmitry Osipenko wrote:
> 31.01.2019 17:43, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, Jan 31, 2019 at 05:06:18PM +0300, Dmitry Osipenko wrote:
> >> 31.01.2019 15:06, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Thu, Jan 31, 2019 at 03:05:48AM +0300, Dmitry Osipenko wrote:
> >>>> 30.01.2019 19:01, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> [...]
> >>>>> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2=
c-tegra.c
> >>> [...]
> >>>>> +		return -EIO;
> >>>>> +	}
> >>>>> +
> >>>>> +	dma_desc->callback =3D tegra_i2c_dma_complete;
> >>>>> +	dma_desc->callback_param =3D i2c_dev;
> >>>>> +	dmaengine_submit(dma_desc);
> >>>>> +	dma_async_issue_pending(chan);
> >>>>> +	return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static int tegra_i2c_init_dma_param(struct tegra_i2c_dev *i2c_dev,
> >>>>> +				    bool dma_to_memory)
> >>>>> +{
> >>>>> +	struct dma_chan *dma_chan;
> >>>>> +	u32 *dma_buf;
> >>>>> +	dma_addr_t dma_phys;
> >>>>> +	int ret;
> >>>>> +	const char *chan_name =3D dma_to_memory ? "rx" : "tx";
> >>>>
> >>>> What about to move out chan_name into the function arguments?
> >>>
> >>> That opens up the possibility of passing dma_to_memory =3D true and
> >>> chan_name as "tx" and create an inconsistency.
> >>>
> >>>>> @@ -884,6 +1187,8 @@ static void tegra_i2c_parse_dt(struct tegra_i2=
c_dev *i2c_dev)
> >>>>> =20
> >>>>>  	i2c_dev->is_multimaster_mode =3D of_property_read_bool(np,
> >>>>>  			"multi-master");
> >>>>> +
> >>>>> +	i2c_dev->has_dma =3D of_property_read_bool(np, "dmas");
> >>>>
> >>>> Not only the existence of "dmas" property defines whether DMA is ava=
ilable. DMA subsystem could be disabled in the kernels configuration.
> >>>>
> >>>> Hence there is a need to check for DMA driver presence in the code:
> >>>>
> >>>> 	if (IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
> >>>> 		i2c_dev->has_dma =3D of_property_read_bool(np, "dmas");
> >>>
> >>> Do we even need the ->has_dma at all? We can just go ahead and request
> >>> the channels at probe time and respond accordingly. If there's no dmas
> >>> property in DT, dma_request_slave_channel_reason() returns an error so
> >>> we can just deal with it at that time.
> >>>
> >>> So if we get -EPROBE_DEFER we can propagate that, for any other errors
> >>> we can simply fallback to PIO. Or perhaps we want to restrict fallback
> >>> to PIO for -ENODEV?
> >>>
> >>> I wouldn't want to add an IS_ENABLED(CONFIG_TEGRA20_APB_DMA) in here.
> >>> The purpose of these subsystems it to abstract all of that away.
> >>> Otherwise we could just as well use custom APIs, if we're tying toget=
her
> >>> drivers in this way anyway.
> >>
> >> DMA API doesn't fully abstract the dependencies between drivers, hence
> >> I disagree.
> >=20
> > Why not? The dependency we're talking about here is a runtime dependency
> > rather than a build time dependency. Kconfig is really all about build-
> > time dependencies.
>=20
> My understanding is that Kconfig is also about runtime dependencies,
> do you know if it's explicitly documented anywhere?

I don't think it's explicitly documented, just a common practice that
I've seen applied multiple times over the years. A quick grep through
the drivers/ subdirectory confirms that it's not typical to have this
sort of dependency in the code.

Similarly, Kconfig uses select primarily to pull in dependencies that
are in the form of helper libraries and such. Occasionally you'll have
some ARCH_* option select a couple of features, or even drivers, but
that is mostly a shortcut to explicitly having to list the essentials
in a defconfig.

Another reason why it's not good to model these runtime dependencies in
Kconfig is because they unnecessarily restrict the driver. For example,
if you want to build a specialized Linux binary for Tegra186, you will
certainly want to include the i2c-tegra driver. At the same time you
won't want to include the APB DMA driver because it doesn't exist on
Tegra186. Instead you'd want the (non-existent) GPC DMA driver. select
on the APB DMA driver will unconditionally pull in the driver, depends
will only allow you to build i2c-tegra if the APB DMA driver is also
enabled and the conditional in the code may lead to not using DMA
because the APB DMA driver is not available. So you'd have to modify the
i2c-tegra driver to take into account the GPC DMA driver.

> >>>> Also Tegra I2C driver should select DMA driver in Kconfig to make DMA
> >>>> driver built-in when I2C driver is built-in:
> >>>
> >>> I don't think there's a requirement for that. The only dependency we
> >>> really have here is the one on the DMA engine API. Since dmaengine.h
> >>> already provides dummy implementations, there's really no need for
> >>> us to have the dependency. If the DMA engine API is completely disabl=
ed,
> >>> a call to dma_request_slave_channel_reason() will return -ENODEV and =
we
> >>> should just deal with that the same way we would if there was no "dma=
s"
> >>> property present.
> >>
> >> In my opinion it is much better to avoid I2C driver probe failing with
> >> -EPROBE_DEFER if we could. It's just one line in code and one in
> >> Kconfig.. really.=20
> >=20
> > The problem is that from a theoretical point of view we don't know that
> > APB DMA is the provider for the DMA channels. This provider could be a
> > completely different device on a different Tegra generation (in fact,
> > the DMA engine on Tegra186 is a different one, so we'd have to add that
> > to the list of checks to make sure we don't disable DMA there). And the
> > fact that we're tightly integrated is really only by accident. We could
> > have the same situation on a SoC that incorporates IP from multiple
> > different sources and multiple combinations thereof as well, so how
> > would you want to deal with those cases?
> >=20
> > Agreed, failing with -EPROBE_DEFER is suboptimal in that case, but that
> > is really more of an integration problem. Ideally of course there'd be
> > some way for the DMA engine subsystem to know that the provider for the
> > given device node will never show up and give us -ENODEV instead, but,
> > alas, I don't even think that would be possible. That's the price to pay
> > for abstraction.
>=20
> It's not a big problem to solve for this case, there is
> of_machine_is_compatible(). To me it's more a question about the will
> to invest some extra effort to support all of possible combinations.
> If there is no such will, then at least those unpopular combinations
> shouldn't hurt and thus it should make sense to add an explicit
> build-dependency on the DMA drivers.

I think we're arguing about the same thing, only coming at it from
different angles. For me "all possible combinations" also includes the
case where you want to be able to run the driver with DMA if the APB DMA
is not enabled. And I similarly want to be able to run without DMA if
the APB DMA is enabled (by explicitly removing dmas from DT for
example). It just seems that we can't have it both ways.

Also the i2c-tegra driver can perfectly well function without DMA
support (it's done so ever since it was first merged). Keeping existing
functionality shouldn't require the addition of another driver.

Given the deadlock, I think I'd prefer the option of adding the
conditional in the code. I think that's the most accurate description of
the dependency, even though ideally it would be handled transparently by
the DMA engine API. Would that be an acceptable compromise?

Thierry

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxTG94ACgkQ3SOs138+
s6ETGw/+KGSGJfJHDWEpdG40IaLE1E2ebER6QG9ADHuMGxRTrYQyovW8yjcegdQS
c65TZOxivbmoa47/h4B9IROctY4jGA79ZtQfFUBD7zkG5pNDypk5ydavSVrfaY+r
awTgQQp/R8TWlvF9nwBaUP5LBmM2ZMBkFdOcfCNZVQEmUKnMkMyFm/N5l9uD85wE
MrIEEuy7tAzjpqjMiejMwj5Y7T3z36VuEc40+ByB0RtH2JPCYaezSLNP4lIxLHWK
vjYPOn5TwnlP3U7GoqS0MO8lCRagweYrR8q4V27kO7xF/R8OZsijl5FzV15o6dv2
n9VB/1S5Y1lbFuKzqE0m7NBQcXmteBEau9WrRgBXw4L8g/JesZv3PHrCtxQaQe0X
FEmLb0z5D7R3rkL4rfG8K/x6uQP2yFCClOcytjQAWIe9fbpC7cgEZlh/b6DodXuW
ATW+kGUqitBRizpHtSKs731nHIBCLbQBzFzBhhnAKw7C29Q5ApZXubR4OvLa+8MR
EVroCG7LRLTCptSNwrHrw9+aFo0aGS6etsnX4pnP/eNk6inwcoVySyXMkr2rcd/m
B0UxDmoPfddSh5sRRNoAMdGDSIgcdOrfjlK3pJv5wUha9ti/Rcs3DYXori49brmS
6GMWJ4047BpTOJDkculnNbbQthDJaM+Vcz9ljryWLhkpKjDAmM8=
=ohwu
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
