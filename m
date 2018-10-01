Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744C5C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB262083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB262083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbeJAQEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:04:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50696 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbeJAQEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:04:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 451ED20828; Mon,  1 Oct 2018 11:27:09 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id B13D8206FF;
        Mon,  1 Oct 2018 11:27:08 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:27:08 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Manasi Navare <manasi.d.navare@intel.com>
Cc:     Damian Kos <dkos@cadence.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, jartur@cadence.com,
        jbergsagel@ti.com, ltyrala@cadence.com, stelford@cadence.com,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        pgaj@cadence.com, piotrs@cadence.com
Subject: Re: [PATCH v4 2/5] drm/dp: fix link probing for devices supporting
 DP 1.4+
Message-ID: <20181001092708.ow4rxgzp4haax76k@qschulz>
References: <1537455288-20223-1-git-send-email-dkos@cadence.com>
 <1537455288-20223-3-git-send-email-dkos@cadence.com>
 <20180921075929.GA28323@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ybx4xhgzfithc2la"
Content-Disposition: inline
In-Reply-To: <20180921075929.GA28323@intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ybx4xhgzfithc2la
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manasi,

On Fri, Sep 21, 2018 at 12:59:30AM -0700, Manasi Navare wrote:
> Thanks for the patch. Verified with the DP 1.4 spec and looks good to me.
> Also look at the related patch that makes use of the correct extended cap=
abilities:
>=20
> https://patchwork.freedesktop.org/patch/249400/
>=20

If I'm not mistaken, you could get rid of the patch in the Intel driver
when we have this one merged. Is there any reason not to, have I missed
something?

Thanks,
Quentin

> Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>
>=20
> Manasi
>=20
>=20
> On Thu, Sep 20, 2018 at 03:54:37PM +0100, Damian Kos wrote:
> > From: Quentin Schulz <quentin.schulz@free-electrons.com>
> >=20
> > DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
> > DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
> > DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
> > DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
> > DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
> > "true capabilities" of DPRX device.
> >=20
> > Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
> > might falsely return lower capabilities to "avoid interoperability
> > issues with some of the existing DP Source devices that malfunction
> > when they discover the higher capabilities within those three
> > registers.".
> >=20
> > Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
> > and read 0 so it's safe to check against it even if DP revision is
> > <1.4
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > Signed-off-by: Damian Kos <dkos@cadence.com>
> > ---
> >  drivers/gpu/drm/drm_dp_helper.c | 30 +++++++++++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_h=
elper.c
> > index 8c6b9fd89f8a..735ebde5c2f0 100644
> > --- a/drivers/gpu/drm/drm_dp_helper.c
> > +++ b/drivers/gpu/drm/drm_dp_helper.c
> > @@ -370,10 +370,38 @@ int drm_dp_link_probe(struct drm_dp_aux *aux, str=
uct drm_dp_link *link)
> >  {
> >  	u8 values[3];
> >  	int err;
> > +	unsigned int addr;
> > =20
> >  	memset(link, 0, sizeof(*link));
> > =20
> > -	err =3D drm_dp_dpcd_read(aux, DP_DPCD_REV, values, sizeof(values));
> > +	/*
> > +	 * DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
> > +	 * DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
> > +	 * DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
> > +	 * DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
> > +	 * DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
> > +	 * "true capabilities" of DPRX device.
> > +	 *
> > +	 * Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESE=
NT
> > +	 * might falsely return lower capabilities to "avoid interoperability
> > +	 * issues with some of the existing DP Source devices that malfunction
> > +	 * when they discover the higher capabilities within those three
> > +	 * registers.".
> > +	 *
> > +	 * Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was rese=
rved
> > +	 * and read 0 so it's safe to check against it even if DP revision is
> > +	 * <1.4
> > +	 */
> > +	err =3D drm_dp_dpcd_readb(aux, DP_TRAINING_AUX_RD_INTERVAL, values);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	if (values[0] & DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT)
> > +		addr =3D DP_DP13_DPCD_REV;
> > +	else
> > +		addr =3D DP_DPCD_REV;
> > +
> > +	err =3D drm_dp_dpcd_read(aux, addr, values, sizeof(values));
> >  	if (err < 0)
> >  		return err;
> > =20
> > --=20
> > 2.17.1
> >=20
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

--ybx4xhgzfithc2la
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlux6GwACgkQhLiadT7g
8aN2QxAAqgX9IhkXulMuqmg4XqlU+BLiYsRW3taPd50bz/sjTTPLHTLVllTt4y9Q
IkV9QpcSpBdsmRA8iqYXwUQCPs+xXY4TNi2KrKhVWvBwfTnwneYt3v5hijbDil2t
73uk7XJbEKaOLxuHAdvFstg5irXtCqKQzwjmq4sL9hQe4GVq2eFwf7pLJSg/aydy
Mmu/FNnPJL/HL/2Hwg9x6lpe/TkF0Ub3o61lOzSl4Pk7zklrWw53D0d7lr2DcomN
kjR/HFa6pKRVqCR0tKBmwaezXkDFdsnG8mZPbG+nS7Rrr9I1XvyUsYAJiDtLw9K1
3/dRC+Kf6qb1HEOztGBoDDch0YOGeN92vTRFQfoaq2loO+Em0mYNjHNsxQupExVx
rEIQ/GhCtkFO9ZgIIwh1tlnaB9IJ8uRKbJ090/xiZ+ROKu1VhIM83M8VfuAUGpcW
K771bMpa5Je6UfBJDo7rQ352RY8hlL7pAGg+zPQPvf9keZERuMov8epGVhs/CsP+
yq3oqfilNDXmzrvq6+0FJ61EWqoMJCJKIWLtXavaCEyiN0alO6YbsgSuf+U0R6lJ
woTTJp3bCFLpuwQasEnYHAmvJVP1VJlLPh/Gb7Ubw7nyiqHpZCzBML7COG6yAdTO
fscS2eyAyBYNGguSy18Nsxv+26uamEvic3Em6VPxLytbHdGAzck=
=tY+G
-----END PGP SIGNATURE-----

--ybx4xhgzfithc2la--
