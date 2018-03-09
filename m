Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-9267-1520584608-2-14594178316957011635
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520584607; b=nnMmlHWcqOjjqo9rw7RlrbOl6JRXKFKtyfzOstfYEPZ70bl
    WCErzg3e3JttKOLKcfJE2BDqbOXwTBZnnW+MchcRuDwEN+tSV8BYbpnMTk31VmjA
    dyZLuxcEIb7uBVx4xgjMy+N6ujtDOWDlgpjq64Mo4wJgHxtszpc7R1tvfrrnfYt7
    +bj2XbD/iAbyrDfXGoBP/Ws1FYyHP+7lHsemSYdFaF0j7THvGN3UNCP+PKhrfmuI
    FmNddJ/a7A/XecqaI3WcO4ilsKtcuXhJBK3zu/R5pLFyLoqUFK5okvPASTWlls37
    JOY1oD0alPvM7PuVoAHrm/NqVDlyvMk0GnZy5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520584607; bh=sELiIGvzGywJ2iTVrwYi4L6x7C
    3f8VFPez1LbxDH6V8=; b=blNf1/yXyIM3/QZo56PL1wugY9uuT0/OKbPsUcVN/5
    0g1TpSQX4yZtnewoJ7LvjpcwNYCckRQaa62y4spUzYf4CS7XcNKTHj6k4s6E48yJ
    6Ne1aKsUH83nRVmlxL4JH4KP9paKV5QEjsSwh5sSXWjzTjJXNSYK7r1N8jrZIFtJ
    h0jSVJZbdZJRWZz0DQs5EHGz0/P0ATNoiO3xfMsjkPpiFrgiGMSzEKi6P5r/4bzP
    2ARI6mFvRcQSca3voQhLgQMnsBxC9aHBeB+xR+KVani5nCqwE0vSG4BGadXXQ/wy
    +sg6WWp+ZnQFYlRQCF5CBCF/AYR3lTGETeU49osjeesw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HKG9rxDY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sZKy/ARH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HKG9rxDY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sZKy/ARH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeCIIgg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 03:36:36 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37596 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeCIIgd (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 9 Mar 2018 03:36:33 -0500
X-Google-Smtp-Source: AG47ELsaSwoBClJhOOj3WJXLM7QTKuMK7x2ppz0gRZbLgCXi3O9fwMqqiV9/dsgVRxUSDl40dU6PZg==
Date: Fri, 9 Mar 2018 09:36:29 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] usb: xhci: tegra: Add runtime PM support
Message-ID: <20180309083629.GA13877@ulmo>
References: <1518626085-29102-1-git-send-email-jonathanh@nvidia.com>
 <1518626085-29102-2-git-send-email-jonathanh@nvidia.com>
 <54bd00b7-2835-a253-0399-370e8c8203b8@linux.intel.com>
 <f1a1c300-a558-f31a-bcfa-c3eda697b0fd@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <f1a1c300-a558-f31a-bcfa-c3eda697b0fd@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 09:31:07PM +0000, Jon Hunter wrote:
>=20
> On 01/03/18 14:18, Mathias Nyman wrote:
> > On 14.02.2018 18:34, Jon Hunter wrote:
> >> Add runtime PM support to the Tegra XHCI driver and move the function
> >> calls to enable/disable the clocks, regulators and PHY into the runtime
> >> PM callbacks.
> >>
> >> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >> ---
> >> =C2=A0 drivers/usb/host/xhci-tegra.c | 80
> >> ++++++++++++++++++++++++++++++-------------
> >> =C2=A0 1 file changed, 56 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/drivers/usb/host/xhci-tegra.c
> >> b/drivers/usb/host/xhci-tegra.c
> >> index 02b0b24faa58..42aa67858b53 100644
> >> --- a/drivers/usb/host/xhci-tegra.c
> >> +++ b/drivers/usb/host/xhci-tegra.c
> >> @@ -18,6 +18,7 @@
> >> =C2=A0 #include <linux/phy/tegra/xusb.h>
> >> =C2=A0 #include <linux/platform_device.h>
> >> =C2=A0 #include <linux/pm.h>
> >> +#include <linux/pm_runtime.h>
> >> =C2=A0 #include <linux/regulator/consumer.h>
> >> =C2=A0 #include <linux/reset.h>
> >> =C2=A0 #include <linux/slab.h>
> >> @@ -1067,22 +1068,12 @@ static int tegra_xusb_probe(struct
> >> platform_device *pdev)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 platform_set_drvdata(pdev, tegra);
> >> =C2=A0 -=C2=A0=C2=A0=C2=A0 err =3D tegra_xusb_clk_enable(tegra);
> >> -=C2=A0=C2=A0=C2=A0 if (err) {
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&pdev->dev, "faile=
d to enable clocks: %d\n", err);
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto put_usb2;
> >> -=C2=A0=C2=A0=C2=A0 }
> >> -
> >> -=C2=A0=C2=A0=C2=A0 err =3D regulator_bulk_enable(tegra->soc->num_supp=
lies,
> >> tegra->supplies);
> >> -=C2=A0=C2=A0=C2=A0 if (err) {
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&pdev->dev, "faile=
d to enable regulators: %d\n", err);
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto disable_clk;
> >> -=C2=A0=C2=A0=C2=A0 }
> >> +=C2=A0=C2=A0=C2=A0 pm_runtime_enable(&pdev->dev);
> >> =C2=A0 -=C2=A0=C2=A0=C2=A0 err =3D tegra_xusb_phy_enable(tegra);
> >> +=C2=A0=C2=A0=C2=A0 err =3D pm_runtime_get_sync(&pdev->dev);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err < 0) {
> >=20
> > Does this mean that if runtime PM is disabled then clocks and regulator
> > will never be enabled
> > for Tegra xhci?
> >=20
> > How about keeping the clock and regualtor enabling in probe, and instead
> > add something like:
> >=20
> > pm_runtime_set_active(&pdev->dev);
> > pm_runtime_enable(&pdev->dev);
> > pm_runtime_get_noresume(&pdev->dev);
>=20
> For 64-bit Tegra there is a dependency on CONFIG_PM, but for 32-bit
> AFAIK there is not and so yes we should handle the case when PM_RUNTIME
> is disabled.
>=20
> Typically we do something like ...
>=20
>     pm_runtime_enable(&pdev->dev);
>     if (!pm_runtime_enabled(&pdev->dev))
> 	ret =3D tegra_xusb_runtime_resume(&pdev->dev);
>     else
>         ret =3D pm_runtime_get_sync(&pdev->dev);
>=20
> That way we can keep the regulator and clock stuff in the handler. I
> will update this series.

Is there any good reason why we don't depend on PM for 32-bit as well?
I'm not aware of any differences in drivers that are 32-bit specific for
Tegra, and I'm not even sure the !PM case gets any testing at all. And
even if, do we really still want to support that?

I don't see any advantage these days for having it disabled.

Thierry

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqiR4sACgkQ3SOs138+
s6GNiA//X3I2OQDwVf2dkPjQ29rUYps6NVTfwWqSz8oNmK9UnoEnQ47vRbTPP7QW
szuryupTCPIpXzZFXL2A4zxO0BFpKw/nENNYFepmOYj0s7+agpawbPor4x0Rtlnn
etCLwjpZk5iJSHbMVH6Cb9w2tAex8BY1fyyYVz+TATDowsEVU+agIVqRgfYTAUZq
jWw46thN5oiLW+wODbR44C+RNVd5+gICb486Z9bsxU+ZkzdpfWgJ3s4aHJEP2RxN
A42FkxBbZ1klyvqo8KBcfAsNuVGQS3xnR0NmhLZVVNG7cGdFsW+EJFAecQF8oX9P
999RQwfmwXQyWe9fuXL4BSZv/gnQk+Z+EjEWX1rgwtpfFXgKKGPsd+4eG9VkRqGT
XQCOkDeFNyQBfi9aGFX5hgvg+dpTBooXqUhfubyf+Odsf6DTeV7hbwzlNkuVzuPS
Abu7nQeulp1pXg089IqmDn1YxqNB9OTTnQDTCgC+3VlVabX/lS3ce4j/q37vf3DC
UCqwZzdXHm4X1yqCWtlpOdrhU/lGTbxGKYNpUt8qz80+anSegKh78oQo4BKdAqS8
sL6t/SUSNt3ts56z76v10lYZ6TsT/XboT3xiaUaCnakDU9RTIHIGqEyhjVxzoG5h
3iff5vlmBpd/vXpfgY8ceR7pXRuUnenw5yzq3MNlpbIfM1q2pOk=
=6DDv
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
