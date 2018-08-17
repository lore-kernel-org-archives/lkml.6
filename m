Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AD9C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B01204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XxwIoI3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B01204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeHQKlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 06:41:55 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39831 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeHQKlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 06:41:55 -0400
Received: by mail-it0-f67.google.com with SMTP id g141-v6so10674834ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 00:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LEMMN9BoOU6U1CSn8ssmF42PRvc2rYOcVMlTR21RifA=;
        b=XxwIoI3BLWhHRVOpuDGaMdirwwZPBILsjJ8Y085acts6x5slUjE4+S+kardFqvfGhT
         FGglSmejgKN4OmswotsjQ5Kw4FJSAsYc00AKEIBbduJW1e6ejSs6awTiI0dgJ4aFsR7T
         vVg0wYlSYhvDBcCn2MFk+n8T1+53c2J9vChARoOL1drS0k4JD8U/QYffMxiCU3xfd0BF
         +iAKsKXycnyT8rmVjPAzx9VHB2bPvCI0LCwK2XIUI17sd1ced9oAcpzafg1dwZLJOfTf
         InJW7YB/Wh2oF57sfiY3bud7f89n7k7MibHe3W5MtiL9q5SmKDeDXAfPUslymwGirqoJ
         flgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LEMMN9BoOU6U1CSn8ssmF42PRvc2rYOcVMlTR21RifA=;
        b=cu0cjFBFWoUBfoOZaSeBqeseZaZCo8e8Pv+ncJnoF4gJ/7nD7EC+evrPCtjo/jPotv
         BBngnHSFsr8I9mNSTfBczVyla4f+UcWWu0/E0zCr41AlN4KZ4ZYiUGndgNvIsocmNsIv
         fIr2dhg9MEzNeg/XHK0uEipJCaJZalCJVoDjl0yBzJxIs/7rC8qntqp5OVUiVmgxkHSz
         PoQL4b9Y/kCJR1qcYm4wC3PM6oJuhfCkm2fZ2jMO04CO8mVI5TmtLcstAIyT9zPnF/Z4
         elQuUBe6eYtDXJ9KsrFnTFPuRmk1qhqbjFNy2Z2tDAMmGWVfag+Gk1U2sldv4s+heBLt
         W6zQ==
X-Gm-Message-State: AOUpUlFH3/Tj0zOVszUOQgBCMbxRyZkKLFDo27NImggyN2TC+FzkvFSr
        Riyl4/Np0GBd4PWQK45CZwkQ0Rs57sT3PchvaX1COA==
X-Google-Smtp-Source: AA+uWPw3VkZfwNQ9asoc2Ak/Xim+okB++/oGzkOQcLifHQL4KUTLrCGWHbxJivHN5GPNwk199qdMAo8eEiK20nev04g=
X-Received: by 2002:a02:b70b:: with SMTP id g11-v6mr30535802jam.34.1534491574836;
 Fri, 17 Aug 2018 00:39:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9405:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 00:39:34
 -0700 (PDT)
In-Reply-To: <20180817004919.10805-1-bjorn.andersson@linaro.org>
References: <20180817004919.10805-1-bjorn.andersson@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 17 Aug 2018 09:39:34 +0200
Message-ID: <CAMRc=Mcz9Ha_Jj=236d7Mp=abCUKs6oh9b9sW0uOGzQu1ROJ2g@mail.gmail.com>
Subject: Re: [PATCH] remoteproc/davinci: Use %zx for formating size_t
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Suman Anna <s-anna@ti.com>,
        David Lechner <david@lechnology.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-17 2:49 GMT+02:00 Bjorn Andersson <bjorn.andersson@linaro.org>:
> da8xx_rproc_mem size is of type size_t, so use %zx to format the debug
> print of it to avoid a compile warning.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index e230bef71be1..d200334577f6 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -226,7 +226,7 @@ static int da8xx_rproc_get_internal_memories(struct platform_device *pdev,
>                                 res->start & DA8XX_RPROC_LOCAL_ADDRESS_MASK;
>                 drproc->mem[i].size = resource_size(res);
>
> -               dev_dbg(dev, "memory %8s: bus addr %pa size 0x%x va %p da 0x%x\n",
> +               dev_dbg(dev, "memory %8s: bus addr %pa size 0x%zx va %p da 0x%x\n",
>                         mem_names[i], &drproc->mem[i].bus_addr,
>                         drproc->mem[i].size, drproc->mem[i].cpu_addr,
>                         drproc->mem[i].dev_addr);
> --
> 2.18.0
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Can you also pick up this patch[1] for v4.19? David Lechner already
has a patch queued for v4.20 that depends on this one.

Thanks,
Bartosz

[1] https://patchwork.kernel.org/patch/10479365/
