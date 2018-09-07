Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDCBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C89206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vuVthef2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C89206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeIGMe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:34:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43109 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeIGMe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:34:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so6619160pfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hEk/FvjCS1P8NUPV2Jnv6OR4JBQ5FfDKB7r4RhXZdtY=;
        b=vuVthef2rU8JAjb9RPPTcjVLlpivj+9WSnyrL0qo8e90X/uhRilNoMqrn7XOr9JFlb
         AV6+TbtFCurxMo6MUPYy1nCT1zdGHLLP9FFSC1uTdqUAb5yUzvH74thLYM8zgFAgPaAi
         kiEZ6TUhMe6GqyFfb58uwtRWk58MbTmJJz25QGIKyavUnmC76/XuKhXETe5Md/z2iUNy
         SDjS3Monua1oGV54yH8o+swORi8jNNhkUI7twMzBrSUgtrEazZrJlmKfJHLWEyh93p2v
         09K48tihZNw8TLrFiXEMeRQVDBJbTT1xfX+VRyiuAnK7e+ULPJn/nKqVh1WjMGQKLA2y
         gxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hEk/FvjCS1P8NUPV2Jnv6OR4JBQ5FfDKB7r4RhXZdtY=;
        b=HUTz/XvD+r4OCmIFKMJPpm0X+VNMhAPx1Cvwp2oWw1564lPlOgZ2MgucdyBKl2BD4f
         3DT/TINCDlgkav3esVyzA+tNplTbgiu/iEgTuXkdDgjZEDWBbRgLRAVn5VWIhKGWncjO
         uX/V7Ixit1kJdbSAg4rwo2S889EAvYDmnQzlKJup3kXhEBa0JAzSmxFaPDuPyIu1l+t0
         tj+r+jDyMQfhiYzPzE0SlJnyUVGCbTSoxMMoqSGA2qaKl1ccpAH4svIVdkOQdCdTgD8N
         Sf3vkDKP98Y2dwwpN+u59LCxxHP4yCgT+j1KKe1DvRmBajJYv9pwAqP3KrrjgGwG4XtX
         iXWQ==
X-Gm-Message-State: APzg51DpNqfwPg6i1DVqM7qvb3IN3S6cQTsyU4mzWq2LMmoWpiWf32OG
        EGMEAUcNgdQtfVxozMK+pLYzhpEpZqkrWmR4
X-Google-Smtp-Source: ANB0VdYM5pYeWofPICaSXVA6kWHW5h+cmSJ/SPwUQZri6Iat1WomhHmV2OCTplYm1lR4qFQ0CVapsQ==
X-Received: by 2002:a63:1b4e:: with SMTP id b14-v6mr6825780pgm.303.1536306884122;
        Fri, 07 Sep 2018 00:54:44 -0700 (PDT)
Received: from rodete-laptop-imager.corp.google.com ([43.252.149.35])
        by smtp.gmail.com with ESMTPSA id y3-v6sm15817280pfi.24.2018.09.07.00.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 00:54:43 -0700 (PDT)
Date:   Fri, 7 Sep 2018 15:54:38 +0800
From:   Benson Leung <bleung@google.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@chromium.org, kernel@collabora.com, lee.jones@linaro.org
Subject: Re: [PATCH 2/2] mfd: cros_ec: Fix and improve kerneldoc comments.
Message-ID: <20180907075438.GB95655@rodete-laptop-imager.corp.google.com>
References: <20180718160956.19864-1-enric.balletbo@collabora.com>
 <20180718160956.19864-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <20180718160956.19864-3-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Wed, Jul 18, 2018 at 06:09:56PM +0200, Enric Balletbo i Serra wrote:
> cros-ec includes inside the MFD subsystem, specially the file
> cros_ec_commands.h, has been modified several times and it has grown a
> lot, unfortunately, we didn't have care too much about the documentation.
> This patch tries to improve the documentation and also fixes all the
> issues reported by kerneldoc script.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied, thanks.

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAluSLrsACgkQHwn1ewov
5lgaQw/9HcRd+O7Teurjpd87BM743u1UtPkb2wZy9K5fDN5/orvGg9PAxyD8vdyh
mB/VnIqOdkwpLo2LtLwyajFqBVLJvTneubNiO3CmSHQb8OMrIdELDPMOeQTHIjz2
iwhWzN4D+8Mgdz22LeLt+alIhtx2Cs8UO0wd9KNjVbGFigs8zNEASHxsjfG+Wl4r
cudwFcb7YUTiMlYNguvavqXy5oDYfdolZW3wDExgGfMIhnpDE0W5MMUv42H7E6ay
oW0Td93EfAg2eXLLWRgB8BkN/kzHQShkxNF34H4TJB/eB1YaglwJsBlQ76ihndeD
oXyi+K7TD3u+0GojD5eTv53oBTyOYq1I4PqgtbOxRE3JUmfjlG5QlnJEm730qI0N
e/NmeRLeTF7q+ikBNyzR3Wn57WaJGoSjHmjAeDcVXAb+iQ9U/6JzP1CBlOuuznYm
yvQ/hjG01datJpat9al9TWITdwZ63iRyGQOd+rsvpxXO4bDBBW8cb4N1vAcCR0fL
gGjHmX03PVfNzQOtzVE0VJVe8KhG0W2DQUFxHYvWvSrNOG7DfD/F0dqujoh/qI8N
YbtO69kgihnkSdzK6LUhzLrE9FV4zK1Hyrfw8KXTMP9rGHUK2EgLW8/IGT7hYzZ+
CqI5wVoXf6iZV+GDVP6dezLM2Up/s1S3J52nfD7JvUzv6jER4Uw=
=ufyr
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
