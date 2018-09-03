Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF0BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D8A2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="JPCG7suC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D8A2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeICGnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:43:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35717 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICGnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:43:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so10188584wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 19:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XHsnVB3EojNT1X0GEZwThbQDISbAijnu4BJjQ5DSdbo=;
        b=JPCG7suCZinmTE+uLiO7EZb5hbJDdD9mClXjcHbdrMVe/GRIiiVBys3IsOSLy6uHf7
         Op9HB0+eSxT4yZVnGbsyGNbzrZVEXT4v46PGTVaVRcofIH+z296Gn/Ti8YhOQ9giHBGE
         2f64/yDv0U+pLAi4HFDEXuyo7x0cNlU/gFUPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XHsnVB3EojNT1X0GEZwThbQDISbAijnu4BJjQ5DSdbo=;
        b=DNoF0wR6hgjVwbnSH57hFx73uEqM9ub/rTR4C2allxQVQGkBSBgrLOJLmTbr0I3DFl
         lAv+SSGWecq2/DteyulzsUWn+BQUPDZucLw6BkN+GKA/rZl0ZgAr3TCzttqRUthXseKL
         cBbv/xjM1WoR7UsRFcV5uA4SKGLFdok3K6GF7SZi0aqbEVmuPUIXxdUDoSKSlc0Ce1bj
         +WsPolM17mwZ6SEa80G+yaNfM+ajozOZ9dWi3MlIyi+dlzAZdBFYJ5mmLR+SC2anQ9xm
         j5URhS48BpATmA62WGnG50SOcFgb5yP5BXN13xWC2loq7Nzvgt3XB30IaChvFZK6aW86
         n5Ng==
X-Gm-Message-State: APzg51AxuBIliLTr0HVCK03eRNjMykGXSSA9zJ5V4l7gCYK7jrOMFK+9
        86pfaWW/OO+bkcugMq0cM2wALh478gfOAtQDG/3VkA==
X-Google-Smtp-Source: ANB0VdYG9DLYm5sZW8m1eCX5+zwVvY8FNZo20cu37CYHBrxOsVksy5BRAd+brlldefdXu+24+LgdiftDWUYD65CeYXE=
X-Received: by 2002:a1c:9a09:: with SMTP id c9-v6mr3759763wme.47.1535941509337;
 Sun, 02 Sep 2018 19:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180902064601.183036-1-alexander.levin@microsoft.com> <20180902064601.183036-68-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-68-alexander.levin@microsoft.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Mon, 3 Sep 2018 07:54:58 +0530
Message-ID: <CAFZiPx2_8qFMPHszT8C+x4oHNZhfzx=Oq9isjfdcibW+3Po8RQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.18 068/131] PCI: mobiveil: Add missing ../pci.h include
To:     Alexander.Levin@microsoft.com
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Subrahmanya Lingappa

Thanks.
On Sun, Sep 2, 2018 at 6:34 PM Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
>
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
> [ Upstream commit d3743012230f8dab30d47caba1f2ee9e382385e7 ]
>
> PCI mobiveil host controller driver currently fails to compile
> with the following error:
>
> drivers/pci/controller/pcie-mobiveil.c: In function
> 'mobiveil_pcie_probe':
> drivers/pci/controller/pcie-mobiveil.c:788:8: error: implicit
> declaration of function 'devm_of_pci_get_host_bridge_resources'; did you
> mean 'pci_get_host_bridge_device'?
> [-Werror=implicit-function-declaration]
>   ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         pci_get_host_bridge_device
>
> Add the missing include file to pull in the required function declaration.
>
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
> driver")
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  drivers/pci/controller/pcie-mobiveil.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index cf0aa7cee5b0..2c81be37b010 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -23,6 +23,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> +#include "../pci.h"
> +
>  /* register offsets and bit positions */
>
>  /*
> --
> 2.17.1
