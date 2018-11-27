Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9626C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F062133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYJBLrQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F062133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeK1BeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:34:10 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37976 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeK1BeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:34:09 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so19199612ede.5;
        Tue, 27 Nov 2018 06:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BADIlymsP1ERJL5oxpRCrAlol00rIVOrjKMZXq0zyuk=;
        b=GYJBLrQEhRO1mdO3HlKryjdJWBpyKnq26Rva/8LDtjfRu5R/qV7DYgu+bUi8kGaHuN
         UK4HKcOkJvXrBttkO5jbDjFvj6tS+pXkT/oGEQd9Z/UdEHLhf+oS0RhkcxI1nAlCQES6
         8r9lTswMM9+UVbxSQ+Lu3liL+w5FyZQAqvXOhsw2CQnMM7D+9NZfOKLomgFer7Vg5+LF
         R7KuTDfUfc9fW7H0cn5jaQbinDQzzfs0+9JQh4EDwQH2NV7125LuWuV/IXopGmlyASIa
         lsHrGJdlKw9ZRAxqmpy7LGUaPx2haL5R8OfiAq3+KtZbJPs5Vx3/BQ6VSGCwcs5+dKx/
         4TJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BADIlymsP1ERJL5oxpRCrAlol00rIVOrjKMZXq0zyuk=;
        b=rAjN4CIm7zP9YWR5ECQBd0on9XJqRhGlwvINgoV7OKXoVESrfYT/UhSipPe5rTHdXo
         jGfrUmLZ3/5Tw2uMY3SdU+o9MYMRSs0qSdioHjTnikdD2I+n6TqEsRtYMIS/DRkhxk2p
         R2ckk4Rs2AphWe3u05LjxMPCRjEysGP7ptFfOft8QCcxFMM+k0lkAiqJc4pnXfCYREcT
         hla1F0xhKt/iA6J/zmkvQLTDXM56LwzuE4ACA2hJ/sqc5Pwr2ZRFRZsW1vnJCv8PFGT4
         wLunOTMYQgd0ROaANQ/sSfTvNyBaY9eJ/6t6hCxYom8BXPEQnykernGZ85GLgT6OvkNY
         cnYg==
X-Gm-Message-State: AA+aEWYxyLWHNlVRXXqGmzE3wsNffSS7b7lltA9Um8ZigQAn/OZfBwAh
        u4ZKV9WNqMy6+M7bkAFLKPwlputH
X-Google-Smtp-Source: AFSGD/VwjS2+Oix314v5IqDjl58ZppvR4AQR0/4KTBZljab6hv2Y2qPOTyNFxgWqPNBx1Lxp4y97yQ==
X-Received: by 2002:a05:6402:1299:: with SMTP id w25mr25739452edv.237.1543329360361;
        Tue, 27 Nov 2018 06:36:00 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id d27-v6sm606711eja.20.2018.11.27.06.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 06:35:59 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:35:58 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jose Abreu <jose.abreu@synopsys.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        netdev@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Move debugfs init/exit to
 ->probe()/->remove()
Message-ID: <20181127143558.GA20622@ulmo>
References: <20181123122122.18957-1-thierry.reding@gmail.com>
 <9c8443aa-edaa-2398-bdd8-df49f2529cb6@synopsys.com>
 <20181126153419.GD19710@ulmo>
 <3f5ef823-4683-04f8-5f3a-0ccfdb472d6d@synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <3f5ef823-4683-04f8-5f3a-0ccfdb472d6d@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 09:02:51AM +0000, Jose Abreu wrote:
> On 26-11-2018 15:34, Thierry Reding wrote:
> > On Fri, Nov 23, 2018 at 12:44:02PM +0000, Jose Abreu wrote:
> >> On 23-11-2018 12:21, Thierry Reding wrote:
> >>> From: Thierry Reding <treding@nvidia.com>
> >>>
> >>> Setting up and tearing down debugfs is current unbalanced, as seen by
> >>> this error during resume from suspend:
> >>>
> >>>     [  752.134067] dwc-eth-dwmac 2490000.ethernet eth0: ERROR failed =
to create debugfs directory
> >>>     [  752.134347] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_set=
up: failed debugFS registration
> >>>
> >>> The imbalance happens because the driver creates the debugfs hierarchy
> >>> when the device is opened and tears it down when the device is closed.
> >>> There's little gain in that, and it could be argued that it is even
> >>> surprising because it's not usually done for other devices. Fix the
> >>> imbalance by moving the debugfs creation and teardown to the driver's
> >>> ->probe() and ->remove() implementations instead.
> >>>
> >>> Signed-off-by: Thierry Reding <treding@nvidia.com>
> >>> ---
> >>>
> >> Did you test trying to dump "descriptors_status" file when
> >> interface is not open ? I think that's the main reason why this
> >> is not in probe ...
> > Indeed, that seems to cause a hang. Still, it doesn't sound like the
> > right things to repeatedly create and remove debugfs files just because
> > we can't provide the contents when the device is down.
>=20
> Agree.
>=20
> >
> > How about we return an empty file or an error code instead when the
> > interface is down?
>=20
> I think an error code would be more suitable (ENODEV/EBUSY ?).
> Can you submit v2 ?

I submitted a v2 earlier but wanted to elaborate why I ended up going
with an empty file instead of an error code. None of the error codes
seem like a good fit. For example ENODEV might lead people to think that
somehow the device was removed, whereas EBUSY could be misinterpreted as
the device being busy and therefore being unable to dump the status of
the rings.

I was leaning towards EPERM in the end, but then thought that it also
was ambiguous because it could be interpreted as meaning the user lacked
the permissions to query the rings status.

So in the end, it occurred to me that reading the rings status for an
interface that was down wasn't really an error. It's just that there's
no ring structures to dump, so the most logical way to return that was
with success but an empty file.

Thierry

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv9VksACgkQ3SOs138+
s6F//RAAj7XNgHmaMGPThRAkeNlSdNIWy7gZy9HIWelfy7D/PanOb+Z1faCrtrcO
846S4PK/ZUbiALOak3ZFa4SXIqmmwcM+X7JZ3AMOPhz/GAT9wIZP+p0MhB8AYXfP
8mwXG8EvCfHEy3cRt/n1cWKGATEhrwsK9VNRatribbQ9XLIFxI5T1S0uPK3X8fmB
+S2kMnYCnOszgw6k7/pLD0Ibs4W2HvMx56INnU+DbQbFbHsB66zyESiynZa710Gp
g9aLZ40NgWI8sIAy7N81er/iiPsV8yil+3BO5TIyIPkj8oARytOghrs6uRM3ZWmP
/w218dckJYh5hvsT5aim0K3vSIW9F9u6yLb3tMGUgjc/+ePxrmaF2dQabAYr4SWA
HXh15ouRwSo7vzMpeGVYqpIx6xGyVJrmnc46uYaoJ+AA+aLFcW9+7qY6k3qBJNWn
vk9+CmZb1Dvo6ZFJTdqj/LO3o1548h21hE3dprBv0VpGx8aX50BZ98ccvpGmxJUU
+/aZQCDQ2NYzxauLju2iusouZ41ZhV6jdXHfWZUoNbXrEi0NdA/GZKJ5HihcH3zV
mw1f3cltjfkaE0nn9jQfWYhS9VHeSONcId7/OEDmu9rtrgQSPtbNPCyokxhAxEpo
pBdBzzTk08RRrKpbTuTLNFkW8yTFdzHjeespnwUDB+FLpPTptek=
=AA+E
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
