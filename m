Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8213CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D0921841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVcyhIR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeLRFpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 00:45:49 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39154 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLRFpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 00:45:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so7272952pgl.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 21:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h2X5dVXSlVNhzIbq+LgA0ty+OY+VaXXOqW0go4/JbeY=;
        b=iVcyhIR4D8mtvWhC9mCOx/yCKJQkNfNc14n7pVtNsObpi8+YJn7o4FylGMD5iQXwld
         p4OWstK5iGtTmzeceSVo6NYFM3ZfI2NTR+F8QTJg0PBrmmTQGoQnXJbb4Z1ws+KhZ40z
         Ww2km8YC8MBLYmtDAyjVCgnsUE6TGcQuSdIak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h2X5dVXSlVNhzIbq+LgA0ty+OY+VaXXOqW0go4/JbeY=;
        b=oPP4g9yBgbHLxV3P23A2R9c3s06Zt90CjKcLnbDsK0nKww/EXJMqnwzD0w5bZYFMEo
         seF5RQ+0PT2eYhXu/J97+lpMnQlA0BgYCtiWoBcDvB03dJXgzS7/BhfD/j8SkthSjgFR
         kx7e6u5SEy/e+tWhPirvS5o8P5BP2m85PbdZN9UegTKXbwqFUPHfMtXkeum81L3o0BYQ
         d24Po8HuCGEAwV0Wy5GdvWhsvSZIyeVvsPIJJuAv3bE7FspXJ0IyW9CkS0MaULYYuW/M
         F8BPbxGMKCJ71L8Me/DPVNYdbA5rGik7cE/7cZaTOO/1pkfzn/Jqmy83GIQBCgzi25Th
         kV8w==
X-Gm-Message-State: AA+aEWaVIHf7sQZTmeU4NLBhx4iQhlh4KiIjr7JI/ku+wBK1jJUEUDPr
        TfDB8cUgdIw0TK0wOt3UzBVsKA==
X-Google-Smtp-Source: AFSGD/VIuYz7eMCb5w/D3N6MBjFZGDm8v40EEV0SMRuE2x5ABJ3pKZ8D9XzgZCb0b6Zh3kf5/00WbQ==
X-Received: by 2002:a63:5d14:: with SMTP id r20mr14675517pgb.329.1545111948027;
        Mon, 17 Dec 2018 21:45:48 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id x2sm19501195pfx.78.2018.12.17.21.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 21:45:47 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:15:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Message-ID: <20181218054545.k77jh5lxvmj2zott@vireshk-i7>
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

Hi Stephen,

On 13-12-18, 02:12, Stephen Boyd wrote:
> Quoting Viresh Kumar (2018-12-13 02:05:06)
> > On 13-12-18, 01:58, Stephen Boyd wrote:
> > > BTW, Viresh, I see a lockdep splat when cpufreq_init returns an error
> > > upon bringing the policy online the second time. I guess cpufreq_stats
> > > aren't able to be freed from there because they take locks in different
> > > order vs. the normal path?
> > 
> > Please share the lockdep report and the steps to reproduce it. I will
> > see if I can simulate the failure forcefully..
> > 
> 
> It's on a v4.19 kernel with this cpufreq hw driver backported to it. I
> think all it takes is to return an error the second time the policy is
> initialized when cpufreq_online() calls into the cpufreq driver.
> 
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  4.19.8 #61 Tainted: G        W
>  ------------------------------------------------------
>  cpuhp/5/36 is trying to acquire lock:
>  000000003e901e8a (kn->count#326){++++}, at: kernfs_remove_by_name_ns+0x44/0x80
> 
>  but task is already holding lock:
>  00000000dd7f52c3 (&policy->rwsem){++++}, at: cpufreq_policy_free+0x17c/0x1cc
> 
>  which lock already depends on the new lock.
> 
> 
>  the existing dependency chain (in reverse order) is:
> 
>  -> #1 (&policy->rwsem){++++}:
>         down_read+0x50/0xcc
>         show+0x30/0x78
>         sysfs_kf_seq_show+0x17c/0x25c
>         kernfs_seq_show+0xb4/0xf8
>         seq_read+0x4a8/0x8f0
>         kernfs_fop_read+0xe0/0x360
>         __vfs_read+0x80/0x328
>         vfs_read+0xd0/0x1d4
>         ksys_read+0x88/0x118
>         __arm64_sys_read+0x4c/0x5c
>         el0_svc_common+0x124/0x1c4
>         el0_svc_compat_handler+0x64/0x8c
>         el0_svc_compat+0x8/0x18

I failed to reproduce it over linux/next.

I had the following changes over linux/next:
https://pastebin.ubuntu.com/p/zkVm77PGdY/

I also did savedefconfig to show what all I changed in it. I faked multiple
clusters on my hikey960 board, which is not big little..

And here is the command list from history that I ran after boot.

  501  grep . /sys/devices/system/cpu/cpufreq/*/*
  502  grep . /sys/devices/system/cpu/cpufreq/*/*/*
  503  grep . /sys/devices/system/cpu/cpufreq/*/*/*
  504  grep . /sys/devices/system/cpu/cpufreq/*/*/*
  505  grep . /sys/devices/system/cpu/cpufreq/*/*/*
  506  grep . /sys/devices/system/cpu/cpufreq/*/*
  507  grep . /sys/devices/system/cpu/cpufreq/*/*
  508  echo 0 > /sys/devices/system/cpu/cpu4/online 
  509  echo 0 > /sys/devices/system/cpu/cpu5/online 
  510  echo 0 > /sys/devices/system/cpu/cpu6/online 
  511  echo 0 > /sys/devices/system/cpu/cpu7/online 
  512  grep . /sys/devices/system/cpu/cpufreq/*/*
  513  grep . /sys/devices/system/cpu/cpufreq/*/*/*
  514  grep . /sys/devices/system/cpu/cpufreq/*/*
  515  echo 1 > /sys/devices/system/cpu/cpu4/online 
  516  grep . /sys/devices/system/cpu/cpufreq/*/*
  517  grep . /sys/devices/system/cpu/cpufreq/*/*/*
  518  dmesg 

-- 
viresh
