Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FF2C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455F4218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549890889;
	bh=TN+BubERB3I5NOBJmQTtvcaRHxKQClk9UEUsPWYEEfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bO+cMOD931pS+P4u4e9rqzTXWkai+F609GATHRJ8joF70p5or2PiUZdx/k1BkAR1V
	 75kVtRWL0CawDJ5SU+tO5IJx2dnyHvHd8cbyH4+HtLyQT6xAhMPxiBE9SxWIqaa+IB
	 2kePEfBlSFU6hNEJ9EMBfW3+bwpjn58Drqj9o/yQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfBKNOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:14:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfBKNOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:14:46 -0500
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 950B721B18;
        Mon, 11 Feb 2019 13:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549890885;
        bh=TN+BubERB3I5NOBJmQTtvcaRHxKQClk9UEUsPWYEEfQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qFQBLmoAxPSziAppKfN6yB9WzIQDNvqAAiU7dWeVOGj/uI6c0OwFfpk6Vh9RgYntp
         +7kdDV6tJeNc/hZ4fA6YNoSyTnnKnt4COVDQLFRA6udLIDv6ck+i0YX4JbVT4msRT8
         Vk/ctX6e7IsXCvhKBJYiGsIKlK1yapJl/NwWQLfA=
Received: by mail-lj1-f176.google.com with SMTP id r10-v6so8713207ljj.4;
        Mon, 11 Feb 2019 05:14:45 -0800 (PST)
X-Gm-Message-State: AHQUAuZh3SxcrAdaGHyziN1Hc8w7seSv8gm9YRchA7ccfsILgE42h7FW
        Ai+iKET3+3p/35tiq5oIv7Pn1Asm1pfZL0iK/dA=
X-Google-Smtp-Source: AHgI3IZWe9p3VpX/yp1W80oq+JFBwQdlC2KNatt/vGkhVm7OVcKBt9uG3/KvkKbQ7mqRQUbF13bcBmB14Lvm5bO5ysw=
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr18765720lja.19.1549890883699;
 Mon, 11 Feb 2019 05:14:43 -0800 (PST)
MIME-Version: 1.0
References: <1548761153-28114-1-git-send-email-krzk@kernel.org> <20190201092114.GE783@dell>
In-Reply-To: <20190201092114.GE783@dell>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:14:32 +0100
X-Gmail-Original-Message-ID: <CAJKOXPc_aXh4r7h41dMZLe-zzpxbf3LQr4AixFSQZUxpjhVASw@mail.gmail.com>
Message-ID: <CAJKOXPc_aXh4r7h41dMZLe-zzpxbf3LQr4AixFSQZUxpjhVASw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mfd: sec-core: Cleanup formatting to a consistent style
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 at 10:21, Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 29 Jan 2019, Krzysztof Kozlowski wrote:
>
> > Cleanup the formatting to have consistent style across the file (only
> > white-space issues).  No expected difference in code.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/mfd/sec-core.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
> > index e0835c9df7a1..c3bb53f79e63 100644
> > --- a/drivers/mfd/sec-core.c
> > +++ b/drivers/mfd/sec-core.c
> > @@ -70,9 +70,11 @@ static const struct mfd_cell s2mps11_devs[] = {
> >  };
> >
> >  static const struct mfd_cell s2mps13_devs[] = {
> > -     { .name = "s2mps13-regulator", },
> > -     { .name = "s2mps13-rtc", },
>
> I prefer one liners to remain on one line.

OK

>
> >       {
> > +             .name = "s2mps13-regulator",
> > +     }, {
> > +             .name = "s2mps13-rtc",
> > +     }, {
> >               .name = "s2mps13-clk",
> >               .of_compatible = "samsung,s2mps13-clk",
> >       },
> > @@ -114,7 +116,8 @@ static const struct mfd_cell s2mpu02_devs[] = {
> >
> >  #ifdef CONFIG_OF
> >  static const struct of_device_id sec_dt_match[] = {
> > -     {       .compatible = "samsung,s5m8767-pmic",
> > +     {
> > +             .compatible = "samsung,s5m8767-pmic",
> >               .data = (void *)S5M8767X,
>
> All of the other changes are fine.

OK, let me send v2.

Best regards,
Krzysztof
