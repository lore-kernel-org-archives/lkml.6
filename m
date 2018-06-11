Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id G9DXHPZfHlv9OgAAmS7hNA
	; Mon, 11 Jun 2018 11:41:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5AC52607E4; Mon, 11 Jun 2018 11:41:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXne/40S"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C8819601C3;
	Mon, 11 Jun 2018 11:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8819601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932960AbeFKLlk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:41:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45857 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932858AbeFKLlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:41:37 -0400
Received: by mail-wr0-f195.google.com with SMTP id o12-v6so20024507wrm.12;
        Mon, 11 Jun 2018 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uPIvlP0HjzumjWdRAiDMra90YYIvJTsu1OLoi8y4p/I=;
        b=tXne/40SdUNaqD0F40wNWCxtOKVY/Sx26efg+YW71zEctI1UXtFtE9xhgMwpEOH7yd
         9YeZyfGXQjtZO+PhbYCfqOp6iWvZOBa52n4uptwCW9W0HVRnebvwcNwXUhNt1wb7klyT
         9IwvUHwruwhG4XENmG1gDSzp/H+JqwNhaeI1u4CzVCUYbiGDhQ3U58sFlVHMPBeSE3Gm
         89ahIZ6cnc0O0TOe7yIOYGJ2vXY+WJ3wUgxH+Ux8XNd/r8VpI82YbkYpxmfqx8SMF4kg
         PCQWzJYmnoR4PcUJb/wTN8NViYF/F8+EgJ7UXbR1ut85gMw01cPTLhXA8rMCTicadAHu
         eoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uPIvlP0HjzumjWdRAiDMra90YYIvJTsu1OLoi8y4p/I=;
        b=Q5HKTzZUYETXcXX9QXJRkPxDnen3v8YmzgCvAaDqPX/yS114rWRX6KjdcnY5j43pnR
         9L3LKciLQ9MedEZLsLIU9H/KYHPMgzwhfgmqbkpbkF7pPA7QeUpfiIh/5rODEPvj17dd
         2qVbT2L0UEUkH4AnF7/E+hmJyI4wlKkD6HgVHLZ5fZho6i267trGjkBWUdOCxZbvRlMf
         HlzLp4eCeKshZ+sU6fNbACSohbmwhXZ5yFTUQXBPQA38EqW5Zi+mF73vo4Z10Tf0IRtV
         yfRqqlMpYsg7vFnNBZHrL2xt4mjyo0uSG/Mc8Ot8cY5RtnR4yB+ZHNzNphMzRH2VHsP5
         MsZQ==
X-Gm-Message-State: APt69E0M+Fc6mnAqEe0zXgf0qHE7AOABKb2t5EsL8fKyhfH7jSDBgePi
        N7cUME1ar3nzXl3AA8nyEyQDhQ==
X-Google-Smtp-Source: ADUXVKLOro/OqSm91Pgr6sKvJRulKfKHM9fXoX1fFv7wREz0LV+yFou4NbR4uDfnhvPWAAgXwM8b9w==
X-Received: by 2002:adf:982d:: with SMTP id v42-v6mr13212149wrb.93.1528717295239;
        Mon, 11 Jun 2018 04:41:35 -0700 (PDT)
Received: from localhost (pD9E510DD.dip0.t-ipconnect.de. [217.229.16.221])
        by smtp.gmail.com with ESMTPSA id z14-v6sm6253159wma.11.2018.06.11.04.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 04:41:34 -0700 (PDT)
Date: Mon, 11 Jun 2018 13:41:33 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] memory: tegra: Introduce Tegra20 EMC driver
Message-ID: <20180611114133.GD31977@ulmo>
References: <20180603223654.23324-1-digetx@gmail.com>
 <20180603223654.23324-6-digetx@gmail.com>
 <20180606110258.GL11810@ulmo>
 <c17a1edf-f87d-e5f6-b446-34505a2bbc07@gmail.com>
 <20180611113503.GC31977@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Content-Disposition: inline
In-Reply-To: <20180611113503.GC31977@ulmo>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 01:35:03PM +0200, Thierry Reding wrote:
> On Wed, Jun 06, 2018 at 04:42:01PM +0300, Dmitry Osipenko wrote:
> > On 06.06.2018 14:02, Thierry Reding wrote:
> > > On Mon, Jun 04, 2018 at 01:36:54AM +0300, Dmitry Osipenko wrote:
[...]
> > >> +	if (!child_count) {
> > >> +		dev_err(emc->dev, "no memory timings in DT node\n");
> > >> +		return -ENOENT;
> > >> +	}
> > >> +
> > >> +	emc->timings =3D devm_kcalloc(emc->dev, child_count, sizeof(*timin=
g),
> > >> +				    GFP_KERNEL);
> > >> +	if (!emc->timings)
> > >> +		return -ENOMEM;
> > >> +
> > >> +	emc->num_timings =3D child_count;
> > >> +	timing =3D emc->timings;
> > >> +
> > >> +	for_each_child_of_node(node, child) {
> > >> +		err =3D load_one_timing_from_dt(emc, timing++, child);
> > >> +		if (err) {
> > >> +			of_node_put(child);
> > >> +			return err;
> > >> +		}
> > >> +	}
> > >> +
> > >> +	sort(emc->timings, emc->num_timings, sizeof(*timing), cmp_timings,
> > >> +	     NULL);
> > >> +
> > >> +	return 0;
> > >> +}
> > >> +
> > >> +static struct device_node *
> > >> +tegra_emc_find_node_by_ram_code(struct tegra_emc *emc, u32 ram_code)
> > >> +{
> > >> +	struct device_node *np;
> > >> +	int err;
> > >> +
> > >> +	for_each_child_of_node(emc->dev->of_node, np) {
> > >> +		u32 value;
> > >> +
> > >> +		err =3D of_property_read_u32(np, "nvidia,ram-code", &value);
> > >> +		if (err || value !=3D ram_code)
> > >> +			continue;
> > >> +
> > >> +		return np;
> > >> +	}
> > >> +
> > >> +	dev_info(emc->dev, "no memory timings for RAM code %u found in DT\=
n",
> > >> +		 ram_code);
> > >=20
> > > This seems like it should be dev_warn() or perhaps even dev_err() giv=
en
> > > that the result of it is the driver failing to probe. dev_info() may =
go
> > > unnoticed.
> > >=20
> >=20
> > Absence of memory timings is a valid case, hence dev_info() suit well h=
ere.
> >=20
> > I can't see anything wrong with returning a errno if driver has nothing=
 to do
> > and prefer to keep it because in that case managed resources would be f=
ree'd by
> > the driver core, though returning '0' also would work.
>=20
> I disagree. A driver failing to probe will show up as a kernel log entry
> and is something that people will have to whitelist if they're filtering
> for error messages in the boot log.
>=20
> I think it's more user-friendly to just let the driver succeed the probe
> in an expected case, even if that means there's really nothing to do. If
> you're really concerned about the managed resources staying around, I
> think you could probably get rid of them explicitly. By the looks of it
> devres_release_all() isn't an exported symbol, so it can't be called
> from driver code, but perhaps that's something that we can change.

Maybe an easier way to avoid keeping the managed resources around would
be to move the check a little further up. That way, we can abort earlier
if no EMC timings are available, before any resources are even
allocated.

The tegra_emc_find_node_by_ram_code() function would need to take a
struct device * instead of struct tegra_emc *, but otherwise it should
work fine.

Thierry

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlseX+0ACgkQ3SOs138+
s6FkahAAwxC0A5qAl1JqwFoKzCRt6HubfHuyf5m0f60RrW+fXg/3Z4nfSBnEcS0D
uni1OKg+5jfh4Wfg5PyEhfcXa1haxAOgQj6FvrIPiPdIPRV8WfAjpwh2OPejPKwd
GyA59x5k9ieGZ8ekOw2ynWgjBoel8Ckv0uEqDFfX4ZGJkMSyIge/eb4dQUQnsYjj
aYCf14NOH5SLWzcboLvHI+Hu9/yB14B6uqMiQjZCdxrpP6Uq7MD333OKout+4UGZ
lRzpqLosD5J4fTcvsx2TX6WXLK2lYSmd/RJBOvyb+ZVjdGeIal7csRTZksLzCuqP
5A5QJTgbHIpegR21xxyOUKLb5BjJdaCsxW/3cfeqt3I59sA/V//Qw69TsVl7FYxJ
rD3QdcFFGObKfmopnj6Hjk7ldA5C0cgoGiKLF0QuCDYXZ25wMkygLwu0BpltuCWU
PsQWhgrx9rPbALqIE7e9JystHjvzHxQOvRwaLzNhgrGxULXdayeUOfvzZF2WvTMW
5q4Bq9ck7/JN6OU3U35TN9pe85SDNt85B4IxJUaCvL3vKyrM13a5l5DQsgjxhqc5
woQUz+rnbeJP9LWt2Re7aIhHVUUq00Lo3lNK2/M75YCFBqO4Fw5cfu23E8FiEl2s
qm4kIRwbMsR689omAi1EtM9gtd0XfmLIZ3mv/BDttqAnb19CRkk=
=68ft
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--
