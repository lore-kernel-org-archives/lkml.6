Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B26C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0696B214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fK8NZ1Wt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0696B214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbeLCKsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:48:10 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37482 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeLCKsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:48:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so10299333edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DwydGyffLoyVQbictEcQXUTSUtaLHUV7UHrtoEBRrEI=;
        b=fK8NZ1WtWLW88JL09zjR0pKPEogEOy3qtfpXNs0mMt7sz5Qumpt3lic4u/bpySpa+L
         K37niMGhVQZTRW6SeZfZLtvOGh0PdYW/qW/S7FHgT7oeRs4aZidVHp4UYCx4NfgU3ohT
         XkHlw/50VRseWpQ8YP2Kyht61I9UYSdxhA3B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwydGyffLoyVQbictEcQXUTSUtaLHUV7UHrtoEBRrEI=;
        b=qNFGUBnC25yT0fSEQTQzHp9BRRA8N4vGPGdkZoUANKx+B1Z7koqZPo1cZpV8LqDa0Y
         18BzT47xhIvLLMDlvcFl7dLDY2WN8WoKIr+W87NKOdisyfJ++h4vfNkqVISmOpJyYiu9
         EsvmEzdJ62Kkgq86iatJTaOjZOSxn/HDo+Hjpg63rqAbLN9dQg4ZnLrWs8TY0hvRLXAw
         6EIYhRaJYy6ppknM6UbExxFbsTtsJcHHAoNNtT6XHAugGhQ8Te3rfASUxrShArwL9Xis
         3uBsHdNDdBePZQePyNQBGhkkVv3mXemKIWCJE02AMPU8j0+IO9IO/Z/1I3npAOfH1Umo
         Tm4g==
X-Gm-Message-State: AA+aEWbLnXLf/+lzMYqoRTHsGNJobObNd5AAdzEnd2UjSFAJI4NvG5LI
        rgchFUgUclYUCqQw7VWftWsrH/rFp7gL5GrFthqLjXtLqJs=
X-Google-Smtp-Source: AFSGD/WV4DWoTK3zaxjc4ca9G4VUQ1yyDcOKqnKfxtTOYb1rTGToL9BiI6qd58TWDc5Vhy1M49rc4YrUDoMEwbatQok=
X-Received: by 2002:a50:a7c4:: with SMTP id i62mr14257122edc.162.1543834058764;
 Mon, 03 Dec 2018 02:47:38 -0800 (PST)
MIME-Version: 1.0
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
 <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
 <84836600-c705-9ac3-297e-bb67a611daca@intel.com> <CAAfSe-us5aKOv9F6KHwvJR_cMAF8KFo6W1Gs_B3zBiNOuD10Qg@mail.gmail.com>
 <f78de042-69cf-5345-f16f-236d04d57051@intel.com> <CAAfSe-sfe5A7b_8iBiUmvi_mo1zRZ_Oh0yu-uwXo8Hv+WBftWQ@mail.gmail.com>
 <22591bc4-ea34-dcc6-a3d5-8a75e890ff2b@rock-chips.com>
In-Reply-To: <22591bc4-ea34-dcc6-a3d5-8a75e890ff2b@rock-chips.com>
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
Date:   Mon, 3 Dec 2018 18:47:27 +0800
Message-ID: <CAG2=9p-aBuiimuPR3qv43UKJCe2wQqb4Q_ZqcpF-dK4=5XQCxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: sdhci: add support for using external DMA devices
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Lyra Zhang <zhang.lyra@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 at 09:15, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> On 2018/11/29 17:59, Chunyan Zhang wrote:
> > Hi Adrian,
> >
> > On Thu, 29 Nov 2018 at 15:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 29/11/18 8:22 AM, Chunyan Zhang wrote:
> >>> On Tue, 20 Nov 2018 at 21:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>
> >>>> On 12/11/18 9:26 AM, Chunyan Zhang wrote:
> >>>>> Some standard SD host controllers can support both external dma
> >>>>> controllers as well as ADMA/SDMA in which the SD host controller
> >>>>> acts as DMA master. TI's omap controller is the case as an example.
> >>>>>
> >>>>> Currently the generic SDHCI code supports ADMA/SDMA integrated in
> >>>>> the host controller but does not have any support for external DMA
> >>>>> controllers implemented using dmaengine, meaning that custom code is
> >>>>> needed for any systems that use an external DMA controller with SDHCI.
> >>>>
> >>>> I still think you probably need to reset the DMA if there are transfer
> >>>> errors - perhaps you could comment on that.  Also there are some comments below.
> >>>
> >>> With regard to "transfer error", do you mean if
> >>> sdhci_external_dma_setup() failed?
> >>
> >> No, I mean any error interrupt that can leave the DMA uncompleted.  For
> >> SDHCI, resetting the data circuit cleans that up, but presumably something
> >> is needed for external DMA?
> >
> > Yes, it should need a dmaengine_terminate_all().
> >
>
> No, dmaengine_terminate_all is deprecated for quite a long time.
> Please use dmaengine_terminate_{async, sync}() instead.
>
> See Documentation/dmaengine/client.txt

Ok, thanks for the comments.
Chunyan

>
>
> > How about adding that at here (I will wrap it up of course):
> > https://elixir.bootlin.com/linux/v4.19.5/source/drivers/mmc/host/sdhci.c#L2553
> >
> > Is there somewhere else I'm missing?
> >
> > Thanks,
> > Chunyan
> >
> >
>
