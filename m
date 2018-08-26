Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03414C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849A32170B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGxtauAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849A32170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeH0BFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 21:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeH0BFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 21:05:00 -0400
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com [209.85.161.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 933C12170B;
        Sun, 26 Aug 2018 21:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535318476;
        bh=XOjJ8fzzc00QzisDodiodc3djXxGvuqWu2Xnn9q2xSo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lGxtauAh6bqDkcvcAROQyoHjP/d/YH1hYJRv2c1PaBtSXdFuMMB6i45TnrTUHCz10
         Rlazpx70QnfuI23XlWFcKTP/sNIFZqlLqcR7KGsbgMDwu9q8+llYEpt0uhICWiFBwR
         k82XRnCeGsYPzWopEhnwRO6ZXKTgnxFdcSzpf8HA=
Received: by mail-yw1-f51.google.com with SMTP id p206-v6so4895591ywg.12;
        Sun, 26 Aug 2018 14:21:16 -0700 (PDT)
X-Gm-Message-State: APzg51CzgXxE4kY+BOc1My2bC5ZWSoob37evJqdY6japDJeY9h8m6cI2
        5WiRtcW/rHscUJnOCkoV3/nzkJxfHNwoctvsuhc=
X-Google-Smtp-Source: ANB0VdbJUVpORpZ1NLoDM0io3i2LXeB7VJaTSTcJhzm9M1U7DTBrZjYTb/vihIWB89gSAfSbBS/n52neQaEBT4wVvYg=
X-Received: by 2002:a81:a097:: with SMTP id x145-v6mr5612509ywg.474.1535318475836;
 Sun, 26 Aug 2018 14:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180824152513.8336-1-mdf@kernel.org>
In-Reply-To: <20180824152513.8336-1-mdf@kernel.org>
From:   Alan Tull <atull@kernel.org>
Date:   Sun, 26 Aug 2018 16:20:39 -0500
X-Gmail-Original-Message-ID: <CANk1AXTuVbJLmtv_+L3Dr2GyQ+2gTjJFGwrtFsh0rMu2RbYzkw@mail.gmail.com>
Message-ID: <CANk1AXTuVbJLmtv_+L3Dr2GyQ+2gTjJFGwrtFsh0rMu2RbYzkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fpga: of-fpga-region: Use platform_set_drvdata
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 10:26 AM Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

Looks good.  Thanks for the patches!

>
> Use platform_set_drvdata rather than dev_set_drvdata
> to match the platform_get_drvdata in the _remove()
> function of the platform driver.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>

> ---
>  drivers/fpga/of-fpga-region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index 35fabb8083fb..8c6120e30930 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -421,7 +421,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
>                 goto eprobe_free;
>
>         of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
> -       dev_set_drvdata(dev, region);
> +       platform_set_drvdata(pdev, region);
>
>         dev_info(dev, "FPGA Region probed\n");
>
> --
> 2.18.0
>
