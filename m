Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE42C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24F12087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4R8WQx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24F12087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeH1Pcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:32:51 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53379 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeH1Pcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:32:51 -0400
Received: by mail-it0-f68.google.com with SMTP id p79-v6so2207205itp.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ry4icOhj9HfTMxd8yngWOfJ+SwYJqnbINPTgBo3ffOs=;
        b=W4R8WQx3qxkLToEy2NksXBRRZoWOjAOtrBqkKGz7MqH6vnFf3ao/x5V0q9JLhref2W
         KvavZdMycnmEVUMx/9f1FZuBhEhrFcyjmnFX4SFQ4exoypEszc3DNFdxVQ8rT17L6cHN
         Oyw+eshES9ztI/7Ml7Po0z/IgUMh5aB9RJP6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ry4icOhj9HfTMxd8yngWOfJ+SwYJqnbINPTgBo3ffOs=;
        b=NnwDMbXaBotR0B9SJeDvQr6IhDqm7fWoIc3RZ67kzUVi0zViDZdoO/IjpwkEtfIfq3
         VokrROiUCUUIxWDo5qQ2EZ8DpEE5UTR0HzRv6tCRTt9G2nqLlkpno0OBeW0zbzWW2Wtt
         c8VXKiTR0L8SwcUYHDGuyZ2dVrLyOS2cQCUJe+RTK9AYEZT/mYPj/L4nAjZZISA/3Cpr
         VwIa+EfQVqbzIJLy9Tg84/bgXYFWfdrC/qBaFJeDvTest5XIh5AoQGozCtZbzUnfm5xg
         RH+8TIlRQlmOmXzY/5x2YfyByx56iytO4AFMskfOb39NfT1efkQ6IvFLPN9hJr0Hcfa+
         9D2w==
X-Gm-Message-State: APzg51C3Bxjqarmxr3XemdvHTJDUjZIqt7sB2m7WVZDMGhAF0eU6f9i/
        L+25XEgqD30qHwJqxXiV0m5Di5C07cAn/NRQGLaIjg==
X-Google-Smtp-Source: ANB0VdYJ1stl3n1bwtbQYqwHCRYRCCpSDOvEzckkj9SnW3qz26Y9+QuE/uUwhHNsu3lY4HsDTBp+aWkMbRtym+Dz67k=
X-Received: by 2002:a02:70d7:: with SMTP id f206-v6mr887581jac.142.1535456495680;
 Tue, 28 Aug 2018 04:41:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 04:41:35
 -0700 (PDT)
In-Reply-To: <20180828174534.00fb5e24@xhacker.debian>
References: <20180828174534.00fb5e24@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Aug 2018 13:41:35 +0200
Message-ID: <CAPDyKFpwCx_jReqHBsDh-Sc6zb+4sQGtLsH8QcQ1L=0GUqrcYg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] solve SDHCI DWC MSHC 128MB DMA boundary limitation
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 August 2018 at 11:45, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> When using DMA, if the DMA addr spans 128MB boundary, we have to split
> the DMA transfer into two so that each one doesn't exceed the boundary.
>
> patch1 adds adma_table_cnt to struct sdhci_host so that driver can
> control the ADMA table count.
> patch2 introduces adma_write_desc() hook to struct sdhci_ops so that
> driver can override it.
> patch3 finally solves the 128MB boundary limitation.
>
> since v5:
>   - use dma_get_required_mask() to calculate the extra adma_table_cnt
>
> since v4:
>   - add Adrian's ack to patch 1 and patch 2
>   - address Adrian's comment -- if the boundary is fine, we have to
>     return after writing dma desc once; adma_table_cnt updating could
>     make use of the fact that it's already initialized by the common
>     sdhci code, we just need to tune.
>
> since v3:
>   - s/adma_table_num/adma_table_cnt
>   - add comment to adma_table_cnt
>   - make the exported function name without the _
>   - let sdhci_adma_write_desc() accept &desc param and set the new desc
>     value
>
> since v2:
>   - make use of "likely" to check (!len || BOUNDARY_OK(addr, len))
>   - explicitly include <linux/sizes.h> for SZ_128M
>
> since v1:
>   - fix BOUNDARY_OK macro if addr+len is aligned to 128MB
>   - use DIV_ROUND_UP to cal extra desc num
>   - fix !len for dwcmshc_adma_write_desc()
>
>
>
> Jisheng Zhang (3):
>   mmc: sdhci: add adma_table_cnt member to struct sdhci_host
>   mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops
>   mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary limitation
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 39 +++++++++++++++++++++
>  drivers/mmc/host/sdhci.c            | 54 +++++++++++++++++------------
>  drivers/mmc/host/sdhci.h            |  7 ++++
>  3 files changed, 78 insertions(+), 22 deletions(-)
>
> --
> 2.18.0
>

Applied for next, thanks!

Kind regards
Uffe
