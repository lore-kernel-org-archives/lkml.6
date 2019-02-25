Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E04C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E4421871
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UT+ZbmKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfBYXza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:55:30 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40280 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbfBYXz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:55:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id w6so9088953ljd.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 15:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYbJU7KLt5fEwcgGrnxctZm7wSA32fxgxnmdAdViJBo=;
        b=UT+ZbmKg075BMaoRB3dhU31fxp6X1Tf7UHYXVQYaK8UAfVWUk/ZwXVhmbxnTcYJ81q
         c676Cv+YcqLBgfy8NFHZHV58ZwllODWoGj4WqRxk9FvCasx3FU0WjRhsuLmOREqVmxJI
         dtA4oDX3k8kRvxo3hDxECsOCT2ad3sKa6QnL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYbJU7KLt5fEwcgGrnxctZm7wSA32fxgxnmdAdViJBo=;
        b=Je2Wbjr/S1CnBElbjTFCHD7TWiocFvUGqKrZdqoM4Np95pophsJhz8fDeXsh5pgFMl
         T88vF2xGmJgx7vzs8Ak3Cxfy11GImNYpkv9BbS8pGDCfWpXx0PXy2UtNn/2NEeo24/qx
         OWuteDRAlM/VrpP71onWqx8uQJWETjdJKMZLKlbH7sX77WiZd7z5FU5/E5L09iDfLMkQ
         RIWkecX06Dj6azf90reADZuf4VCz8Q8Rdd+/IS3SlUrB6ty2Lnr9Q4HR39kF53yPb4i/
         /8YvxI1PoQv+/lGoCJOGb3kFVMSJkyI+eeCkkAl+loIa4N3SfNWlSmc1suy+D7Taj2Bm
         2cBg==
X-Gm-Message-State: AHQUAuY7Mp44nXxP6q4RpI9HJg9XoAFYf1qoRF+eIbuOON92cwRseq1O
        zz6ZFY4zgX/+YKiB+02fTluq73GpKyk=
X-Google-Smtp-Source: AHgI3IYjxwk1NqHAGXRVV+Kt+12+KiHrN+xMdSADr596b3HPKPmLENC6QaVAgLDcCSI0a38DBZ5m9Q==
X-Received: by 2002:a2e:9e09:: with SMTP id e9mr5881157ljk.14.1551138927406;
        Mon, 25 Feb 2019 15:55:27 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id q12sm514597lfc.8.2019.02.25.15.55.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 15:55:26 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id w6so9088908ljd.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 15:55:26 -0800 (PST)
X-Received: by 2002:a2e:99c9:: with SMTP id l9mr11481483ljj.60.1551138926072;
 Mon, 25 Feb 2019 15:55:26 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com> <1546318276-18993-6-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-6-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 25 Feb 2019 15:54:50 -0800
X-Gmail-Original-Message-ID: <CAE=gft71J+5ui_FFm4D+62uSy6KHYzT7wru_NNdPsvrCDV3ekw@mail.gmail.com>
Message-ID: <CAE=gft71J+5ui_FFm4D+62uSy6KHYzT7wru_NNdPsvrCDV3ekw@mail.gmail.com>
Subject: Re: [PATCH 05/13] memory: mtk-smi: Add device-link between smi-larb
 and smi-common
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Normally, If the smi-larb HW need work, we should enable the smi-common
> HW power and clock firstly.
> This patch adds device-link between the smi-larb dev and the smi-common
> dev. then If pm_runtime_get_sync(smi-larb-dev), the pm_runtime_get_sync
> (smi-common-dev) will be called automatically.
>
> Since smi is built-in driver like IOMMU and never unbound,
> DL_FLAG_AUTOREMOVE_* is not needed.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 9688341..30930e4 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -271,6 +271,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct device_node *smi_node;
>         struct platform_device *smi_pdev;
> +       struct device_link *link;
>
>         larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
>         if (!larb)
> @@ -310,6 +311,12 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>                 if (!platform_get_drvdata(smi_pdev))
>                         return -EPROBE_DEFER;
>                 larb->smi_common_dev = &smi_pdev->dev;
> +               link = device_link_add(dev, larb->smi_common_dev,
> +                                      DL_FLAG_PM_RUNTIME);

Doesn't this need to be torn down in remove()? You mention that it's
built-in and never removed, but it does seem to have a remove()
function that tears down everything else, so it seemed a shame to
start leaking now. Maybe the AUTOREMOVE flag would do it.
