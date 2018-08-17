Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D8CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CD121878
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CD121878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeHQSNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:13:12 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42499 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeHQSNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:13:12 -0400
Received: by mail-io0-f194.google.com with SMTP id n18-v6so7164541ioa.9;
        Fri, 17 Aug 2018 08:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vTL2ybjkKQBIZUu9Qdv85wPYfLrndjnFu0dUKf0QkkM=;
        b=pZGWjvnO8k9wJM/qzmlN7LQtdURLIhQyzKoqmUDcK5H7vg1I72S7JqdZUyVCoCK2hR
         JmWmEeu6Gg9jKw6L9ynuf0E35cc9Mwynsht4L9MIXCJzEN7Ro/rLsNFZ/9rvqShNsedc
         66diGPywnLo3fAMif8gWVUkFFkvEs66nZjLX4p2jMB5q1Vsr6JhBOtPZi8i8vlt/rAeq
         9kWUCS5o9WNj80QQnjvUL8d+JgydHFlin72IOJCxKgonxP4m3xaM6irOQoGLDE4wAqnS
         AlIjfFp1pht0XHtFpOweh+rlu2QG2maoCJUdP3dv3g5KzM/qSaJm0lN6a+zSt68HP2vH
         zhlQ==
X-Gm-Message-State: AOUpUlEEB4kxyeEomSBjOv8xnTtghJTQn5/MZ+HxtqQ81+3O50qcofrY
        ZEqVrNBU1/XBe17lysTqnA==
X-Google-Smtp-Source: AA+uWPz3fZrNfSr+PBrKbkXBp6MDcKqt3T2GvZIQKk4OxOmhwkrBx8g11JisSEBTIiFSvTegVzsipA==
X-Received: by 2002:a6b:9a50:: with SMTP id c77-v6mr29548615ioe.148.1534518568452;
        Fri, 17 Aug 2018 08:09:28 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id a79-v6sm1932934itc.33.2018.08.17.08.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 08:09:27 -0700 (PDT)
Date:   Fri, 17 Aug 2018 09:09:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sricharan R <sricharan@codeaurora.org>
Cc:     mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com,
        linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, sboyd@codeaurora.org,
        linux@armlinux.org.uk, thierry.escande@linaro.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        niklas.cassel@linaro.org, sricharan@codeaurora.org
Subject: Re: [PATCH v12 14/14] cpufreq: qcom: Add support for krait based socs
Message-ID: <20180817150927.GA20248@rob-hp-laptop>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
 <1534248753-2440-15-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534248753-2440-15-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this email is from Rob's (experimental) review bot. I found a couple
of common problems with your patch. Please see below.

On Tue, 14 Aug 2018 17:42:33 +0530, Sricharan R wrote:
> In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
> that has KRAIT processors the voltage/current value of each OPP
> varies based on the silicon variant in use.
> 
> The required OPP related data is determined based on
> the efuse value. This is similar to the existing code for
> kryo cores. So adding support for krait cores here.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
>  .../devicetree/bindings/opp/qcom-nvmem-cpufreq.txt |   3 +-
>  drivers/cpufreq/Kconfig.arm                        |   2 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c               |   5 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c               | 151 +++++++++++++++++++--
>  4 files changed, 149 insertions(+), 12 deletions(-)
> 

DT bindings (including binding headers) should be a separate patch. See
Documentation/devicetree/bindings/submitting-patches.txt.
