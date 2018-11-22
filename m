Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B680C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE21D20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTnblpf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE21D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392108AbeKVPox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:44:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32946 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeKVPox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:44:53 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so8671335plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 21:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Oal68aMbB46i9rad/4oX/NrDQvV8/RAFMheUFx2YrLY=;
        b=WTnblpf6HpghHrs+5pJHQ9Dum4+1rAwgi9nDhy6KPxnBiXd5WXsr5YosjkNJ0Ynq54
         UOsvP/IDLWgLfw94mPxt7BtQV4NELeGbbErcfY97NIxhdr4N4vAqnechmc/HySZYEWS/
         845OnPZZVJpqtcUmJK154u371mWK39R+vmZGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oal68aMbB46i9rad/4oX/NrDQvV8/RAFMheUFx2YrLY=;
        b=Ydsdxq85GoZHFEwJMshduxs1HAiZ1wQgqN/tiYYnzTWJVlATGfjJd1vJsstxlMPvCI
         v6fW2QqgNVd0GGfSon/1p+oSvCEypUJ5qN6AiHD5SFiSn1TeNRjseEtTw4hdG+Qgnv27
         6b3vjkSWfJqsdwFBg7lOuCEbdVGHWtlOEGc+2xbjjUpRS92xxMKVKP9MvpPCmULtXBwh
         GVqvHjfTIZYkF5D6FuzP9wIb0hRoCRYmOw1lg1R57vN4hB2NWuco/Z7CY27QsHkmN9IE
         3439uscnbLSn6ij9LhyXT0RVKxYHV/Tk+IzkFUE93/5BW0QrWKZ7n4uL+aW2/WU/cV92
         tK0g==
X-Gm-Message-State: AA+aEWZhIv04msTjjbddkXaV6Qw7q/5plcFyTNemBae7eBxXkM071VIS
        zpryac+/S8VEXGxqPzYDnpIJbA==
X-Google-Smtp-Source: AFSGD/WR5kG6RM5XHXAOWodsq7ookagP4X2kImbZzKSeLkWCPYlD5d0alJ1a1r6VMwtYL63qnYU4Fg==
X-Received: by 2002:a63:f412:: with SMTP id g18mr8843617pgi.262.1542863232324;
        Wed, 21 Nov 2018 21:07:12 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id w136sm38344133pfd.169.2018.11.21.21.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 21:07:11 -0800 (PST)
Date:   Thu, 22 Nov 2018 10:37:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
Subject: Re: [PATCH v10 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Message-ID: <20181122050708.zictqzfne6odsywu@vireshk-i7>
References: <1542796967-5949-1-git-send-email-tdas@codeaurora.org>
 <1542796967-5949-3-git-send-email-tdas@codeaurora.org>
 <20181121220614.GU22824@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121220614.GU22824@google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-18, 14:06, Matthias Kaehlcke wrote:
> On Wed, Nov 21, 2018 at 04:12:47PM +0530, Taniya Das wrote:
> > +	.boost_enabled	= true,
> 
> I have no real expertise with cpufreq boost, but after reading a bit
> through cpufreq code this seems wrong. Boost is enabled statically,
> however the driver has neither a ->set_boost function nor does it call
> cpufreq_enable_boost_support() which would use a default
> implementation for ->set_boost. As a result boost support is
> effectively disabled:
> 
> static bool cpufreq_boost_supported(void)
> {
>         return likely(cpufreq_driver) && cpufreq_driver->set_boost;
> }
> 
> The driver should probably do the same as cpufreq-dt.c and call
> cpufreq_enable_boost_support() if boost frequencies are available,
> instead of 'enabling' boost statically.

Feels like I have written the boost support in cpufreq core few decades back as
I don't remember any of it :)

But reading through the code this is what I understood.

There are two parts of boosting.

- Sysfs file available or not to enable/disable boost frequencies on the go.
  This file gets created only when cpufreq_enable_boost_support() gets called.

- Will cpufreq core consider boost frequencies or not while checking target
  frequency again, this is governed by cpufreq_driver->boost field, which can be
  set from driver or using the sysfs file mentioned above.

In this driver, all we have done is to set the cpufreq_driver->boost field to
true, which would allow cpufreq core to use boost frequencies as well. But that
isn't any better than making them all normal frequencies and getting rid of
boost stuff. The boosting stuff will be useful only if you want to disable some
of them at runtime, based on heating, etc. And that is possible only after you
create a sysfs file.

-- 
viresh
