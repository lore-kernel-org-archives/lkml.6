Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B70C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0915B2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndaA3WRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0915B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeLLLHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:07:36 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37726 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbeLLLHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:07:35 -0500
Received: by mail-yb1-f195.google.com with SMTP id f4so7483021ybq.4;
        Wed, 12 Dec 2018 03:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rmXM7vJPFGhzp4/UIOP/orO+Gdxk0SXT7YF7+cHL0gs=;
        b=ndaA3WRwYlgg13FjRVMHpM0ymT1LKN5aL+/R59q24MhSgItKEddp+RfBzhJ8WREtt6
         wzULqiMYi61+LYkt1+VoB/n+6Fsmyg52XDl1fMLcz1Ht1+sO68/+ZTuA1uE68NpHBKoB
         PxqG2wQM6Wd6M2Kzpt/V4yODwIWNS9gyZA7waCUELSyGPbDCAMfumql+8xkedzDi7Van
         htgBRHsNI+pR6dN3D9o+gIIEgMvv/chM16Ib1wwPEFmqA1M1Vi+HU5dxRDQ26XGj6RNz
         PFpr69kajdkRHBkRvneo/G0ntP+MDM/L4WACX0TkCgJb6bR4GFO3kwQcnxL25uN6qIsV
         233w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rmXM7vJPFGhzp4/UIOP/orO+Gdxk0SXT7YF7+cHL0gs=;
        b=Y1Yj3iztPvSBGHTDi4rZyF2X5R+BjJtk0FIocUVGRiiMJdCuBzUY1WUKajyFXQUjKy
         9WtbFhEDgqjib+FEulcTSVXksJjtMrptExovKVPy9qDSzXBn6AfcjqF2dFUQ150/3Zn0
         y1WvesF6Rg2r8ApuLr+WgDLXitxY8UEyOnSvga58vgYD9M8iBxLOBJbEir+8uH71ma78
         6hhfe+vWsYl2I6mpgQ3bJHGsRgeJIPAoFMUzj401UObMaslTB8s6fggl7C9gzKXGRtpy
         L6EN9C8/WXDEBXBLEVOT2a8omo79D7+kLrcedEPC7IeNVB7I8Yx52TbYDLU8GO0yQNRa
         4UHA==
X-Gm-Message-State: AA+aEWb3l+1q2d5W7tlSYn1zwN/X2aZnjy7izWpakUDPg73PvHxFTxDC
        YKl3btbrzKTi49ICMWKUoOA6o/7Uev08lxC8Nxk=
X-Google-Smtp-Source: AFSGD/UFGHD+c9InxVqgcgBs70Y28ufwfnEZRR29FNu+T9u77I/OUkMxdonDHBnsrleN5YQ0H3zpezzK45vTwVoYwfE=
X-Received: by 2002:a25:9744:: with SMTP id h4mr19012085ybo.416.1544612854245;
 Wed, 12 Dec 2018 03:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20181107093613.26734-1-peron.clem@gmail.com> <20181107093613.26734-2-peron.clem@gmail.com>
 <20181212110446.GF17654@ulmo>
In-Reply-To: <20181212110446.GF17654@ulmo>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 12 Dec 2018 12:07:23 +0100
Message-ID: <CAJiuCccG+NtaDF70_4bJwgBCKAKxiE8379h=6qkN8OAQ8rjKBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: bcm-kona: apply pwm settings on enable
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suji Velupillai <suji.velupillai@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On Wed, 12 Dec 2018 at 12:04, Thierry Reding <thierry.reding@gmail.com> wro=
te:
>
> On Wed, Nov 07, 2018 at 10:36:13AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Suji Velupillai <suji.velupillai@broadcom.com>
> >
> > When pwm_bl framework calls enable, a call to pwm_is_enabled(pwm) still
> > return false, this prevents the backlight being turn on at boot time.
> >
> > Signed-off-by: Suji Velupillai <suji.velupillai@broadcom.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/pwm-bcm-kona.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
>
> I see v2 and v3 of patch 1 of the series. Did you work on v2 of this
> patch (2/2) as well? I don't see it on the list and it didn't seem like
> everyone was happy with this version.

No, I dropped it.

Was working on an atomic convert of the driver but I don't have access
to my cygnus board anymore.

Regards,
Clement

>
> Thierry
