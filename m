Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344FFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2042080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVmpw3BM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2042080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbeKTIfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:35:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40447 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731273AbeKTIfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:35:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so24524441wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 14:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ix5DVTabkihYKI0mNasuj+mbNxbjZy/HjmKnTawTaDA=;
        b=AVmpw3BMNL4JLrBazsjIZi/5ZthpzXkeFNYa1nW4JmGqbzipeXb4gl3Yp0VZ4PeT2V
         /IsL2pB5BuXta4ys6p3ZGmJw6StJqfczgLyMvrlhRVlosW7XXPX+sWteCKWvfT7z7kKm
         Yuhk6yy2TkB0dY+rmZIs13yQGqm1CizAEn5oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ix5DVTabkihYKI0mNasuj+mbNxbjZy/HjmKnTawTaDA=;
        b=rh0KS1W7jLAEGIpKjVYR02sZV5N2//1PAU03NAX4M3rhFuLCdnE87eI3yoJGe3fE64
         OZyzruTqBa8wSp/RNITxmLRwvYZwDPQRAUlBroaSaMP2vAh46tqnWdI64Go96CXkHoU5
         7EFozIwWXELbeDuimALCJM9VZsp9v3HHuguy78cUXqkeBRupCYnZ+uqHGGzYj4vImSf7
         cpLcKRd8SrBNJdyVhdemJh1gXj8ED83K15ownzy+qtX01RBT0q/4H48j/nb9nxFBLTWt
         r8opXVGI6FQl02tzY9NcBxWxBVIMkhTwRAJqjNw7/x8co7WpNX2tuTCcg6iqQb57kLSc
         xGdA==
X-Gm-Message-State: AGRZ1gJg+Lvem54xodnuBRoXMi9KhYV3bEyy8g8vlmb0/zvbCigmledB
        41t2wKwzxCDcSVjeLgBP8/fZDQ==
X-Google-Smtp-Source: AJdET5fZoIaBekUMFIlKswysnnktnAd4bLZ8M4fCs/P5CNcDlZY9NDUR2smMi4JVeLyXUo5OtV1JbA==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr21635454wru.154.1542665385492;
        Mon, 19 Nov 2018 14:09:45 -0800 (PST)
Received: from [192.168.0.40] (98.242.136.77.rev.sfr.net. [77.136.242.98])
        by smtp.googlemail.com with ESMTPSA id q9sm24179292wrp.0.2018.11.19.14.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 14:09:44 -0800 (PST)
Subject: Re: [PATCH v3] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
References: <20181119112917.4214-1-abrodkin@synopsys.com>
 <360a492f-58b0-daa4-a450-3cdbfffbeabe@linaro.org>
 <349be75346aaf03eda8c49dfd90c06e3f916a1e3.camel@synopsys.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a400dabc-df12-1854-21c4-8e914ef538d8@linaro.org>
Date:   Mon, 19 Nov 2018 23:09:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <349be75346aaf03eda8c49dfd90c06e3f916a1e3.camel@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2018 22:53, Alexey Brodkin wrote:
> Hi Daniel,
> 
> On Mon, 2018-11-19 at 22:50 +0100, Daniel Lezcano wrote:
>> On 19/11/2018 12:29, Alexey Brodkin wrote:
>>> It turned out we used to use default implementation of sched_clock()
>>> from kernel/sched/clock.c which was as precise as 1/HZ, i.e.
>>> by default we had 10 msec granularity of time measurement.
>>>
>>> Now given ARC built-in timers are clocked with the same frequency as
>>> CPU cores we may get much higher precision of time tracking.
>>>
>>> Thus we switch to generic sched_clock which really reads ARC hardware
>>> counters.
>>>
>>> This is especially helpful for measuring short events.
>>> That's what we used to have:
>>> ------------------------------>8------------------------
>>> $ perf stat /bin/sh -c /root/lmbench-master/bin/arc/hello > /dev/null
>>>
>>>  Performance counter stats for '/bin/sh -c /root/lmbench-master/bin/arc/hello':
>>>
>>>          10.000000      task-clock (msec)         #    2.832 CPUs utilized
>>>                  1      context-switches          #    0.100 K/sec
>>>                  1      cpu-migrations            #    0.100 K/sec
>>>                 63      page-faults               #    0.006 M/sec
>>>            3049480      cycles                    #    0.305 GHz
>>>            1091259      instructions              #    0.36  insn per cycle
>>>             256828      branches                  #   25.683 M/sec
>>>              27026      branch-misses             #   10.52% of all branches
>>>
>>>        0.003530687 seconds time elapsed
>>>
>>>        0.000000000 seconds user
>>>        0.010000000 seconds sys
>>> ------------------------------>8------------------------
>>>
>>> And now we'll see:
>>> ------------------------------>8------------------------
>>> $ perf stat /bin/sh -c /root/lmbench-master/bin/arc/hello > /dev/null
>>>
>>>  Performance counter stats for '/bin/sh -c /root/lmbench-master/bin/arc/hello':
>>>
>>>           3.004322      task-clock (msec)         #    0.865 CPUs utilized
>>>                  1      context-switches          #    0.333 K/sec
>>>                  1      cpu-migrations            #    0.333 K/sec
>>>                 63      page-faults               #    0.021 M/sec
>>>            2986734      cycles                    #    0.994 GHz
>>>            1087466      instructions              #    0.36  insn per cycle
>>>             255209      branches                  #   84.947 M/sec
>>>              26002      branch-misses             #   10.19% of all branches
>>>
>>>        0.003474829 seconds time elapsed
>>>
>>>        0.003519000 seconds user
>>>        0.000000000 seconds sys
>>> ------------------------------>8------------------------
>>>
>>> Note how much more meaningful is the second output - time spent for
>>> execution pretty much matches number of cycles spent (we're runnign
>>> @ 1GHz here).
>>>
>>> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Vineet Gupta <vgupta@synopsys.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> ---
>>
>> Applied, thanks.
> 
> Maybe a bit too late but I completely forgot to add stable tag into Cc list.
> Any chance to add it still?

Yes, no problem, I've added it.



[1]
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/Documentation/process/stable-kernel-rules.rst?h=timers/core


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

