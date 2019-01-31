Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43219C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BEB218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548928946;
	bh=PSK8nWqrax5OTwMbWZrojTdN2fH49Dig3n38U6AB9nc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=i/iV54q5Ag1frdO+aWgXvkcoVuqgcFa01030Z4Vpp/GcdDhF5Z2xxR+WAOW/L21cu
	 QgfYpI2ROA8aiTlqDYS04p7HxaiVeEAKTtxBfbmht3+qboXsgqPbRN5BWtVb5SQBci
	 f8W/XrqRcBPTzUzYQe70Ad0yBCz5U0xZtBSr8rNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbfAaKCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:02:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45591 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729509AbfAaKCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:02:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so2253841ota.12;
        Thu, 31 Jan 2019 02:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PHT1EMf0HMi7CqErngK2FHpkAf8OS6d9/B/7LNThXEA=;
        b=Jrd4C7k7DRI20aNhQnwr0jHW0FUUQ/zDJQIvLBApp3QO2as9Btmbb3OJfFBKRWpiJ1
         UwBWn8rnYbys8ioNLJ80tZ1IhR+L7P9EAaFeZlSaNv0cUKN5G3ZNFBYgMpAcqjcBbn3q
         wwLHDv1gD12kGNqwSa3+nvCboygSof9HR0izzR/SBtf+v5cvikyB6wHBmmagbE9BoGru
         8Y7CDQH97BP5t4LZXF55YUBppGx9HVzJ20H+iPR7lOnUYxQUwIDdigIi/F0StqPgioMD
         lxkSgxiltGjgvFv+APwJF9ai+fGMChbsh0AqmYBrKG08KTOdVFbWjXW3N4zvPFdl1GxZ
         tAhg==
X-Gm-Message-State: AJcUukeXwRtf4WuHBGcZpoIqNxPkywYMJdw/wkjHf6CTgx14NLgyQF/p
        UO+PoP0hNFi/N33rzhoDQD4mginfIVatgKjkJMg=
X-Google-Smtp-Source: ALg8bN4BsHfOwok203tdzzskFIbEhCCq+taACP4UZNV1pPdl8DhI+t4YB7uAcsjddsSKCbQV3Y3qeCix2zo5xlJ/TQQ=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr26238397oti.258.1548928943246;
 Thu, 31 Jan 2019 02:02:23 -0800 (PST)
MIME-Version: 1.0
References: <20190131015139.126890-1-mka@chromium.org>
In-Reply-To: <20190131015139.126890-1-mka@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Jan 2019 11:02:12 +0100
Message-ID: <CAJZ5v0gJUx0MWtjJMK03dqgfotpDZ-TqOKi8=6Pg4dv=wV-5cg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Record stats when fast switching is enabled
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 2:51 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> When fast switching is enabled currently no cpufreq stats are
> recorded and the corresponding sysfs attributes appear empty (see
> also commit 1aefc75b2449 ("cpufreq: stats: Make the stats code
> non-modular")).
>
> Record the stats after a successful fast switch and re-enable access
> through sysfs when fast switching is enabled. Since
> cpufreq_stats_update() can now be called in interrupt context (during
> a fast switch) disable local IRQs while holding the stats spinlock.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> The change is so simple that I wonder if I'm missing some important
> reason why the stats can't/shouldn't be updated during/after a fast
> switch ...
>
> I would expect that holding the stats spinlock briefly in
> cpufreq_stats_update() shouldn't be a problem. In theory it would
> also be an option to have a per stats lock, though it seems overkill
> from my (possibly ignorant) point of view.
> ---
>  drivers/cpufreq/cpufreq.c       |  8 +++++++-
>  drivers/cpufreq/cpufreq_stats.c | 11 +++--------
>  2 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e35a886e00bcf..63aadb0bbddfe 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1857,9 +1857,15 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
>  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>                                         unsigned int target_freq)
>  {
> +       unsigned int freq;
> +
>         target_freq = clamp_val(target_freq, policy->min, policy->max);
>
> -       return cpufreq_driver->fast_switch(policy, target_freq);
> +       freq = cpufreq_driver->fast_switch(policy, target_freq);
> +       if (freq)
> +               cpufreq_stats_record_transition(policy, freq);

No extra locking in the fast switch path, pretty please.

This runs in the scheduler context and it adds enough overhead in there already.

> +
> +       return freq;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
