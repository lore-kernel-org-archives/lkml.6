Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D258FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955202080F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bgb37aKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfBKWal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:30:41 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36128 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfBKWak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:30:40 -0500
Received: by mail-vs1-f65.google.com with SMTP id t13so382245vsk.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tixZFh62XyTVWJSfqeuBwFv5ridgMOTpg3/m+r1Nj0c=;
        b=Bgb37aKSltcuKSGwpBVqzyXnEUBe+9cErktDjz6l4NlTnPdqdW47s1c4dXvVabeTfk
         uBj5ufRi2nbGcd5+H8A8rnEKnAUYX+gyaWmNd3b1kkuaIoFEaqwsP5kQShjGItCR1E5E
         CVHeep1BIhwk4ts3qcGlj0DHa+feM3XyCZTM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tixZFh62XyTVWJSfqeuBwFv5ridgMOTpg3/m+r1Nj0c=;
        b=A8VjHNRh2hrWDNzebPbzsVpFDwSq6SPzc1T0y88JLoonYOqZUIo5xnnfiWhlILoc2/
         IxOggXaoHtAV/CGn0H3n+7TeKMxdVwWpgpQrtwNSfDMgBuH86PNIXYGJRLv36bAepBaA
         uKU3L1x5Fo9gboe6iaGovLWd9VunzT6ktcxgZ6E73eVRwikLOO3hA2qg8RaBBZLZltff
         qa2Y9vxdzmNpgy5h7n+ivSekftNkrS9h7izAS77SeNwa4Qj3yOfR8It8IjiHfjpLo6QC
         F1LhnZyGgYDAFCbwSTZ2BuWYGBb1aaRw6JxwtL9jJVfkqzvZe46tU3SS8e8CdbbBEYSs
         DY2Q==
X-Gm-Message-State: AHQUAuYmCRPnufoB6JeHpskfEim3bgz0PhtELtqQ6F+YivRNnzMeW3JI
        d+xN1BL74SzuURizRc39hcotH1TeewM=
X-Google-Smtp-Source: AHgI3IZAxV9Z3hUxW8L7dm1qHjiic7Su6AqLIGHpmPYbhVjM0VE3ocVQtUxRwFMMWUCu32+l0H20Og==
X-Received: by 2002:a67:705:: with SMTP id 5mr67760vsh.59.1549924239011;
        Mon, 11 Feb 2019 14:30:39 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id e67sm9866185vsd.32.2019.02.11.14.30.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 14:30:38 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id u64so345172vsc.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:30:37 -0800 (PST)
X-Received: by 2002:a67:81c1:: with SMTP id c184mr243840vsd.111.1549924237496;
 Mon, 11 Feb 2019 14:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20190206051335.23799-1-bjorn.andersson@linaro.org> <20190206051335.23799-6-bjorn.andersson@linaro.org>
In-Reply-To: <20190206051335.23799-6-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Feb 2019 14:30:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WDnKgiqP7Ta0xJtm5COTApYQ2DPTcUXH95O7S_vUJBCA@mail.gmail.com>
Message-ID: <CAD=FV=WDnKgiqP7Ta0xJtm5COTApYQ2DPTcUXH95O7S_vUJBCA@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] soc: qcom: Add AOSS QMP communication driver
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
> +       if (of_property_read_bool(pdev->dev.of_node, "#power-domain-cells")) {
> +               qmp->pd_pdev = platform_device_register_data(&pdev->dev,
> +                                                            "aoss_qmp_pd",
> +                                                            PLATFORM_DEVID_NONE,
> +                                                            NULL, 0);
> +               if (IS_ERR(qmp->pd_pdev)) {
> +                       dev_err(&pdev->dev, "failed to register AOSS PD\n");

nit: not worth spinning just for this, but if you happen to spin you
could print the error number in your message.


> +                       ret = PTR_ERR(qmp->pd_pdev);
> +                       goto err_close_qmp;
> +               }
> +       }

As discussed in v5 I wonder if the complexity of a separate driver is
really worth it or if everything would be a lot easier to just link
the two ".c" files together.  Now that it's a full error case if
"aoss_qmp_pd" doesn't probe I'd vote for linking the two ".c" files
together, but part of that is because I don't really want to dig into
all the details of how you're supposed to call
platform_device_register_data() for sub-devices and double-checking
that you've got all the corner cases correct.

...NOTE: presumably if you just change it to a straight-up function
call then you can also get rid of the above "dev_err" since
(presumably) you'll know that the init code of aoss_qmp_pd will print
any relevant errors?


-Doug
