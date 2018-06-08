Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MoVqJjMAGlsfXQAAmS7hNA
	; Fri, 08 Jun 2018 04:04:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B59ED608BA; Fri,  8 Jun 2018 04:04:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIP6PV5m"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 960FB607E4;
	Fri,  8 Jun 2018 04:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 960FB607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbeFHEEU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 00:04:20 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36609 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbeFHEEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 00:04:16 -0400
Received: by mail-pg0-f66.google.com with SMTP id m5-v6so5746362pgd.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 21:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JLXuaJ+8FCQWd3Wp4FxxkpLkNy4WgUroUbrDJKdCrHY=;
        b=CIP6PV5mAZ1k5V77Kft2cPQqEj3Nnp1BPBN3CRBa9XAlgk4kTR03SH67HsYIL+pz2t
         UlDc9vf3CltDJxR00t9th6A2hvd1bG62T89BUIVSafApSAiS2bUPIZul6x5NnOsCKQWn
         rJMDaPvBDRoxI9P7B7QiPsDkj+JGdydmuIG6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JLXuaJ+8FCQWd3Wp4FxxkpLkNy4WgUroUbrDJKdCrHY=;
        b=aCLbaqX7rsDvwbtFbZp6DwXYtPo841im8SK2XfZz1R7mVYUfOd8i62m242eMEAU57U
         q9PygPZ0UrlU+MmkityYnAKR6rNI9gdf1FDXF/M757Zz0Kfy7WYg0FNORNaa7sCk/pr+
         airBMIw/205e3lWaPRkj7/zuLrRUxvPwkWgI3FyeHFJna3r555vtqIqW7vn/NuRjrK/m
         Ry0tZYq3XwSOAYK8FfVYZO2o1gFhMdQXWcoyEgJYCDedLzXPh6aKTHwqBEOSqpveur0Z
         bpNY0T+GKZLwi61wFjN/kKm5O4XP4TW+OKCPXjqPORsExXbzBG8WD5RJzwe6Lr2yzSpQ
         f1Sg==
X-Gm-Message-State: APt69E2cYbezn/P52RgMlMGeL/AEig/03TbIQAa6EcvXltjXcfAU21A7
        Yyn/RyCHhnubnq62AWYSLR3mPA==
X-Google-Smtp-Source: ADUXVKL6U4SGtuoF9CF57Dt6FzC4SKc2G1CpD9D/ioh5LMqsI/ybnlrx9LiZYsiGiYtZ/8EOLlhusg==
X-Received: by 2002:a62:fd0b:: with SMTP id p11-v6mr4335207pfh.52.1528430656022;
        Thu, 07 Jun 2018 21:04:16 -0700 (PDT)
Received: from localhost ([223.226.91.101])
        by smtp.gmail.com with ESMTPSA id c12-v6sm26949591pfi.177.2018.06.07.21.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 21:04:14 -0700 (PDT)
Date: Fri, 8 Jun 2018 09:34:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        Artem S Tashkinov <t.artem@mailcity.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH][v2] sched: cpufreq: Fix long idle judgement logic in
 load calculation
Message-ID: <20180608040413.2pjfr6by3me5qymk@vireshk-i7>
References: <1528420053-22884-1-git-send-email-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528420053-22884-1-git-send-email-yu.c.chen@intel.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-06-18, 09:07, Chen Yu wrote:
> According to current code implementation, detecting the long
> idle period is done by checking if the interval between two
> adjacent utilization update handers is long enough. Although
> this mechanism can detect if the idle period is long enough
> (no utilization hooks invoked during idle period), it might
> not contain a corner case: if the task has occupied the cpu
> for too long which causes no context switch during that
> period, then no utilization handler will be launched until this
> high prio task is switched out. As a result, the idle_periods
> field might be calculated incorrectly because it regards the
> 100% load as 0% and makes the conservative governor who uses
> this field confusing.
> 
> Change the judgement to compare the idle_time with sampling_rate
> directly.
> 
> Reported-by: Artem S. Tashkinov <t.artem@mailcity.com>
> Cc: Artem S Tashkinov <t.artem@mailcity.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2: Per Viresh's suggestion, ignore idle_time longer than 30mins and
>     simplify the code.
> ---
>  drivers/cpufreq/cpufreq_governor.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
