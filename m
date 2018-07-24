Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DDBC6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31EB20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JBIBzkaH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="foB+saIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31EB20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388565AbeGYBFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:05:06 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:45279 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388536AbeGYBFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:05:05 -0400
Received: by mail-vk0-f66.google.com with SMTP id b78-v6so2931077vka.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 16:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=13suI+NySlNOezUVpqPUPtUeoenar1/HobLOiyny9gQ=;
        b=JBIBzkaHg7llrQG/gCyJoAhb8aGhVq78xsWBdMQoioqseGnsctYqlz4m3C8ZwW/1mY
         kUzLfeMfc6ekwHy37V5BskuYESLQuqsRJ6kUBgII1fnNxvXCPLjPHloGmuZQbzqNK0A6
         WpsVkQfKetH/R9z+P6xisj92OoTrrtE1H/FYVgf2BjAxPYWotxLj4eqnnMEZqyzWVLti
         3KdMr/yu2h2b+rS6vRwsdkHZbEh1FnuvqrUN0h8Qwpmpa+Q9p84daHN8V85GewXx918U
         8LqqGEIH9Uj1PPd5ZnlKt14RSvX8UZzdzp2QcXxBIfWuqDGZY5v9wx5Fc44facB8mZat
         dlxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=13suI+NySlNOezUVpqPUPtUeoenar1/HobLOiyny9gQ=;
        b=foB+saIWzYNl8pZ0ImqhswmvH54Asl/vkYtoD14Y/dDvHi97CR3tNBK3jjYEvjTPnL
         ZnIeDDkUsLo5uQbZxVJx6JmMGfSPiSNhecsB2MNSucKv+Aq/fkNLrJ4hizKLoB4CWmeE
         dxxcW7mamyYHVQFexi0DLG9ZobNe9dBUkvzis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=13suI+NySlNOezUVpqPUPtUeoenar1/HobLOiyny9gQ=;
        b=KlGa90zbFXjE0/f1xUf94QPePbckoz/Kmu/5YKvh3RwIiXJI6i9QekJY0C0eme6eV3
         fj3bS43ZqGEZCggI+3bcvt1ZAXDoSy86W9Wc/waoiPSQMn3+Y/SeD75hgcu2YvzliBdP
         koK1N3dPLYJeTSyOTnza9e+ol8yN5JeN3JmOOYXdtjuS0Ut1jvKEwrrWIYS/rwUTVl9b
         HdcAibUDjrdoQOWcTECUOBuOLqqEKjjZ/1v78Vt/DBU013CpOgqX5q0Yr92ZI15qRwaM
         46swSeKtFulrdA6MjFtdjeiKEUCblCYJUDxezldcjeTxNaJ202N3vJiAOHqSp9YwLsIv
         EwrQ==
X-Gm-Message-State: AOUpUlGjVzEgoGyV4CjelhzEwweVeqcwQYb3BbhTqkZZE0Y+SUFBg2fD
        G0bpRNC06DZaJoudSJGn/z6IvWwVBvEnTKZX6BHOxA==
X-Google-Smtp-Source: AAOMgpfLh9zy4ukORwfQRyTkHza/OsGO1qQ0EMwzhz8N/tHdmu5j9fGpzeIN450zskimQ2/Cx5rFlJxQfp/9lLFRLQY=
X-Received: by 2002:a1f:a784:: with SMTP id q126-v6mr12093472vke.70.1532476568673;
 Tue, 24 Jul 2018 16:56:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 16:56:07 -0700 (PDT)
In-Reply-To: <20180724071223.18901-1-daniel.thompson@linaro.org>
References: <20180716210241.9457-1-daniel.thompson@linaro.org> <20180724071223.18901-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 Jul 2018 16:56:07 -0700
X-Google-Sender-Auth: TORWiFlUHDz8ZqXn0vLQxeyJku4
Message-ID: <CAD=FV=W9WZVS28++mF+yOCREW3iHWahJuAx=ySODA18ResDXog@mail.gmail.com>
Subject: Re: [PATCH v3] backlight: pwm_bl: Fix uninitialized variable
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 12:12 AM, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> Currently, if the DT does not define num-interpolated-steps then
> num_steps is undefined and the interpolation code will deploy randomly.
> Fix with a simple initialize to zero.
>
> Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
> brightness-levels")

I think it may be incorrect to word-wrap the Fixes line.  A quick grep
through the source code looks like others agree.

> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
>
> Notes:
>     v3:
>      - Switch to the simplest fix and zero the uninitialized variable. git
>        grep indicates that ~25% of calls to of_property_read_u32() use this
>        pattern (pre-initialize optional properties with sane values and
>        ignore the return code).
>
>     v2:
>      - Simplify SoB chain (with Marcel's permission)
>      - Separate complex if statement and make other similar calls use same
>        return code checking approach
>      - Tidy up comment formatting and fix pre-existing grammar error
>
>  drivers/video/backlight/pwm_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Other than the nit on the commit message, this simple fix seems sane.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
