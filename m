Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFFFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF648214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dv0BypLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF648214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbeKNPgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 10:36:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45147 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeKNPga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 10:36:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so2606360plm.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 21:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=diIPDUTQNR5cWMK1c5y3D7k3PD6LJn059v50MJhZOYw=;
        b=Dv0BypLRtS71XWfBhM89MoLEOLC8RA3gia5toz1hwessMTfUcExMUgU5j6/pALc8yz
         SxDEvpH/1EUK7nctPuL1Qa2ticq8lChiZIS2ALdrd/dyQ9rVwMrRbBbUPlYVv7jx9uih
         0zrrs/vwNnH5K2w4D3T0Qfe2zPH3/9R+Y05VxWwjT8poqZOqRwdKV7xb3DoblHHf6oyA
         kpWsF0jCx9CSgpB5+i4yaMUJizX5nm0KbtQint3KkdHq195YQ3cXhykQ49P695haNcEe
         QOe3/86OFC0ebL/FFUcKKUJC00eHQrSr+iAm6lNDie1jwBBA9ld4CbUDF9FVdzu1mnqT
         9t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=diIPDUTQNR5cWMK1c5y3D7k3PD6LJn059v50MJhZOYw=;
        b=abC3ZoDSeU4BqbBwnuCSbw5f3Twc4utvfFyiVYbR9q+BI9lRAHI+AEgbXhGkIq4Lht
         1NMU558Q3ukrGtohYM2KQixaOSGB6r0OseZV1629PTMQ5p5zPDyfaFkOAjVCylaA49gc
         UBBZPob1+ewKIzczoZmbvLiGp7cu/MKVkyUR+yiF3Z5XqnV/gZMQkMF3SStgM8UUMxJ7
         jR+WqIKW0+KPQHXNTvq2XnBGqtBMYiFFXTaIY6B1I0eGUTMCjAb9iSa7ZrMYOpEW3Zd1
         DxKYbVI9epyB9q/+MQCoHhHIIhffPqp89YPEkkLbfX/th7NzbaPu3b6t7bZ8nT1kmtAJ
         HeTg==
X-Gm-Message-State: AGRZ1gLH6R6NrQIWFZ7Oh7Xp12OwRfm0koEGDGK1tF+1sfQUeQC+fZJ4
        Zw+6uC0CyOVEdGKQKMtojJVFQw==
X-Google-Smtp-Source: AJdET5c1j0c1pXt0TlrDjidtKmISSvn+Mxp+CuAZQMsgd9ieX2SWZmhYT/Fy45FUN/uTwgYMqZ89YA==
X-Received: by 2002:a17:902:8f82:: with SMTP id z2-v6mr512127plo.175.1542173688212;
        Tue, 13 Nov 2018 21:34:48 -0800 (PST)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id g65sm22216622pfa.63.2018.11.13.21.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 21:34:47 -0800 (PST)
Date:   Tue, 13 Nov 2018 21:34:45 -0800
From:   Benson Leung <bleung@google.com>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Shawn Nematbakhsh <shawnn@chromium.org>,
        Alexandru Stan <amstan@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        RaviChandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH v2 2/2] platform/chrome: don't report
 EC_MKBP_EVENT_SENSOR_FIFO as wakeup
Message-ID: <20181114053445.GB145716@google.com>
References: <20181108024939.174321-1-briannorris@chromium.org>
 <20181108024939.174321-2-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20181108024939.174321-2-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Wed, Nov 07, 2018 at 06:49:39PM -0800, Brian Norris wrote:
> EC_MKBP_EVENT_SENSOR_FIFO events can be triggered for a variety of
> reasons, and there are very few cases in which they should be treated as
> wakeup interrupts (particularly, when a certain
> MOTIONSENSE_MODULE_FLAG_* is set, but this is not even supported in the
> mainline cros_ec_sensor driver yet). Most of the time, they are benign
> sensor readings. In any case, the top-level cros_ec device doesn't know
> enough to determine that they should wake the system, and so it should
> not report the event. This would be the job of the cros_ec_sensors
> driver to parse.
>=20
> This patch adds checks to cros_ec_get_next_event() such that it doesn't
> signal 'wakeup' for events of type EC_MKBP_EVENT_SENSOR_FIFO.
>=20
> This patch is particularly relevant on devices like Scarlet (Rockchip
> RK3399 tablet, known as Acer Chromebook Tab 10), where the EC firmware
> reports sensor events much more frequently. This was causing
> /sys/power/wakeup_count to increase very frequently, often needlessly
> interrupting our ability to suspend the system.
>=20
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied. Thanks!

Benson

> ---
> v1 -> v2:
>  * no change
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/c=
hrome/cros_ec_proto.c
> index fff67b389c87..cc7baf0ecb3c 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -575,6 +575,7 @@ static int get_keyboard_state_event(struct cros_ec_de=
vice *ec_dev)
> =20
>  int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_eve=
nt)
>  {
> +	u8 event_type;
>  	u32 host_event;
>  	int ret;
> =20
> @@ -594,11 +595,22 @@ int cros_ec_get_next_event(struct cros_ec_device *e=
c_dev, bool *wake_event)
>  		return ret;
> =20
>  	if (wake_event) {
> +		event_type =3D ec_dev->event_data.event_type;
>  		host_event =3D cros_ec_get_host_event(ec_dev);
> =20
> -		/* Consider non-host_event as wake event */
> -		*wake_event =3D !host_event ||
> -			      !!(host_event & ec_dev->host_event_wake_mask);
> +		/*
> +		 * Sensor events need to be parsed by the sensor sub-device.
> +		 * Defer them, and don't report the wakeup here.
> +		 */
> +		if (event_type =3D=3D EC_MKBP_EVENT_SENSOR_FIFO)
> +			*wake_event =3D false;
> +		/* Masked host-events should not count as wake events. */
> +		else if (host_event &&
> +			 !(host_event & ec_dev->host_event_wake_mask))
> +			*wake_event =3D false;
> +		/* Consider all other events as wake events. */
> +		else
> +			*wake_event =3D true;
>  	}
> =20
>  	return ret;
> --=20
> 2.19.1.930.g4563a0d9d0-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlvrs/QACgkQHwn1ewov
5liXVBAAuqVX0iYCLB1ifW6Oz9/lFGuFP42GVNtOXag4zntljyGpC8LOO7sCbHoD
5vhMJFARuKjF892eP6aNU6eT3vqCwQvBp4odE48qcaos4lLMl7++SxWsfRz1WVkQ
o8lWgVYZs3y1XXEhShSW5WRem8LXs8WOgiE+d21Z1ltBgihabwDpziVxooszcUlJ
lDejygd1MA/3kxyyNJjMyRxMXByZjFYH09UmY5JEJpT+ar/NDRW+bBPfznjOFzUR
D+/IfGEq9rILzfzU5Jj8lCZErjWUtO2uypaiD23YXfk8v/GnZSHDjM2k8vxiz8EK
kTTgjnhh++9NjQibRxHpE/HCPlrilxIUkRFWB9HpFFq6zTqrDSvad5d4FQaWz+Jg
NIWCA+5xbVUxFF6Ug22Xh7lFw3yzp5NmhvtS2wdPQP/+454whuVHlK/kT8tcUCmQ
kIfvyuoUqZRT23KqS1d0UIQWO++3qc8a9oFF8pcT9TQC29wGimfx3h/Wz/vbw2xz
/kZvlhUrp9J7Fqrv5AC1BcD68YQb2bj/gQTNm8Bv29cKweg30dm1dzm7oGo5TOkO
pRFFpkekYCZk/9T9X7B8nxz/9NUbPhrGAk0nlQs3lvxH+C9EWtnK0tDdQGsS3hW8
EiFH1SdYw2S+4+KnPB10O939MlPzV6EaOx746rdSnJrA64dUzfQ=
=u1lk
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
