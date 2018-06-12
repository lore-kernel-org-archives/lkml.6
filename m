Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8EBF1C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFCE208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1CE2PMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFCE208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933347AbeFLHjM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:39:12 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45517 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933243AbeFLHjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:39:09 -0400
Received: by mail-io0-f195.google.com with SMTP id l25-v6so26900262ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 00:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LyL49EB3rTTx7ntP4Mea49HKY5BzLbJOFBp8jPFPBAA=;
        b=L1CE2PMi0uLhKu83cNtA4K+uTT0dTzQfCg/PFEzCE9cKtJzewd1bcnDqg4UFiVzgaf
         0ViadJMq6yReqWzIBK1CTeVPa3qxmHN7MOgI9LOf3mRZXRchO5f7JRhXXXvggN07/QHo
         6M/99A3OoL5mkT2p0Z9CcMuax0dau1XYXCWco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LyL49EB3rTTx7ntP4Mea49HKY5BzLbJOFBp8jPFPBAA=;
        b=dyIPkFN1aidDZqRPHzlExt4FOA4NKlEZnFA8XZAdKPCqJe+XgGE9P/dGFcQC+UkefT
         OkOx+UzwFstbtdRBtR5toqPoDhtxqdxYU5itkjHEYfXUe2RoXZ7G6+hqlW5e1mhg2VU3
         4U2bJ4RCArLY+jubjIWbTEeJIy/4lvMoOK9PwcVOUC5LMqAJsjTKwVo0HT8FxYi14cqm
         BRXr6LcUA0ljLRk7SPoFI0oK+nFKoUcDRniMJe1/Nk1M41pWz/9erjz84bzt66f+zC6i
         VMgOKo2iRh27vPhieP+zPIPcgnpK7H6ROCUHD5NO5qoMunY4gWCmPcDi08TpDhLFKN8D
         9gSw==
X-Gm-Message-State: APt69E0r0aX6IJ3/44ox9Xm61ZQ566L0m/HWaRWRgTzh3ekRSX/ap3oZ
        nZfGiTMhJ/lFcbvAcNgz2xXGT3VbbCDM2nps72VndA==
X-Google-Smtp-Source: ADUXVKKp8FEsUeeG6q/pj8WIysTkmh26tkQYGRPslOASJVxsNJj8UPVw/sDPf7twmfKYahoxgQSmVw50BycZCCQuOqo=
X-Received: by 2002:a6b:1410:: with SMTP id 16-v6mr2211774iou.218.1528789149203;
 Tue, 12 Jun 2018 00:39:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 00:39:08
 -0700 (PDT)
In-Reply-To: <20180612044052.4402-3-rnayak@codeaurora.org>
References: <20180612044052.4402-1-rnayak@codeaurora.org> <20180612044052.4402-3-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jun 2018 09:39:08 +0200
Message-ID: <CAPDyKFpJPUiBfzkM__niwnbHd_BDYYXpvEJCwfDxKp-L0nLOvQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] soc: qcom: rpmpd: Add a Power domain driver to
 model corners
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

[...]

> +static int rpmpd_probe(struct platform_device *pdev)
> +{
> +       int i;
> +       size_t num;
> +       struct genpd_onecell_data *data;
> +       struct qcom_smd_rpm *rpm;
> +       struct rpmpd **rpmpds;
> +       const struct rpmpd_desc *desc;
> +
> +       rpm = dev_get_drvdata(pdev->dev.parent);
> +       if (!rpm) {
> +               dev_err(&pdev->dev, "Unable to retrieve handle to RPM\n");
> +               return -ENODEV;
> +       }
> +
> +       desc = of_device_get_match_data(&pdev->dev);
> +       if (!desc)
> +               return -EINVAL;
> +
> +       rpmpds = desc->rpmpds;
> +       num = desc->num_pds;
> +
> +       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->domains = devm_kcalloc(&pdev->dev, num, sizeof(*data->domains),
> +                                    GFP_KERNEL);
> +       data->num_domains = num;
> +
> +       for (i = 0; i < num; i++) {
> +               if (!rpmpds[i]) {
> +                       dev_warn(&pdev->dev, "rpmpds[] with empty entry at index=%d\n",
> +                                i);
> +                       continue;
> +               }
> +
> +               rpmpds[i]->rpm = rpm;
> +               rpmpds[i]->pd.power_off = rpmpd_power_off;
> +               rpmpds[i]->pd.power_on = rpmpd_power_on;
> +               pm_genpd_init(&rpmpds[i]->pd, NULL, true);
> +
> +               data->domains[i] = &rpmpds[i]->pd;
> +       }
> +
> +       return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
> +}
> +
> +static int rpmpd_remove(struct platform_device *pdev)
> +{
> +       of_genpd_del_provider(pdev->dev.of_node);

In principle what you need, additionally to the above, is something like this:

while (!IS_ERR(of_genpd_remove_last(pdev->dev.of_node));

Then in the ->probe() function, use dev_set_drvdata() to store the
pointers for the allocated data, such you can use dev_get_drvdata() to
get them back here to kfree() them.

However, running the ->remove() path for this driver doesn't really
make sense. As we can't remove a genpd that has devices attached to it
anyways.

Perhaps make this a built in driver, if possible?

[...]

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
