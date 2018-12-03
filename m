Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90691C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F59214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceXJkczc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F59214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbeLCKrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:47:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39744 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbeLCKrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:47:16 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so10286154edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4DqEn37SBRsotIrKAm5yynDS6jpvHS3hOUw3P+QwwE=;
        b=ceXJkczc3iwbnmoscqMAaL+NjPXtiaF34nuMObqEEb7hKST2xROzzBteuUrgOuOFPs
         iC2ndrSzUKhw0r+tpD8KFlfUNd7DGDSDjozQndVSgwpp42uFneeBSv88OO1FjfQDQN8+
         GxtWC2HGrzOjyaOAVzgSxocFjLdYuoOP6mvw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4DqEn37SBRsotIrKAm5yynDS6jpvHS3hOUw3P+QwwE=;
        b=QyOrt4lHuCUSUCa7x8Jx8QGFu+OWPefp4fzUbJIx62HpTy33cwPXhV9ggf2B41SDFq
         oD/fr1bWTTf2DcpdgxrRtwRU0gLJHCtui0pk0qx89wZABCdXzZFwkO+bGDWDUDXFY0YZ
         iOV8gha4e2C/dXikz3H6bLY+uV41qY2AFevHVo48cUdSNFwnuTE73Xk4wRkC6R9JYLBf
         DJNF5PpLPDLxBpQPbElORb19FYsj+h5AP+7QBWnHixwOkgTkP1HSBByXJoPMOZyAOKU2
         CU0jZV74YGjJAb0ou+noB32Z005xbQgnMAgVwZS3CKhwG0a9bd1uUpylKYCYMXllbMJ2
         ImvQ==
X-Gm-Message-State: AA+aEWaVKeCJR+RZkc7z0AnyOu0PtoylRF1H1/DxiT3vO6uC/Yt+gWOb
        svis/m0NrqjU1lRIVwfPRAvoR9EVSGFlX6xF6rbzFA==
X-Google-Smtp-Source: AFSGD/URT8DMwYQqi3GnvKg+Ka9Ax99Ydlrwjle9DgaZ130aE5Oz8MzvgGgJwhdjI4d04wYF5hJ2yJzWRQh7dRG5Tlg=
X-Received: by 2002:a17:906:404a:: with SMTP id y10-v6mr12518544ejj.30.1543834004482;
 Mon, 03 Dec 2018 02:46:44 -0800 (PST)
MIME-Version: 1.0
References: <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
 <1543471664-22856-1-git-send-email-zhang.chunyan@linaro.org>
 <cb2cdfb9-f3e6-72cd-2d55-734b08ea3e15@intel.com> <42f994b2-ba98-8160-6eef-11eeb8a10f5e@ti.com>
In-Reply-To: <42f994b2-ba98-8160-6eef-11eeb8a10f5e@ti.com>
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
Date:   Mon, 3 Dec 2018 18:46:33 +0800
Message-ID: <CAG2=9p9mpC_mB4ghbrJm=e4Ewa9pL7R0zURg=erFPw4MR4S+Zg@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] mmc: sdhci: add support for using external DMA devices
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Lyra Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018 at 17:01, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi Chunyan,
>
> On 29/11/18 2:53 PM, Adrian Hunter wrote:
> > On 29/11/18 8:07 AM, Chunyan Zhang wrote:
> >> Some standard SD host controllers can support both external dma
> >> controllers as well as ADMA/SDMA in which the SD host controller
> >> acts as DMA master. TI's omap controller is the case as an example.
> >>
> >> Currently the generic SDHCI code supports ADMA/SDMA integrated in
> >> the host controller but does not have any support for external DMA
> >> controllers implemented using dmaengine, meaning that custom code is
> >> needed for any systems that use an external DMA controller with SDHCI.
> >>
> >> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> >> ---
> >>  drivers/mmc/host/Kconfig |  14 ++++
> >>  drivers/mmc/host/sdhci.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++-
> >>  drivers/mmc/host/sdhci.h |   8 ++
> >>  3 files changed, 206 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >> index 1b58739..4183f43 100644
> >> --- a/drivers/mmc/host/Kconfig
> >> +++ b/drivers/mmc/host/Kconfig
> >> @@ -969,6 +969,7 @@ config MMC_SDHCI_XENON
> >>  config MMC_SDHCI_OMAP
> >>      tristate "TI SDHCI Controller Support">>        depends on MMC_SDHCI_PLTFM && OF
> >> +    select MMC_SDHCI_EXTERNAL_DMA if DMA_ENGINE
>
>
> This should be in patch 2.

Ok, will move to.

Thanks,
Chunyan

>
> Thanks,
> Faiz
