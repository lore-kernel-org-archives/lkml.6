Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 009C2C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82BF20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIJ9V1tM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82BF20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933428AbeFLHqW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:46:22 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34595 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933183AbeFLHqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:46:20 -0400
Received: by mail-it0-f67.google.com with SMTP id y127-v6so13452270itd.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 00:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Pi2Eknix1xjP1Wy8DQyLKrJAMW8HK9NxuSzeSS1yuzk=;
        b=OIJ9V1tMP55HIzWKmNdXJASRMEWyOCkztsrtCHv0LnCZJxsiQMTYOwiJds7LrRk1jB
         ZC2JLMS/6ZDH1XjkApzWi31RQfF4+R4GBZy+38JQvs7Jd/NuLUTFUOLpNJsdTylcTQdX
         PxuW58kIXZUWfqnLJQ3Aqmcx+gsUYfuXKaMXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Pi2Eknix1xjP1Wy8DQyLKrJAMW8HK9NxuSzeSS1yuzk=;
        b=d+6iLxSNNAEoHap4Al9uRdWcneVnVH9F7piOm8dpbHsbArebnWmMiZQ+aDiucBa0zw
         1x/idqlTg1Jbrf5EwuNowwod4LeHb12iVqFRLfRTO2wcCQGNgs5nXSdcwMuya5kCZ5Ri
         nUkwxPXx79Ik/LglQ8HwO3Uqz93J9f5v245PxkdcI9Jo8mhQmBC78l3d9ouef1Tj3h/O
         Conan7s+kCtVWj1z4Pl37LG3CvA3hEinW9aDAmvajok/bkJog3DF7CDK7FCgs2rlmOMR
         wbOC6igRc+iXdbfvb8Lk+3t4LwOIr8Mhgav+odtKLnFu9iXRjC9XPtGh3mzAhDosSMiF
         i7GQ==
X-Gm-Message-State: APt69E29xgnYlZTQhDmkz1kuom2xLYkFzz+avdtbCxd/LKOOSDNZ5YqC
        FDNJ7O5VBpZKSfpAcV1qHLGH9z8QmAPUqq87ThBQdA==
X-Google-Smtp-Source: ADUXVKKy27qIUPqMowZPr3jigUsuou40dYkQIAxx5C3bH7XM9mvIGYG7A66qbrOzLDjwo0Jfykn6viMvxEI/8jXWkjA=
X-Received: by 2002:a24:6514:: with SMTP id u20-v6mr2224296itb.38.1528789579645;
 Tue, 12 Jun 2018 00:46:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 00:46:19
 -0700 (PDT)
In-Reply-To: <20180612044052.4402-7-rnayak@codeaurora.org>
References: <20180612044052.4402-1-rnayak@codeaurora.org> <20180612044052.4402-7-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jun 2018 09:46:19 +0200
Message-ID: <CAPDyKFpLjN4F1yh0VEerzXTcpN2deNWWPG7qud_KLZgrcVcruw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] soc: qcom: Add RPMh Power domain driver
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>, collinsd@codeaurora.org,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 June 2018 at 06:40, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> The RPMh Power domain driver aggregates the corner votes from various
> consumers for the ARC resources and communicates it to RPMh.
>
> We also add data for all power domains on sdm845 SoC as part of the patch.
> The driver can be extended to support other SoCs which support RPMh
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

[...]

> +
> +static int rpmhpd_remove(struct platform_device *pdev)
> +{
> +       of_genpd_del_provider(pdev->dev.of_node);

Similar comment as I had for patch2.

> +       return 0;
> +}
> +
> +static struct platform_driver rpmhpd_driver = {
> +       .driver = {
> +               .name = "qcom-rpmhpd",
> +               .of_match_table = rpmhpd_match_table,
> +       },
> +       .probe = rpmhpd_probe,
> +       .remove = rpmhpd_remove,
> +};

[...]

Kind regards
Uffe
