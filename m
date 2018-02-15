Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2294769-1518724443-2-200505393596109630
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
    t=1518724442; b=YJCvD76qMA93qRpfPvqZjl4Au4msIbx4q1jzZq0sQ3kmAQ8
    nQMbXa6ROO0E+17tZUAvpIFJc/CdOdMdiFgltyaNLZO2vo7ET9ccpIBIwwbPms8m
    snPBQjxvGzM6aDOvCsmncKbImW5VzNTJpgjQgsdZYwqiZayMjKAzlBRxyCK7bLnp
    O8WQVNY8gFbTXukvCFU+7htGkZ3iLc9H988YYLR9ynU8bnpSaqMDi4O9HpqUGSSO
    7WGzS48/GdxFb5ycphY+3CwQuTqDiKj/kas8qIw2pzMsQ/joz/hLpJu9m70rMDGr
    I/xwNk793LIc0en+HYePdCnOLsrivLezZZuOiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518724442; bh=1rIEoKt3bnAMCXJYZ2UPf+zFPn
    9fduANDWUuOuafgx8=; b=cYi7E7/lsr0f911ySMmhPjEZlHtDrgG+iPsx+p+J9E
    A3P5F4+PjwWWj6TJimdx9peh5Q0DhYCYb0LZIxhmXz33qINH4olMczMhpCPkTd3l
    8WoikJnb16T5Plsr1HGg5msZu7SgorbcnxMgfihxfHdUTokurrvxi8tugcIndnJX
    43qGNMgs9nLjtU+c+CuGIKTKIwax2jRTDVAQ4oGxmlzHa/CUhIghh2TGi+hct4nV
    a0FNKI2Oh/0C9hNCkAkk/EcCSWnO33U1GZaeeCqDZW70Uagwk3ubk8jfcjzR3LvK
    ZPzCprjEilV/7KWA/LNdKQlxmQq/fM+D42pAijWuGW9g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HHGmS8pT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HHGmS8pT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161623AbeBOTx7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 14:53:59 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45612 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033208AbeBOTx4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Feb 2018 14:53:56 -0500
X-Google-Smtp-Source: AH8x224es618c/P/fgOoPg31KnM/0kNs9x6v8lZyWGLCJxcywbqAwGXsuIFFY1s9MwopZfSKRpB7cw==
Date: Thu, 15 Feb 2018 11:49:01 -0800
From: Moritz Fischer <mdf@kernel.org>
To: "Wu, Hao" <hao.wu@intel.com>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>,
        "Whisonant, Tim" <tim.whisonant@intel.com>,
        "Luebbers, Enno" <enno.luebbers@intel.com>,
        "Rao, Shiva" <shiva.rao@intel.com>,
        "Rauer, Christopher" <christopher.rauer@intel.com>
Subject: Re: [PATCH v4 07/24] fpga: dfl: add feature device infrastructure
Message-ID: <20180215194901.GA4382@tyrael.ni.corp.natinst.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-8-git-send-email-hao.wu@intel.com>
 <20180214210319.GC25618@tyrael.ni.corp.natinst.com>
 <CANk1AXRksJum6s5yB5727136DBLHs4UPW7xaLn_dT5qMEfqm9A@mail.gmail.com>
 <BE8371DA886269458E0220A16DC1F8277E154EC0@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <BE8371DA886269458E0220A16DC1F8277E154EC0@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2018 at 10:05:20AM +0000, Wu, Hao wrote:
> > On Wed, Feb 14, 2018 at 3:03 PM, Moritz Fischer <mdf@kernel.org> wrote:
> >=20
> > Hi Moritz,
> >=20
> > > HI Hao,
> > >
>=20
> Hi Alan and Moritz
>=20
> Thanks a lot for the code review and comments.
>=20
> > > On Tue, Feb 13, 2018 at 05:24:36PM +0800, Wu Hao wrote:
> > >> From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > >>
> > >> This patch abstracts the common operations of the sub features, and =
defines
> > >> the feature_ops data structure, including init, uinit and ioctl func=
tion
> > >> pointers. And this patch adds some common helper functions for FME a=
nd
> > AFU
> > >> drivers, e.g feature_dev_use_begin/end which are used to ensure excl=
usive
> > >> usage of the feature device file.
> > >>
> > >> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > >> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > >> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > >> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > >> Signed-off-by: Kang Luwei <luwei.kang@intel.com>
> > >> Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
> > >> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > >> Signed-off-by: Wu Hao <hao.wu@intel.com>
> > >> ---
> > >> v2: rebased
> > >> v3: use const for feature_ops.
> > >>     replace pci related function.
> > >> v4: rebase and add more comments in code.
> > >> ---
> > >>  drivers/fpga/dfl.c | 59 +++++++++++++++++++++++++++++++++++++
> > >>  drivers/fpga/dfl.h | 85
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > >>  2 files changed, 143 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > >> index 38dc819..c0aad87 100644
> > >> --- a/drivers/fpga/dfl.c
> > >> +++ b/drivers/fpga/dfl.c
> > >> @@ -74,6 +74,65 @@ static enum fpga_id_type feature_dev_id_type(stru=
ct
> > platform_device *pdev)
> > >>       return FPGA_ID_MAX;
> > >>  }
> > >>
> > >> +void fpga_dev_feature_uinit(struct platform_device *pdev)
> > >> +{
> > >> +     struct feature *feature;
> > >> +     struct feature_platform_data *pdata =3D dev_get_platdata(&pdev=
->dev);
> > > See comment below w.r.t ordering declarations. Not a must for sure.
> > >> +
> > >> +     fpga_dev_for_each_feature(pdata, feature)
> > >> +             if (feature->ops) {
> > >> +                     feature->ops->uinit(pdev, feature);
> > >> +                     feature->ops =3D NULL;
> > >> +             }
> > >> +}
> > >> +EXPORT_SYMBOL_GPL(fpga_dev_feature_uinit);
> > >> +
> > >> +static int
> > >> +feature_instance_init(struct platform_device *pdev,
> > >> +                   struct feature_platform_data *pdata,
> > >> +                   struct feature *feature, struct feature_driver *=
drv)
> > >> +{
> > >> +     int ret;
> > >> +
> > >> +     WARN_ON(!feature->ioaddr);
> > >
> > > Not sure I understand correctly, is the !feature->ioaddr a use-case t=
hat
> > > happens? If not just return early.
>=20
> Actually this should never happen (init a feature without mapped mmio
> resource address). If this warning is seen, that means there should be
> critical issues somewhere in driver enumeration code. But sure, I can just
> use if () return instead. : )
>=20
> > >> +
> > >> +     ret =3D drv->ops->init(pdev, feature);
> > >> +     if (ret)
> > >> +             return ret;
> > >> +
> > >> +     feature->ops =3D drv->ops;
> > >> +
> > >> +     return ret;
> > >> +}
> > >> +
> > >> +int fpga_dev_feature_init(struct platform_device *pdev,
> > >> +                       struct feature_driver *feature_drvs)
> > >> +{
> > >> +     struct feature *feature;
> > >> +     struct feature_driver *drv =3D feature_drvs;
> > >> +     struct feature_platform_data *pdata =3D dev_get_platdata(&pdev=
->dev);
> > >> +     int ret;
> > > We don't have clear guidelines here, but some subsystems want reverse
> > > X-Mas tree declarations.
> >=20
> > Sounds good!  I agree.
>=20
> Do you mean we should reverse fpga_xxx definitions? If yes, then I can up=
date
> the code to use fpga_dfl_xxx or dfl_xxx instead. : )

More a stylistic thing, in the sense that you'd have the longest line
first:

+     struct feature_platform_data *pdata =3D dev_get_platdata(&pdev->dev);
+     struct feature_driver *drv =3D feature_drvs;
+     struct feature *feature;
+     int ret;

Instead of:

+     struct feature *feature;
+     struct feature_driver *drv =3D feature_drvs;
+     struct feature_platform_data *pdata =3D dev_get_platdata(&pdev->dev);
+     int ret;

as I said not a big deal, some subsystems want you to do this, I don't
think we made that a strict rule so far, but it makes it visually more
pleasing ;-)

Moritz

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAlqF5CkACgkQUVwKRFcJ
cNhqqwf+Ibu/z4f0N3WBO4bAxe34nIx6p14BO4VSmsMKVOXdtzqbBc+wHnXqOcVK
JZwXBvn4+7dVHbCLHivj0pnYk78gCptUUFrZRvDNoDsF8wwx1jsKjOjrh100T4Dn
Tq8yG4LIi8A/85lt8CEcUDkXeu5M+7IMDAba2I/9fH/px0tUSThIXl6B8ERX+ev/
xC4WONYsmshDoq0x3l48Lgxh7KSZf92YsAeC4kHCitRa/e4LmV9dcKLQxWg9sgjl
I4z+W4V+56pOku7zqLb8LdU3lbHNSIc+pesw/lBInFWw+eyhCU7puTq9JEpmB8rK
0xBsFSh0B4wkWKTPIYnuUw2buQKvsA==
=MGvV
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
