Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65C7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957E22087E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Nl7TIr+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957E22087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeKUPrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 10:47:12 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38262 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeKUPrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 10:47:12 -0500
Received: by mail-vs1-f66.google.com with SMTP id x64so2533415vsa.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 21:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yf+TiMjDAOBygPDZIX/LUh2h6lbo1zT2tA93KE961wU=;
        b=Nl7TIr+Ne5/ulFHdhVmjL6UmYcwlx868a4R3aVJCKuLCZkfFOuniggqwc3sbpoyCfX
         8nmBXnl2OkAmthGDM6Ia3JiA2RQabV8TfmT6I1IZmM2pRgpn2Fq8iY/63p8zvbH8iywt
         DAed13w7mn36ZKP3qRy6G+SUVvr1ut+tmTrs0VanlWrIzcwiJv8YUvsF2wKrMa4z2SZn
         7KVpHJvu79aS804NZwXS9eJyCL75iAOCQewpJs4S+VC5aBJdvG15FoaXW3EdumW5+EKJ
         jrzsSUNreyMW8B/lDxXdqcR1ZPNFB8r7dWWRKmipajtLNm+sxS1abVDPAuFY10eNYtDs
         4uNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yf+TiMjDAOBygPDZIX/LUh2h6lbo1zT2tA93KE961wU=;
        b=Twmgr+Ys2uuB907IAyDyWsjdAI1g/pRcNlYXMuutwh+8wXAk6mhmooQKdeGdW7Xwhn
         SYEz4poOZgbfwlKr7ki37FVuW52CB92i0pBfG9ZN8xyc7iMlNgHIr7vhPRBJJI0fFMS1
         h5dTuqhcz92QHGUnz3FYuMD1AiG4LITABGRLW/FBwzyYGX4Ar9+4ylsguALEnbDa+tNu
         w/XTulRYgy7W5mcXlwbLch9pnXKx/Es/NGPAgZPuuA6Vd1SLNDRCEueOye2CPnSHOXR9
         LbWwvE8sqik0pgqpi6ymwbAgc+2/bjUh4S1W2xraSdIiEwRItkW9lVN+E97sostPr8Hv
         E7zw==
X-Gm-Message-State: AGRZ1gJz5rrqLFQU1LsYveoz03jaVVvZzXYugvfFuY4nXnXDmEPUTk7C
        qSBVbUSD4TEQDdCcKnBLg9RlzLkl43r2aOYCCUpU6Q==
X-Google-Smtp-Source: AJdET5e7vBlKUc+yfCBvQhsSRHpILZHU77ivBekZtkUweqUzRAlsC5DVTF1QkDEl0vvQZa4vcUggOOEoLaPljmwUXhQ=
X-Received: by 2002:a67:8a81:: with SMTP id m123mr2149000vsd.206.1542777256943;
 Tue, 20 Nov 2018 21:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20181119061219.14238-1-jian-hong@endlessm.com> <04d0345d6c6c4ac0950ab0676ffd7689@SFHDAG2NODE1.st.com>
In-Reply-To: <04d0345d6c6c4ac0950ab0676ffd7689@SFHDAG2NODE1.st.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Wed, 21 Nov 2018 13:13:40 +0800
Message-ID: <CAPpJ_ed-A_mkPJieZA4pHaRbY0SGpOEXP04aY4g1b60PzMGQuA@mail.gmail.com>
Subject: Re: [PATCH] iio: st_sensors: Fix the sleep time for sampling
To:     denis.ciocca@st.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>, linux@endlessm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Denis CIOCCA <denis.ciocca@st.com> =E6=96=BC 2018=E5=B9=B411=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=883:05=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Jian,
>
> Not clear to me why should be + instead of *.
>
> ODR is expressed in Hz, so (1/Hz) =3D period in seconds (1 sample samplin=
g time) [s]
> 1000 * (1/Hz) =3D period in milliseconds (1 sample sampling time) [ms]
> n * 1000 * (1/Hz) =3D n times period in milliseconds (n times sample samp=
ling time) [ms]
>
> In your case you assume bootime is in milliseconds.

Yes, I assume that according to the original comment.

>Maybe we can change the comment and use 'number of samples ...'.

Making the meaning more clear is better.

However, does the bootime of the measurement need as the long time to
be enabled?
If the sampling rate is 1Hz and n is 2, then they will do msleep with
2000 ms for each st_sensors_read_info_raw.

Regards,
Jian-Hong Pan

>
>
> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> O=
n Behalf Of Jian-Hong Pan
> Sent: Sunday, November 18, 2018 10:12 PM
> To: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>=
; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmee=
rw.net>; Dominique Martinet <asmadeus@codewreck.org>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; linux@endles=
sm.com; Jian-Hong Pan <jian-hong@endlessm.com>
> Subject: [PATCH] iio: st_sensors: Fix the sleep time for sampling
>
> According to the description of st_sensor_settings and st_sensor_data str=
uctures' comments:
> - bootime: samples to discard when sensor passing from power-down to powe=
r-up.
> - odr: Output data rate of the sensor [Hz].
>
> The sleep time should be
> sdata->sensor_settings->bootime + 1000 / sdata->odr ms.
>
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/ii=
o/common/st_sensors/st_sensors_core.c
> index 26fbd1bd9413..6b87ea657a92 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -594,7 +594,7 @@ int st_sensors_read_info_raw(struct iio_dev *indio_de=
v,
>                 if (err < 0)
>                         goto out;
>
> -               msleep((sdata->sensor_settings->bootime * 1000) / sdata->=
odr);
> +               msleep(sdata->sensor_settings->bootime + 1000 / sdata->od=
r);
>                 err =3D st_sensors_read_axis_data(indio_dev, ch, val);
>                 if (err < 0)
>                         goto out;
> --
> 2.11.0
>
