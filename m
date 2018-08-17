Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CA5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF678208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="kHgrYAMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF678208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeblueprint.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeHQNab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:30:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38026 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeHQNaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:30:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id t2-v6so4263303edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 03:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+vZk7C/cvTmaqiJT52wjY54OISBHhnjBYNXgUMZjnxw=;
        b=kHgrYAMIESJL1ZnamAad4Uu5XsUDvwR5bxa1aqwrR+U+ChNAoOxia0Gx6VzzGn+LcN
         kLhO1pXZQi+gcgqkxW81/Dvd8i19fCO1ipbmrUwWDnyESI27AiRMnSh14Zhy4Go6aRPV
         KO1R6t9zoNCcfI0/5IXdw1wflTZIUE/ZRuITKl5hixWRsuml07pf9gQ/60tbkzKER3eV
         ZJjof1q1JLBSsUuCxQLjE9lVBzjc98GI4bZ7Cu/HU0PPtQ1bd8CzHIr3M2gJQWkRCVwq
         m/8nHI90owuKx6CHo29/czeNoGMG2cMgKewxESNGfpFJJML2SiDKje12HqHrmuNEmmCc
         lWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+vZk7C/cvTmaqiJT52wjY54OISBHhnjBYNXgUMZjnxw=;
        b=eXqehS2ho4xrkNHWny4t4FGurTfQ6wjvwsRF/XpQgbameLttYDyWDn3CKMzPX0bASa
         Oj3KqJO2PWjXKI8LwpvJLRKpZ2CmxoZXoybobdFf733q14Ulc41IRmJbsULXrXyy2mo/
         8zOPgtv4x4ir9o7DCLAaa1kdZuHb6nTXewBynS1oDXRD59HSEzTaw+NkpyolE1MitaMg
         ZM8EPMvVBOk80fJNvsRcSerF5gq6+788jqzLrFu7F8zxBkd+4qCPqic1+/kg8RtqyDkr
         QjVEWIP+Ve7erw7e6xdWXrCt0kX1o0fbcP7gIpE9TTffZLdiD6OtH+ZCEnOVJkGk+CTB
         QiuQ==
X-Gm-Message-State: AOUpUlFeMV2qWrn79ruXKij3ZCrw7HfcPOnhWgtDHQtfiXNjV2+XhKze
        nYoPYRf4RebBAHfWKEg7XmtoO1zASqM=
X-Google-Smtp-Source: AA+uWPwaQrgffGp8jsFRKEj4xG+54XqKXScVJraj8laWfDiTamDGPR99gVGwD+VIzaaJHEncGqFiNA==
X-Received: by 2002:a50:d689:: with SMTP id r9-v6mr41959256edi.259.1534501655669;
        Fri, 17 Aug 2018 03:27:35 -0700 (PDT)
Received: from localhost ([94.13.61.204])
        by smtp.gmail.com with ESMTPSA id d26-v6sm3383121ede.50.2018.08.17.03.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 03:27:35 -0700 (PDT)
Date:   Fri, 17 Aug 2018 11:27:34 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH] sched/fair: Avoid divide by zero when rebalancing domains
Message-ID: <20180817102734.GA4253@codeblueprint.co.uk>
References: <20180704142455.16035-1-matt@codeblueprint.co.uk>
 <55afee27-4143-e08c-b254-0d68a05d5ee6@arm.com>
 <20180705132726.GB3864@codeblueprint.co.uk>
 <94149109-a54c-fc5d-7b56-e786c8de5b94@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94149109-a54c-fc5d-7b56-e786c8de5b94@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul, at 05:54:02PM, Valentin Schneider wrote:
> On 05/07/18 14:27, Matt Fleming wrote:
> > On Thu, 05 Jul, at 11:10:42AM, Valentin Schneider wrote:
> >> Hi,
> >>
> >> On 04/07/18 15:24, Matt Fleming wrote:
> >>> It's possible that the CPU doing nohz idle balance hasn't had its own
> >>> load updated for many seconds. This can lead to huge deltas between
> >>> rq->avg_stamp and rq->clock when rebalancing, and has been seen to
> >>> cause the following crash:
> >>>
> >>>  divide error: 0000 [#1] SMP
> >>>  Call Trace:
> >>>   [<ffffffff810bcba8>] update_sd_lb_stats+0xe8/0x560
> 
> My confusion comes from not seeing where that crash happens. Would you mind
> sharing the associated line number? I can feel the "how did I not see this"
> from there but it can't be helped :(

The divide by zero comes from scale_rt_capacity() where 'total' is a
u64 but gets truncated when passed to div_u64() since the divisor
parameter is u32.

Sure, you could use div64_u64() instead, but the real issue is that
the load hasn't been updated for a very long time and that we're
trying to balance the domains with stale data.
