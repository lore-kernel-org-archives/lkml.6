Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AC3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED25920831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCbL9DOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED25920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbeKTC5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:57:14 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43729 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730994AbeKTC5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:57:13 -0500
Received: by mail-io1-f66.google.com with SMTP id g8so5927380iop.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 08:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AgiikwE28IRGj4NGL1R9Q0Vtntndov4NVIEhl2+L9do=;
        b=MCbL9DOkKGCEiqTn1Lpcq05QbCifJRemU+ZS0e5O8IUzu85E7QcyIkkSybSa34duCZ
         Y6ZIdfsbl4rTlTxb+seJLzPGMOm1nxLal4lCrHBWsaqsob66GylhLaSXq1IGbT2YNFco
         wkAn55dLJj7L1DmfNMrF919jlAKGsjCPvLVAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AgiikwE28IRGj4NGL1R9Q0Vtntndov4NVIEhl2+L9do=;
        b=MArC9q6+JBL7kwYok9SM6pvQl3BY88n9NMdPSYUsWcio15k/N9592gDLnbVJvSCWk3
         JTj1pWpDtg7xjedhAKoTE4xcHQvWFhprrbM37awqPxdl0xFHrk0teIfKFumMO4I83/M1
         d59WrlafjKuQc7M7FhC7XAv3g3hPk2iiASraW4vhqTO9eTeJavzAEMf+zfEbhcdK8Iqw
         OD9OXNdplX310RxBrX9utudRkT7T4uD8M9C/ayKdw1Ux2u5lSqx2UmKFXHMsAxZvlKuk
         6zFbJZ6KwTIrSIC6oHzZe9MboVoPB+h8wfDVtRJRV3zl3IlPJQwruUX79urwa6UuUI8m
         AIvQ==
X-Gm-Message-State: AA+aEWbPTP0LjeLTqMyGU3hpzDkg53C/KbTD01+mRCFqQpdeAs+mrX1S
        cWnj7UiYeUgk+JZpZ8Mgxt6aeHZmJpoZUOA/isu1XA==
X-Google-Smtp-Source: AFSGD/UucweR4nxmQGv05FGK9xUqV8yzUe5hONjMKo6SEa5O7LQW5YGrjtWYZq9LejovSJI1UkAJwmQUtj0FcngEnko=
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr18829642ioa.266.1542645185475;
 Mon, 19 Nov 2018 08:33:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:70c8:0:0:0:0:0 with HTTP; Mon, 19 Nov 2018 08:32:25
 -0800 (PST)
In-Reply-To: <44e1a97e-0446-283f-72f7-fd8d39a74b0f@ti.com>
References: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
 <1541387810-24867-3-git-send-email-zhang.chunyan@linaro.org>
 <be0a18e8-8ee6-4d4e-6dcc-6ba6e39033c9@ti.com> <CAK8P3a2X4tbx_R-5VgfApF-UPmJ_XuzH3hO_uVAfffC6h8WrJw@mail.gmail.com>
 <44e1a97e-0446-283f-72f7-fd8d39a74b0f@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Nov 2018 17:32:25 +0100
Message-ID: <CAPDyKFpomN9KyX5u8C9-gBwBNm-sdfHwxbDVYD0hs73WFJR53A@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] mmc: sdhci-omap: Add using external dma
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 November 2018 at 06:27, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi Arnd,
>
> On 06/11/18 6:21 PM, Arnd Bergmann wrote:
>> On 11/5/18, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> On 05/11/18 8:46 AM, Chunyan Zhang wrote:
>>>>
>>>> +   sdhci_switch_extdma(host, true);
>>>
>>> A number of devices using sdhci-omap supports ADMA. So switching to
>>> external
>>> DMA shouldn't be unconditional.
>>>
>>> IMHO sdhci.c should see if the device supports ADMA or SDMA. If not it
>>> should
>>> try switching to external DMA and if external DMA too is not supported, it
>>> should use PIO.
>>
>> What's the reasoning for preferring ADMA/SDMA over external DMA if
>> both are supported?
>
> Generally from our experiments we've found ADMA gives better throughput than
> DMA. I have to ascertain the actual reasons for that.
>>
>> I'd expect that if the external DMA for some reason is worse than
>> ADMA, we just wouldn't list it in the DT at all, but if it's listed and
>> ADMA also works, then the driver should try to use it before falling
>> back to ADMA.
>
> I would agree that for newer dtbs. However if you consider omap_hsmmc, external
> DMA bindings are already added in dt. If we try to switch to sdhci-omap with
> the same bindings, systems with older dtbs will use external DMA and give
> lesser throughput.

I was under the impression that the internal DMA (for old versions) is
rather poor.

However, in the end this is a software policy decision of what to use.
I have no strong opinion, so feel free to pick what you think makes
best sense.

Maybe Adrian also have some thoughts?

Kind regards
Uffe
