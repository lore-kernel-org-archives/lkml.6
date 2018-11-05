Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95681C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD8020827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1vPWDWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD8020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbeKFBUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:20:35 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33275 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbeKFBUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:20:35 -0500
Received: by mail-it1-f195.google.com with SMTP id p11-v6so8052998itf.0;
        Mon, 05 Nov 2018 08:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxIPlcSNGoybxmAmaq0nhuvSvQfnw2nMfZ8XytkklR0=;
        b=A1vPWDWNTM3fo6UavUzlhlixlUX+YL/6SmgqvrYV8AkpGf5hN4POgGBElt25IRfp6k
         BwLi714b1od+R7qgRhDggcFF2jR8lfsOPgv+BkT8CHioL5Xq1xfNbVTbgrzh6+h+m0g4
         U9QLMdDOtJ8KrpK9M6izLQQ8RzAU0eq6SHWyOhKABDHB70R/rXGbLfjo1H5dcNlRD3b7
         vDFZw/H6aug/5iGf9WRuj6nD8Eu14qUngJIC9nbLFwQjngJ7ajP273RuSazF64n/jTBh
         q25V5IO9LEdpOp0mr0Z21VnK/XDhGZrKKpkM4hvTDQsw5vZXNWhoL4vlPZox0K+qAQeT
         alXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxIPlcSNGoybxmAmaq0nhuvSvQfnw2nMfZ8XytkklR0=;
        b=nTTJCvrQIMHi8D6qay0qZLbSdl55XL3fxJ07g7VI0deTbXIzzmdwo4FNXLAy07+xfM
         kxEz1AUOEG4N4G5pIXF31T/LfyCqyT4aeQUey5e4o8rfAI8I/nC6ZENx9EvAirXXY3Kd
         FaKHKGxIMCQw2Ke1r08wdvxdbkqvYikG10Y+KtsK03vPvGKDqD3V8Da8o3+CW+/gNcaG
         fq9CYsnE8p+4KyRgUSPSNWQ1A4TnnEmwspU9r1ZNmDLM6JIxB6iswr0h2/h8SNIOFtLF
         SNRNl7Ea2h3XSAkohhK6z+5KNFQ83/z/YFpNltxzvg4p66Z06r4ziZJ1TMYJUDUtIQTc
         IsAw==
X-Gm-Message-State: AGRZ1gJsvzd6K2OOiTIG8aKtrC9CgC1abIUmIsHt4eJ/+4/kfskH88+2
        sw9Ti20Ai1Hxw+WOavyZ0I/Hq9G39oa9jT4ShO4=
X-Google-Smtp-Source: AJdET5caGsQPcJJAwg6K1rX4bdD04wGfGnOKKi1/ik6AXVKtFwnhtRmSLglql6hFAJNKgoDLqFTNNG8k+8Ua02WlWbU=
X-Received: by 2002:a02:2b29:: with SMTP id h41-v6mr20317596jaa.12.1541433613024;
 Mon, 05 Nov 2018 08:00:13 -0800 (PST)
MIME-Version: 1.0
References: <20181102124535.24331-1-tiny.windzz@gmail.com> <19a28033-9241-1f4e-97cd-7c6648a73c6d@axentia.se>
In-Reply-To: <19a28033-9241-1f4e-97cd-7c6648a73c6d@axentia.se>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 5 Nov 2018 23:59:58 +0800
Message-ID: <CAEExFWtQrPD8hUn15Add-EuueCL5=Crb+yvDckWejG75BExGug@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: rk3x: fix some typo
To:     peda@axentia.se
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry.
-- Yangtao
On Fri, Nov 2, 2018 at 8:58 PM Peter Rosin <peda@axentia.se> wrote:
>
> On 2018-11-02 13:45, Yangtao Li wrote:
> > Fix multiple instances of a misspelled "Calculates".
>
> Yes, it sure is hard to spell "Calcluated," it's almost impossible to
> get it completely right and not introduce another typo somewhere... :-)
>
> Cheers,
> Peter
>
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > Changes in v2:
> > -add commit message
> > ---
> >  drivers/i2c/busses/i2c-rk3x.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> > index b8a2728dd4b6..fe347e8e2a23 100644
> > --- a/drivers/i2c/busses/i2c-rk3x.c
> > +++ b/drivers/i2c/busses/i2c-rk3x.c
> > @@ -555,7 +555,7 @@ static const struct i2c_spec_values *rk3x_i2c_get_spec(unsigned int speed)
> >   *
> >   * @clk_rate: I2C input clock rate
> >   * @t: Known I2C timing information
> > - * @t_calc: Caculated rk3x private timings that would be written into regs
> > + * @t_calc: Calculated rk3x private timings that would be written into regs
> >   *
> >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
> >   * a best-effort divider value is returned in divs. If the target rate is
> > @@ -716,7 +716,7 @@ static int rk3x_i2c_v0_calc_timings(unsigned long clk_rate,
> >   *
> >   * @clk_rate: I2C input clock rate
> >   * @t: Known I2C timing information
> > - * @t_calc: Caculated rk3x private timings that would be written into regs
> > + * @t_calc: Calculated rk3x private timings that would be written into regs
> >   *
> >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
> >   * a best-effort divider value is returned in divs. If the target rate is
> >
>
