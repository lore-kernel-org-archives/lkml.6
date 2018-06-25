Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C7FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048E325EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048E325EEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964816AbeFYRPu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:15:50 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:37927 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933870AbeFYRPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:15:47 -0400
Received: by mail-yw0-f193.google.com with SMTP id w13-v6so5031491ywa.5;
        Mon, 25 Jun 2018 10:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QG6e7w97m9sAcjWPZDMgj0TIFIRZzmbyWfp4geZhq7w=;
        b=F083P1TI+NekSS3rmxf085SsxxoWLlhwS3RLEkVlUr5TDpWu+ZMyaWoTX0jkFvWkUY
         vBqZx2og38klWQVih5xxmHaC38+cZkJd+X8TbpcAj2PwimxAg/RWvxNDSXeGTyfruT5F
         82NdLrCW+E6djFhML7qVk4Fj1wfigxfrLztwTiAWhHVpjImRX2sj/NUJGjB+cH/AyLz+
         cSF8yWjkkIN3H89UNFYEyhf51S1EgJEcvAxWOlKyD9KaBrwd/vVPSAMY/0HNZf+W27Xm
         mE6t3tH2dEYUThOw9PxzfY9KJn9VpSxNVYe0Jp3WxynIAVhYpmcZKdCeOPXHtDQds0/b
         l/Uw==
X-Gm-Message-State: APt69E3l8P9wS8d+4BzWXYJUW3yzaXeP0idZL85ja0U4IW3FRbbvPm4y
        vzSSpQZ1MRb97VNpsJGb8g==
X-Google-Smtp-Source: ADUXVKIS+gibfFmFfVi/C8117xiTQ1GEjAeV7UBe+5CsDxovIa9XBkjuMEVGiq4AchvlOHbpV5JArg==
X-Received: by 2002:a0d:d951:: with SMTP id b78-v6mr6384435ywe.396.1529946946730;
        Mon, 25 Jun 2018 10:15:46 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id i2-v6sm447823ywa.20.2018.06.25.10.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 10:15:45 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:15:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] soc: qcom: rpmpd: Add a Power domain driver to
 model corners
Message-ID: <20180625171544.GA18520@rob-hp-laptop>
References: <20180612044052.4402-1-rnayak@codeaurora.org>
 <20180612044052.4402-3-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612044052.4402-3-rnayak@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:10:47AM +0530, Rajendra Nayak wrote:
> The Power domains for corners just pass the performance state set by the
> consumers to the RPM (Remote Power manager) which then takes care
> of setting the appropriate voltage on the corresponding rails to
> meet the performance needs.
> 
> We add all Power domain data needed on msm8996 here. This driver can easily
> be extended by adding data for other qualcomm SoCs as well.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig               |   9 +
>  drivers/soc/qcom/Makefile              |   1 +
>  drivers/soc/qcom/rpmpd.c               | 301 +++++++++++++++++++++++++

>  include/dt-bindings/power/qcom-rpmpd.h |  16 ++

Acked-by: Rob Herring <robh@kernel.org>

>  4 files changed, 327 insertions(+)
>  create mode 100644 drivers/soc/qcom/rpmpd.c
>  create mode 100644 include/dt-bindings/power/qcom-rpmpd.h
