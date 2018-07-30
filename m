Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74347C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F6620881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F6620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbeGaA7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:59:22 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44643 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeGaA7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:59:22 -0400
Received: by mail-io0-f195.google.com with SMTP id q19-v6so11339401ioh.11;
        Mon, 30 Jul 2018 16:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jqg5CxC/r+bZwVJnW2gYOjjpvy4EnWwOhlbGGNdiRX8=;
        b=q77v3vQw+GO9JTcKUl1mXuHNAxDslwDCf9YiXjGgeHzJoO8l1GgCvJC1H/EKXD/t9L
         pAAaMzdIEAODtObPe2XSgVO/z8szH8JsW6GH6bECYsZvz4v/eOT/VNmEXO1AUYm9KU7+
         B1tFzz4ZrmPoMlmrePUhJ5zhlu3cPkueHI0TdJK71Vb+nUc9MNCvXDDtZnAHrlo1sZyB
         vCWLHRPEfPHja1EZUIu7HMU61WfU/PO5liyEDuEKmdxM0Goe7vIhtzD+M1of2mjD2MtH
         WazzN1EDzEJTJnX8+K3BTNf25pw55tXsUcfA/ar0B1bacvUyZM6Yd8EJ3jjJIjvuntKT
         5N5A==
X-Gm-Message-State: AOUpUlE6mTN66vUMNISBeCTilJnSGOyrpdpylOLC2H3IlGLFapm60Psf
        p0XQWvVpqiRdVXvTvH2vfg==
X-Google-Smtp-Source: AAOMgpcWp2DtdrPrAcfFAfQRF1Ud0UiiFc1d+vhbcb7/8OYu6kV1uoV9VRTiSLalVihcw2NyalCuKg==
X-Received: by 2002:a5e:c106:: with SMTP id v6-v6mr9145163iol.262.1532992923428;
        Mon, 30 Jul 2018 16:22:03 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id o20-v6sm4154667ioa.83.2018.07.30.16.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 16:22:02 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:22:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] dt-bindings: mmc: tegra: Add pad voltage
 control properties
Message-ID: <20180730232202.GA14378@rob-hp-laptop>
References: <1532607560-11253-1-git-send-email-avienamo@nvidia.com>
 <1532607560-11253-2-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532607560-11253-2-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 03:19:11PM +0300, Aapo Vienamo wrote:
> Document the pinctrl bindings used by the SDHCI driver to reconfigure
> pad voltages on controllers supporting multiple voltage levels.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
