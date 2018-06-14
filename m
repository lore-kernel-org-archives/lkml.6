Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AC21DC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63623208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FGeMK9Gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63623208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754786AbeFNHPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:15:04 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42732 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754638AbeFNHPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:15:01 -0400
Received: by mail-io0-f194.google.com with SMTP id r24-v6so6122218ioh.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 00:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VXHq0Cw0etQAq/IxN6VYTYbPcYpeCe/mn7hKNWDG+ow=;
        b=FGeMK9GvzrmirgQvmAkzYYyGKvyiDoQl7nBec1Z0kqlIKQBkzc9SmCDzLU4ecOogwM
         kCm35UI+qwSeBC5snMCwgZGw3rCoznOESCKRn5vaxzWk1B2fdSSSYeSAI3TtmCI1IC57
         Q4RdVyvqC/NHvWrDM+J6Fv5cjkppympwQyXp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VXHq0Cw0etQAq/IxN6VYTYbPcYpeCe/mn7hKNWDG+ow=;
        b=exv7o5zoqwkoZuJCkbfB1OxeJ8WDUAhslo/cy45MS9Eta3J6Vf/fNhsY5rzpu1bJPK
         2V/8wzHi8BQJd6LP/6ndX9D0UR01dUzapgfNRIH9RJzvUBbdkBllQ/y5JuRIHH+co22E
         RwWRxz+96LMe3WFZtvfzFkFRCbqlBuWdrhWMe7o+wiv1A4OfKX4ukYMOYEtC/P5I3zAy
         upAjzxOG+Gl/CJ1sR/IBuO8lY4HVSGtalRA4gKhK5NqxDCQaMKlAal6NNtip2BK+ffil
         hsGHFmVtunC3O1pUjlit/55ppeSkGcUSFZexh1XB3xADPM1RZL509v1Txqk/a94h6dtX
         Tymg==
X-Gm-Message-State: APt69E2RPGSyQRsVZgW3Z5mxni4YvW02+T+3d3aqp4LOnUqGVrCmQstZ
        sUvec2sYtQEkNGbLdKi4rPipCGOpRi8XmWzu0LUB0g==
X-Google-Smtp-Source: ADUXVKIP91EvVrLDxC0ergOb4Fjzxd2w1ebY1m3/f3UrJ1Twy+hmRF6uq9VyfSB981qSetPvz+BmvgjXDabyTfmJSyw=
X-Received: by 2002:a6b:1410:: with SMTP id 16-v6mr1219838iou.218.1528960500265;
 Thu, 14 Jun 2018 00:15:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 00:14:59
 -0700 (PDT)
In-Reply-To: <3d3687c030535189885d84c57dbffb034c4461c2.1528953706.git.viresh.kumar@linaro.org>
References: <b90f44d35e8e0fa9c81b3a88d05449a580be5567.1528953706.git.viresh.kumar@linaro.org>
 <3d3687c030535189885d84c57dbffb034c4461c2.1528953706.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Jun 2018 09:14:59 +0200
Message-ID: <CAPDyKFooucRfxtk768LMjLR6scj6XdHDzOSuqznTLNrbF19qaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / Domains: Fix return value of of_genpd_opp_to_performance_state()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 June 2018 at 07:23, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> of_genpd_opp_to_performance_state() should return 0 for errors, but the
> dummy routine isn't doing that. Fix it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  include/linux/pm_domain.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 9206a4fef9ac..139f79c8477a 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -276,7 +276,7 @@ static inline unsigned int
>  of_genpd_opp_to_performance_state(struct device *dev,
>                                   struct device_node *opp_node)
>  {
> -       return -ENODEV;
> +       return 0;
>  }
>
>  static inline int genpd_dev_pm_attach(struct device *dev)
> --
> 2.18.0.rc1.242.g61856ae69a2c
>
