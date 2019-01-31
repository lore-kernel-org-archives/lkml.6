Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11345C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5AA20811
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1EfyOYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbfAaOnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:43:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55049 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfAaOnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:43:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so2763552wmh.4;
        Thu, 31 Jan 2019 06:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nF2h23C+D8QwwAcBjG8QIO7FK+KV4ROvCnKMbKet2p4=;
        b=G1EfyOYt7yjyvn3sj/tfsxsFUawprRf8YzHfVatehMDy/IFdGShtfrFJtWASp3VAMA
         0BEX4NGTPBGJluZXq2fgv06GGCksrdwD78ypAu6JjYAGPNIJ52OWK+if43ygN0A7/haY
         wkglrQUZf7J1fmrlc4Rl5pMTXD6AMYSksfkXDW0hJWd/iY+/b5uMyzIDDIBR0hyPdatK
         aTmMGzc2yl/gZrLFQvs4fOfx/5L8X35QEeVIQjSoV+k8UvdqgU7vs7TUza9WMAinmPfU
         QFdjfvXemSBfbi6pmgji2fGxRER21sGEgwim346hiTAI7/8qYWQgjY4nsnzqEc3C5leZ
         WhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nF2h23C+D8QwwAcBjG8QIO7FK+KV4ROvCnKMbKet2p4=;
        b=n4xLfF01ApKFhLDMSquVUSSH/BGN5yavK5TOlmTev9c4rTpn+HRbZe0IhGCl7a4Tye
         AYJlVrI2KKH+2I5uQ/gJR0ls1R6ncVlrRP3ePF6btotVJJorVPyTZ4F9ID3pH2UD634B
         OAsKU5r6Iuqj6V4MQmJRyGmPwgRY3ZbpgrDwE9OTqwcmUcFRHuH1qi/qrvDPCbPcEWr0
         2KwaMqAanMW34Uczq1LuNdCA6yFWkd9+0z34bQivdHPuB2Qw4c1l3olN5h3Hiyd4AIdj
         bS1FGS9ZjhAkgjzWn8lcKilplIp+Y9IT/smrvqdW7nk8ic1DE/ug12vSG06FmwwKVl27
         Wh/w==
X-Gm-Message-State: AJcUukemWJzC0tEz7oq3+wdVQc9zuB84fbAvNvKLIBVQWjUSwfQjlxQC
        SSauRx1AQ+vNFkDzAMqWHs4QB4yQasY=
X-Google-Smtp-Source: ALg8bN7DSvLPK35U3fyiYVkVSjZWr1H5hHhClzdLi7UomNaZjOmt2RBEcDGmCIx+UsSbPVHIYDmAHg==
X-Received: by 2002:a1c:cec1:: with SMTP id e184mr30851651wmg.75.1548945826529;
        Thu, 31 Jan 2019 06:43:46 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id s5sm4570051wmh.37.2019.01.31.06.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 06:43:45 -0800 (PST)
Date:   Thu, 31 Jan 2019 15:43:44 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V7 3/5] i2c: tegra: Add DMA Support
Message-ID: <20190131144344.GP23438@ulmo>
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
 <1548864096-20974-3-git-send-email-skomatineni@nvidia.com>
 <1f10cb76-59a1-93c5-ae03-ccc0cd8db1a3@gmail.com>
 <20190131120640.GF23438@ulmo>
 <0e832fa6-f143-7b24-2685-b88a55e77e51@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OwXh6gFRjCd3qPCM"
Content-Disposition: inline
In-Reply-To: <0e832fa6-f143-7b24-2685-b88a55e77e51@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OwXh6gFRjCd3qPCM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 05:06:18PM +0300, Dmitry Osipenko wrote:
> 31.01.2019 15:06, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, Jan 31, 2019 at 03:05:48AM +0300, Dmitry Osipenko wrote:
> >> 30.01.2019 19:01, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > [...]
> >>> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-=
tegra.c
> > [...]
> >>> +		return -EIO;
> >>> +	}
> >>> +
> >>> +	dma_desc->callback =3D tegra_i2c_dma_complete;
> >>> +	dma_desc->callback_param =3D i2c_dev;
> >>> +	dmaengine_submit(dma_desc);
> >>> +	dma_async_issue_pending(chan);
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int tegra_i2c_init_dma_param(struct tegra_i2c_dev *i2c_dev,
> >>> +				    bool dma_to_memory)
> >>> +{
> >>> +	struct dma_chan *dma_chan;
> >>> +	u32 *dma_buf;
> >>> +	dma_addr_t dma_phys;
> >>> +	int ret;
> >>> +	const char *chan_name =3D dma_to_memory ? "rx" : "tx";
> >>
> >> What about to move out chan_name into the function arguments?
> >=20
> > That opens up the possibility of passing dma_to_memory =3D true and
> > chan_name as "tx" and create an inconsistency.
> >=20
> >>> @@ -884,6 +1187,8 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_=
dev *i2c_dev)
> >>> =20
> >>>  	i2c_dev->is_multimaster_mode =3D of_property_read_bool(np,
> >>>  			"multi-master");
> >>> +
> >>> +	i2c_dev->has_dma =3D of_property_read_bool(np, "dmas");
> >>
> >> Not only the existence of "dmas" property defines whether DMA is avail=
able. DMA subsystem could be disabled in the kernels configuration.
> >>
> >> Hence there is a need to check for DMA driver presence in the code:
> >>
> >> 	if (IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
> >> 		i2c_dev->has_dma =3D of_property_read_bool(np, "dmas");
> >=20
> > Do we even need the ->has_dma at all? We can just go ahead and request
> > the channels at probe time and respond accordingly. If there's no dmas
> > property in DT, dma_request_slave_channel_reason() returns an error so
> > we can just deal with it at that time.
> >=20
> > So if we get -EPROBE_DEFER we can propagate that, for any other errors
> > we can simply fallback to PIO. Or perhaps we want to restrict fallback
> > to PIO for -ENODEV?
> >=20
> > I wouldn't want to add an IS_ENABLED(CONFIG_TEGRA20_APB_DMA) in here.
> > The purpose of these subsystems it to abstract all of that away.
> > Otherwise we could just as well use custom APIs, if we're tying together
> > drivers in this way anyway.
>=20
> DMA API doesn't fully abstract the dependencies between drivers, hence
> I disagree.

Why not? The dependency we're talking about here is a runtime dependency
rather than a build time dependency. Kconfig is really all about build-
time dependencies.

> >> Also Tegra I2C driver should select DMA driver in Kconfig to make DMA
> >> driver built-in when I2C driver is built-in:
> >=20
> > I don't think there's a requirement for that. The only dependency we
> > really have here is the one on the DMA engine API. Since dmaengine.h
> > already provides dummy implementations, there's really no need for
> > us to have the dependency. If the DMA engine API is completely disabled,
> > a call to dma_request_slave_channel_reason() will return -ENODEV and we
> > should just deal with that the same way we would if there was no "dmas"
> > property present.
>=20
> In my opinion it is much better to avoid I2C driver probe failing with
> -EPROBE_DEFER if we could. It's just one line in code and one in
> Kconfig.. really.=20

The problem is that from a theoretical point of view we don't know that
APB DMA is the provider for the DMA channels. This provider could be a
completely different device on a different Tegra generation (in fact,
the DMA engine on Tegra186 is a different one, so we'd have to add that
to the list of checks to make sure we don't disable DMA there). And the
fact that we're tightly integrated is really only by accident. We could
have the same situation on a SoC that incorporates IP from multiple
different sources and multiple combinations thereof as well, so how
would you want to deal with those cases?

Agreed, failing with -EPROBE_DEFER is suboptimal in that case, but that
is really more of an integration problem. Ideally of course there'd be
some way for the DMA engine subsystem to know that the provider for the
given device node will never show up and give us -ENODEV instead, but,
alas, I don't even think that would be possible. That's the price to pay
for abstraction.

Thierry

--OwXh6gFRjCd3qPCM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxTCZ4ACgkQ3SOs138+
s6H0wg//RRMujyzSzXWpZldVvx9vlWYeUEwuvBIExPjIoU5XIYGi84HUGr5bHBQh
q+h1NoX+6t3XbLUAAwLTrl/FrPkqhsJW7RRKDoU3r9eXVnhOyj/47WUxtC27Bb3/
nw6jjrAPyyT+6ZfM70wK2dR4JrovcW4O8gAIXOTtutrFO8HwLwNAcP9Vh4Lpt6yI
LeDYjpyL/8dvVgRyXcTGmisXBcoNzfZ1gBEWiX9PNAmcRhVQiqvk411I2xlHVxUK
qEGzzojl3I/Bp7mPlgt/r83GgFgvndvyBzwGxMoIFwvcLu0Tzi4DdI2UZRxtaTCl
Hhz7jJkxARvb8KH5kpNp5TZq7HExzWNQ/ibKCv6zMrGSdWM3XN0mj7mZhjdpg+F0
PhBMxZ38RIncob9N9QN+RqrpqXJfIMW5R59aVdIaFW503nkNUWiwTP5L4JIBoV7T
ZcyrsStkyEEESlnyLtHn2mgzVQzTWqwIqsRXNN2GghJJKV2FY3SWU+cYArLJGy4Z
lof76FCQUtv8inquMYPuwpEp9hx3Gie/8B169CTry9L4oxbSljqxavgkjPVzf9f/
Krnuzf5oWZi71fg4/RGzZXrHaSrfgJrTXDbnxPL79C/xX4xvyx21xHgHWYHHit/2
t9VxEl5mPuCbKJicMRXAIJTDGpw6vLcoz+BwFoIkKmzH7vbEe1U=
=ue2Q
-----END PGP SIGNATURE-----

--OwXh6gFRjCd3qPCM--
