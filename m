Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A81C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3985920849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBu5QExX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3985920849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeLMKFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:05:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41377 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbeLMKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:05:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so833156plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 02:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fsStyqZ+Oi8IWCobZN88MbquuXK8Ka8f7XuCzY3T/so=;
        b=dBu5QExXtmHRI6yefFNFpIi58jL7Dgg9POUt3KLusie6uaD821kxzmWAbUHkQ/J6pU
         KHhiwytgAt2lC0UGrupj20D7zWce8zlQ4wDUNuhqgBTHeLbuJdiiQOMzJAkp9HT+7BTg
         xfoZWSCXXEpJw2RrcoYq8NcyJdVpjoF4YvJOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fsStyqZ+Oi8IWCobZN88MbquuXK8Ka8f7XuCzY3T/so=;
        b=P/KZ3a4jRIxuSRSq+x4iJ2ukSsYu0clhIrQD1RAeciIlPhfKAEz61ySCyRicv1t7t4
         unNY2CJGAlf1v80eCPSnvgkSj+RtY/9nlKuBAioMfM9oMu1K+sVym7jT0slwLTI2s77s
         4TpaV6bMTb360eXVlIcutNGazmQscjHDm31FOhpX4eKdzRmrZonFgoIogbEtc/ZcyGqw
         /Pv3DWMhaCRkbgHqNlF2oThv9/L8PzYpNJB9kmAlTeuggYXR7wU3Ggd+9umFlprD8PF3
         +dUf8y5zwunmwzwzNstfdwe0+SPwXBFmQKgvTN7R0GspATVbT9FFKKnNUctcOkwXS4UB
         IRuw==
X-Gm-Message-State: AA+aEWZoBqAHGZkGcdpchGSGbanxTECaJS1JM8UOKlDgFhm5N+xVDwRX
        /MNnh7uNOt0RmtQz0CKCg8uGbQ==
X-Google-Smtp-Source: AFSGD/X9KmmOs0ME0/acDGNNrY14c29aPstY8lmrtyFRSSenOe07pHP3TroJLZcS1cfRCdHj67Sonw==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr23638944pll.51.1544695510074;
        Thu, 13 Dec 2018 02:05:10 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id u137sm3195111pfc.140.2018.12.13.02.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 02:05:09 -0800 (PST)
Date:   Thu, 13 Dec 2018 15:35:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Message-ID: <20181213100506.sy3haqjbxtmkthvt@vireshk-i7>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
 <1544687394-331-3-git-send-email-tdas@codeaurora.org>
 <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-18, 01:58, Stephen Boyd wrote:
> BTW, Viresh, I see a lockdep splat when cpufreq_init returns an error
> upon bringing the policy online the second time. I guess cpufreq_stats
> aren't able to be freed from there because they take locks in different
> order vs. the normal path?

Please share the lockdep report and the steps to reproduce it. I will
see if I can simulate the failure forcefully..

-- 
viresh
