Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63879C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BD12086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIgEdcwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BD12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJJMF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 08:05:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35368 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeJJMF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 08:05:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id f8-v6so1901198plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 21:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OBYnFskO5WcncXqPENCCFVmRscJ9rUQeaLNUqkEoqWU=;
        b=tIgEdcwNmQMWC3JYNGnGmNdRIr+9PzT/qDyi69AK+wBAoWAJ64jHs7ImgNU3PTjWcB
         f29QuOsfPaTgI4UAMH1O1OBcw+s4Mlm9j2ZRmdJOL5+M6CQ/AU6DX3/V0sYSIiSrxhJg
         u3XFkcJImE4uyp7qJrgu4NNQGoy93svLkrrw4F17zWsA+SLedQ7622IR9IwPdbbevwDY
         EWp6/ZleIv8pyJMJuVUXWZC3LVoT4nOh8ZiJMH+y4MdgVY7sO55O1CginKuDQEa6Ah1C
         nQgtDDxL2Lnio1Z1Zg24hQgfs8TFNXMRzHzTKU/piEWc9Vn1XJY23Wedp0fnFjejBS5K
         XwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OBYnFskO5WcncXqPENCCFVmRscJ9rUQeaLNUqkEoqWU=;
        b=lO97klSLniFi3PwW6hIVQ8CYKLSGXL0Ywf7S6usTAYtPTxCelVNI/xS3TxOgSD34BJ
         vfSAALSmSv3uWnSK7jnfcQ+4rdDDXV+9D974/h1lIOUcf1KKmoB1wncsZMilLXWevCqS
         xrSR9ho6x9HR7SIHGouzqdNHChxtiYHxd13i8E1HGVII8tC8P2O2tVZCc4ssbTwXajVR
         MzAS9Jnkcbyc6hXLNrhLK7zNO0qJzXQG48+X4ohb3hfDZ2qP4WDf/bVPj17+poohbyt1
         o8qEiPssu9bG/BMXQ9NNDbsQfNP/W3jZ4Qj7BMCJ2NtYgU3UGOV8CRZqBEhaf1j61JDN
         swag==
X-Gm-Message-State: ABuFfojpqGDZc9ZbAfeB/A2drX+4eGRDPvyRnpUJRxxmnetp7ix9E0oy
        UzmUrFUnart6n5GN2HOCgJy7tg==
X-Google-Smtp-Source: ACcGV60NLIdAFb6IRYKkIPP5IbCFyn5432gFPx+zNBqGMaO/YkSer9zgnI6xciosq+bCG0CoFyDKVg==
X-Received: by 2002:a17:902:2e:: with SMTP id 43-v6mr31363123pla.290.1539146740347;
        Tue, 09 Oct 2018 21:45:40 -0700 (PDT)
Received: from decatoncale.mtv.corp.google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id 187-v6sm39510250pfu.129.2018.10.09.21.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 21:45:39 -0700 (PDT)
Date:   Tue, 9 Oct 2018 21:45:37 -0700
From:   Benson Leung <bleung@google.com>
To:     Enrico Granata <egranata@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        gwendal@chromium.org, Enrico Granata <egranata@chromium.org>
Subject: Re: [PATCH 2/2] platform/chrome: Add a new interrupt path for
 cros_ec_lpc
Message-ID: <20181010044537.GA147693@decatoncale.mtv.corp.google.com>
References: <20181003184506.149579-1-egranata@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20181003184506.149579-1-egranata@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On Wed, Oct 03, 2018 at 11:45:06AM -0700, Enrico Granata wrote:
> From: Enrico Granata <egranata@chromium.org>
>=20
> This commit allows cros_ec_lpc to register a direct IRQ instead of relying
> on the ACPI notification chain to receive MKBP events.
>=20
> This change is done in the interest of allowing reduced jitter in the
> communication path between the CrOS EC and the host for receiving sensor
> data.
>=20
> Signed-off-by: Enrico Granata <egranata@chromium.org>

Applied for v4.20. Thanks!

Benson

> ---
>  drivers/platform/chrome/cros_ec_lpc.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chr=
ome/cros_ec_lpc.c
> index 31c8b8c49e45..07eea608915e 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -25,6 +25,7 @@
>  #include <linux/dmi.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/interrupt.h>
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/mfd/cros_ec_commands.h>
>  #include <linux/mfd/cros_ec_lpc_reg.h>
> @@ -248,7 +249,7 @@ static int cros_ec_lpc_probe(struct platform_device *=
pdev)
>  	acpi_status status;
>  	struct cros_ec_device *ec_dev;
>  	u8 buf[2];
> -	int ret;
> +	int irq, ret;
> =20
>  	if (!devm_request_region(dev, EC_LPC_ADDR_MEMMAP, EC_MEMMAP_SIZE,
>  				 dev_name(dev))) {
> @@ -287,6 +288,18 @@ static int cros_ec_lpc_probe(struct platform_device =
*pdev)
>  			   sizeof(struct ec_response_get_protocol_info);
>  	ec_dev->dout_size =3D sizeof(struct ec_host_request);
> =20
> +	/*
> +	 * Some boards do not have an IRQ allotted for cros_ec_lpc,
> +	 * which makes ENXIO an expected (and safe) scenario.
> +	 */
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq > 0)
> +		ec_dev->irq =3D irq;
> +	else if (irq !=3D -ENXIO) {
> +		dev_err(dev, "couldn't retrieve IRQ number (%d)\n", irq);
> +		return irq;
> +	}
> +
>  	ret =3D cros_ec_register(ec_dev);
>  	if (ret) {
>  		dev_err(dev, "couldn't register ec_dev (%d)\n", ret);
> @@ -294,11 +307,11 @@ static int cros_ec_lpc_probe(struct platform_device=
 *pdev)
>  	}
> =20
>  	/*
> -	 * Connect a notify handler to process MKBP messages if we have a
> -	 * companion ACPI device.
> +	 * If we have a companion ACPI device and no dedicated IRQ
> +	 * connect a notify handler to process MKBP messages.
>  	 */
>  	adev =3D ACPI_COMPANION(dev);
> -	if (adev) {
> +	if (adev && ec_dev->irq <=3D 0) {
>  		status =3D acpi_install_notify_handler(adev->handle,
>  						     ACPI_ALL_NOTIFY,
>  						     cros_ec_lpc_acpi_notify,
> --=20
> 2.19.0.605.g01d371f741-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlu9g/EACgkQHwn1ewov
5liAmA//TVir5JystHr+78Xt6RA59R88pAiNMSnoN868p0q/9WxXDASXK7/sGDrU
Mz3s+w0Vu74MNBRz+i+Ui3g8zyY6uKhWUC0oo1P+CygF787aomOpPsK7GJVMdHUL
VQ2sS9rp3TTqh5aoGB5nAABUBryZlyhQ8lWqsoxIW4knDVE0v1je2XewCUFpUwny
ZwtFDvFZC+TgaHQnaVgYanNOJqoFaUzwmLYRN7Ad7+uaMuNW+ik1BERFun9UzF78
tfuRIqwDfvYVTz2g7Cnsgl9pO0XBgAh8AFbuGtqt3E2UDy06UBckgaD5G4BUDGxB
wRcIuwUoRq8JX/xLOU2ZRAxQZjPPjnxECvb0M7cK0EAIsHtSnPX7Z5GjdaIE3Xp/
MMRl7kRFHJZ0YRo9a+5covvmCC2aWTGYvWjSQtCEB1kbqOVQ4e+fk+8rE6mX1YA1
j5wBQ4uJ0UPqVMq+yHGCzAo04Dr2KiInbkbG/PnnjfhGJfZ435QJONMbZ8TVv5b2
5eOD/3yn5Q8RfMjKAIACdEa2W+o65Ib/IZCd7cfuU7Qj6teNepzZkLims2snF/0T
j5rCJSGpUdQZGItRWtz+jMh2rPwVaLwUgfDbySR5/LgIdTiWhKTrnkqR/Rz2HtYn
/SV1yWlwW+TIzhk7/OBOqkFCb742nH0cBYUf5oGX0b9kK6jjV+U=
=LIkL
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
