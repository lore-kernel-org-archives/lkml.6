Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Q2rQCNbwGFt9EwAAmS7hNA
	; Thu, 07 Jun 2018 08:46:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0773B608B8; Thu,  7 Jun 2018 08:46:14 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EfHZJbAf"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8495E602FC;
	Thu,  7 Jun 2018 08:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8495E602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753602AbeFGIqJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:46:09 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40411 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753190AbeFGIqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:46:06 -0400
Received: by mail-wr0-f194.google.com with SMTP id l41-v6so9135395wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TuKujEVZEvlNaf2eg9Wfnq/Vxwa1ZH5uK4jFxIqCpuI=;
        b=EfHZJbAfHjHVdKY3XFNISoHLptbxFtmPTrUI9Vy/FUMIa0tYLdWYf01mWiOyMJrEgm
         /hIBAGea1ojarLs6HhteE+x+v49sgIwXCYqRJi2iIiotc+A7+YuIBTbJAFZp/fakb+ul
         NtVy4kcXOx9ItNIQYiSoiJ+Cf4538sbx161/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TuKujEVZEvlNaf2eg9Wfnq/Vxwa1ZH5uK4jFxIqCpuI=;
        b=DFCSCiqssstyVnXqF3n/ICEdjpjzm+prRstdCWrVaBWoDqDpRUsTD77dTXNhXbkkqQ
         EtjWMc1HW3P6V+pt27pYx1If3GZBeCx0qQtkT5yNO0ipW6ZRivRsG4QJlmmHb8u7Zf46
         OvVPymmkrDNdNTQHAnqf8flPJqpo/9X2IFRhHzF2PG/nw5jBiW8SsNx4lg7R9f8U91jC
         B2CwAFIWItTWG6qnlqH+eyltXmKwiVKaY+/g244Le+dbssniu0sDpUxzEVewnBdR1amS
         5Lcbg5vdPHc2pmdbDMhJM7RDMNv4+htj8GD0M9RNMDcW0WN8ZyfOq2x1Kqat0I/gdoN+
         pcyA==
X-Gm-Message-State: APt69E2XGxvJsi/wDotIGNEHi4bSgdO8IaC01pSW8fnCCPNNstvjs2KU
        zI/xiTl3UKhgWC7XADi6QzlgXg==
X-Google-Smtp-Source: ADUXVKLOdTSH1bGnX9V04xkQbganVMCtHx1KbcnHyAePJLoqEpwuAk9dI0em7SXMpJHAGVHZzTNJbA==
X-Received: by 2002:adf:979c:: with SMTP id s28-v6mr958160wrb.28.1528361165503;
        Thu, 07 Jun 2018 01:46:05 -0700 (PDT)
Received: from [192.168.1.75] (lft31-1-88-121-166-205.fbx.proxad.net. [88.121.166.205])
        by smtp.googlemail.com with ESMTPSA id b124-v6sm1458465wmf.11.2018.06.07.01.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 01:46:04 -0700 (PDT)
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle injection
 framework
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180606122357.GN12258@hirez.programming.kicks-ass.net>
 <22f5cf0b-049e-7938-55f6-4b4b154f8389@linaro.org>
 <20180606150203.GE12180@hirez.programming.kicks-ass.net>
 <ea347237-7cef-095a-5ddb-19c181d10c23@linaro.org>
 <20180607083229.GJ12198@hirez.programming.kicks-ass.net>
 <20180607084251.rv2tg3kgz4aohlpd@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9996fb40-c7aa-db61-5445-52c146f44d85@linaro.org>
Date: Thu, 7 Jun 2018 10:46:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607084251.rv2tg3kgz4aohlpd@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 10:42, Viresh Kumar wrote:
> On 07-06-18, 10:32, Peter Zijlstra wrote:
>> On Thu, Jun 07, 2018 at 10:18:27AM +0200, Daniel Lezcano wrote:
>>> So IIUC, neither atomic or WRITE|READ_ONCE are necessary in this code
>>> because of the wake_up_process() barrier is enough, right ?
>>
>> I didn't look hard enough; if there ever is a time where the loads and
>> stores happen concurrently, you need READ/WRITE_ONCE(). If there is no
>> concurrency on the variables, you don't need anything.
>>
>> Neither atomic_read/set() nor REAd/WRITE_ONCE() will help with ordering,
>> which is what the wake_up_process() would provide here, different things
>> entirely.
> 
> Right and you still need the READ/WRITE_ONCE() thing as
> idle_injection_set_duration() may run in parallel with the idle_injection_fn()
> thread.
> 
> And I don't think the purpose of atomic_read/write was ever to take care of the
> ordering issues in this code, it was always about parallel loads/stores.

Yes, correct.

But if we don't care about who wins to store to value, is there a risk
of scramble variable if we just assign a value ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
