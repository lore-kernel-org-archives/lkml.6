Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeBAMWk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:22:40 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37064 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbeBAMWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:22:35 -0500
X-Google-Smtp-Source: AH8x225IcIsiAQuVbZChOrg+NRd982YkwabJohg8z8uXYTu4YykBJIYh0+KH/V/If5MxPKR+1c0QyA==
Date: Thu, 1 Feb 2018 13:22:30 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] gpio: Add GPIO driver for Spreadtrum SC9860 platform
Message-ID: <20180201122230.GC690@gmail.com>
References: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517313987.git.baolin.wang@linaro.org>
 <cccc1addb9c0cc541b676dbad005ec341d12d165.1517313987.git.baolin.wang@linaro.org>
 <CAHp75Vcig869pUQ5yK1b=GpXinhYkpw1q29OVKSs_7EqP4Hknw@mail.gmail.com>
 <CAMz4kuL9r+97_rDihgKD_TyNaDQ3aCk7go6e4mB24QOpovFYJg@mail.gmail.com>
 <CAHp75VcYQMYNmW9-MkOKA5TWV2JgNfqnUB22s1qB4Z0ZZbTG2g@mail.gmail.com>
 <CAMz4kuLO=zRqg72=7dC2fLHyVcEOcsU0PqiZM8XEYC3TGT1fYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <CAMz4kuLO=zRqg72=7dC2fLHyVcEOcsU0PqiZM8XEYC3TGT1fYA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2018 at 11:08:46AM +0800, Baolin Wang wrote:
> On 31 January 2018 at 22:23, Andy Shevchenko <andy.shevchenko@gmail.com> =
wrote:
> > On Wed, Jan 31, 2018 at 4:01 AM, Baolin Wang <baolin.wang@linaro.org> w=
rote:
> >> On 31 January 2018 at 00:48, Andy Shevchenko <andy.shevchenko@gmail.co=
m> wrote:
> >>> On Tue, Jan 30, 2018 at 2:07 PM, Baolin Wang <baolin.wang@linaro.org>=
 wrote:
> >>>> The Spreadtrum SC9860 platform GPIO controller contains 16 groups and
> >>>> each group contains 16 GPIOs. Each GPIO can set input/output and has
> >>>> the interrupt capability.
> >>>
> >>>> +config GPIO_SPRD
> >>>
> >>>> +       bool "Spreadtrum GPIO support"
> >>>
> >>> Either you have to put tristate here, or remove all redundant
> >>> module_*() and MODULE_*() macros.
> >>
> >> I will remove module_*() and MODULE_*() macros in next version. Thanks
> >> for your comments.
> >
> > In that case you need to explain why driver can't be module. (And
> > don't forget to replace module.h with init.h).
>=20
> After more investigation, I found most GPIO dependencies can be
> deferred to probe. So I will change the GPIO driver to module level
> and change bool to tristate in next version.

Then you could replace

+static int __init sprd_gpio_init(void)
+{
+       return platform_driver_register(&sprd_gpio_driver);
+}
+subsys_initcall(sprd_gpio_init);
+
+static void __exit sprd_gpio_exit(void)
+{
+       platform_driver_unregister(&sprd_gpio_driver);
+}
+module_exit(sprd_gpio_exit);

with

module_platform_driver(sprd_gpio_driver);

>=20
> --=20
> Baolin.wang
> Best Regards


Best regards
Marcus Folkesson

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlpzBoAACgkQiIBOb1ld
UjLDLg//bbOVj4bi8CfryAT76NKZCO7XNQPOyt+ZgwrJKFJKCAMWvEj2cj54/Adp
S7TdKbFRsXsD0mQXMJDpO4AbP+lkoLaEe88N0CkN4v6x+lxRAJUYXSeyLDjWY6pJ
8L5GAufoNHp8PQunaxJzWetVbtrX6EaT7TTPU4Ogjy8oXM6DefxQj5wnCs5m2Xcw
0VhjgMEi1lmrd3cN1cTPeQ3wMiwmms3UJmgt3vo3z4swSPfNLeBtYHeTKp3BwE3p
JDHfPgVZ6sUNX2MD4XbmMiV0irG2t4l46mwc+77KfTmy+D3LSOQUi6JDMBw17WiB
ywaqf7z0Fa8S/IVyaV6JZ/acM07barxax1a/g48xQdmGQ0LveiA+pr8Hq/TrRueM
MAki2Ew68SGuOhC7/ZgsbfH1Q8wtwSNYO3HeSmxkdDjyspMjPp/pv0T/9EikKlI/
s00SNyBfd2YsLqc5sAZy1ZQ11yEGmZ+ldCIvHhw83OQq6XAdiT+O08i8wICp6XcA
c5esJCQj74STPRGqKcMJBs/duPyrKtKv7yycSPUY+RXQrcRztvAxB8FIgIpgi48B
x8pN59yAjdazI1aPZdUA+3RAaENFR3ZmMH2X3LMkUvSy27tG3Qv/8pXNfsfMg3ic
qjqOWpJAn9oaDKu46RTEsHRJzClPuPBXH30CXacJHxr4RIAaOdw=
=6kpr
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
