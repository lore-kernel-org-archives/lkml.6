Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9476BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4038F20645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMp6SN5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4038F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeH3LGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:06:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46035 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeH3LGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:06:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id r4-v6so6319314lff.12;
        Thu, 30 Aug 2018 00:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lgktf0Fo9cMvRg/9sqhU40GJcSPvbDJT9ACm4qVK9jc=;
        b=vMp6SN5BUekZVgD7uG9Q9Ei5VAknoFFtYSoaj9e8t0bTxReGyg2IuSE6RI331Zn5Bm
         /o80neUR61Vki+BLE1Y/IpYs6r9Ot8eFW8FDuFHvHtTAP94zhKzT02XuNV0C/duclSLb
         nygSWhbrCFqtmx1d/GtXcV9qFsGmtcNzv5vm0xiV1++iUn4HOsc2il/+a0BZCPUKGGdS
         7vunNOLHTGkbd6sUrYa1ecq0DLLZxnti3vJnidRoidwxDQ8A3TF91Q0KdXyDoNAT+S1O
         BdQBRHJjGw+ifA57A3SMTQ4cUVDvejHmqJJ2dFQzvcSRzP1Of1hrYqCY0Tvk3FDw3Hwf
         M7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lgktf0Fo9cMvRg/9sqhU40GJcSPvbDJT9ACm4qVK9jc=;
        b=bcLRuH9Vfjkeg0l1emhyK6v8BKw3foN7xuCIPX7Y3BvaLxoO5IO00k9qmxfbhD995Y
         oheMypQ15Ks+3UcWeJqbJrhej2MnOCx0xGw/EiNyNd/8ePm5cuL3o15aKwzrODJT9Pgq
         Xi2L5+vLNfZEfbF4NGFu88B4dXyNHqXKAQJpOPc4XoGRGY+7RfdsnaER/xTAAgqcRB7G
         gaBvGX14bkomGUz4qiO4z0dAWQ8smSWa0pCN6vXqRU516CopxUF+J6CQhRNNzPi1RdSo
         27ffc+nqlvX9maBQpkYuXOil5P/XGJ1gq/J85Aj9+iiGl/muJ6d/qMLuSKc3qnijwPkA
         Me0Q==
X-Gm-Message-State: APzg51CRCxD85AN9uFiTqhMhTNTil4bV2oebkDb1t9NG3JqU15WEy4Vt
        TvjH9tVTgMoxe5tcdTmZvBmWAiuE0ibhNBYh8Ho=
X-Google-Smtp-Source: ANB0VdbyTQ7nLV+j/SUQ6OvHMTMAPuP5eRX/thbZFJkGS6WI8Wixsu0Y9X3/M2BtOGvCY8jSt7PpsDFn9/OOVlfo8R0=
X-Received: by 2002:a19:9e85:: with SMTP id h127-v6mr498784lfe.89.1535612718108;
 Thu, 30 Aug 2018 00:05:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:6318:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 00:04:37
 -0700 (PDT)
In-Reply-To: <48e8ec2c-c3e3-ad08-2c1e-a0feb9ba0820@intel.com>
References: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
 <1535526184-32718-8-git-send-email-zhang.chunyan@linaro.org>
 <a38f8d87-a373-5de4-c3b5-bba68f8ffeec@intel.com> <CAAfSe-s-W467D2dk-_7AWQz9ZaysROf5otoN-o-yu3Eu5ZVC4g@mail.gmail.com>
 <48e8ec2c-c3e3-ad08-2c1e-a0feb9ba0820@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 30 Aug 2018 15:04:37 +0800
Message-ID: <CAAfSe-sATpAmhemU896e4kCj_EUwA+3dkjXN2yxXO5Cvje6J=Q@mail.gmail.com>
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

On 30 August 2018 at 13:59, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 29/08/18 14:39, Chunyan Zhang wrote:
>> On 29 August 2018 at 18:59, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 29/08/18 10:03, Chunyan Zhang wrote:
>>>> When Host Version 4 Enable is set to 1, SDMA uses ADMA System Address
>>>> register (05Fh-058h) instead of using register (000h-004h) to indicate
>>>> its system address of data location. The register (000h-004h) is
>>>> re-assigned to 32-bit Block Count and Auto CMD23 argument, so then SDMA
>>>> may use Auto CMD23.
>>>>
>>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>>> ---
>>>>  drivers/mmc/host/sdhci.c | 8 ++++++--
>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index 62d843ac90..ac92e0f 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -3834,10 +3834,14 @@ int sdhci_setup_host(struct sdhci_host *host)
>>>>       if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
>>>>               host->flags |= SDHCI_AUTO_CMD12;
>>>>
>>>> -     /* Auto-CMD23 stuff only works in ADMA or PIO. */
>>>> +     /*
>>>> +      * For v3 mode, Auto-CMD23 stuff only works in ADMA or PIO;
>>>
>>> ; -> .
>>>
>>>> +      * For v4 mode, SDMA may use Auto-CMD23 as well.
>>>> +      */
>>>>       if ((host->version >= SDHCI_SPEC_300) &&
>>>>           ((host->flags & SDHCI_USE_ADMA) ||
>>>> -          !(host->flags & SDHCI_USE_SDMA)) &&
>>>> +          (!host->v4_mode && !(host->flags & SDHCI_USE_SDMA)) ||
>>>> +          (host->v4_mode && (host->flags & SDHCI_USE_SDMA))) &&
>>>>            !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
>>>
>>> This is over complicated.  We can use auto-CMD23 if not using SDMA or if in
>>> v4_mode i.e.
>>>
>>>         if (host->version >= SDHCI_SPEC_300 &&
>>>             (!(host->flags & SDHCI_USE_SDMA) || host->v4_mode) &&
>>>             !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
>>>
>>
>> So no matter whether SDHCI_USE_ADMA is selected, right?
>
> Yes

I think you mean like this:

if ((host->version >= SDHCI_SPEC_300) &&
    ((host->flags & SDHCI_USE_ADMA) ||
     !(host->flags & SDHCI_USE_SDMA) || host->v4_mode) &&
     !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN))

Otherwise, without checking (host->flags & SDHCI_USE_ADMA), if using
ADMA and SDMA on v3 mode, auto-CMD23 would not be selected.

>
>>
>>>>               host->flags |= SDHCI_AUTO_CMD23;
>>>>               DBG("Auto-CMD23 available\n");
>>>>
>>>
>>
>
