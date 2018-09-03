Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5566AC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087B220862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1u68FPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087B220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeICQfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:35:02 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40193 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeICQfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:35:01 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so831944ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 05:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RL5OKYHwqTxZfaW/e0ksUAWOPGaiDSL8hVbpIxd2crE=;
        b=i1u68FPFwb8SPZOG5+KvY0jmwxoFH68It4BzCga+iqBOtZVCsCOmXe75Op5zFx/CTH
         qVOwwwEp1O955zdyXoNPQTZro440tYMuLreKpNk4izU2G8ZgOVOJYRd8ByIJHkp9hKXG
         L5ZY0IuE4trGmye6tsQ5GHfsV4RD4jQ3MjMOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RL5OKYHwqTxZfaW/e0ksUAWOPGaiDSL8hVbpIxd2crE=;
        b=i94/R1rNlBItJF0yQ6yE/4UOMq/k85WaY2Et85cixKsMf+MG60HU7uMJaeYb70eGdt
         ySWzR4D3P8RNkN+m1zu41QPbkqrUZU2C0VXjejTX8Xm1ECRYSvZBv0iolZheGHmF88tN
         YV+x8t1juOhoWz/I524TgUFbUM7r7a9u+ttSbF440X+9U2n2M492kKEAjEmRgYG+jDfk
         e7TllLIrahihwjoi3NjosPvLVkKWj5BfMsndCImf0tvm6prfUI617GyQu3/QmjqFobDr
         sT/MB++fwqc/pYkTm/XPQQyRSxv70sJIAQ1v14uHTeF3O9ofy4sSLBG2nDjCouJMnwmw
         rbSA==
X-Gm-Message-State: APzg51AgynSyTHt4g7eED7TbjmqGPbjUomfK7RBd/5nPXbfOemkvhGRN
        nZx43qRVQZ3qNzmiVrKTptOJQnvrgi1k6TfdpYf4bQ==
X-Google-Smtp-Source: ANB0VdZvBx3TXgr/laVSaJjkGAP78FrZkX5+IsrE3vnXRpbql8WyqDF7JcN6YgWx7Iicofo9k+43DUXErO0ST+X3hfA=
X-Received: by 2002:a02:344:: with SMTP id y65-v6mr20069188jad.121.1535976908421;
 Mon, 03 Sep 2018 05:15:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1bd8:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 05:15:07 -0700 (PDT)
In-Reply-To: <1533116221-380-4-git-send-email-ludovic.Barre@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com> <1533116221-380-4-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Sep 2018 14:15:07 +0200
Message-ID: <CAPDyKFoWPcWmjgivNVUeLR6j-_KUY-O-aJfgdh3dhQKL3oPedQ@mail.gmail.com>
Subject: Re: [PATCH 03/14] mmc: mmci: internalize dma_inprogress into mmci dma functions
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 August 2018 at 11:36, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch internalizes the dma_inprogress into mmci dma interfaces.
> This allows to simplify and prepare the next dma callbacks
> for mmci host ops. __dma_inprogress is called in mmci_dma_data_error
> and mmci_dma_finalize.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

[...]

> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 696a066..f1ec066 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -332,9 +332,7 @@ struct mmci_host {
>         struct mmci_host_next   next_data;
>         bool                    dma_in_progress;
>
> -#define dma_inprogress(host)   ((host)->dma_in_progress)
> -#else
> -#define dma_inprogress(host)   (0)
> +#define __dma_inprogress(host) ((host)->dma_in_progress)

Please keep the existing function name.

If there are good reasons to change it, please make it a part of a
change where it makes sense.

>  #endif
>  };
>
> --
> 2.7.4
>

Besides the nitpick above, this looks good to me!

Kind regards
Uffe
