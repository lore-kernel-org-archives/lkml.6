Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E6DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27C32145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N/fmOetJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27C32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeKUO1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:27:11 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36199 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKUO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:27:11 -0500
Received: by mail-oi1-f196.google.com with SMTP id x23so3437175oix.3;
        Tue, 20 Nov 2018 19:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Pk7kO/WAIOzpbIEJUuunb4KqRrIVh3tI3sbN8tWw6w=;
        b=N/fmOetJ/pk0xiQtCJMVOVSZ4Ydt9ocNGH4n7GmnEyPpR8cupNof6VtnsvsTWRh5C7
         kxUoUs8FJPkldGN4KA4k1g8BEHcKysuQKNsmEmycXF7nqjhTXuQUiyGb1UvHylxtfXU/
         mjfO8AnhqhQE2iZk8qFkZDXm3ttlGVNFtb/Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Pk7kO/WAIOzpbIEJUuunb4KqRrIVh3tI3sbN8tWw6w=;
        b=eVFZ3X0AMPD7HszTDCp0Bgj/Jw59eQ4MNafS0pMm4Fyw2anMf6OvOe6tXM9Bc9ueSO
         ObrC5vETZ6TCYBeynG20QtbS4ANSAi3dgYexcAMAaIUQbkaeEJqT+ckasWkaZtlrHpWB
         SO+ZjeCATzO6iGM/HoJ92r5zv+qBdNW2dY5QaqS5Gl4R4F411qnqurYA11qHD1XOXt22
         oSxQRJpaMsG6xxgnsGGFkN2gtrDCoyJYTKfV3dpXd8aaweMt5mAsaYqgSUbzatnthFY6
         fAcloewA3Ci30JtGlntJLtSc1SwmALzCDKK0Ff8OvgLduP+V27kO7uxe3Zkd474PVpUY
         G5Iw==
X-Gm-Message-State: AGRZ1gK2g3MtKi+7Bf1KIUgilQdkPG7qTCfByluET54yWwqy0iAilLF7
        RiuSRpmDzIoxHCEq4zljBfKYm8o5uSXffWHwqes=
X-Google-Smtp-Source: AJdET5ezwUpktbWdjwd8hw5DyPJyHNbPI0naNZb7ZfH0r3FzaVB/3DV1EVswpjrJMZjRvbOvBlX3TWLZe8Qd0OzSzQY=
X-Received: by 2002:aca:50cf:: with SMTP id e198mr2770970oib.343.1542772473157;
 Tue, 20 Nov 2018 19:54:33 -0800 (PST)
MIME-Version: 1.0
References: <1542767703-1984-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1542767703-1984-1-git-send-email-Anson.Huang@nxp.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed, 21 Nov 2018 09:24:18 +0530
Message-ID: <CAOh2x==PecS4OzoX3UagBE0RjQL-0BBC=r=MAaO3cA2MczrA=A@mail.gmail.com>
Subject: Re: [PATCH V3] thermal: imx: fix for dependency on cpu-freq
To:     anson.huang@nxp.com
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        l.stach@pengutronix.de, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 8:11 AM Anson Huang <anson.huang@nxp.com> wrote:

> @@ -830,8 +851,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  clk_disable:
>         clk_disable_unprepare(data->thermal_clk);
>  cpufreq_put:

While at it, rename this label as well to something like legacy_cleanup.

> -       cpufreq_cooling_unregister(data->cdev);
> -       cpufreq_cpu_put(data->policy);
> +       imx_thermal_unregister_legacy_cooling(data);
>
>         return ret;
>  }
