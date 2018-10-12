Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2AAC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7461D204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7461D204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbeJLW2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:28:08 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41353 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbeJLW2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:28:08 -0400
Received: by mail-oi1-f196.google.com with SMTP id l197-v6so10059622oib.8;
        Fri, 12 Oct 2018 07:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Fk5es5h+kiBXu47OJD9YBi2zH657LlgQeWFA/bDZAg=;
        b=kFUrec4ae91dMMOtmM55bA9fSW8t4L0yE4ckgvC8F7v7fKaLHUd9K5+L+Oc1bzoFBv
         T1WHl1bfvjdU32KlKEZEpzALomsfCd6erM1jfN79jG7AZdO0VNrImq1d9jQxaNYd27vn
         7XxCmK/u31XhlI0tj057vC3ILJUsGQumDVOzVJavVaq4B9RGFSA8a0V5dTsmUaCQyiqM
         SX83VFey3h3ETHknR7EK7Ct2Kr1KvIa53qNO656ZYgWlTfaF5A0HGXF1WPilE6LDPsEi
         Edjn5DsaupTEOruLtvKsCzf3LxewJP3vVNF1smMrbWWdIH/FpSeGYk+ik929ld52ayLE
         qHKA==
X-Gm-Message-State: ABuFfogq3ZBVz6KI+XM8vkLDhVB7TFeRUsIkVBqQW8jAgZ5yU39jZ+fK
        X5azET4KBmWtev1wirU3SA==
X-Google-Smtp-Source: ACcGV632qPYf3g3/lHEZnfb7VBl8rHtv36CYHJBi0xE4NtUk9xpWvocPipJwUfc7T70/CkTGUBo7nA==
X-Received: by 2002:a54:4793:: with SMTP id o19-v6mr3249597oic.23.1539356118044;
        Fri, 12 Oct 2018 07:55:18 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f6sm380251oth.70.2018.10.12.07.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 07:55:17 -0700 (PDT)
Date:   Fri, 12 Oct 2018 09:55:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        evgreen@chromium.org, dianders@google.com, asutoshd@codeaurora.org,
        riteshh@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 2/3] dt-bindings: mmc: sdhci-msm: Add entries for
 passing load values
Message-ID: <20181012145516.GA10205@bogus>
References: <1539004739-32060-1-git-send-email-vbadigan@codeaurora.org>
 <1539004739-32060-3-git-send-email-vbadigan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539004739-32060-3-git-send-email-vbadigan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 06:48:58PM +0530, Veerabhadrarao Badiganti wrote:
> From: Vijay Viswanath <vviswana@codeaurora.org>
> 
> The load a particular sdhc controller should request from a regulator
> is device specific and hence each device should individually vote for
> the required load.
> 
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 502b3b8..cb22178 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -25,6 +25,10 @@ Required properties:
>  	"xo"	- TCXO clock (optional)
>  	"cal"	- reference clock for RCLK delay calibration (optional)
>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
> +- qcom,<supply>-current-level-microamp - specifies load levels for supply during BUS_ON and
> +					BUS_OFF states in power irq. Should be specified in
> +					pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
> +					Units uA.

Seems like something that should be common?
