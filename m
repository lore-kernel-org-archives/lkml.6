Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E666C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB5A20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="oW+cN6qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB5A20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeKJHEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:04:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37865 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeKJHEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:04:00 -0500
Received: by mail-qk1-f196.google.com with SMTP id 131so4175128qkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 13:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=k67FzxYvLPbDYKJ6Qno3xiGOQg6ZgYBNz1QsP0ytJ08=;
        b=oW+cN6qm4CTW4rNZB65R23L6sRwX3IEQZxaMV9xxhgDWB4zfHx+/bUduQ9Mc8SrEVW
         tHsUAWcxoO3N91SXFWGWIhPmARfIsKieLFyGHxfO6nNTRECXFb9Hlu/v0fPjksDMCu7F
         Rh+/C4NFrvgXlpSVnFwVpdzCjnTraFiIGbg2TqQV8jaV/cU+hOsE+tfvpYz5T6BzeTF4
         VIA+YWqEWdCUYFOPJJXMf/AW4FBMqGe56qBvtztnlET2lT5pIb71nvZnrFOrGynYpGHS
         ddUMejP0JIXVYscYG8K80PKYUTJzIb6H6rDHp7rzqrAg6QsTtPBSrRFQfQhOthu7L6yu
         6NHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=k67FzxYvLPbDYKJ6Qno3xiGOQg6ZgYBNz1QsP0ytJ08=;
        b=eoPwyUqNb+cEwN+kA/wqS+xyEJZXSGn7kGfUV0yAO2VaZO3hsKtwtMjF80CjD0po3U
         bz4LGO7DBWNYaFcYblF3B8NHUJqBeX8si5GXlJ1i6eP185EdGEogN/skVz6xgjrHXfUN
         6b1N+HalIa0oKDCUmH2N0NLuqa1lDRMa8gEKBLJwvcCKeLuaBGDQ0GvXglPi8liN5Ub8
         bSH9wH7R3m8IhSU+q5T+EvPpVK8Qqrvfh46XcBsb3pYncAFBpSTkm0MQoLO7m58XTyoj
         6X5WigIFiWr4sSQZWdsiLqEEgW0gLdAwjszx4C6y3EvQFmB1JZhx8g1rQQ3XL3pwz1vT
         cbkQ==
X-Gm-Message-State: AGRZ1gKZrFtoglR9AwpkV8K14lMvK3Px3QW0TgwGF/WFxd3uHZRa/zfX
        Gu8QQO60W8SD6revM27Jd+HiNw==
X-Google-Smtp-Source: AJdET5dgCpbvvZp7H9g5kmb8EGn+q5TvUgVJ6S6JfQCiROjss3XKZGyllc2fY+povKeB/wJe8r/1Sg==
X-Received: by 2002:a0c:d933:: with SMTP id p48mr10779059qvj.15.1541798497843;
        Fri, 09 Nov 2018 13:21:37 -0800 (PST)
Received: from tpx230-nicolas (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id h67-v6sm4373030qkf.32.2018.11.09.13.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 13:21:36 -0800 (PST)
Message-ID: <0841fd86ea9bf52057e2a4622a7b9719662cc484.camel@ndufresne.ca>
Subject: Re: [PATCH v4 2/3] media: meson: add v4l2 m2m video decoder driver
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Date:   Fri, 09 Nov 2018 16:21:35 -0500
In-Reply-To: <2f88a17d-76f8-ec70-c18f-aa0d688249be@xs4all.nl>
References: <20181106075926.19269-1-mjourdan@baylibre.com>
         <20181106075926.19269-3-mjourdan@baylibre.com>
         <2f88a17d-76f8-ec70-c18f-aa0d688249be@xs4all.nl>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-LJ1ZOKBs27Eu2dHy/4L4"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LJ1ZOKBs27Eu2dHy/4L4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 08 novembre 2018 =C3=A0 09:42 +0100, Hans Verkuil a =C3=A9crit :
> > +static int vdec_queue_setup(struct vb2_queue *q,
> > +             unsigned int *num_buffers, unsigned int *num_planes,
> > +             unsigned int sizes[], struct device *alloc_devs[])
> > +{
> > +     struct amvdec_session *sess =3D vb2_get_drv_priv(q);
> > +     const struct amvdec_format *fmt_out =3D sess->fmt_out;
> > +     u32 output_size =3D amvdec_get_output_size(sess);
> > +     u32 buffers_total;
> > +
> > +     if (*num_planes) {
>=20
> If you are not supporting create_bufs, then you can drop this part.
> Without create_bufs you can assume that *num_planes =3D=3D 0 and
> q->num_buffers =3D=3D 0.
>=20
> You should add a comment here mentioning that create_bufs isn't
> supported by this driver and explain why it isn't supported.
>=20
> I understand it is due to gstreamer problems, but the explanation
> in your cover letter didn't say why it is a problem with this driver
> but not other drivers (apparently).

There is problems in GStreamer with this, but it was disabled because
the firmware does not really allow adding buffers at run-time. Worst,
we would often seen kernel crash when this was enabled.

No decoder before this one implements CREATE_BUFS from what I'm aware,
which explain why I never catched the GStreamer issues before.

Nicolas

--=-LJ1ZOKBs27Eu2dHy/4L4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCW+X6XwAKCRBxUwItrAao
HOZ5AJsH8ZD3W+TeUWe/UNJV3bYp0L8AXgCfXruwEQXll0C8dn63JN5dNOcXfpY=
=Smtu
-----END PGP SIGNATURE-----

--=-LJ1ZOKBs27Eu2dHy/4L4--

