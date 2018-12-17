Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755D1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C9420874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545079817;
	bh=aPIU4ZO4+5dcoZ1Fx+ddjaRwaxRAU+8LPqLIFUgYWmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FlLsaPs3cVJ8W/8NRjXBj0lZnIhncS9EGiNk29rMCy+Gj0+yutYpy9q1H7eqktvNS
	 zroewdObtQjETI/VPOvUGRAm6n0bxjnKwi8FN2WVYAVmf1P8Rr3t1umtRAh0r0y1YJ
	 T+I8PiKTJWcoKW46636FeF5BMt7JH3hoXrUKqXHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbeLQUuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:50:15 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35100 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeLQUuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:50:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id 81so13529394otj.2;
        Mon, 17 Dec 2018 12:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=643fpEcms3UHkeg5nqoluiWhtvQr++bquFg06DEARNY=;
        b=D3xn0X94YBydP6oQxqNiL4GKqs3ApGcb+wEt/rZrNMRQt50+V9CPJpv+FGUfLm6RXU
         LbdsvVE9qoh8MQCARMYV8OJqy2WOv5c5mRa9C0aIHvMEg/KMU5sUXYOsE59vIfVT9Sac
         lCaqrFiFUZUjuvn9dxidhR9Nc7wtl+F+4Z2At/o4lkxmYLWfWgmbZhhBYkblO2/MIj5l
         vPJqc/+NTJC7FuDt91o/squWTB3wEqXtpezbf9CH5xEtQygMsDDDAdF200NMy9HF9D0B
         ISBXcOyNBihLBn6GLi2NSY17XL9glCfzr7XxXll1SLsouHe5JEBiDSbkm8ZoEjqo5k9Q
         kf5Q==
X-Gm-Message-State: AA+aEWZAYXrphaSSYh0BJZeuUeo9i/92gvn/BNsmlT9HbrrYFDiy+nGo
        hw+gflM8EPva6WfRRbOXVg==
X-Google-Smtp-Source: AFSGD/VtKFYfxfXL0doV0b/VwFKdFoNsPTKHy9ihRgkIDgqBhx0WvjJYaYuicywTafU1ibKiNqwQyA==
X-Received: by 2002:a9d:2015:: with SMTP id n21mr11227852ota.289.1545079813851;
        Mon, 17 Dec 2018 12:50:13 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id a1sm6473515oto.71.2018.12.17.12.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 12:50:13 -0800 (PST)
Date:   Mon, 17 Dec 2018 14:50:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v13 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Message-ID: <20181217205012.GA22574@bogus>
References: <1544760624-12874-1-git-send-email-tdas@codeaurora.org>
 <1544760624-12874-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544760624-12874-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 09:40:23 +0530, Taniya Das wrote:
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which are
> controlled by the hardware engine.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 +++++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
