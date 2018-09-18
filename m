Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5FFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746E020C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXUMSyMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746E020C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbeISBTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:19:48 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54835 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeISBTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:19:47 -0400
Received: by mail-it0-f68.google.com with SMTP id f14-v6so5021822ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tvwoQzC8hI7IcRh+/+7aF0Dtd4gEMwC8X/raTfa6fDc=;
        b=PXUMSyMKhKnd8gMhfj3ynERXkBd4x70RJTR7z+tU8IyL0ZAbvdmhPTnELgQA7hygPB
         1CoOaSvDZGi892I+GRfA9o6PKvbihbxekS58OjDkcZUNCZi1SAGQSRbpBjuRK17NbFTq
         JgsrGEHHXiNCoDDQjQJdPv7ohjXaRJgCBhZGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvwoQzC8hI7IcRh+/+7aF0Dtd4gEMwC8X/raTfa6fDc=;
        b=pTa+lzSf10sSC2XpKVukNTh55IjXXF5P+aAnukBIlUPtAzeDYTn4QMqDHjvjOuWpWz
         7ssMBwRpVMOX1sOuzLVUmvNnx2LMN410JV6UAsAeVqZp62pbtWrG4KJtPzTZdNoJgSNo
         8O9eeJG/vOT7AfxRl+4n/TMKicfGuqvgVz4Lr5TB+9g1yIC7qFIKflr8bhOIDyBHi5T2
         4YNI5ypKN2oxlXvn6iZRpmc8ps2lS8fS+JJSCyb4Ra0MtP3qWcoSNzOoXpByj+pQlaly
         FxDh9l8yT1PFNfarBx2ijBFaXAXo3NdyXxaYSFyzCeVJtFIf0cQIyuW8WG4tYX5dtLSa
         MwUA==
X-Gm-Message-State: APzg51Dd5pbtLpuEpe3mse298afkyoEOWpLm/4xGU5IhJhW1KuliG8Zu
        efh2Rnt8n/6Y3taJceWq4wN4fi48Pw3IMGojMCrV4Q==
X-Google-Smtp-Source: ANB0VdbeCRiseaIA96haRa4r623W6oLoNf6nlKAjY4fUEFLbrQxOOs8SuJtlr29Ansbl1SWEOfeYX63ErRdYU3Do75I=
X-Received: by 2002:a24:7605:: with SMTP id z5-v6mr6751603itb.62.1537299941809;
 Tue, 18 Sep 2018 12:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <17ff79fcf3df7c7208b6cda6f207e5e96c4d6c7e.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <17ff79fcf3df7c7208b6cda6f207e5e96c4d6c7e.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:45:28 -0700
Message-ID: <CACRpkdYmx6yDjaxa9eGro9Ld9FK465X8x-u=8kBERYEYjiYm_A@mail.gmail.com>
Subject: Re: [PATCH v2 05/22] pinctrl: mediatek: extend struct mtk_pin_soc to pinctrl-mtk-common-v2.c
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Add two parameters gpio_m and eint_m for configuring GPIO mode and EINT
> mode, they might be varying depend on SoC.
>
> Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
