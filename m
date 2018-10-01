Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383A7C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A1B21470
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8uZeIcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A1B21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbeJAUSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:18:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36524 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbeJAUSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:18:06 -0400
Received: by mail-io1-f67.google.com with SMTP id p4-v6so3607461iom.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 06:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tDmSV3zlFp5ts33g+ip+xQYt9fF9N/zXqL8bRkNf6Dw=;
        b=H8uZeIcRFa8KWrlLv397u0P4xX1v7jpUvv9tMtrQK+KIYJsyqfSYjHxsp/R4RKSli9
         L9n/L0aRUWqszjzvN+Gp0q6mZRsjoQOKDS4Xo3Hnc7E0tS8ts9bq2ED2IBHeqga/OuGt
         0+CZnVAtDKSYGpXcKbYWfMbTIx/bqwI47js+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tDmSV3zlFp5ts33g+ip+xQYt9fF9N/zXqL8bRkNf6Dw=;
        b=o0B6MsvRfSyOoB42jAnDGOF70VgAQwpsCZ3iufHZs4MkymFu20apG7k3KlWgHkTE4k
         rBLoPD/inqc2bc0f0VbzOwZkSIoJR29tnt5Q+VN/Y2dONK4tKM1Tx+BMP+JrygGgSlsC
         Fn13XtlXnXujYR48hDUYwxBirPI28ifTB53NdB4YPiCh/gi4GDvj00Mm75ZKMY8lsNDI
         es2A4/IAqe8SgP9TABWiUveriJeSBXQ8JOJfXtSPE8i4Nz/w8cp7MFJ1xdbGmqgB1etr
         1Pcerh7ZBMOZQRt+clS2uK2axHRCdjAIUOVC/sWjJXIqHrOS+G3p/Bsi4Pv9kRPVvBTK
         xfew==
X-Gm-Message-State: ABuFfoiFxUOGxI3NOhTxKT5GSqOFpq0NsLthIxlwdcK8oo9w6I6ovYow
        3hc334SiGHimZOqwxJGoOc+LdO4S3GVLZgJPSuk+ow==
X-Google-Smtp-Source: ACcGV60pBMww7uGwpzmYKN5VlLPVaXbkNvm73ZdF9+dknWhA/+0U0eu10VgUyCAnPgkieQ71l4EEFGXXs0Js68SBCJQ=
X-Received: by 2002:a6b:144b:: with SMTP id 72-v6mr6935823iou.218.1538401213650;
 Mon, 01 Oct 2018 06:40:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 06:39:33 -0700 (PDT)
In-Reply-To: <50222b8d-3b53-acea-7935-092fa149d54c@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-28-git-send-email-ludovic.Barre@st.com> <CAPDyKFqGY2o7TcUVW9bCZM9-4xtyJJ4PaCtWWQvV3VMd+cK99A@mail.gmail.com>
 <50222b8d-3b53-acea-7935-092fa149d54c@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Oct 2018 15:39:33 +0200
Message-ID: <CAPDyKFr45FF-wbhT7C=+G5ptbCMRiKie304UM9P2vRypKd=PvQ@mail.gmail.com>
Subject: Re: [PATCH V2 27/27] mmc: mmci: add stm32 sdmmc variant
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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

[...]

>>>   struct variant_data {
>>>          unsigned int            clkreg;
>>> @@ -348,6 +350,8 @@ struct variant_data {
>>>          unsigned int            irq_pio_mask;
>>>          u32                     start_err;
>>>          u32                     opendrain;
>>> +       bool                    dma_lli;
>>> +       u32                     stm32_idmabsize_mask;
>>
>>
>> What are these?
>
>
> This property is specific for sdmmc variants:
> sdmmc has a Internal DMA and the number bytes per buffer
> could be different between sdmmc variants
> (depend of SDMMC_IDMABSIZER register).

Okay. Thanks for clarifying.

Could you please add some information about this in the changelog as well?

[...]

>>> +
>>> +static int _sdmmc_idma_prep_data(struct mmci_host *host,
>>> +                                struct mmc_data *data)
>>> +{
>>> +       int n_elem;
>>> +
>>> +       n_elem = dma_map_sg(mmc_dev(host->mmc),
>>> +                           data->sg,
>>> +                           data->sg_len,
>>> +                           mmc_get_dma_dir(data));
>>> +
>>> +       if (!n_elem) {
>>> +               dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int sdmmc_idma_prep_data(struct mmci_host *host,
>>> +                               struct mmc_data *data, bool next)
>>> +{
>>> +       /* Check if job is already prepared. */
>>> +       if (!next && data->host_cookie == host->next_cookie)
>>> +               return 0;
>>> +
>>> +       return _sdmmc_idma_prep_data(host, data);
>>> +}
>>> +
>>> +static void sdmmc_idma_unprep_data(struct mmci_host *host,
>>> +                                  struct mmc_data *data, int err)
>>> +{
>>> +       dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
>>> +                    mmc_get_dma_dir(data));
>>> +}
>>
>>
>> The sdmmc_idma_prep_data() and sdmmc_idma_unprep_data(), seems very
>> similar to what the mmci core driver needs to do in this regards.
>>
>> Can we perhaps avoid adding these callbacks altogether, but rather
>> rely on common code in the mmci core driver?
>
>
> Actually, these callbacks allow to manage prepare/unprepare of
> dmaengine interface for mmci variant, (not needed for sdmmc which uses an
> internal dma).
>
> For Sdmmc, today there are no special case, just dma_map/unmap.
> But in the future, I hope manage the lli list in these callback.
>
> Only dma_map/unmap could be common, but the error management may
> be complicated (in mmci variant).
>
> Personally, I prefer keep prep_data/unprep_data mmci_host_ops
> interfaces.
> What do you suggest ?

Okay, let's keep them for now. We can always change things on top, in
case we see later that those callbacks can be removed.

[...]

Kind regards
Uffe
