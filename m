Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3914241-1517498050-5-5897961709980629632
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
    t=1517498050; b=cNn478hpnRGZrQb6D55k74l8vdBOnujPZtCECQust4C5I8u
    UYuYTmant9DLUrSflupJKBL0VFuzqIxGmYT12OC4k8Rj39OqNrkWTB/SpdUDyyxj
    pAISg17gdup4rKlu5XePkPk9XL2smH7EOYRoRUd5XYaHhmR2AAFjSr73a0MABfcN
    P8z/xyM8wuC6WRQoopeyf8VY35YOd1EGiVRzZSRRJLbU440eRs2tqkl2HFjFvO2U
    RICNDb/JgvB1pwYdHDa/mtF5jHFg0840Tvh28lY9TEoSITiDLCm89PE4hROxBxph
    R2FKD2xmMHzZ/vNRIV2vRq/75QfaeC18HnyAmzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517498050; bh=3z/plw3nv89WXcYjYUw0OLK2Cn
    9guNqYlrMr78D88vg=; b=vdMsuubpQ2woWj0BrqWS0n7SHOvwyrXRd1oDMcfalj
    VAls77YCMX6Pr23n/TLzUP+zRZLRQ6GiOBMMVPa9DOSScyzIIS+GfcmTDWBRkpbe
    91uFcGMOn8eYlYGjlTc3LwAUOqClgTl9W2zXQ9AQnLm/JhEmZCuUH88/KSmzcuiU
    tF59ts8sk0ok0YDHwjoI0Yd323ooXGw/BQLSOM9EIdHDOSAXTr7WVJ1P+Yz6EvQW
    jjw4jgfMDQoywmSRWgGPe22/TqBWb2u+wLXL5sTrEI7QRDhgZKcTuEogc5rN93wo
    qn2GcoBF4HxI7OTs1peVec4aordWxpb530HN+vJnw0Fw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W0HbP+9w;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W0HbP+9w;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeBAPNO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 10:13:14 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33703 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbeBAPNL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Feb 2018 10:13:11 -0500
X-Google-Smtp-Source: AH8x226SGEgnSdPLLzl/PhP04STK6m0djSdlAEuPSeB/MvtZm699uKputuQKweCqN9GuBvBobg4n5A==
Date: Thu, 1 Feb 2018 16:13:09 +0100
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
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v3 19/21] fpga: dfl: afu: add
 FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls support
Message-ID: <20180201151309.q3jjx42y6ldcrhc6@insfl13.etec.uni-karlsruhe.de>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-20-git-send-email-hao.wu@intel.com>
 <CANk1AXSfUfVbtbuREwG5Ck8TNZrqBg1fO5AuDDdFk-x=UjRTiw@mail.gmail.com>
 <20180201051625.GD10273@hao-dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrqoflovbpuksoed"
Content-Disposition: inline
In-Reply-To: <20180201051625.GD10273@hao-dev>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--lrqoflovbpuksoed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2018 at 01:16:25PM +0800, Wu Hao wrote:
> On Wed, Jan 31, 2018 at 08:52:36AM -0600, Alan Tull wrote:
> > On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> >=20
> > Hi Hao,
> >=20
> > I'm adding my "Acked-by' below.  When you post v4, please add it so
> > that we can keep track of what got acked.
>=20
> Sure, thanks a lot for the code review. :)
>=20
> Hao
>=20
> >=20
> > Thanks,
> > Alan
> >=20
> > > FPGA_GET_API_VERSION and FPGA_CHECK_EXTENSION ioctls are common ones =
which
> > > need to be supported by all feature devices drivers including FME and=
 AFU.
> > > This patch implements above 2 ioctls in FPGA Accelerated Function Unit
> > > (AFU) driver.
> > >
> > > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

Looks good,

Moritz

--lrqoflovbpuksoed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlpzLoIACgkQUVwKRFcJ
cNiaKQgAxTIN45BIdHFBxrE4KKy+VhjXDUAAX/MfKSUieGYwJKRDfQu4xrc1VEKj
J64u1Ajahp1dleg5hZGdPZgfvjwmW4HPWVL+qPFBp3COqusmBdM90hPhpsMCaUEA
Kd4+QsGINKFreP1S3FprehjBt3k0/Yhut+B8uXxiLvAsR4My0/A2ih7gA4ZkUnPI
68rRWUC4EItMagUVxGC9u6JzWk1d18Fn2VKs7RjeRnp15ieN8OaTfZhjt2m6K5z4
Tn7Eb+j9wb/WOIo3pgUDqBLIS28/6H9mTl2wQdPNPgRiQXB0otrW8rmhcw2hzky4
XA/h7gpr7ODi8uWfcLdlTZ0LD2H/UA==
=fXxH
-----END PGP SIGNATURE-----

--lrqoflovbpuksoed--
