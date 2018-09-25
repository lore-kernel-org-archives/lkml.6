Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C1AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4883920676
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4883920676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeIYXGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:06:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44944 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeIYXGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:06:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id 36-v6so25149634oth.11;
        Tue, 25 Sep 2018 09:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JiFj+FkgYKk/vlkN10eDN/1VPnWnp2uYtFlwJlI2AgU=;
        b=GU+Q2ywSolaLQgfwf7fJDVezPgd5x/eDYr+s1U9CO2+v39vz+leyf7NuXqLzwoF6K3
         wgQaczqr700FwTfpf2QFUzC7icsVe5zrZ8WVJN41W/wzKroivKh3qTJVKTd9XoFkhtG7
         lx7KJZRKcnvJEyX53HfEOM7JIl6TPfAtM43xZzLAMG0vnVNUvSHwOA/wl/iNje9DACcy
         FSEnkD5F0uZQy7FHoyficBamIu6m6DkDpHDquzcfFv+2e45mOQ4xWndtwAg3PrYnUG3k
         U7Da0eIAYofI0TVJQ2LaBoCHF2gXJxyUulaXfBF0TcUXXd+2I2Z3kHanYVVeL9Pse9Rf
         20kg==
X-Gm-Message-State: ABuFfogi79qnGr/t2VSsRD4YqBb8zkGtVJvsAwXrXAPQISobX15b8V3s
        MMcXx2KnfoJvuzxGgcgrXMu8lFjg9A==
X-Google-Smtp-Source: ACcGV62nyN9GORN+Bp3h44Ke7qvcydhkD6pgioYrDByJpWtrI8LkBBJjq91ltSA/Rj2jj7fLGByBtQ==
X-Received: by 2002:a9d:4d15:: with SMTP id n21-v6mr1388024otf.121.1537894692698;
        Tue, 25 Sep 2018 09:58:12 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h9-v6sm356266otf.78.2018.09.25.09.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 09:58:11 -0700 (PDT)
Date:   Tue, 25 Sep 2018 11:58:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] dt-bindings: cpufreq: Add binding for NVIDIA
 Tegra20/30
Message-ID: <20180925165810.GA32430@bogus>
References: <20180830194356.14059-1-digetx@gmail.com>
 <20180830194356.14059-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830194356.14059-2-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 10:43:52PM +0300, Dmitry Osipenko wrote:
> Add device-tree binding that describes CPU frequency-scaling hardware
> found on NVIDIA Tegra20/30 SoC's.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../cpufreq/nvidia,tegra20-cpufreq.txt        | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> new file mode 100644
> index 000000000000..2c51f676e958
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> @@ -0,0 +1,38 @@
> +Binding for NVIDIA Tegra20 CPUFreq
> +==================================
> +
> +Required properties:
> +- clocks: Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +  - pll_x: main-parent for CPU clock, must be the first entry
> +  - backup: intermediate-parent for CPU clock
> +  - cpu: the CPU clock

The Cortex A9 has CLK, PERIPHCLK, and PERIPHCLKEN clocks and only CLK 
is used for the cpu core. You can't just define your own clocks that 
you happen to want access to.

Otherwise, you're not defining anything new here, so a binding document 
isn't required.

Rob
