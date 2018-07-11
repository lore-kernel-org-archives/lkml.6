Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DD8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2B720849
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flLMiwCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2B720849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbeGKH0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:26:21 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43772 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeGKH0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:26:21 -0400
Received: by mail-ua0-f194.google.com with SMTP id x24-v6so15587815ual.10;
        Wed, 11 Jul 2018 00:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6kqBGmdqqsi0A/rQyOXB4uOi+kXF7fjB/fSTA1rqEDk=;
        b=flLMiwCdkPX/Z/3kMO+tDMCIHAg16nicRYZfEe3Fkrd45XpNokUB0Uf+43Qov5ryQd
         tci4g636MhJfD8q/7pat54t1q7J636S+NOgQWBaLDdRgF74V90hnKTzL/1hA0LidSx7a
         4hYEae8ANMMyvwt2Xxu3nwTKNLbH4VpC+7fdWueLyIUMK1iOf9Td4QcUsRy2o1s8ZTO+
         l/0Ukx8wZ7NaMPqKd+WgiCW+FFd9MGS36fTRGMVztSBdmSUg3ObG/2moYaepgc28oTb9
         KNOp3d7W1PJM6ZgQ+8co3LwdF8NjqUYDSp7tRV7dI8KCvk53tkvWShpflzkgUVM5MXwJ
         9kJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6kqBGmdqqsi0A/rQyOXB4uOi+kXF7fjB/fSTA1rqEDk=;
        b=sV131P5aNP6D4wDh7h2hRfCprR5GTkAd0ibImn/IH41xqR/JneQ4eMBGGDiThxCfIJ
         hgBULShZ/WZMH1Enl4lKV606aUh7Hc4bwmYXRBE79AI50Vn6LL43f2pvfifunG61BtUX
         zQYYU/6YKlHJm0RIbc3L4f4LGJWGFawtLSiI15mOYW17ZuwSQ5Ec4Cn2gFjHpIg+LpWh
         KM7r8dnBSqrtH4fb+YI4wsb14ap5+nOx7H511AXqIpdWYMDAQydL5GGCSykHTi/nSBRu
         QR+/MdbappK/4HFlZeb49Yz3564sFiNQgtUyIJjLCDyHCtDL6pRa+TvjLQrtGDICeSkP
         sZfw==
X-Gm-Message-State: APt69E1acjKXhhDKTL8jguDiy1n0sUWawvpQZViMd4EjHieQigINy4AA
        vfXJljWPYv++8GxywYoclQIRGfLsVTkHml367Yg=
X-Google-Smtp-Source: AAOMgpdp+biMh9E/E03LBXDZDzmPnESxTmt2RDzSNj45bpAJW1aMTkIu9YkraGCfpIGLtcQ88Nd8OmSm18d4lNIk0TM=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr17372945ual.28.1531293809427;
 Wed, 11 Jul 2018 00:23:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 00:23:28
 -0700 (PDT)
In-Reply-To: <20180711065724.128299-2-songxiaowei@hisilicon.com>
References: <20180711065724.128299-1-songxiaowei@hisilicon.com> <20180711065724.128299-2-songxiaowei@hisilicon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Jul 2018 10:23:28 +0300
Message-ID: <CAHp75VfqGC5KNi4mCc3Q0bD0jXb4bkkdYFSv3LDQw5E=goc2Pg@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] PCI: kirin: Add MSI support
To:     Xiaowei Song <songxiaowei@hisilicon.com>
Cc:     Wangbinghui <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Yao Chen <chenyao11@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 9:57 AM, Xiaowei Song <songxiaowei@hisilicon.com> wrote:
> Add support for MSI

> +static int kirin_pcie_add_msi(struct dw_pcie *pci,
> +                               struct platform_device *pdev)
> +{
> +       int ret = 0;
> +
> +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +               ret = platform_get_irq(pdev, 0);
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev,
> +                               "failed to get MSI IRQ (%d)\n", ret);
> +                       return ret;
> +               }
> +
> +               pci->pp.msi_irq = ret;
> +       }
> +
> +       return ret;
> +}

Like someone already noticed, is it really IRQ number you would like to return?

If you rewrite like

int irq;

if (IS_ENABLED(...)) {
 irq = ...
 if (irq < 0)
   return irq;

... = irq;

}

return 0;

It would be slightly more explicit what you do and what you return.

-- 
With Best Regards,
Andy Shevchenko
