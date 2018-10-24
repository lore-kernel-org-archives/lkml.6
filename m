Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48389C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3912075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OCrHk9yM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3912075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeJXT12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:27:28 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35765 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeJXT12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:27:28 -0400
Received: by mail-it1-f193.google.com with SMTP id p64-v6so6018528itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4KbEukfe2E0Nq1yDbXbDoovNt5xKMaz706naFLobtSc=;
        b=OCrHk9yMxusgjWI3cJFxPJbwFjASBDnb8WV+tXcoJ3QG6ScCcNHOJF2//JUQGvAwJB
         taTy0tqKkySBkkxA1hN5ni7LmMwKaWBK6PzXDssuhsW+WOJtXgjcOSy8xUJbcOc1f96j
         IFxImrj+lcAW7RirpCVyTxttGmBklkvi65ti8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4KbEukfe2E0Nq1yDbXbDoovNt5xKMaz706naFLobtSc=;
        b=bCISErN5oZFNOh2J7wmgD4N8j8LZbbzzbUqvktTJbvZMfZgGZrreCziOZHzCMILYXw
         mA4PQzBdgiBtfAQEpMaSAcobJnwfU2Q7+XAbbUZ40s/hKP8qrRtSRgsNSsa6ksbOWmGM
         SeiJPIdu+ls66kLOZtTBKIWXBZCMmv1mYToery6N+L4j8Rdr9yuSEhvVyYX4vMv4BN+f
         b0gYXeeQVjNYGt/qwbx5qlaPFOc2iCi82A0rDqA/C0/OdWWqQ/QxxCLF9Vho4mfimKWl
         3LSvtbnxIwMjjCi+znZxoYK4ckTxsc7/wRO/DkWsB706Reex5x7o3ScyfbIg+bMJMgjL
         /R5Q==
X-Gm-Message-State: AGRZ1gKDDfCl24qQsSkmDSGZmGjC6q/f41iSmz/mLdWRZMfBnYrfk/Bk
        OLKFXZXwsEa5//uxSjz/2x83p6p0K5BCknZvwKY2TA==
X-Google-Smtp-Source: AJdET5flaTJ8RHeSu8fms5gxi5W1X4DHwzg9IDL3QU84d3PznsEkV0pm2NwDm7AuZQVatnqecTVisk/il87yUrEIZmU=
X-Received: by 2002:a02:5f96:: with SMTP id x22-v6mr1328972jad.43.1540378789721;
 Wed, 24 Oct 2018 03:59:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Wed, 24 Oct 2018 03:59:09
 -0700 (PDT)
In-Reply-To: <d9e592c4b8082f77fc219764a26f50dec434d8fc.1539890997.git.lsun@mellanox.com>
References: <d9e592c4b8082f77fc219764a26f50dec434d8fc.1539890997.git.lsun@mellanox.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Oct 2018 12:59:09 +0200
Message-ID: <CAPDyKFowhnOp+YjXJyBVbxjKgwBfFyC+_5omTeZ4F4QGp6b15g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: dw_mmc-bluefield: simplify the probe() function
To:     Liming Sun <lsun@mellanox.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        David Woods <dwoods@mellanox.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 October 2018 at 16:26, Liming Sun <lsun@mellanox.com> wrote:
> This commit removes the unnecessary of-node check since the
> dw_mci_bluefield_match[] structure has only one entry.
>
> Signed-off-by: Liming Sun <lsun@mellanox.com>

Queued for 4.21, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc-bluefield.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
> index 54c3fbb..ed8f225 100644
> --- a/drivers/mmc/host/dw_mmc-bluefield.c
> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> @@ -52,16 +52,7 @@ static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>
>  static int dw_mci_bluefield_probe(struct platform_device *pdev)
>  {
> -       const struct dw_mci_drv_data *drv_data = NULL;
> -       const struct of_device_id *match;
> -
> -       if (pdev->dev.of_node) {
> -               match = of_match_node(dw_mci_bluefield_match,
> -                                     pdev->dev.of_node);
> -               drv_data = match->data;
> -       }
> -
> -       return dw_mci_pltfm_register(pdev, drv_data);
> +       return dw_mci_pltfm_register(pdev, &bluefield_drv_data);
>  }
>
>  static struct platform_driver dw_mci_bluefield_pltfm_driver = {
> --
> 1.8.3.1
>
