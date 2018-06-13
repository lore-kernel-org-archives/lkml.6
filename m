Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EC7B2C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99187208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="0mKzyoVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99187208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935561AbeFMMmI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:42:08 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40720 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754467AbeFMMmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:42:06 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so3711399lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 05:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f7MMz8SVO3y9MIoVz+hhmJfnY8gjRKfvQ9L0Ay1IlDo=;
        b=0mKzyoVpwKAsLbFXh/PUGEgSgbhhXzcz4EU/a5u9RChlhnsL/sVXuSeKwnyygNasGG
         IPcOcSic8MA95y/hBEnH6AchYmAQoOOJd493IJM6ZIe6oxRPADyvV/v/dT1M0q8fQ3U2
         Jhjn0PStUhXw8F28tsh1eDKcyvvX4y25w/E0b8UXcoPL0tdHSz3yhvE6K3zHceubkqup
         pRpU2wbMq81VKh6XmYExABz5LZJ3sHutYgd1uPwZkv7RjFkfNnUot/tp7Uwi5NJKepJm
         v4jmNPemNE4I+TIjSp7QmNFQyOceoss59zveKjTnxmI01Jih7oSprE+Wi8DjFWndWlgB
         urIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f7MMz8SVO3y9MIoVz+hhmJfnY8gjRKfvQ9L0Ay1IlDo=;
        b=L/pOFvrnCVrZ3Td0l4Q9cFH7l6oMvH2OauFy5ZsY7OpFvKszHIi9SZXK68bhs78IsG
         Cff2ilAih5y86L22Yp7h0R4qyt2YE5KT7hTvUrVS+rJJtNzkw58neXlhA1ZqBsec7S7M
         AI3czuzFi1/Qb7NAMtcTN7xbC58mI7U9n25xWr4HMM2pusFiIZHvXGO1dMn6KJxQLQqI
         qKgzfnLpMcm3uxlwHLh6583S+l/Ub6ccChO0rRXmvWmCSGGsKbllsblbYGaoA/Fbnpbh
         /h1bKV1yYnHnNfmhkmmJY89275TGAthD08niGX6BP7HccFeDFZyyODPNzGDV6OvBGB1y
         licw==
X-Gm-Message-State: APt69E27zbGgmX+s1R5RpOyOKbz8fcnKb0hsMDE8JdCKVYwbikHbLSV4
        k4CwRtjI3E2UYMSy3VfT46pMTDl3JXgWkUH0ypRACw==
X-Google-Smtp-Source: ADUXVKKqL9F1SzCdyS1tSB6z5JjZiSr8WiD37AV2OTU7hWFvKILebD6lYS50XAXYtTWSAJbPMH81mSZmork0tDE9MVg=
X-Received: by 2002:a2e:889a:: with SMTP id k26-v6mr3043455lji.54.1528893724764;
 Wed, 13 Jun 2018 05:42:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:2e11:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 05:42:03
 -0700 (PDT)
In-Reply-To: <20180611172049.26630-1-christophe.jaillet@wanadoo.fr>
References: <20180611172049.26630-1-christophe.jaillet@wanadoo.fr>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Wed, 13 Jun 2018 07:42:03 -0500
Message-ID: <CAAtXAHdF_AEcohGW=yoUgoe1OWcxLeCYgp2u3pjsmUn=-z-_bg@mail.gmail.com>
Subject: Re: [PATCH] fpga: altera-cvp: Fix an error handling path in 'altera_cvp_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

good catch!

On Mon, Jun 11, 2018 at 12:20 PM, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> If 'fpga_mgr_create()' fails, we should release some resources, as done
> in the other error handling path of the function.
>
> Fixes: 7085e2a94f7d ("fpga: manager: change api, don't use drvdata")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/altera-cvp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index dd4edd8f22ce..7fa793672a7a 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -455,8 +455,10 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>
>         mgr = fpga_mgr_create(&pdev->dev, conf->mgr_name,
>                               &altera_cvp_ops, conf);
> -       if (!mgr)
> -               return -ENOMEM;
> +       if (!mgr) {
> +               ret = -ENOMEM;
> +               goto err_unmap;
> +       }
>
>         pci_set_drvdata(pdev, mgr);
>
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,

Moritz
