Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6CBC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416A926503
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUVMzXza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416A926503
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933939AbeF0Jbx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:31:53 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42235 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933664AbeF0Jbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:31:49 -0400
Received: by mail-wr0-f194.google.com with SMTP id p1-v6so1291381wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 02:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KWSPorib+rcFS+AbGQaimDLnTgL2QfSgheTWv9cJFis=;
        b=bUVMzXza7dhl/IiHAJl8Qj4MhK898jZVQ+LkOF9ZdNKIsou9MBa3e1B0scbLIHREHq
         mJocMrBQbZxgm5n2J5G/1Y3pKCgIEp0Imgm2tAOuI3KujW1r6BsGSyvlXohSvqUO3qNt
         Hr2TaO93kMEFkDr7sr9/pESlX2HxjTxvp6Xfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KWSPorib+rcFS+AbGQaimDLnTgL2QfSgheTWv9cJFis=;
        b=oblfzq8mGhFKyJawh+YdA5VV4h66o5xlpXrW8TtStJOtsl73hLKnHoqM+9J0m36c10
         Q2vcZr9YxgJtfh9kOi/YdARVRHC7N89a/OIIN6UGRmW/8XL5/0hLaodWPyjwyEGs4HA6
         ffP2YDnFcnfbu0amF+2XXox3/c98YS4AYbHKeA2E21RaIz46dkbWD9UgonE4Ow0JwJ/w
         Cv/RjOo+TmqOKs0NkQzRU1g2/ui66ETmZ5Yb4Dpi0B3PxY6wWu20yRGqrenTGvWGWUsD
         VZ39zS/qfYPY34t3CpOq2gMr0/h0YNo74vYeRtiTVIuxhFa18lo2q7YMLJvj/TvM6z76
         RAwA==
X-Gm-Message-State: APt69E03O8/xNzxbcgobr2EJpAjakE/TWeKPzhxtUWueymOYTdcHCFIe
        9Es+ZvuVjaxWv5Z5ms525g97IQ==
X-Google-Smtp-Source: AAOMgpemMn8X9aw9Hfs91ju1ETh7yYZLBb6lT5A3yuZaPSHFRAEysWdWc+fGGFrtB08FpJkXHRFQKA==
X-Received: by 2002:adf:ef50:: with SMTP id c16-v6mr4181281wrp.182.1530091908052;
        Wed, 27 Jun 2018 02:31:48 -0700 (PDT)
Received: from [192.168.1.100] (aig34-1-88-167-228-121.fbx.proxad.net. [88.167.228.121])
        by smtp.gmail.com with ESMTPSA id y18-v6sm4911202wrn.68.2018.06.27.02.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 02:31:47 -0700 (PDT)
Subject: Re: [PATCH v10 00/14] Krait clocks + Krait CPUfreq
To:     Sricharan R <sricharan@codeaurora.org>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
Cc:     robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk,
        ctatlor97@gmail.com
From:   Thierry Escande <thierry.escande@linaro.org>
Message-ID: <a58c2d2c-64d1-7223-dc98-8f749397375d@linaro.org>
Date:   Wed, 27 Jun 2018 11:31:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sricharan,

On 19/06/2018 15:45, Sricharan R wrote:
> Sricharan R (2):
>    clk: qcom: Add safe switch hook for krait mux clocks
>    dt-bindings: cpufreq: Document operating-points-v2-krait-cpu
> 
> Stephen Boyd (12):
>    ARM: Add Krait L2 register accessor functions
>    clk: qcom: Add support for High-Frequency PLLs (HFPLLs)
>    clk: qcom: Add HFPLL driver
>    dt-bindings: clock: Document qcom,hfpll
>    clk: qcom: Add MSM8960/APQ8064's HFPLLs
>    clk: qcom: Add IPQ806X's HFPLLs
>    clk: qcom: Add support for Krait clocks
>    clk: qcom: Add KPSS ACC/GCC driver
>    dt-bindings: arm: Document qcom,kpss-gcc
>    clk: qcom: Add Krait clock controller driver
>    dt-bindings: clock: Document qcom,krait-cc
>    cpufreq: Add module to register cpufreq on Krait CPUs

Tested on apq8064 (db600c).

Tested-By: Thierry Escande <thierry.escande@linaro.org>

Best regards,
Thierry

