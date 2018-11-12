Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4135C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B39224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4xq1GgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B39224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbeKMBYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:24:01 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33448 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeKMBYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:24:01 -0500
Received: by mail-ed1-f67.google.com with SMTP id r27so4751747eda.0;
        Mon, 12 Nov 2018 07:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qo/ro8ScpXG0uJ1MFMpXOn60TWxkFsT0+7vV3XnI0Yg=;
        b=P4xq1GgWCks/MrGfIPeu1bysO0/lGSkMCVbguJhbHYYYyiUqwxjNvIuFHjkdDK3sDl
         XnGr/aK/RABj/pcbfHvlyQIe25zAK2f4SyLQ71fXeB7EzCkDSHlAYv05T536ufaz2ygR
         9nssKJw9oBW2rZSjbvkU4yTnYgAxrBevvtuIMevHpckSeq9Ek+9PsHHyxQF9IiqOqQFO
         gzJHoBKP33Rkv2LV3YxTSuq2ogowxZ7YU6MJC+08SLncGo4cioO6OCG6jcgplgKY0NuO
         8/9uXgpB01SGtbhnJ30KrzA/JVX0XpXShlBXXr8bcGAUg4ZwUDG9g9Yn7S6oQsiXgevf
         Ei5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qo/ro8ScpXG0uJ1MFMpXOn60TWxkFsT0+7vV3XnI0Yg=;
        b=R1l9HAQmXb1teMuIAYgR5Tv9/9n7vrBVlHrvJDrwx+olaV9mmi6hE8BExrkN9QBGwf
         dNdK0+HjHUMy5h8RYJlnrx+ZfqPIvVSEwTRJwvveJy3qtR8ZcJtozFykmp0kLqn1fpeh
         uBNe69wcfieuhJqYOHquJ8m6LI6x8ZRWi+hV8r/tIVrHvfrv2WwRggVohGLA9MO6eElx
         KcmYPUYBIrrwUwQKvkzvwK2A2PqHSJteL0hizJ8QJrQ0VnhWOMQ1ETcZEjcHbQOqf0La
         fvOHVR2NsEKn3C5dztsiSQXB6Q0hcS1MVFstzFK0RK3ndtEsFEj5qnQSUTuD3vsMy2iP
         pmSA==
X-Gm-Message-State: AGRZ1gKAJejgeVgDnv+tPh4okSGUWPXl01XHATBGx3uUU0ibxJfSf5p/
        PqWjQa8tbUfMxdSvv7dTVZY=
X-Google-Smtp-Source: AJdET5fBxpIhYsFWANR5iLsgTYFdOLn2iRkWgdJCEDI566KMBIeRb49tuWZkAl7wKyS/n2AmUL1Gqw==
X-Received: by 2002:a17:906:6c9:: with SMTP id v9-v6mr9567828ejb.203.1542036616224;
        Mon, 12 Nov 2018 07:30:16 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id n12-v6sm2448492ejl.13.2018.11.12.07.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 07:30:15 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:30:14 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] serial: Add Tegra Combined UART driver
Message-ID: <20181112153014.GA29481@ulmo>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
 <20181026111638.10759-8-thierry.reding@gmail.com>
 <20181109170526.GB14151@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20181109170526.GB14151@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2018 at 09:05:26AM -0800, Greg Kroah-Hartman wrote:
> On Fri, Oct 26, 2018 at 01:16:36PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
> > multiplexing multiple "virtual UARTs" into a single hardware serial
> > port. The TCU is the primary serial port on Tegra194 devices.
> >=20
> > Add a TCU driver utilizing the mailbox framework, as the used mailboxes
> > are part of Tegra HSP blocks that are already controlled by the Tegra
> > HSP mailbox driver.
> >=20
> > Based on work by  Mikko Perttunen <mperttunen@nvidia.com>.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks. I just sent out v2 addressing Pekka's comments on the series.
But I'm slightly confused now. Are you expecting anyone else to pick
this up? There are technically no build time dependencies between any
of these patches, so it should be fine to pick them all into the
corresponding subsystem trees.

Perhaps the only thing to note is that there is a runtime dependency
=66rom this patch on patches 1 and 2 in the series. Patch 1 is required to
make blocking a mailbox possible in interrupt context, which we need in
the TCU driver because the TTY and console paths do end up calling the
mbox_send_message() from interrupt context. Patch 2 is only required at
runtime if the two mailboxes are provided by different instances of the
HSP block (which they are for TCU on Tegra194).

Would you prefer for Jassi to pick up the TCU patch along with the
mailbox core and driver changes so that we deal with the runtime
dependencies that way?

Alternatively, if Jassi is okay with the mailbox changes, I can pick up
all of the v2 series of the patches into stable branches for v4.21, deal
with the dependencies there and send out pull requests for everyone to
merge into their subsystem trees.

Thierry

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvpnIIACgkQ3SOs138+
s6G9thAAmhwMCREJAWW3pWq4rGnjyHIlRwal0f3ryO2kKoJUU6pMMjIpyhyL7HDg
UE9ytBcLqT8UtijC79Ur9pT8Zg8iocoLhK2CUlkt+swYWiKgCTYY04U7th/rsiEP
Eqqxw8W6Ev8mmWnbtZxEnANPGye1O+QyWKNr/enMynt4oFKmXhoPopJE9X+jdDrm
BPkTsfB+iDpurl6az6dpbkiJoTfnDH/KslT0O2B8b3glX84NPouZd9d/uX2GSD6C
9u9AXoAtm2I13zVTHrwYXdAbJW+R3fgN52QX5ugaygrM+15dkOgomREfeRTZLQyu
1Sgc6GEMr0Jj+cB7MnJuVrduVZBemGP6w4NGo0A6vAIG4J2rqM1XGfWXAaeN3iv2
8aQfedqyWlmByrPw+CSwxdBQYfKPkxgEt5aCRXPv3qfock+ycHy/jUp+po3Y+0Nu
A5Abh1x1WzUJBIL8tMd6wAh7sm5ndxRBFJjdIWXXuGKHYv1H7URD0RNooE1B+vEK
itDzAx5ZS+JCbqkhsrTxtNqxhgalaprdEtHj2JbB1VY9w/RdoORyz9jQ49b7BENB
flX3750cp1p364hSncwBIsAw6Z3Hk87iLZh5PcHGOHCgowU7izEEMS3gbVSfDgPc
kWRr0GaixLog3OXxriCFU/HurHGBcQNb7YiQbuxNUMum3dRR6oQ=
=SwJi
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
