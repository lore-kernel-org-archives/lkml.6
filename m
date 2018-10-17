Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAD5ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79822087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79822087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeJRDzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:55:16 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35044 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeJRDzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:55:16 -0400
Received: by mail-ot1-f66.google.com with SMTP id 14so23474444oth.2;
        Wed, 17 Oct 2018 12:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hOmTxnFBCChT34ZPXs3roEwNf7Q36IbA6NOv02WWc8I=;
        b=hp8cPDoLdW7m89SRQAe7EHfhT7oBd1dyoasL13wt6C1Yrtr5XdVXx94hqQcDhzJO1t
         fK6yR0EBZQ2CML1p8kcj7xdrRKnIjwOmHmu2Ybs82gbMPaIIMk4L47bkbE8u5m90S69H
         xJJ7fqplZyd4FmMFKpt8mTzaTTE3Q4He2FvJUFvOT3OFaM+aLs9eiSfdQ6oQ7lAydJW/
         vvfsn+EIpAnvfMg7aVgQO0Ui/aE8wOeH+NAB+/Vn2AKbo7NIxAmIYxu/6t/8pI246ign
         SBkQ63TDgQT2qIE+929TS0T/RMapYQBDZrkguDS+MTINxcNLslJ9EiVsq90lmrlOpbcM
         mDww==
X-Gm-Message-State: ABuFfoh5nI6xKNXmX8lCsthLCdPsbK1ik4JdeVyo0Z30MzkwlUTq/Q6i
        TTTaOXg9kWl5s1eVrGMKDw==
X-Google-Smtp-Source: ACcGV62dXWBTBM1mTV3tyPb1XH1mK0mB++UuXDBu7t/qPRlNlu4MITUf/THdm1gcYcUQy6yeMxtF4Q==
X-Received: by 2002:a9d:8a4:: with SMTP id 33mr16402646otf.269.1539806279766;
        Wed, 17 Oct 2018 12:57:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a17-v6sm5737358oii.7.2018.10.17.12.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 12:57:59 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:57:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Message-ID: <20181017195758.GA11226@bogus>
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539257761-23023-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 17:06:00 +0530, Taniya Das wrote:
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which are
> controlled by the hardware engine.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 173 +++++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
