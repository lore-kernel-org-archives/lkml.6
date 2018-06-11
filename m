Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C2ECCC004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7616E208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bMWUhoNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7616E208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934027AbeFKVXo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:23:44 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40144 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932474AbeFKVXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:23:42 -0400
Received: by mail-ot0-f194.google.com with SMTP id w9-v6so20065256otj.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rm/PlapAOTZU/Itlig5FNjZj1VTUK0u/+wX9QuDVEKA=;
        b=bMWUhoNl+yG56a+S7qMpVaMUq9tgiJQTAtD5mnNY7JpXoWHgYCXVq8nCcdZTnjfmQB
         3iRRGrRLfqRzAtzNmG/X1d9I9ATLa+Gzf+7NiSl7wXpLOrrr+IRFNGU0EJcVSqq68ai9
         0kDz2wX5WRqCQAYsfR7QIoq7eH4SKcV4673Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rm/PlapAOTZU/Itlig5FNjZj1VTUK0u/+wX9QuDVEKA=;
        b=VRnU5NsEm/AjuqqZ7uKt8NB0fvuRNYsVQ0mWLx0obKJgiTKD+gYJ/s3ExHbvjlX7Gj
         k3ZPFbLfoxkF/eMKRbRQC3mekJvT0XI1c0HdTnLFxrkcQYnP7v8tgNVuAOdG9QfRee28
         qoGh35rQin8dDF3dNMT5jdaWwRQsHK+v+5znw4rt2RdIg3M2+ptM9ucTGEhRDYfllMDA
         fjZAXCVyf5R0Vnx7gRVQwF0MO5AQZrpgdgMkv8M9j/6jdNPG/YqivAs6CQD3f9U8oUGK
         HqUB3OmHuP8DrFZndIjWGuA6EwZeQAOyFRk+4E8S7NoJ4AV/ndKXm7BoY33pzeaaiawd
         e3Ew==
X-Gm-Message-State: APt69E2FnfiOKoVUbLWPLB8E/q3cYLYeM4hOfRLc6c5Lwc1IwXWy4ANq
        7QLLkrPY8mK6cw+zDrMOIDsTVOjMzh0=
X-Google-Smtp-Source: ADUXVKKXWEePEa/Ws9P6FOoORFvN5qyC+qHcZ1bgS682SX46wBEbvAH7M1jlzW2EIH1n4IPOqAB9UA==
X-Received: by 2002:a9d:53ca:: with SMTP id i10-v6mr570338oth.188.1528752221865;
        Mon, 11 Jun 2018 14:23:41 -0700 (PDT)
Received: from mail-ot0-f173.google.com (mail-ot0-f173.google.com. [74.125.82.173])
        by smtp.gmail.com with ESMTPSA id w39-v6sm21814345otd.13.2018.06.11.14.23.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 14:23:40 -0700 (PDT)
Received: by mail-ot0-f173.google.com with SMTP id 92-v6so25542232otw.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 14:23:39 -0700 (PDT)
X-Received: by 2002:a9d:4c86:: with SMTP id m6-v6mr546985otf.273.1528752219355;
 Mon, 11 Jun 2018 14:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
 <1527587561-27448-3-git-send-email-vviswana@codeaurora.org> <e0157064-1dee-e3a6-e4a5-5d5f12d629e8@intel.com>
In-Reply-To: <e0157064-1dee-e3a6-e4a5-5d5f12d629e8@intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 11 Jun 2018 14:23:02 -0700
X-Gmail-Original-Message-ID: <CAE=gft41G9tBHORVMeN1PbwLut+E2m2q1wcQ3G5bVHDZnhYXAg@mail.gmail.com>
Message-ID: <CAE=gft41G9tBHORVMeN1PbwLut+E2m2q1wcQ3G5bVHDZnhYXAg@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] mmc: sdhci-msm: Add msm version specific ops and
 data structures
To:     adrian.hunter@intel.com
Cc:     vviswana@codeaurora.org, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        riteshh@codeaurora.org, vbadigan@codeaurora.org,
        Doug Anderson <dianders@google.com>, sayalil@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 11:32 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 29/05/18 12:52, Vijay Viswanath wrote:
> > In addition to offsets of certain registers changing, the registers in
> > core_mem have been shifted to HC mem as well. To access these
> > registers, define msm version specific functions. These functions can
> > be loaded into the function pointers at the time of probe based on
> > the msm version detected.
> >
> > Also defind new data structure to hold version specific Ops and
> > register addresses.
> >
> > Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> > Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> > ---
> >  drivers/mmc/host/sdhci-msm.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> > index 4050c99..2a66aa0 100644
> > --- a/drivers/mmc/host/sdhci-msm.c
> > +++ b/drivers/mmc/host/sdhci-msm.c
> > @@ -226,6 +226,24 @@ struct sdhci_msm_offset {
> >       .core_ddr_config_2 = 0x1bc,
> >  };
> >
> > +struct sdhci_msm_variant_ops {
> > +     u8 (*msm_readb_relaxed)(struct sdhci_host *host, u32 offset);
> > +     u32 (*msm_readl_relaxed)(struct sdhci_host *host, u32 offset);
> > +     void (*msm_writeb_relaxed)(u8 val, struct sdhci_host *host, u32 offset);
> > +     void (*msm_writel_relaxed)(u32 val, struct sdhci_host *host,
> > +                     u32 offset);
> > +};

Since you removed the implementations, and these are also trivial to
re-derive, I'd suggest removing msm_readb_relaxed and
msm_writeb_relaxed members from the struct. Other than that, you can
add my Reviewed-by.
-Evan
