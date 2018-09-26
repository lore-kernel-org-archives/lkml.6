Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48816C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91A421533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91A421533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeI0FGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:06:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40803 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeI0FGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:06:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id g14-v6so647984otj.7;
        Wed, 26 Sep 2018 15:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BlHLXCs1+wE2htd1BvPIf4MkbK9Fh9AmjvT5glU59vI=;
        b=IyLvM+uCu5L1LFqisod6/PmbzYPPoQPUc42eXWJSO2A/PHl9JvpK5gl5evsP4Nqm6V
         pR0IAMsNPxWQ1AHUpMTTD+AsD0ey56kU0ljbj0NJ9/a8oTNbhIrJe+jjStaLxwH0ZXLz
         dI6TccwYcFivwk2n56exLe065oYp7UbwKScTY9Cke6SxdYL/FDkCEKPo6v0nuUUF7zva
         6SsEig/1o03uh9zqXf1D7aGft0rUUBThRuTQ8X8JJvqgnntFjDyi5Cf+hHjMol/kAWFH
         ksNx0woOW/hObzlbLJipRlMFLEnwCpl0uR7qzuCTL8YLXIRDVqD/c89GknjzL0qYtO02
         j4IA==
X-Gm-Message-State: ABuFfoh5cglHY5b+vXY8NrO0qnHcD/KeOmGI/piZTCqLHFgl9a2v3XiV
        zg8A/nggNF29BqgIKoyNIoyQWWdWxA==
X-Google-Smtp-Source: ACcGV60J9eI+QlGEvAIxnwF4pxGshIwPg/+9jD9ZHGAed96+7jLVzhTaFYSW2FgtKia7nwyYqlUwBA==
X-Received: by 2002:a9d:420c:: with SMTP id q12-v6mr5124439ote.289.1538002269542;
        Wed, 26 Sep 2018 15:51:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 39-v6sm359319otz.67.2018.09.26.15.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:51:08 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:51:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     swboyd@chromium.org, dianders@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, Dilip Kota <dkota@codeaurora.org>
Subject: Re: [PATCH V4 1/4] dt-bindings: soc: qcom: Remove SPI controller
 maximum frequency binding
Message-ID: <20180926225108.GA13931@bogus>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
 <1537294047-12093-2-git-send-email-dkota@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537294047-12093-2-git-send-email-dkota@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018 23:37:23 +0530, Dilip Kota wrote:
> SPI controller driver should maintain the maximum frequency
> of the controller instead of relying on device tree bindings.
> Because maximum frequency is specific property of SPI
> controller.
> 
> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
