Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0504EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE4721779
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE4721779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbeHMWIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:08:25 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43972 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbeHMWIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:08:25 -0400
Received: by mail-io0-f193.google.com with SMTP id y10-v6so15876678ioa.10;
        Mon, 13 Aug 2018 12:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P5fSht67JiyreejbCrzEO5+lSEojkAFyMl5iSM417Yc=;
        b=hqxz3+nUb43outD6kYRQTteLI9Gzc2pv+q7HX+MmIZ4/1o0ri8bSkBWDtXfyhFJaO0
         5I3KJ0GYpTDGwLd0psCs4Zu/qPOcDMg5HJyZoRKEG8CeJS33x8VMYOG9a6uJ0I4mnL4Q
         1iIlfiJ8zxVkW9sl8ULzjlLtcTrXboJEqRhZ3IiHbT+xwmh2g0p8ND7LfZMEonpafJAH
         sXkY5X+MVY1HL2hqpjNi8EsHtqGfLaERca2lvJoszCi3dOJxeAVaZFr8XuIPBooOoWPw
         cUeQoDHgAppXIFSXDNmqTsd/FlSzqxIhfDrdt20JxYi+7zt9Im4cE702eaVA/NC466rP
         70EA==
X-Gm-Message-State: AOUpUlHphSt99ib8d8/yTO7/c5t3Hz0PF1Pdqn26voGWWP3KChohf2dP
        U3hRbrWRyHDWsApLmrN6Fw==
X-Google-Smtp-Source: AA+uWPwrt0ohbkWXiKgahxX+YVLw8v5iDNWfF/cxe0clrQLaG49P0iCxuJOekoeel23m9TZZk0W1Cw==
X-Received: by 2002:a6b:5306:: with SMTP id h6-v6mr16015463iob.2.1534188289793;
        Mon, 13 Aug 2018 12:24:49 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id z195-v6sm15689249ioe.38.2018.08.13.12.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 12:24:49 -0700 (PDT)
Date:   Mon, 13 Aug 2018 13:24:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 03/40] dt-bindings: Add Tegra SDHCI pad pdpu offset
 bindings
Message-ID: <20180813192448.GA15903@rob-hp-laptop>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
 <1533924522-1037-4-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533924522-1037-4-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 09:08:05PM +0300, Aapo Vienamo wrote:
> Add bindings documentation for pad pull up and pull down offset values to be
> programmed before executing automatic pad drive strength calibration.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
