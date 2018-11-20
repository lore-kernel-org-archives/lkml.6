Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4DEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EC620671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TLhq242d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EC620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeKTVRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:17:25 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41827 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbeKTVRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:17:25 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so1106898oii.8;
        Tue, 20 Nov 2018 02:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfuChNTdIwHfhgY3ojNZWOJaMS/vf5e4JBNm3xaQn48=;
        b=TLhq242d9kb2mwhcxbvDCBUQNqTTl+YORw5LL8hVvsNp/OHxCPbwvChk2uztQit0DS
         mjUh+mUxME8LJrqvhj+or//8AVQKTNymqlqNDYDrv9j3xG2eASXvUpyOIorQCMiO/GLr
         RZBo2fclFlN9nNsj7wxy8ck0TV1nNjNjrYxTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfuChNTdIwHfhgY3ojNZWOJaMS/vf5e4JBNm3xaQn48=;
        b=fErXkzc7M2ZrBFYfUzgovWh1hbjFhhzhtfgzyfu/Ck/0oaTD5rQ0GobUFJ6imQY6zC
         l/5r4KHxBetG/IfbQKFVisfESNnqesuyC6MF1ljoMdfz1mBeh38SUXrAzW3APmbf8zy6
         haez2lzYoMM5U+m7Z3aT9kKdujrrdEtNy7SH3SMAknHS38avSmy6t3XrQjLMkCaBQyM1
         tCNmMgnTyfCqizcLFE4PrEw2BcdXC7kDOWneHw9hhqHGFx64w71M8+LYA/7q0sAVPFxm
         3pXZ3iolLPRZZUrxVMf5CWKQVDhvDZe4RFkA53xUbXqOjn9aH14mY2GsZ76HeMAPYcKt
         qiLA==
X-Gm-Message-State: AGRZ1gJKoA5EFlqr8po7eNMt1aZVMOua689G2AaeK7SpvIVa4ymVyC/y
        70BhgBlOuv4Ht8Pq0WLhF1Ic84qbPER9miv68Hc=
X-Google-Smtp-Source: AJdET5fFfRBCtHGpGebQ8pFVEBlivaukNdZs0wiAr/Dod2Vqfw9c1Bi+4LyA+fR3mfr0xKTqZ38LLMYQB8KPOlKRyLc=
X-Received: by 2002:aca:5cc6:: with SMTP id q189-v6mr827281oib.121.1542710934302;
 Tue, 20 Nov 2018 02:48:54 -0800 (PST)
MIME-Version: 1.0
References: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue, 20 Nov 2018 16:18:43 +0530
Message-ID: <CAOh2x=kwGUto-TMsQORtx0CkgZSDsq6Mg1e=QKL=LeDPWJ=NPQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: imx: fix for dependency on cpu-freq
To:     anson.huang@nxp.com
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While I am aligned with the fact that we need to carry this code for backward
compatibility, there are few things I would suggest to improve.

On Wed, Oct 24, 2018 at 12:10 PM Anson Huang <anson.huang@nxp.com> wrote:
>  static int imx_thermal_probe(struct platform_device *pdev)
>  {
> @@ -743,6 +745,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
>         regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
>                      data->socdata->power_down_mask);
>
> +#ifdef CONFIG_CPU_FREQ
>         data->policy = cpufreq_cpu_get(0);
>         if (!data->policy) {
>                 pr_debug("%s: CPUFreq policy not found\n", __func__);
> @@ -755,6 +758,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
>                         "failed to register cpufreq cooling device: %d\n", ret);
>                 return ret;
>         }
> +#endif
>
>         data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(data->thermal_clk)) {

You missed the error handling code which unregisters cooling/cpufreq stuff.

And it would be better to write things in a somewhat better way, like this:

#ifdef CONFIG_CPU_FREQ

static int imx_thermal_register_legacy_cooling(...)
{
        ... current function body
}

static void imx_thermal_unregister_legacy_cooling(...)
{
        new routine body to unregister things
}

#else
static inline  int imx_thermal_register_legacy_cooling(...)
{
        return 0;
}

static void imx_thermal_unregister_legacy_cooling(...) { }

#endif


And then you can get rid of ifdef hackery in the middle of probe().
