Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3997CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA54B20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLsAmmd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA54B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeK2VFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:05:12 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41822 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbeK2VFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:05:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so962822lfj.8;
        Thu, 29 Nov 2018 02:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qA1DNuw+7GiqVUBAahLlA+0uqyff0Brlhy+2UZlD/dI=;
        b=SLsAmmd/zyPgskuVNZESLCfDNFRyNP7fwMGHhMdA8qe4qBfE1rvCxWmCPAhhHuzhf1
         XyyUQN6lGLg2g+BdjeAj5AZvKREtbMYJlemqmz+McRMYlnHqm6ZBJ86yc5e15gDmIaY/
         HZmhk9QqCPmp/w2056tXZZI5CztUA66cCRbLeFROjaKpJwDS9rP6b+EUVVItWnVKVua5
         QKoqWEVhA0Km0k11fll9bTcrw5zGz5aJVCJfDYMRelp1M/NRHV9kKX+irEY730BbiEg8
         lWzU3DOjsMA+8L9TLh3OTHfTsuJod9SjRJai6QZsz2IU4n+WQjf+yFLuFdaFtB2mdkMz
         g4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qA1DNuw+7GiqVUBAahLlA+0uqyff0Brlhy+2UZlD/dI=;
        b=SMLwTrIphawQGZGWBMMv7BOa/IDsrKqoCkIslLtlWgRR+3FLby5gUA5zhKmfakIsRv
         6aeBXAsrKkIMBMyxsSs9nI6kMzWS6XXQf2LPHezjriE0RULOZ/kDrxRU79zqa6XZzcfS
         oLugbS1J7o9blDhICqUmEhMAUk45VuUOQ1fBJbLca4rtqVdUvIlgU8bXe92Wkxs9BASv
         KEPMCfMW0XYzh2Ux1F29NOZABTnOWjQUbJQmYYh4Bc5no/Q/aWH6x6v4MuQKboQ02Gf3
         hvgatveS8r9WxrM9Z8inSM6kcCeNgHydu7XzJyNx7H7ofOcigULP2+E7/9HvLb1AT7bF
         4Xrg==
X-Gm-Message-State: AA+aEWa9OskPqX7GvBJV6syYvqQlAXw6CFma6DhIlxuiiGCImtwNflky
        U4tUspr5vEABTQgx6n5gbDv62ow03bQSBhWyW9A=
X-Google-Smtp-Source: AFSGD/UiRVhqMm8zhmPaCDXqpaVX6gohIegDv+i1ouoH6K6CUIpbh3Ryt+GJ79XVsRKh27x84mNT86t44QO6E04lvyw=
X-Received: by 2002:a19:d58e:: with SMTP id m136mr638831lfg.70.1543485623040;
 Thu, 29 Nov 2018 02:00:23 -0800 (PST)
MIME-Version: 1.0
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
 <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
 <84836600-c705-9ac3-297e-bb67a611daca@intel.com> <CAAfSe-us5aKOv9F6KHwvJR_cMAF8KFo6W1Gs_B3zBiNOuD10Qg@mail.gmail.com>
 <f78de042-69cf-5345-f16f-236d04d57051@intel.com>
In-Reply-To: <f78de042-69cf-5345-f16f-236d04d57051@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 29 Nov 2018 17:59:46 +0800
Message-ID: <CAAfSe-sfe5A7b_8iBiUmvi_mo1zRZ_Oh0yu-uwXo8Hv+WBftWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: sdhci: add support for using external DMA devices
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        kishon@ti.com, nsekhar@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Thu, 29 Nov 2018 at 15:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 29/11/18 8:22 AM, Chunyan Zhang wrote:
> > On Tue, 20 Nov 2018 at 21:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 12/11/18 9:26 AM, Chunyan Zhang wrote:
> >>> Some standard SD host controllers can support both external dma
> >>> controllers as well as ADMA/SDMA in which the SD host controller
> >>> acts as DMA master. TI's omap controller is the case as an example.
> >>>
> >>> Currently the generic SDHCI code supports ADMA/SDMA integrated in
> >>> the host controller but does not have any support for external DMA
> >>> controllers implemented using dmaengine, meaning that custom code is
> >>> needed for any systems that use an external DMA controller with SDHCI.
> >>
> >> I still think you probably need to reset the DMA if there are transfer
> >> errors - perhaps you could comment on that.  Also there are some comments below.
> >
> > With regard to "transfer error", do you mean if
> > sdhci_external_dma_setup() failed?
>
> No, I mean any error interrupt that can leave the DMA uncompleted.  For
> SDHCI, resetting the data circuit cleans that up, but presumably something
> is needed for external DMA?

Yes, it should need a dmaengine_terminate_all().

How about adding that at here (I will wrap it up of course):
https://elixir.bootlin.com/linux/v4.19.5/source/drivers/mmc/host/sdhci.c#L2553

Is there somewhere else I'm missing?

Thanks,
Chunyan
