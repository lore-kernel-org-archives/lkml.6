Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2F4C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AD22082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjrVkQc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AD22082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbeKBBWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:22:38 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34865 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeKBBWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:22:38 -0400
Received: by mail-it1-f193.google.com with SMTP id p64-v6so2783048itp.0;
        Thu, 01 Nov 2018 09:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=85Mfoaf5xDXSJPwVPluH7KDZZe4cuM/XzCPr4Nl+d8I=;
        b=fjrVkQc6OezHSxZ8iRcDrZPuPSBce6TRNrJIc9VzSTyH7+mlHAUWf+kQxXXG2WLxaB
         2VHLSWtmDC3Uajw+WKaqMsPpDjk+TlyfonUIkhPA5FXB9BPU13M8nD7CfUsrXLu5tEqX
         Yotq0PvagmGm8oiNbBq3iLSmFFLWTHAe2xrCGtsgNpgqT/XfzcW/AX9ULb0l4dfV0y+y
         v5ZUAn1d9nt/uVc3miN9ex3Hslxfv+czjMowwWrMKG4AUquQOBzctl+elmbfJiuGAlsT
         aFpcB1TCE3aCSWNhvun0f4Z4Gvnbl+YCfgXHMYbt7BPkETnYK1DxEX7HOxl5U6sE+XRw
         HYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=85Mfoaf5xDXSJPwVPluH7KDZZe4cuM/XzCPr4Nl+d8I=;
        b=P8s9DYvHaW8+AcqsOVqg9S4lWPbGcI3aYECsc1rM9kxooFD7JN5BQwUDi0I1kpzUHu
         TyGkS5a5UVDf2mXujplhCYVyBBPIDRGcBw8oBfXSAs7NI/pCJEEjV1v34tJq7nSMBHAK
         wpaG7Zp1NFeclq+FP3FFb4WfqRvW7hF+vUumPpZhYO5r9SuJ7syx8b9bsGBTJLgnZleW
         Da4BfaQTRBbnRZUxK2/ZIgcObriBmCVZZ+bacAK7Gdm5WXFLjGl0+xUNR3Abij+S3uXb
         DA1/0b8xOnemo3+Wd0fZf38zU9qVSkvQ8iD3xXiSnl3WLvgWUH85Od2HL7iAM2aWFr9Q
         Sacg==
X-Gm-Message-State: AGRZ1gLo+tQ4TuDlJ6KWo+7L+N60eUvZesS8XWtNxIVMMHqE4bCsUwoF
        dy5AnoJ7Q3hlq/14K5PsFz7jm/zzHL+/RdrUBeDQLswuL9p5jQ==
X-Google-Smtp-Source: AJdET5dMK2yXvJCBipsI7FICzVeuDWA7oR49AQhwwFiCuTq9Wr6x/aBV1Al6Qrjl7hfScLONS6bIEjCua6K/dfbAxTM=
X-Received: by 2002:a02:5748:: with SMTP id u69-v6mr6407747jaa.30.1541089139556;
 Thu, 01 Nov 2018 09:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181101153749.22935-1-tiny.windzz@gmail.com> <5544442.bXqbKBZQMR@diego>
In-Reply-To: <5544442.bXqbKBZQMR@diego>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 2 Nov 2018 00:18:46 +0800
Message-ID: <CAEExFWsO=piLg_JCCKTH6p49f+RT8qDzii6iwjHuTcwd8j0Okw@mail.gmail.com>
Subject: Re: [PATCH] i2c: rk3x: fix some typo
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>Am Donnerstag, 1. November 2018, 16:37:49 CET schrieb Yangtao Li:
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
>while the changes really are pretty self-explanatory, it is always
>nice to describe changes in a real commit message, like
>
>Fix multiple instances of a misspelled "Calculates".
>
>Change itself looks good, so
>Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
>
>Thanks

Yeah,this is my fault.

--Yangtao Li
On Thu, Nov 1, 2018 at 11:56 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Donnerstag, 1. November 2018, 16:37:49 CET schrieb Yangtao Li:
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
> while the changes really are pretty self-explanatory, it is always
> nice to describe changes in a real commit message, like
>
> Fix multiple instances of a misspelled "Calculates".
>
> Change itself looks good, so
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
>
> Thanks
> Heiko
>
> > ---
> >  drivers/i2c/busses/i2c-rk3x.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3=
x.c
> > index b8a2728dd4b6..fe347e8e2a23 100644
> > --- a/drivers/i2c/busses/i2c-rk3x.c
> > +++ b/drivers/i2c/busses/i2c-rk3x.c
> > @@ -555,7 +555,7 @@ static const struct i2c_spec_values
> > *rk3x_i2c_get_spec(unsigned int speed) *
> >   * @clk_rate: I2C input clock rate
> >   * @t: Known I2C timing information
> > - * @t_calc: Caculated rk3x private timings that would be written into =
regs
> > + * @t_calc: Calculated rk3x private timings that would be written into=
 regs
> > *
> >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In=
 that
> > case * a best-effort divider value is returned in divs. If the target r=
ate
> > is @@ -716,7 +716,7 @@ static int rk3x_i2c_v0_calc_timings(unsigned lon=
g
> > clk_rate, *
> >   * @clk_rate: I2C input clock rate
> >   * @t: Known I2C timing information
> > - * @t_calc: Caculated rk3x private timings that would be written into =
regs
> > + * @t_calc: Calculated rk3x private timings that would be written into=
 regs
> > *
> >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In=
 that
> > case * a best-effort divider value is returned in divs. If the target r=
ate
> > is
>
>
>
>
