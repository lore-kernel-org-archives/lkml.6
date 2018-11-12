Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA56C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A009223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A009223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbeKLVkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:40:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:34764 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbeKLVkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:40:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 03:47:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,495,1534834800"; 
   d="asc'?scan'208";a="88640560"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by orsmga007.jf.intel.com with ESMTP; 12 Nov 2018 03:47:14 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 4/5] usb: dwc3: drd: Switch to device property for 'extcon' handling
In-Reply-To: <20181110181101.24557-4-andriy.shevchenko@linux.intel.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com> <20181110181101.24557-4-andriy.shevchenko@linux.intel.com>
Date:   Mon, 12 Nov 2018 13:47:10 +0200
Message-ID: <874lcm34ch.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> Switch to device property for 'extcon' handling.
> No functional change intended.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/usb/dwc3/drd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index e7e421521a34..5dc4cddd5b68 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -10,6 +10,7 @@
>  #include <linux/extcon.h>
>  #include <linux/of_graph.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>=20=20
>  #include "debug.h"
>  #include "core.h"
> @@ -485,8 +486,8 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3=
 *dwc)
>  	struct device_node *np_phy, *np_conn;
>  	struct extcon_dev *edev;
>=20=20
> -	if (of_property_read_bool(dev->of_node, "extcon"))
> -		return extcon_get_edev_by_phandle(dwc->dev, 0);
> +	if (device_property_read_bool(dev, "extcon"))
> +		return extcon_get_edev_by_phandle(dev, 0);

No reservations against any of the patches. What is the idea for getting
these merged upstream? I don't mind taking 4-5 through my tree, but what
are the other folks considering?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlvpaD4ACgkQzL64meEa
mQaAtw/+InF7b2f+wuzyOTNpr/uXn6Y7KMmBL0Cvh9ee7BiuQvghmcpKNufDLxA0
6DvmfmqxBdyvHMaKvygBJzpRVrYZIvcmzk9kGpYmTZFJ/7IF8S+jmuZZUz6V+/Db
T5MOC+czKGWBVv8XVDzvK2jG53RUMDzpeiu/KXksXvUi89Kg88kH77Brj/RnUfia
8FGJ7Vdzvbsntd/efVQl3q6gSQHRI1Syi3Nm5htsRwJxZZx6Cl0VnyDSXNLR6Ecc
GOC+xRGTDrP8f4DoSc66Bzak8NhOly9RE+DnjlqbHX8SZPp9lyg+3bWy1VlCnjW1
ze0yiIPQE5wytjKyFYg0L+0INesgsxb3ptfg2XRoeuStfjr+2z6CcXh+q2Dwve3/
pvA9ZUf2cNU6x+oiPCn26G6dfFtGaqRiliJ33L3K7dtajA52+Xt7zRg45Vz9fb1p
a2yT9lWZWpPFcDQ/pLX8H7JVpp4p8djt9v7BsVCtbbyHXnO6gtaeH7idmlQ/eTfj
bsiPYCMDCcvzjkVM69R7URy5E0sDQ4IGpm5v99c+PWnHICYb0SfaGFwEeTDe8QnF
b+SqdpIhIMinHMEYYUHnKn/8WpGx/4MrLSlCNvWWCuQjuxgyI1RawygsU9AMnyv5
JhP7cfr6dMvsXij/bzlM4XNOVbhUKpQSLyYSaOThXoeBXPyJdJI=
=htB7
-----END PGP SIGNATURE-----
--=-=-=--
