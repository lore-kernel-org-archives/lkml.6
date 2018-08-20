Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82543C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3772172D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tV0V4iAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3772172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbeHTVDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbeHTVDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:03:48 -0400
Received: from mail-yb0-f172.google.com (mail-yb0-f172.google.com [209.85.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0AA521473;
        Mon, 20 Aug 2018 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534787234;
        bh=aY2su6ecetACGrhnTTL3bQqpoRmzHKZDkLxWMxFX1Yg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=tV0V4iAt9LdpQ1puz2oa+LgKcKY2zK4sm7vtOGIDZ26d6ihcnGNfO+tac4fpiocpi
         bmp0q+6mdqzB6Y7QCAWNIHSULYC5xxghZUTViQfSwUd2Qoudh3Yq8vPSK/w+DPVbKC
         KjhovkOXJm6Rw3lKnU3n/NW41r4/BbIecuLIKVbM=
Received: by mail-yb0-f172.google.com with SMTP id f4-v6so4925049ybp.7;
        Mon, 20 Aug 2018 10:47:13 -0700 (PDT)
X-Gm-Message-State: AOUpUlHEttZ9E/nMJQ0EpkvMbeIljzDiOfSUsxm6VJeBiWuJhL1Jv0Lj
        Gx5WLqMTPsbEGuZkWjmUNSaURquilkxkSnKGGcE=
X-Google-Smtp-Source: AA+uWPwsGcPG/qOF11h1oN3v6srSQbD+Q1Ue8IqH5chwYDIozxCb4oZE0/o6O4t1thLIDbXoMu78DZmDw3cqk29lKSY=
X-Received: by 2002:a25:db83:: with SMTP id g125-v6mr6373470ybf.412.1534787233066;
 Mon, 20 Aug 2018 10:47:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:81c4:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 10:46:32
 -0700 (PDT)
In-Reply-To: <20180820171818.7710-1-mdf@kernel.org>
References: <20180820171818.7710-1-mdf@kernel.org>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 20 Aug 2018 12:46:32 -0500
X-Gmail-Original-Message-ID: <CANk1AXSMSLGCcaRcZo4TWKEJW+YUQqbHWEuHpz_csF5J1m-Sew@mail.gmail.com>
Message-ID: <CANk1AXSMSLGCcaRcZo4TWKEJW+YUQqbHWEuHpz_csF5J1m-Sew@mail.gmail.com>
Subject: Re: [PATCH v2] fpga: dfl: region: Restory symmetry in probe()/remove()
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 12:18 PM, Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

> Replace dev_get_drvdata() with platform_get_drvdata() to
> match the platform_set_drvdata() in the probe function of
> the platform driver.
>
> Fixes commit bb61b9be3e6b ("fpga: dfl: add fpga region platform driver for FME")
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>
> Changes from v1:
> - Still compile after change ...
>
> ---
>  drivers/fpga/dfl-fme-region.c | 2 +-

Thanks for catching this.  of-fpga-region.c does a similar thing and
needs s/dev_set_drvdata/platform_set_drvdata/ in the probe.  Could you
fix it here too?

Alan

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
