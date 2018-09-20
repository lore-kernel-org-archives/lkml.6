Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62467ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FB82087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="COiCOBHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FB82087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbeITV5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:57:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43976 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeITV5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:57:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so4590029pfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BMbuZk/S6KBpfbhYO1oujXRRcxe3kAbC1VYLKwZIaSw=;
        b=COiCOBHM2tDlj4SDbcSqTYiTwnZdz0brO2htDrwCuok5jrFuz9n0iIfNDunQQbor/E
         IR/QGeFTq9dMK0SbNX43ZQucBOY9Z3C1uGqc/Dr7/zGQn+9auxXL8FRSsoCDszerw/UT
         akY8eR6ZCgGnhwP8tUiCkeuK52f9NbcDkgq94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BMbuZk/S6KBpfbhYO1oujXRRcxe3kAbC1VYLKwZIaSw=;
        b=QIJmIY7sSzpXencczfC4r+GtxVywiUJyvHv0Q4PJ7AG+tEk89UoJyzNZaB7Aecxgyu
         EsUIRa29pV7KdxGx+CNjnscTQjHskZHamtv7JXsza1LbMPnD6Eig5muk6lH6vBY3z2RH
         cE+WTGuzxo+2MFuZL8IDBgq4ID30AvSzZq4MXgQ/uOhYAO/d+N7AQwyXgYCBoYGC5DCI
         x8031r3duqjatpi7kcG1U7Q7XO6pn7/s/GkKVp685z3VEaEaMcFi7FFf+12ectgPdKCe
         5kTLwiJiRhFekawhFgZQpReodHoLcnrPF8eiEMtTX6WODpgsTKF/EtwxH5tPlBRg4YG+
         fHCw==
X-Gm-Message-State: APzg51A+GGS93Yc/YJ3OGofbZ0yqG1RD54e7uwiinVmpG/ehl0mQ40/W
        +IfmhzTW++v1SspjGY35/KQpAQ==
X-Google-Smtp-Source: ANB0VdaQHmoK6tAlPBI9rVS4o8vIuAbMfbkfuHhTufJHcjmkEwkdQhxmd5seRTNmyXuwCE+sgb+rQA==
X-Received: by 2002:a63:f501:: with SMTP id w1-v6mr37677332pgh.446.1537459990206;
        Thu, 20 Sep 2018 09:13:10 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id e64-v6sm35287691pfk.87.2018.09.20.09.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:13:09 -0700 (PDT)
Date:   Thu, 20 Sep 2018 09:13:08 -0700
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ilia Lin <ilia.lin@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3] cpufreq: qcom-kryo: Fix section annotations
Message-ID: <20180920161308.bitlceo2czyzomsg@vireshk-mac-ubuntu>
References: <20180920002220.16644-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920002220.16644-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-09-18, 17:22, Nathan Chancellor wrote:
> There is currently a warning when building the Kryo cpufreq driver into
> the kernel image:
> 
> WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
> the function qcom_cpufreq_kryo_probe() to the function
> .init.text:qcom_cpufreq_kryo_get_msm_id()
> The function qcom_cpufreq_kryo_probe() references
> the function __init qcom_cpufreq_kryo_get_msm_id().
> This is often because qcom_cpufreq_kryo_probe lacks a __init
> annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.
> 
> Remove the '__init' annotation from qcom_cpufreq_kryo_get_msm_id
> so that there is no more mismatch warning.
> 
> Additionally, Nick noticed that the remove function was marked as
> '__init' when it should really be marked as '__exit'.

I know Rafael asked to merge the two patches into a single one, but I still
believe its the best to have two separate patches to fix these two separate
issues. For example, picking this patch for an earlier kernel may produce
conflicts because the exit code was written at a later point of time and also
that the below Fixes tag applies only to the first problem only. And the
individual patch for the exit problem is already on the list.

> Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Anyway I am fine if Rafael wants to pick it up this way only.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
