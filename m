Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD86C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C2A21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gm+yxHVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfBAXjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:39:17 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38611 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfBAXjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:39:15 -0500
Received: by mail-vs1-f67.google.com with SMTP id x64so5288944vsa.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 15:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8UUj5SiR9uRVJlVjnP8RFQZGlFNQmwiIwZRifreesU=;
        b=gm+yxHVgEMcAmvolylcoTb+zeQJWpKjEcxmIDU8AaRSGVXVqww2pTTJQypQEnM+Fi1
         tV84gQw6QMXqOWeWQ/lFUP66EAl0TitD5/w/EbXuQ0YGCkUlAhDwPR0mXOFbhFdtPyrJ
         OC8WAL0wd2+xIyKXmeNTVO8fpTlJt6Hr4K/sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8UUj5SiR9uRVJlVjnP8RFQZGlFNQmwiIwZRifreesU=;
        b=CDEFwrfJJl20UYTZs4/CIP/GxKjPb321Rw22dJZDGCYbSAbinqwG3Z/8+gLXhLN1ZB
         6j9Bi6SxP27wZCakN1XfiQ2DdCuXrNDo51WJxjpcYz8fAmaPTZNd9xfrlzzPe6EpH17h
         pNSczanLEcMRjz6CkScIPcgf7UHBNDaqzn0cg1qt1Mme/1QjNA2vv8e1DDy4p93pI63b
         R9z8xtP6M6iusPLJx/uTYtTYb41TfzM2ueWkD+QPprK7qlKs6grkwpNqGMfpxpFebmgH
         ZNXEcpjgu/MQw43YNXfvf3lino81JN9iLziYGpaBRyv8iiKZY3XxZYP+7UDcmRDH+E0c
         3xcA==
X-Gm-Message-State: AJcUukf3CFAlUDo0A6AGxhNwNjvxhiurSYF8PYPKoXaDrh5OIAn5faoL
        WATYuXli6jtKmYF9qdRz5grj5jmqpW4=
X-Google-Smtp-Source: ALg8bN7y7AFIrbu4zvZeWsnUCHnq4tlp6Pnuf0z5WB0dzDaPp7R6QPiz0yD+BTkOhH4Vf8TI8+oFNg==
X-Received: by 2002:a67:7ed8:: with SMTP id z207mr16642985vsc.159.1549064354140;
        Fri, 01 Feb 2019 15:39:14 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id n206sm10664579vkn.36.2019.02.01.15.39.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 15:39:12 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id x28so5242482vsh.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 15:39:12 -0800 (PST)
X-Received: by 2002:a67:dd94:: with SMTP id i20mr18937757vsk.111.1549064351737;
 Fri, 01 Feb 2019 15:39:11 -0800 (PST)
MIME-Version: 1.0
References: <20190131003933.11436-1-bjorn.andersson@linaro.org> <20190131003933.11436-7-bjorn.andersson@linaro.org>
In-Reply-To: <20190131003933.11436-7-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Feb 2019 15:39:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Us8-VBGhwuJHCAGAxV13FOYOx2WBDegQ60SSG=oSO=EQ@mail.gmail.com>
Message-ID: <CAD=FV=Us8-VBGhwuJHCAGAxV13FOYOx2WBDegQ60SSG=oSO=EQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] soc: qcom: Add AOSS QMP genpd provider
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 30, 2019 at 4:40 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> +struct qmp_pd {
> +       struct qmp *qmp;
> +
> +       struct generic_pm_domain pd;
> +
> +       const char *name;

nit: why do you need name?  Can't you just reach in and use pd.name
since they're the same?


> +static int qmp_pd_clock_toggle(struct qmp_pd *res, bool enable)
> +{
> +       char buf[AOSS_QMP_PD_MSG_LEN];
> +
> +       snprintf(buf, sizeof(buf), "{class: clock, res: %s, val: %d}",
> +                res->name, !!enable);

nit: "enable" is a bool, so "!!" shouldn't be necessary right?


> +       return qmp_send(res->qmp, buf, sizeof(buf));

It appears that you write a string less than 96 bytes onto your stack
buffer but then send the full 96 bytes of stack to the AOSS.  That
doesn't seem like a very good idea to me.  Sorry, but your secret plan
to embed NSA code in the AOSS firmware and scrape data off the kernel
stack has been foiled.


> +static int qmp_pd_image_toggle(struct qmp_pd *res, bool enable)
> +{
> +       char buf[AOSS_QMP_PD_MSG_LEN];
> +
> +       snprintf(buf, sizeof(buf),
> +                "{class: image, res: load_state, name: %s, val: %s}",
> +                res->name, enable ? "on" : "off");
> +       return qmp_send(res->qmp, buf, sizeof(buf));

Please tell me you're joking that for turning on/off clocks "val" is
1/0 but for turning off images "val" is on/off.


> +static int qmp_pd_probe(struct platform_device *pdev)
> +{
> +       struct genpd_onecell_data *data;
> +       struct device *parent = pdev->dev.parent;
> +       struct qmp_pd *res;
> +       struct qmp *qmp;
> +       size_t num = ARRAY_SIZE(sdm845_resources);
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
> +
> +       for (i = 0; i < num; i++) {
> +               pm_genpd_init(&res[i].pd, NULL, true);
> +               res[i].qmp = qmp;
> +               res[i].name = sdm845_resources[i].name;
> +
> +               res[i].pd.name = sdm845_resources[i].name;
> +               res[i].pd.power_on = sdm845_resources[i].on;
> +               res[i].pd.power_off = sdm845_resources[i].off;
> +
> +               data->domains[data->num_domains++] = &res[i].pd;

nit: data->domains[i] = &res[i].pd;

...and then somewhere in this function (not in the loop) just write:

data->num_domains = num;


I think that's the same, right?  They you don't have to re-compute
num_domains by adding 1 at at time and it'd also be more obvious that
all the array accesses in the loop were the same number?


-Doug
