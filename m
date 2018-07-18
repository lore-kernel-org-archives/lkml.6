Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BE0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C15A2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="zM6bNJOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C15A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verdurent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeGRK6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:58:39 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43858 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeGRK6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:58:39 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so7747334oib.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bmq/5HbomXQbIA8MFB9oU6QJ/XER71D3GZoHtxQ6SGw=;
        b=zM6bNJOQBwEbmiamoENbK5QLMnb9Q8ua8ucT4QpMhOrjMOe2iDeXAPYn4rJ5CThg+n
         t9vSCSwbgAN+S58FrQMqIQDXuI11v7Rc0WMvvSlRtUCRKg+VK+bUjymdhSBCfVFtKIb5
         EmD+VEb8XZ78fkMAkvs/+P5vqbXM64kIVWKkQY/E3euf1ChoXHQqhz2m/MyJt8mdcig8
         lWMojIb2WWyZSu8eF31GIvFGxmQgsuarlPti9b/Q6/65X+vkJ9c1vk/XW6qZsu+wmHiN
         o5xXoUXlfq4P2nDTzd1zjKPyzhKrYW+lax0wLag9s2OZMV04/PilBVH5d/Jxvjnh9jie
         2R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bmq/5HbomXQbIA8MFB9oU6QJ/XER71D3GZoHtxQ6SGw=;
        b=fq8yCjYnmbNS9ec8CiZ7+tjDwiuMcoxcaEHqXEFAc8VxvKhbXTG+ik/Lqv2SFU19hk
         U6v+QbzPBAtoJJ5USWHrIo3LQoJxvbj54aJA7dCJTBStmVxWCnc1Uuc2j5L5MLWZcYwB
         Plff4yFcxK10xgrkjZYYLInGRsZgKczArJgnEI2az/9Tdhv8FbU6h9WiVNFnHn6Rip1z
         4bFamXK5bVhMPhOF/9/Vy6hZA04Afb/tD3iMc6TyTs5wINN3/5+uvQAiA+lXqlQoylje
         q7ZtLApkavHcAjnMs74RbSR9oXIIcS3LpUUm3KWLmlxlJZRvbOQW+otX0MiI7uQ2nZJ3
         0nSA==
X-Gm-Message-State: AOUpUlG+sEGOpGJOlAGU+fr7N+9wnnDs5sHvcXmC36N19n9tJiY36ZJ+
        5TDjI/XSfhEL5p4VkPeVWPbwsUHSZIL6RxszIuDYdg==
X-Google-Smtp-Source: AAOMgpdU2QWUkEXiajsBmxbr9EfRBhpshPjXr2+UTCMNbIKiywUwlpZqEha5uDU4sLyQoy6XJ0Tikg6KE7S1kFyKQyc=
X-Received: by 2002:aca:e450:: with SMTP id b77-v6mr6193127oih.0.1531909286371;
 Wed, 18 Jul 2018 03:21:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3745:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 03:21:25
 -0700 (PDT)
In-Reply-To: <20180717204821.15987-1-niklas.cassel@linaro.org>
References: <20180717204821.15987-1-niklas.cassel@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 18 Jul 2018 15:51:25 +0530
Message-ID: <CAHLCerMfcjjjEmHZthA23V1WfrS6x05h2a-LZRpQjCKLyZVSzQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: qcom-kryo: Silently error out on EPROBE_DEFER
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Ilia Lin <ilia.lin@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 2:18 AM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
> If of_nvmem_cell_get() fails due to probe deferal, we shouldn't print an
> error message. Just be silent in this case.
>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 29389accf3e9..b8d1e6875f16 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -109,8 +109,9 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>         speedbin_nvmem = of_nvmem_cell_get(np, NULL);
>         of_node_put(np);
>         if (IS_ERR(speedbin_nvmem)) {
> -               dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
> -                       PTR_ERR(speedbin_nvmem));
> +               if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
> +                       dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
> +                               PTR_ERR(speedbin_nvmem));
>                 return PTR_ERR(speedbin_nvmem);
>         }
>
> --
> 2.17.1
>
