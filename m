Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FEBECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7DF21550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSApUQ1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7DF21550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390505AbeIUV5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:57:24 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37651 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUV5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:57:24 -0400
Received: by mail-it1-f194.google.com with SMTP id h20-v6so2442728itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ufKt1o6XZWWhy3FWmpYRN0ahckMTjd9MIhEaFudp5K8=;
        b=OSApUQ1zEDDwwZ0GeHcXSxIWexaztneKskDPc+pbnAtP0kezLMvVPYZo+QqcjAUCkA
         a52Y8jyMaffid5eizbWYTu2Y+l7fYAI71+ZZmjxk6Lwj+S5UgZkOzDGJWc/s+TetD8Bg
         UdMZXvPQtdxCRXiCk4MZO40bhU2adaLZ0Y/cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ufKt1o6XZWWhy3FWmpYRN0ahckMTjd9MIhEaFudp5K8=;
        b=Jxdd8H1fAEz6d85928dFv9SyIBe8R9WruskdCo6nJ/v8zOZ3xvn4aXiZaCFmz+wHcl
         N4ZpfRZnE6lnKf7Wl1oqTJjioLM4bZtyoiCKBRTDofWHNzmP3oKXg2Fji7/36NkpiSTr
         zsZGw2uxLPUyPjW/r+McBlAK9VMdFcnDAUJBh2ygGGuWhrAQxMgpeYoSF42VTxsF9jFM
         7OLUINSARCqOTsZOasuOcGnSOFVL/vgNDPL/LS74QvBIAJoZSRFDsDQSu/SXw87DKIw6
         4pgMSFTkV5gl2dS7CPQYSf6GgW/Ixrc/Q+j10d0PI2CssN/oKre3UyeM7/GuboxScRj2
         H7oQ==
X-Gm-Message-State: APzg51DgojKlG/HUWFKPHMeiC5u+ru1RdwCI6SHAtMPu3Fxp4rf52aSC
        AhE9ZY4lYx8GHFPdhZIsocg2HFsAkb5w2rhDjwIneA==
X-Google-Smtp-Source: ANB0VdbBRhKxCUMOBmi+e0LiNpZFNHhuXAe+aPNDISxjHrogJMMoqOr67cOPgxQNC5VxgYZo5L1PhyDssynID1uSmX4=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr6588665itd.130.1537546070708;
 Fri, 21 Sep 2018 09:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180914070839.4667-1-ricardo.ribalda@gmail.com>
 <20180914070839.4667-2-ricardo.ribalda@gmail.com> <CACRpkdbqmK=MzGsOYLdtFO3AAbKHhzy_RD=Gr6wj3WnQunyCGg@mail.gmail.com>
 <CAPybu_0iDqSn02iGLEg8Ge9EdyCCNhRVV3JgHg180qrXK+bcdw@mail.gmail.com>
 <d84ee082-f578-3ed3-32be-dbeb9562980e@kernel.org> <CACRpkdYGpEVG9gqPxNaOsD55k9idEfGaxOUrObbN9VZS06x5jw@mail.gmail.com>
 <bcb79947-dfe0-e5e2-fb48-3b6992720f01@kernel.org> <CACRpkdbz0hyjy5U3-xo8Oi-ojB_H3=DEwuJtmoqJTJQNiAYYaA@mail.gmail.com>
 <27c8e13a-44bf-18b5-083b-25b87d7b8605@kernel.org>
In-Reply-To: <27c8e13a-44bf-18b5-083b-25b87d7b8605@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Sep 2018 09:07:38 -0700
Message-ID: <CACRpkdYV+A9rUZvYN_Vh3wD6Vb73qj8=SkHJCJ0ZiTWP5Ojw1A@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Show correct direction from the beginning
To:     timur@kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 7:05 PM Timur Tabi <timur@kernel.org> wrote:
> On 9/20/18 5:36 PM, Linus Walleij wrote:
> > What I mean is that $SUBJECT patch might not hurt Qualcomms
> > GPIOs (not crash the platform) if and only if it is augmented to not
> > try to get the initial direction from lines masked off in .valid_mask
> > if .need_valid_mask is true.
> >
> > Whether it makes sense semantically is a different debate, but it
> > seems possible to reintroduce calling .get_direction() without
> > hurting anyone.
>
> That means that all the logic for checking valid_mask needs to be added
> to the chip driver's .get_direction() function.  We can add that logic
> to msm_gpio_get_direction (at one point, I had a patch that did that,
> but it was rejected).

Nah, what is in patch v2 is better, just checking it when we need to.

> My concern is: what if a driver depends on a .request call being made
> (in order to configure muxes, for example) before touching the hardware?

Hm. That is a good question.

I wonder if we have that problem in practice. If this happens, maybe the
driver needs to keep track of stuff a bit. I think if we just loop request
over everything we could disturb other mux set-up.

> I wonder if this is something that really should be handled in the
> driver's .probe function.  The driver should collect that information
> and pass it to add_data.

I see the idea, but it seems complicated compared to just calling
the callbacks. Let's try the v2 patch approach first.

Yours,
Linus Walleij
