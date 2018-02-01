Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3914241-1517498088-2-7351954891519504501
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
    t=1517498088; b=MjronN/FYrGUdTR3XWnO4yfkDQgttWyrr/cJ74tZ+afPBBa
    MvXKu1/OY9yYfOJyXoGEYsAqpa0ian4CleoquO+j4wRRQpLl8QEkRW8Z3kPG4K+c
    +2dfiuDTPuuiL0HAyKi7IeUd03kQde6ghV4rccnFu4sg5VBFCej7HAVwq9KlmkK8
    0GYFzpmzSMADOgmyPMXPiPHym1m8oGrsYcHKUNFG0Jf4b6qmAHr41WoAvfNu+QaW
    Uij4Doo1KVlNe3oyw3pnCTxn4L7c8rAyDQWzSqPoWc/ChU7p+E1BSklPjt6PB/N2
    QoxIfUkcdDQqAcNzuQRA3hV+wHwuIwkBdBhzMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517498088; bh=5/kq5V/esfaCZUZvO8E7jTsfmJ
    RbcLGYmfUZG3hmn4w=; b=vXWOJHkejGgR/Akxeh6R9I1DsJpCbcLmc47ILOj7JW
    j+K/3dAsf1aPJG/WXWoG29+UymeDXs+PJvzLogWpqIUcnrR+biM+FY2XMnV/Jyw+
    t2uIy8bkadjcNX0LN+Pnf7mEOx7bvxj664Ec63kURzr2AnPify37LsLdZpEGBrWF
    FN5yHHSN0HUxnTCi5tq4D2QAvJGAsxN4lOEy1IKXdM6xd9WRrMkZeqTNWylRKkcV
    ESPNYatAnu1ybtjloPvzaBZwEXzHWbzEFVUN6Ba0JnUf++1xP/Qf+JkFGF11C8RC
    i0Zd+XPnruAymAGVyA7jWmoYuOlRos8/tf6S08kG6asQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HBWRe0ik;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HBWRe0ik;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeBAPNv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 10:13:51 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33256 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbeBAPNu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Feb 2018 10:13:50 -0500
X-Google-Smtp-Source: AH8x2271fIChHcZDBtNHpyEyPenOv+/6TH8C1jmsp8Y0tW7C4+FpCPo96fgEmujP8cnCcyamEWjhCw==
Date: Thu, 1 Feb 2018 16:13:50 +0100
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
Subject: Re: [PATCH v3 16/21] fpga: dfl: add fpga region platform driver for
 FME
Message-ID: <20180201151350.ijbryvpmpuiv2rxu@insfl13.etec.uni-karlsruhe.de>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-17-git-send-email-hao.wu@intel.com>
 <CANk1AXTBprjzr71xa=YD5jR77822xugVEQMboxhzAJFY8YFMxw@mail.gmail.com>
 <20180201052345.GA10393@hao-dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oqm7cbdnri4usvmy"
Content-Disposition: inline
In-Reply-To: <20180201052345.GA10393@hao-dev>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--oqm7cbdnri4usvmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2018 at 01:23:45PM +0800, Wu Hao wrote:
> On Wed, Jan 31, 2018 at 02:46:28PM -0600, Alan Tull wrote:
> > On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> >=20
> > Hi Hao,
> >=20
> > Just fix the SPDX, otherwise it looks good.
>=20
> Sure, will fix it. Thanks for the review. :)
>=20
> Thanks
> Hao
>=20
> >=20
> > > This patch adds fpga region platform driver for FPGA Management Engin=
e.
> > > It register an fpga region with given fpga manager / bridge device.
> > >
> > > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> >=20
> >=20
> > > diff --git a/drivers/fpga/fpga-dfl-fme-region.c b/drivers/fpga/fpga-d=
fl-fme-region.c
> > > new file mode 100644
> > > index 0000000..0b988ab
> > > --- /dev/null
> > > +++ b/drivers/fpga/fpga-dfl-fme-region.c
> > > @@ -0,0 +1,92 @@
> > > +/*
> > > + * FPGA Region Driver for FPGA Management Engine (FME)
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
> > > + * SPDX-License-Identifier: GPL-2.0
> > > + */
> > > +
> > > +#include <linux/module.h>
> >=20
> > Thanks,
> > Alan

Thanks,
Moritz

--oqm7cbdnri4usvmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlpzLqoACgkQUVwKRFcJ
cNibgQf/bkWTtCXm9nLqQmYlQdXq1ri3DQNzr/aZsdyWEbHTUipMENsf6kW0/YgI
huPBMqU8uWUANBZotm7/qtoWnine6G3CTNogjdiLExvf8TJhtFCu5cfyKAmO9xu0
6t4TJYfPp0ZhtpDSJPml4Y1JJQb8ZBIjyS7x4A0NoR1aUr15Hzt1ry1+URM4anT+
Ij4pGpcZValSvyZtKE0gyUWg+p2E6SZATuMhxJWMENYhB2pfm7bOmSK+TgVixiXX
o7kqqSBgj//IlSG0hB+qM+DXuqzrQXODg+GWX2/bxCj5vVfgkoICti9+R2Vs+Wbj
u26xPUlT/u9CMumzHSJorcDz3L2s6Q==
=yXQy
-----END PGP SIGNATURE-----

--oqm7cbdnri4usvmy--
