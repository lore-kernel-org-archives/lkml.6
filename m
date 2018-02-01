Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3914241-1517497892-2-2291883482290323051
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517497891; b=SF8ouIYflWT1jZ2pb8hZSBulNavDwnc+MQ9ckjCcVnzELnp
    dYytlbPT7O9/k+vmLJpZ/Th5yoRVbOH8937sgZwma15fKM4+nBF6pAofDKEPVZrd
    fAindiD3uY8NCJcxknHZLz/MeLe34WtR/nqx+Ws67EgdDErDHCIrV8WgSFRFo4yL
    08PjbfVfsqc7cGSHe4nWSDmmfPhT8aWhiozU4Y28fWLDlUotzKJ40fusyzuBTpNR
    7hB06FH4YnPf6XwHwhIMw/u94GLWGGgG8EFd6VG66PTM8YP+IzwuLKvkaBPKHtMt
    ZnxgrNxdbWAv7WI/6A3UKe4rHvGqLb1c+IuDZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517497891; bh=/udgXZZZ1P5K6WfIf4pxIJjiMX
    athbvkYu5KYpU9Lws=; b=At1/TkTQ8pmSPzAB3OwYL4aIl48yTW5D2FaJwuQ/hj
    9DUaGvQIMYRzhv3VRP5pLRjyFdMXyMupRx/o4VVQ0lIM/qALbeepyZYAm+f12TCl
    HmlWdP9wL22XRHmZWY0AQ2oUrRyhQQ//zlgRTt884wmq2OgS8xQltjBAO959YyMH
    nKS2mxvCj/R+2bBstTlX129ExZ8rZkpvci2/JhG0sCsjDXLqvSY+5ei50N0uXgm4
    Gk6//CkQYN9O86DMr5eQKxRUdnqKpGzyerWSkBT8yv1EgKDyUgxEbMhQfAiu7TbF
    u01/wB0tlP1n9IQfxfLxKEydsIiLWc88lSK6x+5LbhDQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CZC+v6Ox;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CZC+v6Ox;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeBAPLK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 10:11:10 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53513 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbeBAPLJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Feb 2018 10:11:09 -0500
X-Google-Smtp-Source: AH8x225i7AnWwZ05CTNKoGgoVJDZR4snVIVcroNHq+nNCXpRyC1IwkUVcBYhnfgOI/N59B4Iyq873Q==
Date: Thu, 1 Feb 2018 16:11:08 +0100
From: Moritz Fischer <mdf@kernel.org>
To: Wu Hao <hao.wu@intel.com>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Subject: Re: [PATCH v3 15/21] fpga: dfl: add fpga bridge platform driver for
 FME
Message-ID: <20180201151108.dyxzcpjagfmxgjgb@insfl13.etec.uni-karlsruhe.de>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-16-git-send-email-hao.wu@intel.com>
 <CANk1AXS-ioW2svMS3QwrQCF5TiHp_nwaongC=d2Z2MfT8BEMMw@mail.gmail.com>
 <20180201051543.GC10273@hao-dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aq7qqyqrth4x3dwg"
Content-Disposition: inline
In-Reply-To: <20180201051543.GC10273@hao-dev>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--aq7qqyqrth4x3dwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hao,

On Thu, Feb 01, 2018 at 01:15:43PM +0800, Wu Hao wrote:
> On Wed, Jan 31, 2018 at 09:16:58AM -0600, Alan Tull wrote:
> > On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> >=20
> > Hi Hao,
> >=20
> > One fix below.  Besides that, please add my ack.
> >=20
> > > This patch adds fpga bridge platform driver for FPGA Management Engin=
e.
> > > It implements the enable_set call back for fpga bridge.
> > >
> > > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> >=20
> > Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> >=20
> > > diff --git a/drivers/fpga/fpga-dfl-fme-br.c b/drivers/fpga/fpga-dfl-f=
me-br.c
> > > new file mode 100644
> > > index 0000000..db2603b
> > > --- /dev/null
> > > +++ b/drivers/fpga/fpga-dfl-fme-br.c
> > > @@ -0,0 +1,87 @@
> > > +/*
> > > + * FPGA Bridge Driver for FPGA Management Engine (FME)
> > > + *
> > > + * Copyright (C) 2017 Intel Corporation, Inc.
> > > + *
> > > + * Authors:
> > > + *   Wu Hao <hao.wu@intel.com>
> > > + *   Joseph Grecco <joe.grecco@intel.com>
> > > + *   Enno Luebbers <enno.luebbers@intel.com>
> > > + *   Tim Whisonant <tim.whisonant@intel.com>
> > > + *   Ananda Ravuri <ananda.ravuri@intel.com>
> > > + *   Henry Mitchel <henry.mitchel@intel.com>
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL version 2.
> >=20
> > If we're using the SPDX, then please get rid of the above line.
> >=20
> > > + * SPDX-License-Identifier: GPL-2.0
> > > + */
> >=20
> > The SPDX line should be the first line of the file with a // (for .c
> > files), please see:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/Documentation/process/license-rules.rst
> >=20
> > Same thing for other files.
>=20
> Thanks for the review.
>=20
> Sure, will fix this for all driver files in the next version.
>=20
> Thanks
> Hao
>=20
> >=20
> > Alan

Looks good, feel free to add my Acked-by: with fixes Alan requested,

Moritz

--aq7qqyqrth4x3dwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlpzLgcACgkQUVwKRFcJ
cNjcmQf+OkmCQynZ0YYYDWjRGrfCVrI6Sa7ULCpgQnVNZoGaOfDRQQLZ8vguOgF0
UhX9SiH7bcykBPxJV8hefpdw29/iVP3+xCVO2TFlx/7N18TYmJZIjbWmBok20kLI
WJwU875j0gcJPkAuhPjWSlz50lxrsuH+o8Wp2l42EWaWbqHCIVvZks7zbb4ofZc9
TlHPvvgS7WLLAUrT9oVI2Uz17MOe+iGl4Xr9jDnS+xJ+Pbsn3Ob+ULDpn7lc6BLS
r4HuIzSWTAE2swMMUKt7/U1JhbAUKrwYrg8SNSZP/I75PBw1xMuO43Bxav/7+WJc
vVM4BWVM1TrB/2sfXi/9D11D+9r4Jw==
=ysIw
-----END PGP SIGNATURE-----

--aq7qqyqrth4x3dwg--
