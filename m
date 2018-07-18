Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C578ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6312075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaJFrnuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6312075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbeGRIUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:20:49 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38668 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeGRIUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:20:49 -0400
Received: by mail-oi0-f66.google.com with SMTP id v8-v6so7025933oie.5;
        Wed, 18 Jul 2018 00:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4OsDnmMykXw8+KX6M4qhILFyM7kyOGwz5shw573DZyE=;
        b=EaJFrnuoEkUNKFHW3Civ7GB2xA5CDOEj6QtrpltD3E1uVkvH4MWKw3RdDreGHUTM5I
         PzBgbunU8yN2VFHo/N2d+IDffX9BOXpCILX991aLJOBMAksVYdmcK/ogEePE6T0qE1Ba
         kM7gVPOp3dzGAbEHm4RcW5X7zvwjN2qIdF9n+ia7T8OXlO1R3XXGsf3+mAfO56iB6ln6
         QLKuJKWoNsnLUOWyzn1YKnVffuL27biIrbgEfREsknvD86z6Qs4eHx9cNvC1QSWzzB8s
         UWXArpwFaXF2P3i2GQObF8lQVMclmpcLKTON/k3bh+W3pfJ2+TRsHXFFcXyr6awkOmad
         /LOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4OsDnmMykXw8+KX6M4qhILFyM7kyOGwz5shw573DZyE=;
        b=T7V6TPDgoecVnwoY16Y6hNYAgylUoNRYGqBJZSD8eormAspyf++OeqYtn/i9hjZkzY
         u9wZr48Us0cjY8O1A1vUaYpnOmaIvZew5c0K2X9SP9NBXtk2xOD4s5C6uoRq5sMMWF2B
         BUgDEidd7bKeMno6dfNQQY+16V+ShDB7TQTgewevKFlv0BsCjumMpm1AL+NPaC56eRQA
         j7wT0VBCHqEDbgkv/cElvRwN5sQ3+xwocykuYFpKoafz587UjG+f7nUyk62JJ5Rvt5WZ
         yD8nuDjpTRWnHBBqEvQIa5kZKfWSCpOUk2mqTI/Tcu1zOvhp+QK6gxOuHDPcELg0XjNZ
         0KGw==
X-Gm-Message-State: AOUpUlGj2C7Y6cuYNQiiJix0PFuxC7r09rJl/En0BRvQtU6QsjWBfeo3
        p/REznREzQGsF7r6EReaLfWs4NQX2C/B2C5wbr8ITA==
X-Google-Smtp-Source: AAOMgpe3Z1JAyENpkpVHaqECSD1z/gj5NlPV3YuYkcFNt7Cw7XV6BrjwjSo6ucEqVIMnqZo2zHe5Ningz6I0WHENOsY=
X-Received: by 2002:aca:ccc4:: with SMTP id c187-v6mr5010886oig.282.1531899855037;
 Wed, 18 Jul 2018 00:44:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 00:44:14
 -0700 (PDT)
In-Reply-To: <20180717201323.6rwb4yklq46cmtom@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <306375154.NhdH6AhdAd@aspire.rjw.lan>
 <5423012.ZZnfdYddaT@aspire.rjw.lan> <20180717201323.6rwb4yklq46cmtom@suselix>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Jul 2018 09:44:14 +0200
X-Google-Sender-Auth: T53LXHx4scQlqfULBctvPTIxLqI
Message-ID: <CAJZ5v0i-zrKEVh+KsNOgTpCCBaC7jqibyuz1QhiKWPCV-H4srA@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: pcc-cpufreq: Disable dynamic scaling on
 many-CPU systems
To:     Andreas Herrmann <aherrmann@suse.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:13 PM, Andreas Herrmann <aherrmann@suse.com> wrote:
> On Tue, Jul 17, 2018 at 06:14:58PM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The firmware interface used by the pcc-cpufreq driver is
>> fundamentally not scalable and using it for dynamic CPU performance
>> scaling on systems with many CPUs leads to degraded performance.
>>
>> For this reason, disable dynamic CPU performance scaling on systems
>> with pcc-cpufreq where the number of CPUs present at the driver init
>> time is greater than 4.  Also make the driver print corresponding
>> complaints to the kernel log.
>>
>> Reported-by: Andreas Herrmann <aherrmann@suse.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> -> v2: Rework the messages printed in the problematic case.
>
> I've tested this patch. Effect is as expected: driver loads but use of
> ondemand governor is not allowed. Sample output:
>
> [   40.757519] pcc-cpufreq: (v1.10.00) driver loaded with frequency limits: 1200 MHz, 2800 MHz
> [   40.831705] pcc_cpufreq_init: Too many CPUs, dynamic performance scaling disabled
> [   40.898353] pcc_cpufreq_init: Try to enable a different scaling driver through BIOS settings
> [   40.972327] pcc_cpufreq_init: and complain to the system vendor
> [   41.025620] cpufreq: Can't use ondemand governor as dynamic switching is disallowed. Fallback to performance governor
> ...
> [   41.187928] cpufreq: Can't use ondemand governor as dynamic switching is disallowed. Fallback to performance governor
>
> Last message is shown for each online CPU in the system  (ie. 120x).
>
> Looks good to me.

Thanks a lot!

Please also try https://patchwork.kernel.org/patch/10530321/

Cheers,
Rafael
