Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7C7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E9E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVKLtbG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E9E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbeK1Dtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:49:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeK1Dtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:49:51 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68ADF21104;
        Tue, 27 Nov 2018 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543337481;
        bh=/bwPPknpNZag5mkBmtvyh1J4ESMUK2rWtT8yz5yC5yw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NVKLtbG42uQb4hQ9i2G5NkEwDXPja9sVEgAkkmt8w4c2mJdWreoOzcMvZoxmdGqe2
         yWcVC/yfsY5eVhKCGYuGPtLifMNX8B5PwCERgc09X+9CUzqPTUnFngf4K3JsvQmqnX
         v4cf8O430qJb5lVC+JfXDhdSr55rrLDXHK2Befo8=
Received: by mail-qt1-f180.google.com with SMTP id l11so22539439qtp.0;
        Tue, 27 Nov 2018 08:51:21 -0800 (PST)
X-Gm-Message-State: AA+aEWYAJE1/Rw/tXkB/TcxONlGAtka+gc9siqLY+fnPKnM7gmPpwA6d
        NPQwmzYXL2u5widX/DZ8Hv67Gx+gAbagpQ51QA==
X-Google-Smtp-Source: AFSGD/Uo01ZCkWh2asafOYULEdwHl7J/ERup97zdARhvZylfPrnfXo3wcxm1njR4Bc2HqQbUIV9q/7m0UDaHzuNspXU=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr32509883qvl.77.1543337480622;
 Tue, 27 Nov 2018 08:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20181124143138.28999-1-tiny.windzz@gmail.com>
In-Reply-To: <20181124143138.28999-1-tiny.windzz@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 27 Nov 2018 10:51:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ8XkowAJQjZoiuucAWqZuJh1ep2jCFor6NCq4pL3m-Cg@mail.gmail.com>
Message-ID: <CAL_JsqJ8XkowAJQjZoiuucAWqZuJh1ep2jCFor6NCq4pL3m-Cg@mail.gmail.com>
Subject: Re: [PATCH] power/reset: axxia: Convert to using %pOFn instead of device_node.name
To:     tiny.windzz@gmail.com
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 8:31 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/power/reset/axxia-reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, but I already sent out the same patch and have queued it since
no one picked it up.

Rob
>
> diff --git a/drivers/power/reset/axxia-reset.c b/drivers/power/reset/axxia-reset.c
> index 4e4cd1c8fe50..b16013265142 100644
> --- a/drivers/power/reset/axxia-reset.c
> +++ b/drivers/power/reset/axxia-reset.c
> @@ -65,7 +65,7 @@ static int axxia_reset_probe(struct platform_device *pdev)
>
>         syscon = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
>         if (IS_ERR(syscon)) {
> -               pr_err("%s: syscon lookup failed\n", dev->of_node->name);
> +               pr_err("%pOFn: syscon lookup failed\n", dev->of_node);
>                 return PTR_ERR(syscon);
>         }
>
> --
> 2.17.0
>
