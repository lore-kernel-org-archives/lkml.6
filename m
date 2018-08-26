Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79ADC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CDB21722
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKZC3Rx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CDB21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeH0BFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 21:05:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbeH0BFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 21:05:40 -0400
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com [209.85.161.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0174A208A1;
        Sun, 26 Aug 2018 21:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535318516;
        bh=yzQteqtKfqzbr45HAQsnYRVEynVzN2NUiwZA0MTsBUQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GKZC3Rx6a/M+N/+3VsQQa2PqA0BgEq+xUMdZXyMgD3zy63gAgRCSEwAopzacmW5wa
         f3LanglsBgWIdXHEn5XxUndw8juHZsHYWIbn9t8MLnI6XcKOIsG5LJZnZ56K7bJsZX
         GHXpwEcPZYWfR3q3JXYxZnPeFuw1LMrwMG7RbUlI=
Received: by mail-yw1-f46.google.com with SMTP id n207-v6so4899380ywn.9;
        Sun, 26 Aug 2018 14:21:55 -0700 (PDT)
X-Gm-Message-State: APzg51DahT+on50oEryWnbKaWGoV9YJhYda0B/rD6NmcIXti/6Le7Mau
        shs03HdchFm293xUm7fYmhCSs6PW3BMrK/sLW5w=
X-Google-Smtp-Source: ANB0VdZbpJnppX8SguSDaHHEx+LlFzuJjaVWMwuHlicg1+lCr87zACpsygvxcXGRCq0weJX6vABfZmvfc5KBrAAy7Oc=
X-Received: by 2002:a0d:ec4e:: with SMTP id v75-v6mr5687058ywe.433.1535318515243;
 Sun, 26 Aug 2018 14:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180824152513.8336-1-mdf@kernel.org> <20180824152513.8336-2-mdf@kernel.org>
In-Reply-To: <20180824152513.8336-2-mdf@kernel.org>
From:   Alan Tull <atull@kernel.org>
Date:   Sun, 26 Aug 2018 16:21:19 -0500
X-Gmail-Original-Message-ID: <CANk1AXSTKorR6mJ81sN-yo0bpyT9B+7XvE5chTkUu-tiMWSOww@mail.gmail.com>
Message-ID: <CANk1AXSTKorR6mJ81sN-yo0bpyT9B+7XvE5chTkUu-tiMWSOww@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpga: dfl-fme-region: Use platform_get_drvdata()
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 10:26 AM Moritz Fischer <mdf@kernel.org> wrote:
>
> Use platform_get_drvdata() in remove() function of
> the platform driver rather than dev_get_drvdata()
> to match the platform_set_drvdata in the probe().
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan


> ---
>  drivers/fpga/dfl-fme-region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> index 0b7e19c27c6d..11d3c23a8936 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -65,7 +65,7 @@ static int fme_region_probe(struct platform_device *pdev)
>
>  static int fme_region_remove(struct platform_device *pdev)
>  {
> -       struct fpga_region *region = dev_get_drvdata(&pdev->dev);
> +       struct fpga_region *region = platform_get_drvdata(pdev);
>
>         fpga_region_unregister(region);
>         fpga_mgr_put(region->mgr);
> --
> 2.18.0
>
