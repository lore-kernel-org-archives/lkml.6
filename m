Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EF0C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E31206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhttaXW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E31206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeI2ENd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725266AbeI2ENd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:13:33 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404C7206B8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 21:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538171273;
        bh=xkUumvK2BkCGk7TbKuKqjHQctLrymKGVJHxNd8Y+Wu8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PhttaXW3EwaLnsaexOuWLvpYGrCslnSXnqDF7sOkh5yXjlaaW64+CJ6NcZNVG1tK7
         XBSjPv9PV0bK8y1hhE3Y5h0wnZgxz2Q+41h2lmBVU7GpA8v8HXAwL+rwcOYDZEaK0M
         9Qspn8E+tjpQQ5j8uC24BSlXLpZNwhqFcG5P+0tc=
Received: by mail-qt1-f179.google.com with SMTP id n6-v6so8312955qtl.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 14:47:53 -0700 (PDT)
X-Gm-Message-State: ABuFfogoVTJBahddcyvDGI0zbwPmsWAjog3yWX8yviLnAxVEfiFYBOMA
        XEoilYQPZeawbKZm3MK+kdZ/Ec9pr1JBFc4yeA==
X-Google-Smtp-Source: ACcGV63IWb3oxzl3ITZMDFxauwk9IUxRQj/SojwcKyjEzUkA+8cfRuLZyLp8BidGkQB1Gj7uQhPkBDhHCEVcLHmwRU0=
X-Received: by 2002:a0c:db87:: with SMTP id m7-v6mr439600qvk.90.1538171272475;
 Fri, 28 Sep 2018 14:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-17-robh@kernel.org>
In-Reply-To: <20180828015252.28511-17-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 28 Sep 2018 16:47:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJfWuL5NwXU_Ar76=MHgBeMPJqgDu9F8V+A=mC3Dor=9w@mail.gmail.com>
Message-ID: <CAL_JsqJfWuL5NwXU_Ar76=MHgBeMPJqgDu9F8V+A=mC3Dor=9w@mail.gmail.com>
Subject: Re: [PATCH] firmware: Convert to using %pOFn instead of device_node.name
To:     Sudeep Holla <Sudeep.Holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 8:53 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/firmware/scpi_pm_domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sudeep, looks like I missed Cc'ing you (or anyone) on this. Can you
please ack or apply this.

>
> diff --git a/drivers/firmware/scpi_pm_domain.c b/drivers/firmware/scpi_pm_domain.c
> index f395dec27113..390aa13391e4 100644
> --- a/drivers/firmware/scpi_pm_domain.c
> +++ b/drivers/firmware/scpi_pm_domain.c
> @@ -121,7 +121,7 @@ static int scpi_pm_domain_probe(struct platform_device *pdev)
>
>                 scpi_pd->domain = i;
>                 scpi_pd->ops = scpi_ops;
> -               sprintf(scpi_pd->name, "%s.%d", np->name, i);
> +               sprintf(scpi_pd->name, "%pOFn.%d", np, i);
>                 scpi_pd->genpd.name = scpi_pd->name;
>                 scpi_pd->genpd.power_off = scpi_pd_power_off;
>                 scpi_pd->genpd.power_on = scpi_pd_power_on;
> --
> 2.17.1
>
