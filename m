Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3D2C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C17218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ESxyoGpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfAXEcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:32:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51251 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfAXEcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 23:32:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so1661912wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 20:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppYlKynL28Z/4kk6Agwk3BdunZjnnz6YD+SVf/KsJXM=;
        b=ESxyoGpSJvAmNrRWK6JiCDvJESCfr0hxPIV1YJO7x63lFdDLQWN84fD3r2SWa3l6qi
         Y5ExyNOOXnt52JpWOx7n44jIvPZpvtvWu9OqP/0Pglncufc4v8ZX6+43EtB/mRyGmw46
         2xEutzSp+xAjjjvr6DJcsdDaMIY43k/jhG1Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppYlKynL28Z/4kk6Agwk3BdunZjnnz6YD+SVf/KsJXM=;
        b=DdP/MiYnaj9AKUR8JyKzTtYBpD08c6+9EWhOSKj38dQXqfDNQXMZyCYnYPiBV9XhnO
         3NGcRGGEpg98r/pehTuCVeYq9g0H2gArv7RY4C0SNovLslV3+NgFm/uaKvdg+0ra9DT0
         fPqlGpkrdsVtl2XpgcsEsqWD7Dtxub33ZAEIMhnpJuWJT8nGoS6PCmfYRGR3trHJrYJy
         g4yTm5pL79caKK61cOiLvpoawrx4gb2nGk2EK7Pw7DR+Id67s8/E2BMb3nlSeDYXM/F0
         NDOY18W0XQ6Zce9956X/s3gRqfiJWbTOf+O4Y9ALbdrM4Q6oMlC/r2Y14WhqNntw6l1H
         GAsg==
X-Gm-Message-State: AJcUukdS8OvBK8NsmYRDNIR2RDbx+xNcFTVxeodbirdMgtGWZYsJQcYr
        P4qgdmgZl+fzR3dZzvmRd/o8ABeS44RsHy9uv4OVBA==
X-Google-Smtp-Source: ALg8bN5zeI2wTMaWsa1iQiUJ6oCzyOKw9n5qBwnxPwv8XaQqGYqflNhIZIukBDwbkxBuVxSe+MVJ6s2596eur3vFXOY=
X-Received: by 2002:a1c:b456:: with SMTP id d83mr820352wmf.115.1548304364207;
 Wed, 23 Jan 2019 20:32:44 -0800 (PST)
MIME-Version: 1.0
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
 <1547658629-25378-4-git-send-email-john.stultz@linaro.org>
 <20190120111115.GU4635@vkoul-mobl> <CALAqxLXauR4guYMtCYK-wnAqcZCkLY7-vWQ5U-knvHQt1twG4A@mail.gmail.com>
 <20190123125533.GP4635@vkoul-mobl>
In-Reply-To: <20190123125533.GP4635@vkoul-mobl>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 23 Jan 2019 20:32:31 -0800
Message-ID: <CALAqxLVAvLN29M4b+NRzhWbbUjAsSk_h1y58bPviz5SWqcY1NQ@mail.gmail.com>
Subject: Re: [PATCH 3/8 v4] dma: k3dma: Upgrade k3dma driver to support
 hisi_asp_dma hardware
To:     Vinod Koul <vkoul@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, Tanglei Han <hantanglei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 4:57 AM Vinod Koul <vkoul@kernel.org> wrote:
> On 22-01-19, 15:48, John Stultz wrote:
> > Do let me know if there's an example you'd rather I follow.
>
> To elaborate I was thinking of alternate scheme with:
>
>         compatible = "hisilicon,k3-dma-1.0", NULL
>         compatible = "hisilicon,hisi-pcm-asp-dma-1.0", .data = &asp_v1_dma_data
>
> and
>
>         soc_data = device_get_match_data(&op->dev);
>         if (!soc_data) {
>                 /* no data so flags are null */
>                 dev_warn(... "no driver data specified, assuming  no flags\n"
>                 k3_dma->flags = 0;
>         }

Thanks for the clarification! Hmm. I can do this, though the trouble
is all the soc_data-> references have to switch to a struct
k3dma_soc_data on the stack, which we have to initialize/copy over
depending on the soc_data return, which I'm not sure really simplifies
much (other then saving a ulong off the heap). But I'm ok with either.

thanks
-john
