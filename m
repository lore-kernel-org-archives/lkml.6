Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859C2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1CC2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtMvpaEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1CC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754749AbeGCJqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:46:54 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36829 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754576AbeGCJqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:46:51 -0400
Received: by mail-qt0-f194.google.com with SMTP id f1-v6so979325qti.3;
        Tue, 03 Jul 2018 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asYnOoOOGsA1RefRlJASHBR+HYhPpzPMD9WAvebcEU0=;
        b=XtMvpaEAyFTn47NHRNiqIl4SLeTGfmm2hZsmCYzHLDIiHilfaKY6tMbEsCMtr20w1n
         3q7uV5tamAxNNH4v4VlRBym3+4YLZkfdhlS8zE4CfsG4zpoMR5lZCQpskqm/y9jds8Fu
         mhj4xwb3jLXIyFih6/tddppR8V5TI7447I1irP5G2ol7gn0EZHRuowo4HQVVrfvMKfET
         TYy3zjB3vfR9uMTR/8Bk7jxckCtOSfo1asxoHOb8mZ3KGMcNeuAyDfsBcdxT4U0OAYOK
         9wx8ujKPGKSIwYeqGr2i3HV/RaE/YIZduKK2fP+wP6hLISqo4XR57vu8iuxDVIBCLI7R
         GCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asYnOoOOGsA1RefRlJASHBR+HYhPpzPMD9WAvebcEU0=;
        b=TMcVtgMoo6sxV7RhTsluQwR61VHoxodseGAGPrjftvPjw3HD2EeHtd7hZJejm2eEP6
         G+0VhCpylHNJHjq8MtMbATq7fuuwyKhBJ8bJjfLuXIMA11zNA1Cprclz5vLW3vMonIBQ
         vo7s8j1QvZB07Aen2MimYNnUy+zjJgyLyVpXbIDJ8fKYMo4g6S9hx0DbXBEHygOZYcW4
         ywbdHF40+GY/Q5btfQlE6fiFcClT47ffnJZB+ZzYNq4kXGg+lDRIlYFbD8SOUfLCL9DP
         gQ6dqyLopE6lLWisIsnN1A/Q0c/PshYcBRdt+iunkOvccPlpjv9b3B6KapraAtPjjaPp
         ppyQ==
X-Gm-Message-State: APt69E1tNxHB/fZpQiOz+XgoNG1rx+aKEC3vXaMRrA/HsqcAbyvloj7e
        9TB7pM3pWmipy7nRfV3OgQUOTmoVfca5BUxSlD8=
X-Google-Smtp-Source: AAOMgpe9Yod0b7YpEAwKQrHAiuTL8uR7gCfjeFIQ7lsZ/f7cNgnVc+RJ5XxoCOnJzqLFQUJbkiUxgpq1xu6+ucIaYOg=
X-Received: by 2002:a0c:b131:: with SMTP id q46-v6mr21745639qvc.168.1530611210492;
 Tue, 03 Jul 2018 02:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180502154418.2153-1-enric.balletbo@collabora.com>
 <20180502154418.2153-3-enric.balletbo@collabora.com> <20180524083420.nna6znszz2lp6jwo@earth.universe>
In-Reply-To: <20180524083420.nna6znszz2lp6jwo@earth.universe>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 3 Jul 2018 11:46:39 +0200
Message-ID: <CAFqH_53wvx+v8fLvcg3HaZ6OsAW2itHGsbhU+YPpLRyF0Upz6Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] power: supply: add cros-ec USBPD charger driver.
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        kernel@collabora.com, Fabien Parent <fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee, Sebastian,

cc'ing Fabien

Missatge de Sebastian Reichel <sre@kernel.org> del dia dj., 24 de maig
2018 a les 10:38:
>
> Hi,
>
> On Wed, May 02, 2018 at 05:44:17PM +0200, Enric Balletbo i Serra wrote:
> > From: Sameer Nanda <snanda@chromium.org>
> >
> > This driver gets various bits of information about what is connected to
> > USB PD ports from the EC and converts that into power_supply properties.
> >
> > Signed-off-by: Sameer Nanda <snanda@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
>
> I suppose Lee's Ack was mainly for the no longer relevant MFD part
> of this patch.
>
> > ---
>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>
> I would be fine with merging this for 4.18, but it has a dependency
> on patch 1 for MFD. Lee, can you provide a immutable branch for
> patch 1?
>

I guess I already lost the open window to see these in 4.18. Doesn't matter :)

These patches now are blocking [1] to land, and also I have some
patches close to be ready to send that apply on top of these two
patchsets. I think both patchsets are fine so would be possible queue
all these patches for 4.19 and maybe create an immutable branch.

Many thanks,
 Enric

[1] https://lkml.org/lkml/2018/5/29/1328

> -- Sebastian
