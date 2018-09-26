Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D746CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753CE20676
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvcLOx3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753CE20676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeI0GFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:05:44 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51510 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbeI0GFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:05:44 -0400
Received: by mail-it1-f193.google.com with SMTP id 74-v6so3786173itw.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 16:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CAPo5X1tPw1JI17B71QMQh3OjuHkZ/IHFhgLDLvcxLk=;
        b=XvcLOx3a0FqeaWzq/X+XvHWMbR8FcinpI0mNsMoDgkpqT4of8dzNqDxPuTBnJC6US5
         ruFt+zWKKfMtMIlzYiyGRKphVntkhzyN6HvRCv4qBwnlxiZ5joE64ZCsJ9d1tirh9MCy
         rL6gXQayNnv+HCCLRz7vN/w9YDmw+nXTxbkFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CAPo5X1tPw1JI17B71QMQh3OjuHkZ/IHFhgLDLvcxLk=;
        b=Sac5g4AqzLP06H4PX/XBc+P3yyp+f0bZy1czgy2K4wxv+UMkb4t9/Es/vcnj6Ltdcu
         IcjWkdEX3E1+5XXkVAdsHGtQVkrQOjktae0kdnsAkWqUUbtWWuqpd3FHsfdnuxTsd2Hd
         VgX/DgdRMyuuAK9/gaplTLUABkdHzJrimqQfW3YESKtUoe1jsZ826bMzZLV3oKhZ8eK0
         /LYouxCVpFG4fVoTvye9QG1wjnSO2mDOWXauhUxd6GV5GAE4KWM/CRRbZvW5GeVvHaZ/
         Qt/tvqFfLhNE6SEIggoYV4D/2UXHfTIPuyR+NkLI6L0wlR+KGbKXDJQq4Jsn7Uxx6OB3
         +rgA==
X-Gm-Message-State: ABuFfog3N4Kna9yAyceBr2jHVnY/g0Owa4O9tCaPoe8TD6hSFC76BPwg
        tnh4lDmEVcLhWNVqmw2GTCMw/NmFUxz4E1dieh2mDQ==
X-Google-Smtp-Source: ACcGV604yiykXLII9oZpQHOrAFyY28f/srd40xbR5FnwT63JOlcmbN0OoUGSh02+aRu5ibuUcMMkGaqv4VNCBYbNzM0=
X-Received: by 2002:a24:3fc6:: with SMTP id d189-v6mr7012959ita.64.1538005819744;
 Wed, 26 Sep 2018 16:50:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 16:49:39
 -0700 (PDT)
In-Reply-To: <15c31e3b-646a-f5db-b45a-3e2f556d9fd5@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-4-git-send-email-ludovic.Barre@st.com> <CAPDyKFqnN0gg9WsbNPQcodqUXJmFEzMM+ST36s6oEZ2OPoONug@mail.gmail.com>
 <15c31e3b-646a-f5db-b45a-3e2f556d9fd5@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 27 Sep 2018 01:49:39 +0200
Message-ID: <CAPDyKFq2FmggcuRRYmeW-ChL-SiEboCTCu745kZHGeNLi_qQjg@mail.gmail.com>
Subject: Re: [PATCH V2 03/27] mmc: mmci: convert dma_setup callback to return
 an int
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gerald Baeza <gerald.baeza@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 September 2018 at 18:12, Ludovic BARRE <ludovic.barre@st.com> wrote:
> hi Ulf
>
>
> On 09/24/2018 04:28 PM, Ulf Hansson wrote:
>>
>> On 21 September 2018 at 11:45, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> This patch converts dma_setup callback to return an integer
>>> This patch is needed to prepare sdmmc variant with internal dma
>>>
>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>> ---
>>>   drivers/mmc/host/mmci.c          | 14 ++++++++++----
>>>   drivers/mmc/host/mmci.h          |  2 +-
>>>   drivers/mmc/host/mmci_qcom_dml.c |  6 ++++--
>>>   3 files changed, 15 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>> index cbd67bc..2f845f3 100644
>>> --- a/drivers/mmc/host/mmci.c
>>> +++ b/drivers/mmc/host/mmci.c
>>> @@ -415,7 +415,7 @@ static void mmci_init_sg(struct mmci_host *host,
>>> struct mmc_data *data)
>>>    * no custom DMA interfaces are supported.
>>>    */
>>>   #ifdef CONFIG_DMA_ENGINE
>>> -static void mmci_dma_setup(struct mmci_host *host)
>>> +static int mmci_dma_setup(struct mmci_host *host)
>>>   {
>>>          const char *rxname, *txname;
>>>
>>> @@ -466,7 +466,9 @@ static void mmci_dma_setup(struct mmci_host *host)
>>>          }
>>>
>>>          if (host->ops && host->ops->dma_setup)
>>> -               host->ops->dma_setup(host);
>>> +               return host->ops->dma_setup(host);
>>> +
>>
>>
>> Looks like you need to implement a error handling, instead of just
>> returning the error code.
>
>
> yes, today if a dma_setup is defined, we can't fallback to pio mode.
> A use_dma variable (defined in mmci_host) could be setted follow the return
> code of ops->dma_setup
>
> example:
>
> void mmci_dma_setup(struct mmci_host *host)
> {
>         int err;
>
>         if (!host->ops || !host->ops->dma_setup)
>                 return;
>
>         err = host->ops->dma_setup(host);
>         if (err)
>                 return;
>
>         host->use_dma = true;
>
>         /* initialize pre request cookie */
>         host->next_cookie = 1;
> }
>
> use_dma variable could be check by mmci_host_ops variant functions.
>
> are you agree with this proposal?
>

Yep, makes sense!

>
>>
>>> +       return 0;
>>>   }
>>>
>>>   /*
>>> @@ -741,8 +743,10 @@ static void mmci_post_request(struct mmc_host *mmc,
>>> struct mmc_request *mrq,
>>>   static void mmci_get_next_data(struct mmci_host *host, struct mmc_data
>>> *data)
>>>   {
>>>   }
>>> -static inline void mmci_dma_setup(struct mmci_host *host)
>>> +
>>> +static inline int mmci_dma_setup(struct mmci_host *host)
>>>   {
>>> +       return 0;
>>>   }
>>>
>>>   static inline void mmci_dma_release(struct mmci_host *host)
>>> @@ -1796,7 +1800,9 @@ static int mmci_probe(struct amba_device *dev,
>>>                   amba_rev(dev), (unsigned long long)dev->res.start,
>>>                   dev->irq[0], dev->irq[1]);
>>>
>>> -       mmci_dma_setup(host);
>>> +       ret = mmci_dma_setup(host);
>>> +       if (ret)
>>> +               goto clk_disable;
>>>
>>>          pm_runtime_set_autosuspend_delay(&dev->dev, 50);
>>>          pm_runtime_use_autosuspend(&dev->dev);
>>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>>> index 21aaf9a..06299ac 100644
>>> --- a/drivers/mmc/host/mmci.h
>>> +++ b/drivers/mmc/host/mmci.h
>>> @@ -273,7 +273,7 @@ struct variant_data {
>>>
>>>   /* mmci variant callbacks */
>>>   struct mmci_host_ops {
>>> -       void (*dma_setup)(struct mmci_host *host);
>>> +       int (*dma_setup)(struct mmci_host *host);
>>>   };
>>>
>>>   struct mmci_host_next {
>>> diff --git a/drivers/mmc/host/mmci_qcom_dml.c
>>> b/drivers/mmc/host/mmci_qcom_dml.c
>>> index be3fab5..1bb59cf 100644
>>> --- a/drivers/mmc/host/mmci_qcom_dml.c
>>> +++ b/drivers/mmc/host/mmci_qcom_dml.c
>>> @@ -119,7 +119,7 @@ static int of_get_dml_pipe_index(struct device_node
>>> *np, const char *name)
>>>   }
>>>
>>>   /* Initialize the dml hardware connected to SD Card controller */
>>> -static void qcom_dma_setup(struct mmci_host *host)
>>> +static int qcom_dma_setup(struct mmci_host *host)
>>>   {
>>>          u32 config;
>>>          void __iomem *base;
>>> @@ -131,7 +131,7 @@ static void qcom_dma_setup(struct mmci_host *host)
>>>
>>>          if (producer_id < 0 || consumer_id < 0) {
>>>                  host->variant->qcom_dml = false;
>>
>>
>> It seems like the existing code is an attempt to fallback to use pio
>> mode. However, I doubt it works as is.
>
>
> oops, I seen that like a variant identification issue, so if it's a
> fallback to pio mode it doesn't work.

Right. Let's see if we can get some input from Srinivas, else I will
run some test on my 410c board to see the behavior - very soon.

[...]

Kind regards
Uffe
