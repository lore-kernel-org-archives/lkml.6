Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEA8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281F02083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FpcJnp5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281F02083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407346AbeHATQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:16:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33836 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390457AbeHATQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:16:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id n96-v6so13884259lfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJ21CmLyzJjxpa5d5A+5XCX7HnX6XA3RPkUMCARv3eE=;
        b=FpcJnp5QEd/HDSCGJyzdnzdG2R9RwWPgw4s6xxDdrwT74b6TzSt4klI4kyAjdryv44
         UuSXECpL94jKoy0DcFUrEg38q3+uZFY9NlLd30ZTYeLHIdaX9a6MDtW+ebv0w+EtVIyO
         oE3XWgRlp2F5L94mcl5J5ffHqrb9ZfFcPcYa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJ21CmLyzJjxpa5d5A+5XCX7HnX6XA3RPkUMCARv3eE=;
        b=EldCNQ3eTecbjzNu/zIMH2Q1aiavcMJ9SXTmnlFBJl+X0rKnJFcupo42CvfnDHVzlz
         /NlYO0/NM9WPZoruG4pOfYVDd8Caoben9vNcX/zyIhV2tOwFxbw4DToXv8jczDwTl1xj
         9oJP8Hz8PaQ1pfVVl9B0Q8z8E7oBOJAqKK4T3YJQ8DxH/re64T8jekF4JZgsQpih2iFm
         z+yMucLleCgO26lmLd5GcT8lG7FjzgxPFD/celtS9tFCmdSWKRr4/quZYS/yFDnfuY/t
         jG00YyEboPT4npmTaxjkNaZEfm4p6gJgCh+bg6Xo67tBckJYHdEPe9K1ivVVYmm4U/DH
         MNzA==
X-Gm-Message-State: AOUpUlHUR42Brq32e4mbYj68g2fFfSyJjYH2N9mmJg6rnCH1vPcMCrEr
        mYeGzxdojwT1hoCJh3psBexLl4F3VoKRFX1x3GHugUUp
X-Google-Smtp-Source: AAOMgpfrO+NPmYr+YcP9laEsHho/GPntdhs4KF6f+ph0DDKNfshj2xIfd5/xD6oalaJdgw/7odMFlDpWmDQpne7c4qY=
X-Received: by 2002:a19:5788:: with SMTP id l130-v6mr17244735lfb.93.1533142854982;
 Wed, 01 Aug 2018 10:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <1533050894-33214-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1533050894-33214-1-git-send-email-zhongjiang@huawei.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 1 Aug 2018 11:00:43 -0600
Message-ID: <CANLsYkwFfBdnt5YdA7n36abg1rGEoh_UqPJ01pxDE69trF8cJg@mail.gmail.com>
Subject: Re: [PATCH] driver/hwtracing: use ERR_CAST instead of ERR_PTR
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018 at 09:40, zhong jiang <zhongjiang@huawei.com> wrote:
>
> Use ERR_CAT inlined function to replace the ERR_PTR(PTR_ERR). It
> make the code more concise.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 2eda5de..1196364 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -536,7 +536,7 @@ static void tmc_etr_sg_table_populate(struct etr_sg_table *etr_table)
>         sg_table = tmc_alloc_sg_table(dev, node, nr_tpages, nr_dpages, pages);
>         if (IS_ERR(sg_table)) {
>                 kfree(etr_table);
> -               return ERR_PTR(PTR_ERR(sg_table));
> +               return ERR_CAST(sg_table);

Applied - thanks.
Mathieu

>         }
>
>         etr_table->sg_table = sg_table;
> --
> 1.7.12.4
>
