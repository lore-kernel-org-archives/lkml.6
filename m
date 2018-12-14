Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB85C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3542086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O9O3F2ZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3542086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeLNFdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 00:33:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36176 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeLNFdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 00:33:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so2270439pfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 21:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:subject:to
         :references:message-id:from:user-agent:cc:date;
        bh=sH6satQMgixv5yZbBv0B+B+pe3E3V+5j91qTsLkde58=;
        b=O9O3F2ZSXbLR2FxV8Vy8O78AiiSaqfVkfFyvJdvTXnnS3Z6hkzpSQQZhc6BG63qqY1
         XG/tfHSg1tyI/y+ZpyCoW9MWzyeGwnQyxf2e+7HBQ8zIF+dTze/gn2SHDn945CaLKXX/
         TBDIwzupA+SE3SgeQuJnkQn/SQKd7l0akzP2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:subject:to:references:message-id:from:user-agent:cc
         :date;
        bh=sH6satQMgixv5yZbBv0B+B+pe3E3V+5j91qTsLkde58=;
        b=EJfLxDlTdoDp7o8FAiHgawh8eEyJiHblWpSVoOiQhL4xJzFGi21QoXPdp1xRVqoK7K
         AbtMts0NbAgNTRUUfr0EUgY8NyJgLtuGWaiP5pfCNpBdHO6jnZ8otumJfbzVKummpX4R
         LJIe1HMfGagOVWA/stJd4mbteThpdf2hLssPqYOS5EGJBsjHmoC5DDJ4VHLlFECDv7g9
         brVWudV8xjCJ6m2jKaQ4OG6p10RzCRbIIsH9z6y3WoZWlNW31tzyhw12H6kOdIOVu641
         w2ORKIEfvr6PFgGRLCNXXElXn3C3eJFojZtimuF8A06wQJ/aLQvOD1TlfEmNERtvqTRn
         Gpvg==
X-Gm-Message-State: AA+aEWYnBu5FHIDLWWLPq67kOZg6mo3hlUVnhFwvd4x/uQCn6XgFGhJx
        YL6clu/qYWpFVypgrmqgolfTNQ==
X-Google-Smtp-Source: AFSGD/Vro6xou6KuB3P/VNV6jait+ntMVVFLDeQw+4nFW9UOkZYEhfOTz9SrqgVT1yMKS/cN86qBzw==
X-Received: by 2002:a62:18ce:: with SMTP id 197mr1669004pfy.88.1544765581489;
        Thu, 13 Dec 2018 21:33:01 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i73sm5304872pfi.66.2018.12.13.21.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 21:33:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1544760624-12874-2-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v13 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware bindings
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <1544760624-12874-1-git-send-email-tdas@codeaurora.org> <1544760624-12874-2-git-send-email-tdas@codeaurora.org>
Message-ID: <154476557998.19322.11977618193120872801@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, evgreen@google.com,
        Matthias Kaehlcke <mka@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 13 Dec 2018 21:32:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-12-13 20:10:23)
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which a=
re
> controlled by the hardware engine.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

except one question below for Rob.

> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.tx=
t b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> new file mode 100644
> index 0000000..33856947
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -0,0 +1,172 @@
> +Qualcomm Technologies, Inc. CPUFREQ Bindings
> +
> +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc.=
 (QTI)
> +SoCs to manage frequency in hardware. It is capable of controlling frequ=
ency
> +for multiple clusters.
> +
> +Properties:
> +- compatible
> +       Usage:          required
> +       Value type:     <string>
> +       Definition:     must be "qcom,cpufreq-hw".
> +
> +- clocks
> +       Usage:          required
> +       Value type:     <phandle> From common clock binding.
> +       Definition:     clock handle for XO clock and GPLL0 clock.
> +
> +- clock-names
> +       Usage:          required
> +       Value type:     <string> From common clock binding.
> +       Definition:     must be "xo", "alternate".
> +
> +- reg
> +       Usage:          required
> +       Value type:     <prop-encoded-array>
> +       Definition:     Addresses and sizes for the memory of the HW base=
s in
> +                       each frequency domain.
> +- reg-names
> +       Usage:          Optional
> +       Value type:     <string>
> +       Definition:     Frequency domain name i.e.
> +                       "freq-domain0", "freq-domain1".
> +
> +- #freq-domain-cells:

I still wonder if this should be #qcom,freq-domain-cells, but if Rob is
OK I won't complain.

> +       Usage:          required.

Nitpick: Weird full-stop here     ^

> +       Definition:     Number of cells in a freqency domain specifier.
> +
> +* Property qcom,freq-domain
> +Devices supporting freq-domain must set their "qcom,freq-domain" propert=
y with
> +phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT nod=
e.
> +
> +
