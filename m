Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FFBC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70D220869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdCnXywd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70D220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeICXyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:54:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39426 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbeICXyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:54:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id i190-v6so537585pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1bHQSx6IVqWrScm6HpRMco9N19rUn5nhVopraMg0GtI=;
        b=NdCnXywdyh+RV16t4/IovIjr26ViuVQoTW1lqIfXCQmQPZgO9ur1L7jNKbHY/+bB35
         shCywHRGA6fqg0m9n0iqynhwBppe/o/5pvlhb/OwFiKcXB454xxNmYRGJnYOVJ7W1YwA
         2CuDrEiz3VAsm5IgLujPY95wKbfyB/+QMuJBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1bHQSx6IVqWrScm6HpRMco9N19rUn5nhVopraMg0GtI=;
        b=d9WZLR9udi5HA/4pQafpYQy9eRFAWfMAa34nfBWeGe1nwWiwYDbWh6FEgKcKxYFSqD
         woQEhx0/OXoFkKzHm8Jw8AOtLca05H9Xyvth2E/CLuthhKtfUl6MvHnXIm6SK3FS3mYe
         I27oEg4fg1E9lQy4VQ+znpmvjOongQb5E8dkh3wbQK6mxSoDxyhayN0paX5qBHFvSOrI
         u4BH9HCUlK7PFUWla5Vvlyb3gbWdbCQpTXYmT0aXQLFXgViw4q0EqKh+XXPeFwlbeeBB
         O7FORVKU1w4PAWE7KC89ym8mwGCOqe9iwP8lkGdGLeok3t/7hlbhFMFhIgAE7UyUbRq8
         qccw==
X-Gm-Message-State: APzg51CxhRMSaaqjHlhot6qV8YWvSTIIM8z790Xv04LHIiYxrlMwB0d1
        VhLvxW48AZhS2md+LXUlVViWFQ==
X-Google-Smtp-Source: ANB0VdZu63hVCHfvvCX60ODIefI2DybkIYgFVFutSN0PA4irQ+C8DMdTnRjSF8MjPFRsyaYnO7Jamw==
X-Received: by 2002:a63:9e41:: with SMTP id r1-v6mr27171059pgo.362.1536003173694;
        Mon, 03 Sep 2018 12:32:53 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r25-v6sm24642720pgm.59.2018.09.03.12.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 12:32:53 -0700 (PDT)
Date:   Mon, 3 Sep 2018 12:36:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>, p.zabel@pengutronix.de
Cc:     mka@chromium.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v3 0/6] Add support for PDC Global on SDM845 SoCs
Message-ID: <20180903193647.GJ3456@tuxbook-pro>
References: <20180829191215.10071-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829191215.10071-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Aug 12:12 PDT 2018, Sibi Sankar wrote:

> This patch series add support for PDC Global (Power Domain Controller)
> on SDM845 SoCs and adds pdc reset lines assert/deassert to remoteproc
> Q6v5 modem-pil. The first two patches adds PDC Global reset driver to
> control reset signals of Modem, Compute, Display, GPU, Debug, AOP,
> Sensors, Audio, SP and APPS. The last four patches (cleans up)/adds pdc
> reset lines to q6v5 bindings and asserts/deasserts in modem start/stop
> path.
> 
> V3:
>   refactored pdc reset driver to remove unused layer of indirection
>   as suggested by Matthias
>   Other minor fixes suggested by Matthias/Bjorn
> 
> V2:
>   Incorporated Philipp/Bjorn/Rob suggestions
>   Renamed reset binding to pdc-global.txt
>   replaced offset with #define of register name
>   replaced with devm_reset_control_get_exclusive()
>   Separted dt binding from the drivers
> 
> Sibi Sankar (6):
>   dt-bindings: reset: Add PDC Global binding for SDM845 SoCs
>   reset: qcom: PDC Global (Power Domain Controller) reset controller

Philipp, there's no compile time dependencies between the PDC and
remoteproc patches in this series. Will you take these two through your
tree and I'll take the remaining four through the remoteproc tree?

Regards,
Bjorn

>   dt-bindings: remoteproc: qcom: Remove additional definition tag
>   dt-bindings: remoteproc: Add PDC reset binding for Q6V5 PIL
>   remoteproc: qcom: q6v5-pil: Explicitly get mss_restart line
>   remoteproc: qcom: q6v5-pil: Add PDC reset for modem on SDM845 SoCs
> 
>  .../bindings/remoteproc/qcom,q6v5.txt         |   8 +-
>  .../bindings/reset/qcom,pdc-global.txt        |  52 ++++++++
>  drivers/remoteproc/qcom_q6v5_pil.c            |  31 ++++-
>  drivers/reset/Kconfig                         |   9 ++
>  drivers/reset/Makefile                        |   1 +
>  drivers/reset/reset-qcom-pdc.c                | 124 ++++++++++++++++++
>  include/dt-bindings/reset/qcom,sdm845-pdc.h   |  20 +++
>  7 files changed, 237 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
>  create mode 100644 drivers/reset/reset-qcom-pdc.c
>  create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
