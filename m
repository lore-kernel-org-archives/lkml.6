Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E3FC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF6A20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCxK4dBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF6A20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbeLMKO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:14:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34069 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbeLMKOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:14:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id 17so854268pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 02:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Prxa9rbmpZlxcfZ2OPiudHG/k+M0T21Jd1CJUsV2Zy8=;
        b=CCxK4dBBmfy8xKAvrxh5BjpsIExxOzMQrOmJs5NK3x4jpZTNRPNfoLblWld5DeAf1M
         TvcsdFAoY3iaLllJAy6evx/iUmjrrBbOtmIp7RRseakz4RtyfYVaoVywf5ggjfCjjH3g
         dwka9xAYpoV1SPTr8m5Cm0X+SkBK80jIVe9tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Prxa9rbmpZlxcfZ2OPiudHG/k+M0T21Jd1CJUsV2Zy8=;
        b=hqDYDc76lVwg3vGTuC8Ptq18Ap1HTM8b44a2HQA0apLtX682S+gIeOZN28Ec8eYkJI
         hzmBCLUQuUQYlpzIUS5eZgdBpheXn47Cpr4rfFgDhRFdPGLPv6JNxozz4iaImV0A38zT
         YYSMYGjKGUAj7chb75oWC+cjEA2BaXh4K71ADeJwdriqMDtkMr4Hf1iYb+oMZZJ1y/fA
         41oJBkMxm2fO/PHSE3gslC189Q8RMuVGAf8OcobmAPLyzMKDll5wn2IDdPBqUjwyyJnH
         JftwVGupCpL2P0BlYi/S5lb1KZABvPGr+cSyMWEeO6tYEOovycMW8ll57ELFYlWUmzp0
         gdwQ==
X-Gm-Message-State: AA+aEWbanZJg4Er3LzBLbB78suRiqpPz6qBNvE6eftZ2PVNqpnt0MyS2
        +t6FA8jxHlWAE8ovo0fv1+pd/Q==
X-Google-Smtp-Source: AFSGD/VtjuYWujsY9lSCYoBUagrPB1V71XsSHUerEY454SmeBHdsei5Wtslr4lsbP4DekINMUhDIUg==
X-Received: by 2002:a62:81c1:: with SMTP id t184mr24188795pfd.40.1544696060056;
        Thu, 13 Dec 2018 02:14:20 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id a15sm1717359pgb.1.2018.12.13.02.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 02:14:19 -0800 (PST)
Date:   Thu, 13 Dec 2018 15:44:17 +0530
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
Message-ID: <20181213101417.dcz66dpbqzbbxkdz@vireshk-i7>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
 <1544687394-331-3-git-send-email-tdas@codeaurora.org>
 <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
 <20181213100506.sy3haqjbxtmkthvt@vireshk-i7>
 <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-18, 02:12, Stephen Boyd wrote:
> It's on a v4.19 kernel with this cpufreq hw driver backported to it. I
> think all it takes is to return an error the second time the policy is
> initialized when cpufreq_online() calls into the cpufreq driver.

What do you mean by "the second time the policy is initialized" ?

We call cpufreq_online() only once for each policy.

-- 
viresh
