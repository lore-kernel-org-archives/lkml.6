Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D5FC71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1752089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkUBuwRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1752089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJOUZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:25:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38293 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOUZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:25:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id g89-v6so13954114lfl.5;
        Mon, 15 Oct 2018 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y4EQh+C9j0+kHUIFQpo4hXkDvT8kHmvPw1ZXxQNAYcg=;
        b=bkUBuwRE+bpAwl7t/79cHph/2bwUnoM/HA85rensuatzY3vRk++9i+vYpJ2QKsGZE/
         qxLWaFDcPDFm7oPXjKhWPQi4D3vhlZyxz4IvNQXlScUnJx6YnYnfYdjZJ/JHslaYAa1c
         EcKQM4PjN3OMdgqBGXZ6gQMExc54CDkPcRCaWrk4Ofm8SPqoc4RhWgvvuOKm4HQrCp9g
         3YNeHx6++c8xkHr/pB3k74gR7Rs2sJmuyVBtATdOKNiuKQLD1fLrE3ReKEUw3PaFPRZK
         AaEm7IBtkA0mmqT5UlmLm8WdXXbmO/eg2okvG5EESImyR+E5NI4yUOPxW58V4ADLfj2s
         rAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y4EQh+C9j0+kHUIFQpo4hXkDvT8kHmvPw1ZXxQNAYcg=;
        b=mzdhuiQc+zXhSwnWDquxecGuqQfKluzUQCh6OiiXAxd+sPpqgNd095lIVMoOQbtYNT
         LdRwqNSLQPgLhvSeBzmuB9uvEsy5XZNMjqTLeZZt0PaeiPufoWlOAyUu6mL6Beqr6pmE
         OrdZVkn3+CYOQaA7XmDgo0L2im2oC9pPZzoRPwQQtGpcRftY0TpZo0Fjd40ZwJmYjSFX
         0MAnqfrTWUee8eCbHJmjSn9/U/IMmhB0/SZFndS2DObLCLGsiav9dS+r4XjcZ7CWS/W5
         DfODano0t3pfSXp11htoct5kXv9C7hVO325400tdFBXhaPmko6ZypLwRCM6zCqEUJKq4
         HQ1Q==
X-Gm-Message-State: ABuFfoj+LJCjg88aXsGKvcDGIUfHT5afLrvs7UqIC3gVj9TX38JhJINo
        HnOmFWTQwB2YP34g9EEw6pSmaJIU
X-Google-Smtp-Source: ACcGV62IP896XFm5oBXRJvQbtRIJJRkbmTaXBdRrhkCFWLPimorg1TKvHRv7OmEpYR6fpRHCDk+asA==
X-Received: by 2002:a19:a3d1:: with SMTP id m200-v6mr9173233lfe.38.1539607230072;
        Mon, 15 Oct 2018 05:40:30 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id g68-v6sm2402376lje.44.2018.10.15.05.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 05:40:29 -0700 (PDT)
Subject: Re: [PATCH v5 0/8] Tegra20 External Memory Controller driver
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180724164221.3307-1-digetx@gmail.com>
Message-ID: <775736e9-0f13-94b0-1d90-871de16ed330@gmail.com>
Date:   Mon, 15 Oct 2018 15:40:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180724164221.3307-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/18 7:42 PM, Dmitry Osipenko wrote:
> Changelog:
> 
> v5:
>         - Fixed wrong EMC clock divider type in the "Turn EMC clock gate into
>           divider" patch. It is a Tegra's fractional 7.1 divider and not a
>           simple integer divider. Peter, please take a look at the change.
> 
> v4:
>         - Fixed "bad of_node_put()" error which was revealed by enabling
>           some extra kernel debug config options.
> 
>         - The "emc-table" DT nodes are now parsed starting from the "emc"
>           node instead of the DT root.
> 
>         - Adjusted code comment in the "Turn EMC clock gate into divider"
>           patch as was suggested by Stephen Boyd to the v3.
> 
> v3:
>         - Handle "nvidia,use-ram-code" DT property, its handling was missed
>           in the previous versions.
> 
>         - Honor "emc-tables" DT node naming which is explicitly specified
>           in the DT binding, also was missed in the previous versions.
> 
>         - Two new DT binding patches: one adds the EMC clock property,
>           other relocates the binding doc file to the appropriate directory.
>           One new patch that adds EMC clock property to the DTS file.
> 
>         - Addressed v2 review comments from Thierry Reding. Driver does not
>           preserve backwards compatibility with older device tree binding.
> 
>         - The PLL_M and PLL_P clocks are kept internal to the driver because
>           after some more considering I couldn't find a really good reason why
>           these clocks should be in the device tree.
> 
>         - Some minor cleanups and fixes in the drivers code.
> 
> v2:
>         - Minor code cleanups like consistent use of writel_relaxed instead
>           of non-relaxed version, reworded error messages, etc.
> 
>         - Factored out use_pllm_ud bit checking into a standalone patch for
>           consistency.
> 
> Dmitry Osipenko (8):
>   dt: bindings: tegra20-emc: Document interrupt property
>   dt: bindings: tegra20-emc: Document clock property
>   dt: bindings: Move tegra20-emc binding to memory-controllers directory
>   ARM: dts: tegra20: Add interrupt entry to External Memory Controller
>   ARM: dts: tegra20: Add clock entry to External Memory Controller
>   clk: tegra20: Turn EMC clock gate into divider
>   clk: tegra20: Check whether direct PLLM sourcing is turned off for EMC
>   memory: tegra: Introduce Tegra20 EMC driver
> 
>  .../nvidia,tegra20-emc.txt                    |   4 +
>  arch/arm/boot/dts/tegra20.dtsi                |   2 +
>  drivers/clk/tegra/clk-tegra20.c               |  46 +-
>  drivers/memory/tegra/Kconfig                  |  10 +
>  drivers/memory/tegra/Makefile                 |   1 +
>  drivers/memory/tegra/tegra20-emc.c            | 575 ++++++++++++++++++
>  6 files changed, 628 insertions(+), 10 deletions(-)
>  rename Documentation/devicetree/bindings/{arm/tegra => memory-controllers}/nvidia,tegra20-emc.txt (95%)
>  create mode 100644 drivers/memory/tegra/tegra20-emc.c
> 

Thierry, I now have v6 with some extra minor changes. Do you see any problems that need to be addressed in v5?
