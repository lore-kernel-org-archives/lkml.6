Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890D7ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB29214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB29214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeIQOwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:52:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:59659 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725757AbeIQOwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:52:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 02:25:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,384,1531810800"; 
   d="asc'?scan'208";a="233536977"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.13.143])
  by orsmga004.jf.intel.com with ESMTP; 17 Sep 2018 02:25:56 -0700
Date:   Mon, 17 Sep 2018 17:15:50 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] vfio: add edid api for display (vgpu) devices.
Message-ID: <20180917091550.GK20737@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20180913054745.6353-1-kraxel@redhat.com>
 <20180913054745.6353-2-kraxel@redhat.com>
 <20180913115139.02775316@t450s.home>
 <20180914122552.3xmepqo7azzmx7ky@sirius.home.kraxel.org>
 <20180917065154.GI20737@zhen-hp.sh.intel.com>
 <20180917085033.ttcs3cpznnf3wngd@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="O8nUzFXSEQuWwhTG"
Content-Disposition: inline
In-Reply-To: <20180917085033.ttcs3cpznnf3wngd@sirius.home.kraxel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O8nUzFXSEQuWwhTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018.09.17 10:50:33 +0200, Gerd Hoffmann wrote:
> > > +#define VFIO_DEVICE_INFO_CAP_EDID	1
> > > +
> > > +struct vfio_device_info_edid_cap {
> > > +	struct vfio_info_cap_header header;
> > > +	__u32   max_x;     /* Max display height (zero =3D=3D no limit) */
> > > +	__u32   max_y;     /* Max display height (zero =3D=3D no limit) */
> > > +};
> >=20
> > As current virtual display for Intel vGPU is still emulating against re=
al HW
> > pipeline with same limitations, asked display developers that whether o=
r not
> > specific mode can work might still depend on current or future HW behav=
ior.
> > So could we add some hints on what kind of edid mode vfio device can op=
erate?
> > Some may support arbitrary modes, but some may only support standard mo=
des.
>=20
> What kind of restrictions do we have here?  Really to a fixed list of
> standard modes?

Restriction is still with HW differences, e.g for skl/kbl with ddi wrpll
within min/max clock range which may generate any required frequency, but
I've been told for bxt there're some gaps in clock range that could be
generated.

>=20
> Some testing (kaby lake) indicates y axis has no restrictions and x axis
> gets rounded up to the next multiple of 8 pixels (32 bytes), maybe to
> align scanlines with cachelines?

That should be plane stride requirement I think.

>=20
> Oh, and btw:  Seems the resolution restriction (to 1024x768 for the
> smallest vgpu type) seems to not be enforced.  Intentional?
>=20

hmm, what do you mean here? Not enforce to have only one mode for vgpu type?
Or can't change to other mode?

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--O8nUzFXSEQuWwhTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCW59wxgAKCRCxBBozTXgY
J7O8AJsFx1JPF0xgMGdYaJXONvbIWvOM3ACglzhQ+F/jyxdCf2qr4oqUg3j+jyc=
=0BaV
-----END PGP SIGNATURE-----

--O8nUzFXSEQuWwhTG--
