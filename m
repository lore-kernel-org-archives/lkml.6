Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT,
	WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7ECC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443BC20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2z/ioMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443BC20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbeLJQ01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:26:27 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:40363 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJQ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:26:26 -0500
Received: by mail-ed1-f50.google.com with SMTP id d3so9989807edx.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XkH8Kd1l2T3aFDNb+AhDS8ZZP1BskzEXBckN1Nq2HH4=;
        b=O2z/ioMjMpm4qLBWvYOS2OJ9O9RRIn4LV84Z9zRV3TCmBOwaQQhbzypHAycAM2TSAb
         geju5JLBQSd5r9BKnCbMmjRumubqMpPB1gUEob53Feh4lfbW8pWNRhcs2X195PQ4rV5b
         NaS59y0pfecGzeFu5VolQD3drA9+FLcV8wZHYXOCU3C6s4vkNlytl1Ztx/I/uQqwYIqm
         QkPNfBDAQFnK3C3BIg8cA0N7Nuj2N+cu9/O4U2re1Zn2tTn0CTvVa2JIwvPjldSj2Svp
         PZKaldkBqLjzXcFVxJ0l4lwNAMf3E6yMeS3JoFgYKcR4NaPOCH6EQQtonDYQm5C4aCCs
         5YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XkH8Kd1l2T3aFDNb+AhDS8ZZP1BskzEXBckN1Nq2HH4=;
        b=VsvFmovZEsHI/qZlOfg4kzCsxigNcwMZbzJisCs8DGU6CoaELYcRcFGeUSZl7MFehI
         hR2S0wqaRbu1Ii0bmJC3fN4W/GsujGpC/qnmxMIZ+39lHLG3Z5VuOuOExqXAuJQVyLVp
         AXV5JYyOPIeW76/5QdlViFSH5BVob9XdFL+XYteIml11lm5oMj5eKW/BEIacEX6who55
         vIrWDfi1sGWTU105cI8vFq2JPqBytRbmrU7qpBiX4S9XJKcMhetbKGtvkI+WQXXfq2Ck
         CCAY0KWygcmsIE9XEKBjEX1yoC//eiZ38omuIm/X7f2ZXt1UCue0IJFbfDWxHWN7FQfO
         Jymw==
X-Gm-Message-State: AA+aEWYcpIp4HKxoyVmW44a7VOqx2aaYh/mHAWrUFxCCTkLMkoYSuqem
        dT1zo1568OuFoplKnrsK5wg=
X-Google-Smtp-Source: AFSGD/VKpjguEShOxQa6FnoVVRjNAoP3zYOYzm8PUKARjZyYhqLWtY0bRByiw1GnZ1Hx49utp8mG3w==
X-Received: by 2002:a17:906:2f88:: with SMTP id w8-v6mr10089603eji.114.1544459184485;
        Mon, 10 Dec 2018 08:26:24 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id b11-v6sm1868049eje.38.2018.12.10.08.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 08:26:23 -0800 (PST)
Date:   Mon, 10 Dec 2018 17:26:22 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Karol Herbst <kherbst@redhat.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: next/master boot bisection: Oops in nouveau driver on jetson-tk1
Message-ID: <20181210162622.GB4789@ulmo>
References: <89fa50d0-945f-d1ed-ae55-ee947187f209@collabora.com>
 <95255117123da3702da585491d2fdd74890937c0.camel@redhat.com>
 <16ca4f0f-6800-7204-6fc2-286caa7b850a@collabora.com>
 <20181210142559.GB6307@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <20181210142559.GB6307@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 02:25:59PM +0000, Mark Brown wrote:
> On Mon, Dec 10, 2018 at 10:00:08AM +0000, Guillaume Tucker wrote:
> > On 08/12/2018 00:08, Lyude Paul wrote:
> > > uhhhhhhhhhhhhh
> > > didn't we fix this weeks ago? with "drm/nouveau: tegra: Call
> > > nouveau_drm_device_init()"
> >=20
> > Yes here's the fix from Thierry:
> >=20
> >   https://patchwork.freedesktop.org/patch/263587/
> >=20
> >=20
> > and I can confirm that it does fix the Oops when applied on top
> > of next-20181206 (what I used for the bisection last week):
> >=20
> >   http://lava.baylibre.com:10080/scheduler/job/71109
> >=20
> >=20
> > However the fix doesn't appear to have been applied in any
> > upstream tree yet.
>=20
> This has been broken for a considerable time now with no response from
> Ben - is there some other path we can use to get the fix merged?

I suppose we could go directly via Dave. But Ben's usually pretty
responsive, so he probably just missed it. Let me ping him on IRC, maybe
that'll get his attention.

Thierry

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwOk64ACgkQ3SOs138+
s6F6XQ/9ES0hTsz4LycsQufs+tw97MIYsZy4gUvyiX5rhUXz6/9wI5JVsEz+GV8z
Xd8Jn7FgbLh6lP1QW9+19mfUaLJfdRz/u2OmOUI+iQrPtpDIuLEiI5dHrUnYlVwr
88MvV265t9Wua8zD2NndZbwAU20iYBGTsaSUnqmw+vmvxP6z+Yr3ULoNqET3OFV+
1M+Lu6I+4ZCSvv14pjACQYzX4h5puXHk8Y1B8/3if4PFgA6ZQ5aILk4HFw232OLz
wQyDZEhfsRz0gb1kkBZuBq/UfTHGjSJ589L9RjNTy/yOmrFfTTb5o/KlzlvmK1Yz
nOFgkpNF2xLpniULwO3dWeI2GMjRidgGWAKqaxWpgXtDpE6hwFnKU8FEFgzOw9sc
kecoaAt8dOgrYnCC99hAM9qRcvwgXutN4gSVmDaLfJvecRbCk80tlJ42q5ujEMvE
CwBm7l7nuYPp0Yql/0A56YoYUIftVJtPr/cthtFZMA879tSzppwpxngaCu5k04uh
3yQulluwPJAkhgnljzAWa9+krla7Mfekr2Jy7O1OBVKbNpUVWfsXqPlfL4hky9b5
21REm8d8itrxAhZUzb979DicV1b8cx6gJodDfc+IHq8l8Pohi0RJZmfn5OnDY/cp
4LjjuH4nlSP1FDsGKomypqGAgoBeLQioyIrP0cCWprJFaJHHM6I=
=P7H+
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
