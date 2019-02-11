Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E08C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABAF218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N37i6q09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBKWP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:15:56 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36424 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfBKWP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:15:56 -0500
Received: by mail-vs1-f68.google.com with SMTP id t13so359377vsk.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTyLzxtQX1goBC2IzELMdZD5FZrfqnBkgXdF8aMw5Ho=;
        b=N37i6q09awb3qQPiQWC9Zac7ps9xZAbpQKnmnJP/KdGBeFAtJIxTyHDGIh9T8CWP6K
         YrpVTBt25q8lQr4QMUZnS7nBIOeUy8kV/LjezLwWJkuV5Rgd2tf8ZFRlI6t6hFBFjiwO
         SAJDOgA5S/QZbzUrdhGoHugTEPcg+P5JjvHo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTyLzxtQX1goBC2IzELMdZD5FZrfqnBkgXdF8aMw5Ho=;
        b=rmepRejavJr5vpIb9/zPr50kpSPcOELjUfE8zOTxWvm8cbTogg+6e1S1gkTdRfVr5t
         W94MMcrEZxuOKXm4aA4EF9Xu+cMAdmm25Z2NW1gFWdFbPt8IwXt70o/EA7CTLaUWJgmU
         qEX2iNZJW0NafWqJwZ9d/0iLSuvepfKWuiVbRbaoXYT1b47y7V452495ZrpwAQRhBFJp
         UpA+MVhp82nvJVzm9iGNc+g2SbBSCwVrHd/7wO+oWRW2YfBpFlLKUWoKpGgqjVriwXgG
         M0+567QfKNHgtl7G331u5GQG48fIzBM0mryFWyOfC0tFYxBD2tuaFSD/YqrBoRqUnJ3A
         mN6A==
X-Gm-Message-State: AHQUAuatiy0W/Pi7lzO7GjFC7E5Tn8ebgm6fwTCS6OkdpGKBH6bw7G98
        OW4jKma2tyf1si60V9D5tseZlNpDVVA=
X-Google-Smtp-Source: AHgI3IYiVFgYk63M+KOlpgfRHIgnRmcmljKpc7keS3wSMqIbIlSP0CQyk1CF3QBsElUS0b6e9FUcEw==
X-Received: by 2002:a67:f4d3:: with SMTP id s19mr230529vsn.134.1549923354781;
        Mon, 11 Feb 2019 14:15:54 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id x185sm9432475vkd.27.2019.02.11.14.15.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 14:15:54 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id v26so195573uap.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:15:53 -0800 (PST)
X-Received: by 2002:ab0:53c5:: with SMTP id l5mr219747uaa.52.1549923353337;
 Mon, 11 Feb 2019 14:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20190206051335.23799-1-bjorn.andersson@linaro.org> <20190206051335.23799-7-bjorn.andersson@linaro.org>
In-Reply-To: <20190206051335.23799-7-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Feb 2019 14:15:42 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VAa_8TyD5F5jiCxPVZEH8pPcxpR8hG+aw=AM2WFBVqmw@mail.gmail.com>
Message-ID: <CAD=FV=VAa_8TyD5F5jiCxPVZEH8pPcxpR8hG+aw=AM2WFBVqmw@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] soc: qcom: Add AOSS QMP genpd provider
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 5, 2019 at 9:13 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> +static int qmp_pd_image_toggle(struct qmp_pd *res, bool enable)
> +{
> +       char buf[AOSS_QMP_PD_MSG_LEN];
> +
> +       memset(buf, 0, sizeof(buf));

Personally I find it safer/cleaner to do something like:

char buf[AOSS_QMP_PD_MSG_LEN] = { };

...but I won't insist.  If you change this, change in qmp_pd_clock_toggle() too.


> +static int qmp_pd_probe(struct platform_device *pdev)
> +{
> +       struct genpd_onecell_data *data;
> +       struct device *parent = pdev->dev.parent;
> +       struct qmp_pd *res;
> +       struct qmp *qmp;
> +       size_t num = ARRAY_SIZE(sdm845_resources);
> +       int ret;
> +       int i;
> +
> +       qmp = dev_get_drvdata(pdev->dev.parent);
> +       if (!qmp)
> +               return -EINVAL;
> +
> +       res = devm_kcalloc(&pdev->dev, num, sizeof(*res), GFP_KERNEL);
> +       if (!res)
> +               return -ENOMEM;
> +
> +       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->domains = devm_kcalloc(&pdev->dev, num, sizeof(*data->domains),
> +                                    GFP_KERNEL);
> +       if (!data->domains)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < num; i++) {
> +               res[i].qmp = qmp;
> +               res[i].pd.name = sdm845_resources[i].name;
> +               res[i].pd.power_on = sdm845_resources[i].on;
> +               res[i].pd.power_off = sdm845_resources[i].off;
> +
> +               ret = pm_genpd_init(&res[i].pd, NULL, true);
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev, "failed to init genpd\n");

It's often nice to print the error number (ret) in the message.


> +                       goto unroll_genpds;
> +               }
> +
> +               data->domains[i] = &res[i].pd;
> +       }
> +
> +       data->num_domains = i;
> +
> +       platform_set_drvdata(pdev, data);
> +
> +       return of_genpd_add_provider_onecell(parent->of_node, data);

Now that you have error handling (the calls to "pm_genpd_remove"), you
can't just do this.  You need:

ret = of_genpd_add_provider_onecell(parent->of_node, data);
if (!ret)
  return 0;


> +unroll_genpds:
> +       for (i--; i >= 0; i--)
> +               pm_genpd_remove(data->domains[i]);
> +
> +       return ret;
> +}
> +
> +static int qmp_pd_remove(struct platform_device *pdev)
> +{
> +       struct device *parent = pdev->dev.parent;
> +       struct genpd_onecell_data *data = platform_get_drvdata(pdev);
> +       int i;
> +
> +       of_genpd_del_provider(parent->of_node);
> +
> +       for (i = 0; i < data->num_domains; i++)
> +               pm_genpd_remove(data->domains[i]);

I presume it doesn't matter, but if you truly want to be the inverse
of the "probe" then you'd want to iterate starting at "num_domains -
1" and go to 0.


-Doug
