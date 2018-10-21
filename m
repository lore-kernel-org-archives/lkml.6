Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2D4ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839D520652
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TASWhoN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839D520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbeJVES5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:18:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46541 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbeJVES4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:18:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id bb7-v6so574018plb.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m2ZtMulS9sIdPI0VvS3XRRyF78zLDzmXYk0wejrjS70=;
        b=TASWhoN22eADbeiLQ4yn2dzA4Pe7C3ON2o+uotIx11ijhDXzO7ugRyGVZRUdvOOXkc
         nA0EV47ZLDTVKx3v5T9ftzSW7VM2pLD1Dfm9e/SoRYFJw5tWM1ae+eZWcZfAxYFIOrJ5
         rI4zBX6B+fta8TZZk0TtdSIaxD14vTkGbX1cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m2ZtMulS9sIdPI0VvS3XRRyF78zLDzmXYk0wejrjS70=;
        b=GsysavMeK4bsIKq/7oVX6tL5ne4ZJkVI+yPJ7tfSo0ZJ0BT+HGr1NoZUSucwBeFGhu
         EQwGGr8P6cmHPf5+WkZ8g67L7YYijRCHaAJ+lhV0t5r9winK2yghipdJmxIOS2dCDjrh
         FSyW0VVTy3w8xBm4NeHRBSjnwgj6oNtE8p4uzcpze49YeBOyAe1EhwBnzJ4pAOTIl1A6
         QbXR8P4E65f0okVfaQ5ZLojtuPYz7jP/A6k1T+wN6RIluL6PXuu5gv7E3CG83hhSvnpY
         icHwPLsz/sgs2p8nM6mqTM/UCFwlnuF1NqeB1oosy+7AqMzapow4+oZgnto6YB9PcUda
         vzjQ==
X-Gm-Message-State: ABuFfohx3XXejxpeZh4vnobFbW6RytWp906d3nUv4RI+hvvsiu2YU2ut
        lozYKYJA22QveYHRwuJYr40PCur9xbk=
X-Google-Smtp-Source: ACcGV63PgIp2lrZvev9UJtQu/AEwOoHieJryGyCHUGyL3MKYHwZbRmb3afWZNLpZS8GMaMNHTJLPTA==
X-Received: by 2002:a17:902:9a94:: with SMTP id w20-v6mr29809979plp.115.1540152209070;
        Sun, 21 Oct 2018 13:03:29 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d65-v6sm43420028pfe.42.2018.10.21.13.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 13:03:28 -0700 (PDT)
Date:   Sun, 21 Oct 2018 13:06:42 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
Subject: Re: [PATCH v8 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Message-ID: <20181021200642.GA1193@builder>
References: <1537698793-15285-1-git-send-email-tdas@codeaurora.org>
 <1537698793-15285-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537698793-15285-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 23 Sep 03:33 PDT 2018, Taniya Das wrote:
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> new file mode 100644
> index 0000000..c06941c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -0,0 +1,169 @@
> +Qualcomm Technologies, Inc. CPUFREQ Bindings
> +
> +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> +SoCs to manage frequency in hardware. It is capable of controlling frequency
> +for multiple clusters.
> +
> +Properties:
> +- compatible
> +	Usage:		required
> +	Value type:	<string>
> +	Definition:	must be "qcom,cpufreq-hw".

As this binding (and driver) operates actual hardware we should probably
have a more specific compatible. Or is this the one and only "hardware
cpufreq" block that will ever come out of Qualcomm?

Regards,
Bjorn
