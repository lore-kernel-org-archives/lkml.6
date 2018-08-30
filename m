Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F87C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FE02082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVcFyRb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FE02082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeH3MYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:24:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45500 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbeH3MYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:24:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id r4-v6so6484505lff.12;
        Thu, 30 Aug 2018 01:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rO/DKR3rI7qewrOYYN0VxXn/N0BiKZbXaxDC6xVvEO0=;
        b=IVcFyRb7qj7hwt+dtxVkeCNtJGvF1Hsr+2RXQY+w+ohWxiVgKG+pco1OsTfcapm2/z
         f8Gk7iDMV4O3BZoO54oZaZgmQdCCOysifUPHlD+vySVaEyylrcW0A8pHYtXY8aLKqp6n
         AbpGmavW7zSZD1ncdRs0pVmhbVyxoJIQA2Dpi+EAGmsWxh9gkT+1jLNv1pSzFxoNgYiE
         XrMtU2s4b4fkeEbEQsnxZ+s+2CZB874IqlklurhJTUciifR/5v699pZ+H0fvBy7N19GN
         4rnmn/SgjDWXc72zDkqh8yJ3QH+CNBrw3+mwc/YIQVRen4KF3SaMUAoRWw2Lqn6NAPKJ
         vCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rO/DKR3rI7qewrOYYN0VxXn/N0BiKZbXaxDC6xVvEO0=;
        b=BQeZ2dI6pLCCYNwR2zeZM8J1PGtQjsOXoZFAS3oKxDP4Atn19VyBteXMwU5kwmPSwh
         T1RpsAlrEOyeAKLF0DGOPtKwRykBvxNnH7/YawFv9aBGsbH2Yppoe8bZvlCbkxig/j3b
         yABkNQwbP3KaEs4+XiQCC4vAzla1jWP5TKy2M7qUtZUb3pERDjp82bUDReu/kGYbjskZ
         yjhQUg03YCQbYCrfxGKfZZ4LP89cDRDoonKtnUo9wQ3+fQKLT0e30O6qOPU6M4140Zlu
         n6AYMesULVLOiQjMks66z1b+4k42AtV36w/JccE6Q3HeCcsfU2GssuBhs0U7j1Xs8x9Y
         gDqQ==
X-Gm-Message-State: APzg51AQsX7TI7LhDKLXdYCe2665G3CyLZNp9wT4tMfOGt924tpISYaR
        PLtGmPfFfnNq7wk7Ug8zXBd2hV5CeNrrSrHsswg=
X-Google-Smtp-Source: ANB0VdYvYoyjZ7F87nMnpYfFts3QumVgVo2ftnBpt7hrZoGBzark3ueefqZoDhNHOlTszC3J0ZtwKs7pM9Eu01o6Z3I=
X-Received: by 2002:a19:cf05:: with SMTP id f5-v6mr6942194lfg.73.1535617424278;
 Thu, 30 Aug 2018 01:23:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:6318:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 01:23:03
 -0700 (PDT)
In-Reply-To: <145ef368-3aae-c6ae-14c9-6e8f50503dcf@intel.com>
References: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
 <1535526184-32718-8-git-send-email-zhang.chunyan@linaro.org>
 <a38f8d87-a373-5de4-c3b5-bba68f8ffeec@intel.com> <CAAfSe-s-W467D2dk-_7AWQz9ZaysROf5otoN-o-yu3Eu5ZVC4g@mail.gmail.com>
 <48e8ec2c-c3e3-ad08-2c1e-a0feb9ba0820@intel.com> <CAAfSe-sATpAmhemU896e4kCj_EUwA+3dkjXN2yxXO5Cvje6J=Q@mail.gmail.com>
 <145ef368-3aae-c6ae-14c9-6e8f50503dcf@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 30 Aug 2018 16:23:03 +0800
Message-ID: <CAAfSe-tKKiV0CCN2Oz6wY5XmfO2aAJHPBcaP48YiEji=PUV5sw@mail.gmail.com>
Subject: Re: [PATCH V7 7/9] mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 August 2018 at 15:51, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 30/08/18 10:04, Chunyan Zhang wrote:
>> On 30 August 2018 at 13:59, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 29/08/18 14:39, Chunyan Zhang wrote:
>>>> On 29 August 2018 at 18:59, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>> On 29/08/18 10:03, Chunyan Zhang wrote:
>>>>>> When Host Version 4 Enable is set to 1, SDMA uses ADMA System Address
>>>>>> register (05Fh-058h) instead of using register (000h-004h) to indicate
>>>>>> its system address of data location. The register (000h-004h) is
>>>>>> re-assigned to 32-bit Block Count and Auto CMD23 argument, so then SDMA
>>>>>> may use Auto CMD23.
>>>>>>
>>>>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>>>>> ---
>>>>>>  drivers/mmc/host/sdhci.c | 8 ++++++--
>>>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>>>> index 62d843ac90..ac92e0f 100644
>>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>>> @@ -3834,10 +3834,14 @@ int sdhci_setup_host(struct sdhci_host *host)
>>>>>>       if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
>>>>>>               host->flags |= SDHCI_AUTO_CMD12;
>>>>>>
>>>>>> -     /* Auto-CMD23 stuff only works in ADMA or PIO. */
>>>>>> +     /*
>>>>>> +      * For v3 mode, Auto-CMD23 stuff only works in ADMA or PIO;
>>>>>
>>>>> ; -> .
>>>>>
>>>>>> +      * For v4 mode, SDMA may use Auto-CMD23 as well.
>>>>>> +      */
>>>>>>       if ((host->version >= SDHCI_SPEC_300) &&
>>>>>>           ((host->flags & SDHCI_USE_ADMA) ||
>>>>>> -          !(host->flags & SDHCI_USE_SDMA)) &&
>>>>>> +          (!host->v4_mode && !(host->flags & SDHCI_USE_SDMA)) ||
>>>>>> +          (host->v4_mode && (host->flags & SDHCI_USE_SDMA))) &&
>>>>>>            !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
>>>>>
>>>>> This is over complicated.  We can use auto-CMD23 if not using SDMA or if in
>>>>> v4_mode i.e.
>>>>>
>>>>>         if (host->version >= SDHCI_SPEC_300 &&
>>>>>             (!(host->flags & SDHCI_USE_SDMA) || host->v4_mode) &&
>>>>>             !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
>>>>>
>>>>
>>>> So no matter whether SDHCI_USE_ADMA is selected, right?
>>>
>>> Yes
>>
>> I think you mean like this:
>>
>> if ((host->version >= SDHCI_SPEC_300) &&
>>     ((host->flags & SDHCI_USE_ADMA) ||
>>      !(host->flags & SDHCI_USE_SDMA) || host->v4_mode) &&
>>      !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN))
>>
>> Otherwise, without checking (host->flags & SDHCI_USE_ADMA), if using
>> ADMA and SDMA on v3 mode, auto-CMD23 would not be selected.
>
> Yeah you are right - I was thinking SDHCI_USE_SDMA and SDHCI_USE_ADMA were
> mutually exclusive.  Thanks!

Many thanks for your review!

Chunyan

>
