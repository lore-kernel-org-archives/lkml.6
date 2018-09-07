Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A90C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E962075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qDGaLOBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E962075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeIGHyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 03:54:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35353 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbeIGHyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 03:54:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7-v6so6253290pgf.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 20:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mWmWKJUk6g6McQihajHleedONHT/BVAq9eEl0P0XyWQ=;
        b=qDGaLOBzDIX/fMoRmP7WVBvKL0tukbI+T43bdJcmA9WvHfbMIr9yI0qYW1VTeYIGmh
         nICIQ5t1wSodFkuU4AxeHslcuf//6LFCfnbSMIQMJUGRI+vSImt8xygX2vSBVRw29ZQh
         O1PsGEiL0xcbB0ilpdOLdnGdOLB32ZB3/QMhP5vVMqxXLkPueWyEg0Zkw5LNuLmjQHmv
         qrsb8la6Rpjj0DDKOtw0ryJmUmq+k0rtAL9U0HXJoiY/3B06dU6Hj/W43SUsltQThZRe
         CJTFJz8AgxA4FHcE/keO0NrkzD89H0q1Fn077ilJJtZVVFRVtgfTYlCjmgzvzCVMTLLp
         X7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mWmWKJUk6g6McQihajHleedONHT/BVAq9eEl0P0XyWQ=;
        b=aBKzoa2YZ4z6QcUXESnZULloUnmF+dhgX6Ix/63Yj5zqx9NTIlY/WXbGOY3EkdK0d5
         I3cgmqlBgd86gdaE1xxEKaaB5Vfs89ek2Zd9BtMq5lQn7KLa0+ndJLutDVnHbanrtB6K
         iGb2WS+MvkyLJ5Q1UDeYx+mDJBETKWD7MkFcJ38+gSiJEhXEKqFQ1M/xYtx+C5DkGfr6
         vSwrVUXdTJIe1xGCm245FxPlB6kc2PFmKN4oeQoIj8n0ZnNLNj3Twd/3n4GEosqtSNMl
         W5SyCL1cwFL0OfpcZRUE4zWvKgUZo57HG5EVIm+JRZ9myRjhmND0B8eNV+tR/2vEFsE9
         V1nA==
X-Gm-Message-State: APzg51DWy0YsMD5z/ScURuE4BuC5KLteZmbcjnvluY1Z5yxc8iLaIEss
        l4PssjS8lqpjwIXhmBuSZQnOFw==
X-Google-Smtp-Source: ANB0VdawmvYgok2JDoxFEiRLLICy/2nCT/wTs0LIV3joxODie3J3jHBSttKqpMCKIYir9aDDewrulw==
X-Received: by 2002:a63:5964:: with SMTP id j36-v6mr5993849pgm.222.1536290132207;
        Thu, 06 Sep 2018 20:15:32 -0700 (PDT)
Received: from rodete-laptop-imager.corp.google.com ([43.252.149.35])
        by smtp.gmail.com with ESMTPSA id m21-v6sm8716577pgd.6.2018.09.06.20.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 20:15:30 -0700 (PDT)
Date:   Fri, 7 Sep 2018 11:15:25 +0800
From:   Benson Leung <bleung@google.com>
To:     Grant Grundler <grundler@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Ryan Lee <ryans.lee@maximintegrated.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bleung@chromium.org
Subject: Re: [PATCH] ASoC: max98373: usleep_range() needs include/delay.h
Message-ID: <20180907031525.GA28772@rodete-laptop-imager.corp.google.com>
References: <20180907002728.112770-1-grundler@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20180907002728.112770-1-grundler@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Thu, Sep 06, 2018 at 05:27:28PM -0700, Grant Grundler wrote:
> Commit ca917f9fe1a0fab added use of usleep_range() but not
> the corresponding "include <linux/delay.h>". The result is
> with Chrome OS won't build because warnings are forced
> to be errors:
> mnt/host/source/src/third_party/kernel/v4.4/sound/soc/codecs/max98373.c:7=
34:2: error: implicit declaration of function 'usleep_range' [-Werror,-Wimp=
licit-function-declaration]
>         usleep_range(10000, 11000);
>         ^
>=20
> Including delay.h "fixes" this.
>=20
> Signed-off-by: Grant Grundler <grundler@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

Thanks!

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAluR7UsACgkQHwn1ewov
5ljaCQ//Vj0U9MYJssR7jVXYrlHFK79ST8WCc4w4xL4ffdrmH9QyTx2dNu/mpwRu
v9YAAPTqwCsbuH4tTMbQXLB/gi9bTRhda3auqcYCdpLoJ7SWIScQDjTBSpDU0fe8
MU6IxI5Aq++p/mMo46OVhUwnqfdPXB/zjTPXpHPxB5Z2mGbFmYh8C1uuun1SMxvr
iJg0rZRoaABVFXW0pVC20levdAWDh0iax49XbYQswVIrfXQAXf2gSanfL/+SxOeW
D/228n9YZ8DUDB3rCs2E0FfhI/XqskgAXtXwHJ1QNTiYpdTTONphUBjPrTiD4Stv
bt5YR7A4XUFPhDgcU4Q6I54x3qKYk64i4PcEx9Mlz9XRvqmGrIr0FV3p7fjPklBh
WsKmaFStb9jdevEgBT87ZgsIupqGSp9A/FIGl1eI7726Ta6SOllBsVywjQ54k1VN
YkkQFfixRZeffUtYzHdDR+Qyoz1mg9zUSG4XdfsI75uRhZYX93Xn0N8SwOA2qwTP
CHdYf0NVWMTxxjbNyD7RIz5/j6y4T1PA9ISoRoJCrOZF9s0VYk6MXcJZej9938km
touyk4i0HsT88C76JBcuKlwbK9gGJw+4n2RaE/brJuHPZLtHKYDLQoDsDX1aZrPC
Gm8lXNDxwmLcdh60S0LObXeq14lYzzDg89kKAHTA/6zPfJ92Yfg=
=zIvs
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
