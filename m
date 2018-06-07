Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 91VMDIC4GFuudgAAmS7hNA
	; Thu, 07 Jun 2018 04:45:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 140A4607F7; Thu,  7 Jun 2018 04:45:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="giAleEvE"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9F678601C3;
	Thu,  7 Jun 2018 04:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F678601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeFGEpt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 00:45:49 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34268 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752549AbeFGEpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 00:45:47 -0400
Received: by mail-pl0-f66.google.com with SMTP id g20-v6so5258435plq.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 21:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BPFHyEwM4EHx1hf8iCpiNb3dLkZMVmR03Snh3awy5XQ=;
        b=giAleEvE299T47vba9DTCH5eA6QhG1Rw8zCq+SCK5auiOYcWNutHAwiRfJL6VAAEGu
         sRChuEt0yh8SmjWlfkHmRjuySgGoj1JOcDIt5Z35xAiL0UQ5KPR76KeUrKsPxJmbgPCP
         Aif4nRTblPHG1qv+LG4hKaVuGlFt0D5J+xFWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BPFHyEwM4EHx1hf8iCpiNb3dLkZMVmR03Snh3awy5XQ=;
        b=bdJm/y/N4hVg/eYn2RYedir16CtISgzKKTfQhTPBjiAd3AheIcDvqgtq8IL5cM6c3+
         3F9rocYsFYYzJqzssx7nDrMp670QUfW41Bt+sBDQm0fgJBZvvT+Thgk9HUaErvD4C2CP
         HCvTxrUnqkNPCL9U8n90N7b9h2ZV9ih5IsqU12X11EhB+JLQ2EAGwYP0H8bkatbo7V/3
         3Okf0hkuWDzq8gTSG0M5Y5hYtjAVgaDQDiJ3mLGOSPzLjiajR2KaIQvPKde0BMW7j+lD
         UuZ6VBCqBk9AQAmEctuumz6hqKNFVRIEvqiL2D/saqSfCp0FA5owFvdR75F+OipFqkiz
         7pBQ==
X-Gm-Message-State: APt69E3UKFO+er46qop/8hRGP0Huh5tWZS7CBvZ2ryI9x3cHxKeRmLWk
        bvE+NkcTg40z4MNSBKxFKjbo2Q==
X-Google-Smtp-Source: ADUXVKIjfnPHXFQcSX6ePBB8uP2LdEwAxRsIWQbo9qZnspOtICiRqzT+E3985RMH43f3aKncEDCI0Q==
X-Received: by 2002:a17:902:b946:: with SMTP id h6-v6mr387213pls.1.1528346747229;
        Wed, 06 Jun 2018 21:45:47 -0700 (PDT)
Received: from localhost ([122.172.63.23])
        by smtp.gmail.com with ESMTPSA id k80-v6sm74977743pfa.168.2018.06.06.21.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 21:45:45 -0700 (PDT)
Date: Thu, 7 Jun 2018 10:15:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        Artem S Tashkinov <t.artem@mailcity.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH][RFC] sched: cpufreq: Fix long idle judgement logic in
 load calculation
Message-ID: <20180607044543.d7pswad5tshw26lc@vireshk-i7>
References: <1528341454-16991-1-git-send-email-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528341454-16991-1-git-send-email-yu.c.chen@intel.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-18, 11:17, Chen Yu wrote:
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 871bf9c..9792c80 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -165,7 +165,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>  			 * calls, so the previous load value can be used then.
>  			 */
>  			load = j_cdbs->prev_load;
> -		} else if (unlikely(time_elapsed > 2 * sampling_rate &&
> +		} else if (((int)idle_time > 0) && unlikely(idle_time > 2 * sampling_rate &&

Yes the figures are insane, but if the idle time is around 36 minutes, the
conversion to int will make a positive value look negative and we will exit the
conditional block. And if we don't think that we will ever get such insane idle
times or we don't want to care about them, then what about doing this instead:

		} else if ((unlikely((int)idle_time > 2 * sampling_rate &&

same below.

-- 
viresh
