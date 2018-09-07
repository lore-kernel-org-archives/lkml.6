Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4CBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42B72075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdwUpxkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42B72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeIGMMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:12:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40952 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeIGMMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:12:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17-v6so6193634plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KEvNzKOX9LaXjEwdELvxEKY0MdszpNAj0MMglu7ydaI=;
        b=gdwUpxkkHGbSF3H2wvxorh1b2M5/BfwIfch3EnnZoIl2uWV6ea5YXAgw01epBCju4z
         eOAV3l1oC2vmsHjy+/VuJbXINmQ4VYHYjDf0/dIXFwRixAo0HjTZbBvoZMcPIcGnNWKQ
         Szj18MG2sS+NxyWDiDilLjwvFUu+9DoRY+wvZu1OQVC01X+WXcXW5ZGzqVzTcPKpfcII
         FZ8EBBpQdTO2E0XqoMS6gab6C5ZbehaQ0FsTitQQaeK4Nf/u1+2+tz5N/yTzdVt8d6OK
         IaYInwaGX+Ohl8q9xzW7pqvT3XkHqrWYRr3SKtWUQDTGvbNyATQ2O46dVX7SJhoSutrL
         XQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KEvNzKOX9LaXjEwdELvxEKY0MdszpNAj0MMglu7ydaI=;
        b=lg/TCbM+t1WdfWBwhRTMEXQdSedt0o1ZvTUYrCfOOthZ+TGH1KoY8/6IzWUD6yKPIQ
         3CtTj1jVrHVcKa1vg5BDuUVwJW9qaOieQrEcGyztSFga/+Nz36Kwqnoav/q9X8Kx4IQ8
         6QReEb4jxPJALEOHZc/sw1nQ24vaIj7pUeCcOHAs0N4CrXl0o4UvLr+82HjGYARyPGrJ
         LRtssvPg1hPLew5QeoQ5fjSw9AfyLF2OEdTfnGGRjCAX5O6SV8ZcSQHJ+1jJNRJY9elL
         6H//2OJDmux6GUUg9S20/D02sOa3XXSqNw8XFsurqWutEEfH3QGgHnWbOa0NVRjEsx9Z
         7pYg==
X-Gm-Message-State: APzg51BXgQ4yBQuNpUXQG1+Rgnwa3srCEPrH0l+OMf/0ouJzEDQJDam4
        UITyiaiKpVOGw3W0oywo+g8ABA==
X-Google-Smtp-Source: ANB0VdZXErnAgGtfis55tcMDUuuwMc2z1OvyH1ByxgHh/4X1X8B/y+SBOStyFLljXgx8yJLJrFSQ9Q==
X-Received: by 2002:a17:902:b115:: with SMTP id q21-v6mr6641993plr.333.1536305585058;
        Fri, 07 Sep 2018 00:33:05 -0700 (PDT)
Received: from rodete-laptop-imager.corp.google.com ([43.252.149.35])
        by smtp.gmail.com with ESMTPSA id p73-v6sm10243325pfk.186.2018.09.07.00.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 00:33:04 -0700 (PDT)
Date:   Fri, 7 Sep 2018 15:32:59 +0800
From:   Benson Leung <bleung@google.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@chromium.org, kernel@collabora.com, lee.jones@linaro.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/2] platform/chrome: Move mfd/cros_ec_lpc* includes to
 drivers/platform.
Message-ID: <20180907073259.GA95655@rodete-laptop-imager.corp.google.com>
References: <20180718160956.19864-1-enric.balletbo@collabora.com>
 <20180718160956.19864-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20180718160956.19864-2-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Wed, Jul 18, 2018 at 06:09:55PM +0200, Enric Balletbo i Serra wrote:
> The cros-ec-lpc driver lives in drivers/platform because is platform
> specific, however there are two includes (cros_ec_lpc_mec.h and
> cros_ec_lpc_reg.h) that lives in include/linux/mfd. These two includes
> are only used for the platform driver and are not really related to the
> MFD subsystem, so move the includes from include/linux/mfd to
> drivers/platform/chrome.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks. Applied to my working branch for v4.20.

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAluSKasACgkQHwn1ewov
5ljmBA//QhKbEzkiUTjQrpLmbVTLqvuqWFixipNX8F16Wc2tufZx1bbmlITobx8T
Tq5EAt8rtJyCp5ihJe/TRRdExbXcO75X7uR4SCTdL+YTDV2a7qWmdHP/vJMFoPYr
uHJxRu0J5xwGucAGgJGkVQgsd0vKauM/hPfpE5N0XhJoMGWC9DNuN/j+qslV1Fig
uzqhDktIC62YbjIqTvDeJy8S9i2Dch60G6Xeno14H0HmaUHydC+6Iwxs4+WcGdNy
gEr+N5M6PV8O8HzjMbblX53GDjQhWT1f0Nz3ae2l9POMzb1ZunnSzZj6mSbPj3gA
jAiiO6PK30PGCu2vXqol/K/+8lFj5SJ4OWX8r65rh+no3qPyjdr9vOxFfoshsn0w
ukqjr7WkFdI6XKMVjX3D7VdhE14QaA9LjUDh0A0gt77fHPOQwrV+FFzdhy0URgYR
gTPsthfIkGBmAI2qsa9fJc31ob6vHviPJYnN9rfviEgjKht+KoiGnGxWmb9gfnOE
JdAwQneLvbsh6Wl+atoCUS2LSsw0nnNTL7kBA5Yn1bN7N+ajVKGH+HPRctvpLn+c
XnEpx/zR+y6nKvCBqT1JUmXyLed5CQLvmVDFhAsz8xNzbWniBTnaMYYy6IR3k0sU
c8q+ldg2tJogy/4Ih4krF3XXCi29Ha+PGTDZLsWRJiLhOQNNSQI=
=5rPY
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
