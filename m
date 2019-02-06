Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7FEC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6817420844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsH58K6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfBFEw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 23:52:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37664 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBFEw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 23:52:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so2402493pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 20:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jXHb9lbYoSf/MPyXB+Nyl8mORi2qbkCDejL2LhD8OUk=;
        b=YsH58K6TkzUKdj07xj0Rc2v8PmOsoRwFTTVzbb2Dq6H4w5RhxrsRoK/NqkDyiAA2xJ
         rfQ0fFoRh1BjhTjarUnPlQrYfYsC7G/TbrLDUYaIkjc0pTb3VZnXSTAOjJ1IIs3pszKa
         G6WmgieTjHZGZ3Ci4sq3n33dzfyNwfAKFkwmtEP9pg6R7+KqdMhYYGBdyChgQfZS7Z8M
         Mk9deWaXaCVTdYiMLCkKAZ4mXZSf9ia6VeTQAwuJFYYilqc2G+iysV0Y0INXRy53resN
         qRKeTxPkwtk9CJnaJf4eFme8am1VVMq+vgmwpCqBi3k/X+OSSNL8+RBLdUJ4aF9ujQvS
         Q+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jXHb9lbYoSf/MPyXB+Nyl8mORi2qbkCDejL2LhD8OUk=;
        b=ftDkQbs87VxFKoBmhvcFyPZVCZ+4wBY/4toLDtlIW8s9YBAJZRFqzwPSXLWIgKxuwO
         q41wetQqyD4tUwMAd24Be5ZOdDYwbH5RZX3yZH8xTHGCpfwXEfqZsK7BigmML5yAOSam
         g/rKqVi1QUpb88WwfkLsglmV5gWdC04vscDiMuAHTPyP/fwx1ue97YVaGXIGmDAFPx8J
         e+HYOVg+E7IJnqHvliaMxabuQElUB8Z+lLXeEIWzoewZV1HZ8+40SU7FZaly0M/MypKh
         KU2W84J+a/Z08HlABEVVCIKuuc6aOjRA2NCwgjFHg485p9slcBJ85hCb87oL8tduyaTJ
         Tn/A==
X-Gm-Message-State: AHQUAub6FjiMIS3UN0nL5aBEmB7evJQeCwPdQhfGq5/5uAxafJ7chaHp
        Lutc+Sz7eM9GI5HQOqzMrDJY8A==
X-Google-Smtp-Source: AHgI3IYpGFT/s/hAcjJT6Li9JPvX+6mYH3O1Nu2RrbRFA5CUBdTYVRqg/Mcabcd0H0y87BQY6mZ0fQ==
X-Received: by 2002:a63:4948:: with SMTP id y8mr7893639pgk.32.1549428775669;
        Tue, 05 Feb 2019 20:52:55 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id x27sm10175969pfe.178.2019.02.05.20.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 20:52:53 -0800 (PST)
Date:   Wed, 6 Feb 2019 10:22:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Quentin Perret <quentin.perret@arm.com>,
        Taniya Das <tdas@codeaurora.org>, CK Hu <ck.hu@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/2] cpufreq: qcom-hw: Register an Energy Model
Message-ID: <20190206045251.23p4imsqlropssxl@vireshk-i7>
References: <20190205175225.25923-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205175225.25923-1-mka@chromium.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-02-19, 09:52, Matthias Kaehlcke wrote:
> Try and register an Energy Model from qcom-cpufreq-hw to allow
> interested sub-systems like the task scheduler to use the provided
> information.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index d83939a1b3d4c..a16b9dca7ea3b 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -205,6 +205,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  		goto error;
>  	}
>  
> +	dev_pm_opp_of_register_em(policy->cpus);
> +
>  	policy->fast_switch_possible = true;
>  
>  	return 0;

Applied both. Thanks.

-- 
viresh
