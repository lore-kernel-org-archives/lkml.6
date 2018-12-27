Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6BEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0E421741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBwFrKgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbeL0IDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 03:03:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34822 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeL0IDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 03:03:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so17521444wrb.2;
        Thu, 27 Dec 2018 00:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXaipZicuaA3PxmcnsRTC44H8F4Ri9DgI3x3aUybNYg=;
        b=KBwFrKgj5lyUpNQ62v9jc36LU4zWga+GAXj++ueulmGgv/V6f/z1tDobaR7WVwld9t
         jOH+tHjVxNwEdT/kLuPODHHGYSZHNv9RNbLVZ2PpNHVreObDgZl9zV+sa5NZaOQTWRKO
         a+staD/ljZHaRBEhUncJ/fUUNnkl2E6+2M0PV0ZcyWIAlFbF8l5s4BiXqvy37O9z6gMj
         AFhtMFq9EGGDW02ZDzUK4f/IVTyCUhLZH8AHbPQd5ncmpKDybkQOZu2kczOgWy89H+lC
         MQVhgtOC+KJPjki7v4l5wwWeXPRC2gTB6xgHPHEKmn52OMXFOcIZmCKzmiSxTprYtMWM
         b4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXaipZicuaA3PxmcnsRTC44H8F4Ri9DgI3x3aUybNYg=;
        b=h/sGyEPKPerZZS2Tw4fUxkc8ywu0iNq8KzcpiYQbRpUp2aqmM+8XpDD1qFmWurTTHG
         IJ/zp57A5joHRVOjFVundjzFnIOHFd4GVZ0NoDcLJoP8fpN37Adb0LuSvcOZZWehLeGT
         lYyV/PWPJ53aDndxJp5Tk6XMvlG09sOL1HvxyCJ8SfBSj5XiaG2gYhDJNN+HPd+g3et2
         tzGtC1zD3nrRyritJA0UI/ipSHs9sjIjk7Ika26jk6VHXwva7YQfBOqWoTKFMQqTN0uq
         GvCUiTEfw3aCSeytDKmuNatMyALfmT62V54EpLjGcsVQDZrl5OCfPnnmCFuRDQLUnWup
         eAaQ==
X-Gm-Message-State: AJcUukczg5xgFXwBA2SNfYUbKPNwYKmRQC36Z5oLO+F/o1tg4S6YogX7
        wGRc3OZv8cCGpc80zTFIUcbxluQa2I81GKTi+84=
X-Google-Smtp-Source: ALg8bN5zBtLYJragIsflCyqhVx6xNUdO2YOYveUXThVk59B/ILLUjMsr79nQUUm+ko1mIgNhhwklrd9j5tWYqs30GaA=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr20339550wro.77.1545897816080;
 Thu, 27 Dec 2018 00:03:36 -0800 (PST)
MIME-Version: 1.0
References: <1544519572-21921-1-git-send-email-zhang.chunyan@linaro.org>
 <1544519572-21921-2-git-send-email-zhang.chunyan@linaro.org> <0e683aef-383c-8200-0059-44a9abb654b8@intel.com>
In-Reply-To: <0e683aef-383c-8200-0059-44a9abb654b8@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 27 Dec 2018 16:02:59 +0800
Message-ID: <CAAfSe-tHu5m3Of6=KBCxBBH1T8=4tgN8aZP_7QaGERctECZPoQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] mmc: sdhci: add support for using external DMA devices
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2018 at 15:44, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 11/12/18 11:12 AM, Chunyan Zhang wrote:
> > Some standard SD host controllers can support both external dma
> > controllers as well as ADMA/SDMA in which the SD host controller
> > acts as DMA master. TI's omap controller is the case as an example.
> >
> > Currently the generic SDHCI code supports ADMA/SDMA integrated in
> > the host controller but does not have any support for external DMA
> > controllers implemented using dmaengine, meaning that custom code is
> > needed for any systems that use an external DMA controller with SDHCI.
> >
> > Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>
> FYI, I am waiting on successful testing before reviewing these patches again.

Yeah, that makes sense, thanks Adrian!

I intend to send out another new patchset after the holidays.
After had another look at omap_hsmmc, I knew something need to be
modified (emailed Faiz about this privately), but I was still not sure
if it can fix the problem Faiz found.

Happy new year to all,
Chunyan
