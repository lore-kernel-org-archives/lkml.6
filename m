Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeFDJ2E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:28:04 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:53214 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeFDJ2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:28:02 -0400
Message-ID: <2634178c3b1fb2c1174eae0d67419e285e2f7c26.camel@sipsolutions.net>
Subject: Re: [PATCH v2] platform/x86: asus-wmi: Add keyboard backlight
 toggle support
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Date: Mon, 04 Jun 2018 11:27:43 +0200
In-Reply-To: <CAB4CAwfEyS0j+q_hM8u-XHU_rEFq3604gjsSw4d_4mhaiz=G-A@mail.gmail.com>
References: <20180503030438.51150-1-chiu@endlessm.com>
         <CAHp75VfM+1HUi6W986r0iEiuS46TJc8XscO_ce4N-i66EtPLWA@mail.gmail.com>
         <CAD8Lp46edWAR2iVti8gGp+L_yy91ij6AHuJh3iuuTLg8oUq47g@mail.gmail.com>
         <CAD8Lp46-q8=t9RoWxLjZkv=EAJAbRvY37-ibUof+oVfZaOE0Kw@mail.gmail.com>
         <aa8608844b153359f5e2a7ab876c75eb19969fb7.camel@redhat.com>
         <CAHp75Vc4iXX7+VY3dE4ETjLsv=VCFaNwz6nmAUBS_E_dhpK2Aw@mail.gmail.com>
         <CAB4CAweonk3RseCO2BdAiyc0XjfU6GC+c3W9H3AZkgrJMKbnVQ@mail.gmail.com>
         <CAD8Lp46Xmk_m5Y4M_oXigOkf=z-3O+5F3QaA3AQvgAT4DbP4ew@mail.gmail.com>
         <CAB4CAwfEyS0j+q_hM8u-XHU_rEFq3604gjsSw4d_4mhaiz=G-A@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-55gQeibBvF1gilaf+Ot3"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-55gQeibBvF1gilaf+Ot3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2018-05-24 at 16:33 +0800, Chris Chiu wrote:
> I've made my change to set the brightness level directly in the
> driver, but the
> OSD doesn't show correctly correspond to the level value. The brightness =
shows
> OK in /sys/class/led/xxxx/brighness but the OSD always shows level 0. I t=
hought
> GNOME should read the brightness from /sys before showing OSD?

Sorry for the late response.

There is a special mechanism to report that the HW changed the
brightness. This works using the "brightness_hw_changed" sysfs
attribute. So you will need to set the LED_BRIGHT_HW_CHANGED flag on
the LED and then call led_classdev_notify_brightness_hw_changed to make
it work.

Userspace should correctly show the OSD when this is done.

Benjamin
--=-55gQeibBvF1gilaf+Ot3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAlsVBg8ACgkQq6ZWhpmF
Y3ANhhAAjloye/ZcS7iPIU/wuwAotBQhxKT8oA2QAJLRkKqfD94pN4+E+1kN8pkv
kiKBrlBS5dYn8XX+AIP6Gc4dZGn1Y/yrUCgZNnF7+kyp6KYdmqo2ortk/E0MP7fy
A4+KauxqgbB7VaBkpA78QAj73imaIVHxHsXXiIBDeliMkl/MSuIV3d34MCc5u/rV
tovljsKyFEWdxKFbOiQ77ga/sJiTuiLUrREUjoLz1ff0EGtDWsD/Q+ZbtzgKV1C5
AcuzDTx0vxAnDYv3cGjt2MWkAFNAnHKopxORS01ewFVZF/iPfa5UoHszrVtj2cZl
pSmADzCjQJHyBI5gZ1jgPtjJZhNiZ8F6WKtrlhJe4dZz0lP5DVbdSZgaVyXM/0VB
9MwLuMenq7QmpRFDpvH/xBAlepzwaZ085TeEPBoKKt++nDfTiXsorfKZE8q1xdGX
YCPi3zmr5oE+D2ASDuQIxtwa0QVmSZRQWfBEoU4NI/liY5v9RtNTff8Jx9KhocS+
5b8gRkIRdL/HUc6vqqIJtG3W5rkd3g9ku2Oy1eaApiPrFovMUGwAQDiODiCSKRDj
fUn1d2BwUi+eXpLdfQtzxBQgN9oVSTqdaku8ChD9fjMm0GKBaHNXeQZGfOvYu4H1
PL/LI6EmQjLMxMDnnfV9PCR8Fk0fFQXZtOG8TORZKeZRdRUesV8=
=4f3I
-----END PGP SIGNATURE-----

--=-55gQeibBvF1gilaf+Ot3--
