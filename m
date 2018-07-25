Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEE6C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327BF2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327BF2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeGYQCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:02:53 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41494 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbeGYQCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:02:53 -0400
Received: by mail-io0-f194.google.com with SMTP id q9-v6so6556472ioj.8;
        Wed, 25 Jul 2018 07:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Hhruy6acC5fptfA3Oyk91rKZiRa+D3TSOxqVoWiKag=;
        b=Dbn7hhklWhHt8jmsrgUyR+/+fBsTVg+xL2QoZEgEBsTfbm/Ls2oXqtAvaBrLJjMSW0
         HMDC0O/sZjwJGE5cxk1Wl7lbk7s5q7nF2bxJiIQJkQEmBB8mLXdLPyBlbbFUGvUuWgES
         f7RZ9bzrR8QdlOpqgCJ/KC5wkDWEyyg2GMoE8RE8fpdBNxtJ4aEv8/uzWev95+8GcV3N
         dqgDhnrzY2j142mQZCuUDNdWEbM/cQlSgd+sDv8zv3qE8rxl32EkrmSWEwGCZ6Z9g5wT
         w9Ws0/21N1AAQABbhKt9YOOGKHwwlLEulYsAo/4A0WI6KBwOxk1Lkgdl7+A+nc2+FntI
         7QZw==
X-Gm-Message-State: AOUpUlGKTSWBrhrmwU9gkfuE09CkwBGvaNhzK8aR21PLpXgB/XAdX27Q
        kFSUV2W85dSitXBwsnopHiuVLJ8=
X-Google-Smtp-Source: AAOMgpe3Sa81ApLanNJbxZG+tiPIXnhYcijnlu0zqPUpee+WzVNPU5MBFig7iDQNFNhsn8tOJmNEBQ==
X-Received: by 2002:a6b:f612:: with SMTP id n18-v6mr18048448ioh.259.1532530250610;
        Wed, 25 Jul 2018 07:50:50 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id u23-v6sm4304077iob.0.2018.07.25.07.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 07:50:50 -0700 (PDT)
Date:   Wed, 25 Jul 2018 08:50:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/7] dt-bindings: Add Tegra PMC pad configuration
 bindings
Message-ID: <20180725145049.GA2407@rob-hp-laptop>
References: <1532084355-31482-1-git-send-email-avienamo@nvidia.com>
 <1532084355-31482-6-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532084355-31482-6-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 01:59:13PM +0300, Aapo Vienamo wrote:
> Document the pinctrl bindings used by the PMC driver for performing pad
> configuration. Both nvidia,tegra186-pmc.txt and nvidia,tegra20-pmc.txt
> are modified as they both cover SoC generations for which these bindings
> apply.
> 
> Add a header defining Tegra PMC pad voltage configurations.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  92 ++++++++++++++++++
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 103 +++++++++++++++++++++
>  include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h |  18 ++++
>  3 files changed, 213 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h

Reviewed-by: Rob Herring <robh@kernel.org>
