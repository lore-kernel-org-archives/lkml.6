Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jbasG3AKGlt9KwAAmS7hNA
	; Fri, 08 Jun 2018 04:48:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1848E607DC; Fri,  8 Jun 2018 04:48:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPUxak8x"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9F5936063F;
	Fri,  8 Jun 2018 04:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F5936063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeFHEso (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 00:48:44 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43397 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeFHEsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 00:48:42 -0400
Received: by mail-pf0-f195.google.com with SMTP id j20-v6so5982300pff.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 21:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Py+1R73YwcoNEMFbhO+eVWpBPwYbKkGS5BYEgnYsIv0=;
        b=CPUxak8xn7janXRY+NxViyjdD0+Kv3HroqlWKuNd76iI/Aq6gyw7lhkn0wpqUglyrk
         0qm/McnBthmQcRfRAbcSO+YkWj5Cnuxcj6evMyaqO8OjKGjlEZawsir7Yc38YRC+ZZjs
         TrbF+SpvKins4XyNp9p2Ez6Hi/CMgBR8p4esU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Py+1R73YwcoNEMFbhO+eVWpBPwYbKkGS5BYEgnYsIv0=;
        b=p3EtG0EEn3gCDJfOy8nevWlUvoDUn9dTwVJF0k8u/r0JRdX8a1c7qcpXyEEd+xEb83
         GfUQFqguM3rgECwd3eaGXq5S5NeaMBe+H8yO2jKv5O6lPHG1eazHOEt3zo8ZaAdFsFww
         4mZXPqI0TgG33ZCvEQdsWcECNDRabt7pv2UNuXi2DSB0PR7PzPe6XP4YWnpvkQs3OtYB
         Lf5MhodgUeLpndJRIY3cf1ggUmWyC9Ign89vogLSYZS3QZrVDnfHAB3kKj7rG0S2rDo+
         llmkzXTHXlfWHWsrKZCwlObcxzMiMHDYrjOAbLsdnh5ZtVDEvBfqClmYLCEdZAzWZUks
         siow==
X-Gm-Message-State: APt69E16AcncT/9OjvwsDo+yG8ObknLrki1RnKcSj3i9IfLAccHs/JHV
        9c5Pqa6+jKjjWA9W1c25E8Qq8g==
X-Google-Smtp-Source: ADUXVKJyRQ9BYafXVf9o9D+XMNF2DyM9e4yNnhMVHp13u0k6yFhvV/ruwW6ApAsw3Lp00DJd8EZqIQ==
X-Received: by 2002:a65:49cb:: with SMTP id t11-v6mr3868448pgs.218.1528433322334;
        Thu, 07 Jun 2018 21:48:42 -0700 (PDT)
Received: from localhost ([223.226.91.101])
        by smtp.gmail.com with ESMTPSA id u84-v6sm62105199pfg.156.2018.06.07.21.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 21:48:41 -0700 (PDT)
Date: Fri, 8 Jun 2018 10:18:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180608044839.eyaib5gkbw7biu2a@vireshk-i7>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180605103917.pyhhcobdvaivqv6g@vireshk-i7>
 <57d769f8-46ea-512e-8f89-a0439c9d053f@linaro.org>
 <20180606042708.mtwd66ecy2cnjp7a@vireshk-i7>
 <2bebd1bc-e1ad-6d22-ad1e-aee2cf8ba878@linaro.org>
 <20180606104528.nhwcd2qnxeouk6il@vireshk-i7>
 <1d542490-fcb5-33fd-ab3b-eddf3d300bd4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d542490-fcb5-33fd-ab3b-eddf3d300bd4@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-18, 16:11, Daniel Lezcano wrote:
> >> I'm wondering if we can have a CPU hotplugged right after the
> >> 'put_online_cpus', resulting in the 'should park' flag set and then the
> >> thread goes in the kthread_parkme instead of jumping back the idle
> >> injection function and decrease the count, leading up to the timer not
> >> being set again.
> > 
> > True. That looks like a valid problem to me as well.
> > 
> > What about starting the hrtimer right from this routine itself, after taking
> > into account running-time, idle-time, delay, etc ? That would get rid of the
> > count stuff, this get_online_cpus(), etc.
> > 
> > Even if we restart the next play-idle cycle a bit early or with some delay, sky
> > wouldn't fall :)
> 
> We won't be able to call completion() in this case.

I was just having a look at smpboot.h and saw the park/unpark callbacks. I think
you can very much use them to align things with CPU hotplug.

-- 
viresh
