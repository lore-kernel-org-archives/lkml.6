Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DAEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFFA2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="guXTSRry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFFA2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeFTFYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:24:11 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46612 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbeFTFYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:24:10 -0400
Received: by mail-pf0-f193.google.com with SMTP id q1-v6so988877pff.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 22:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mCWCourhmPyxphPup+Lj0izPGmdSGYN3AgCtAFQb/iM=;
        b=guXTSRryPlPWOmHOZvpGUd6LD9sEW/V0+1t88Ixxs8qBJfF+hGgBBMUl9tICt5elVY
         v799buoWvAOhfVV6+pWmCdOQNCg7LWIukfR9NK3TFATfvfbgbN8L8nmJSaAsEycV/vR0
         05iTitRaAZy+6FaJ+LSY/V4KvXTwxqEJJC+vwAFtY/JeTeRLM7U4FvQiBymW6q1Hz3mi
         JXbNl29CpHg6J796sRxUM9TqVmpvxTHPXFtl5zl8GrMSrZhU5S24akiKIQg8AW35t2W+
         fuHRo4hdewcxY5F9mCX22vgefc810gahYSaCu25GsPrgEdtwo/Y7kojg9NGqdKXfOQMX
         /+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mCWCourhmPyxphPup+Lj0izPGmdSGYN3AgCtAFQb/iM=;
        b=U6I8NBuXxXlFo1e5HXHBkPKG4Z9qq4E9d19A2UbgxRv7hKCw7I16ecngHkSGqwd0ct
         m2dXigZMReqN50szN5uqHeNRtSSEYjxhuDQGPk/biwFyGhpsiNqB+31XcsEf2fGAi5Qp
         4oY5didO6U5riGGMQCbyDYqWGj/3ul1B9o8g4cW9msvWYkQ3erwX4A1KrB1gkCUkrxhw
         EO0b7jKdfGenyqLPkrbiIwBwCvhZFbnItOEv7dFIiRwwKMKXLgrPf3VgmH1B8v0P+nTK
         8w52w9UnME+y6EW6sh43r0W2+TGl0MauTbpsGF1zQr5YmYz8C0LPVjLiNSH1y0SGs2/U
         T64A==
X-Gm-Message-State: APt69E34NvGqQgSzJhbK/Nn7ozYF8Ck9lv7sWfvudHazvAkBckKb5oYn
        A+Vc61B0UuyqMn2vCFmQ4bjLPxQFoB6y7SxOtDtlkxsZ
X-Google-Smtp-Source: ADUXVKI7lluxOxHq0OLssWca2emKImHOII/szizETrJ/SaakKJnIAMjWISCErGPKIdIfWFZ2Ql1V9JSXzvfBcqcn6Hc=
X-Received: by 2002:a63:743:: with SMTP id 64-v6mr120243pgh.216.1529472249592;
 Tue, 19 Jun 2018 22:24:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Tue, 19 Jun 2018 22:23:49
 -0700 (PDT)
In-Reply-To: <20180619160327.b6ca2389401f421116c155ad@linux-foundation.org>
References: <20180611111004.203513-1-dvyukov@google.com> <20180619160327.b6ca2389401f421116c155ad@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Jun 2018 07:23:49 +0200
Message-ID: <CACT4Y+YN-EPuFc2br+XPRZRcwn=Lxizd3LjTV=7wh_pboMnNCg@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/hung_task.c: allow to set checking interval
 separately from timeout
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 1:03 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 11 Jun 2018 13:10:04 +0200 Dmitry Vyukov <dvyukov@google.com> wrote:
>
>> Currently task hung checking interval is equal to timeout,
>> as the result hung is detected anywhere between timeout and 2*timeout.
>> This is fine for most interactive environments, but this hurts automated
>> testing setups (syzbot). In an automated setup we need to strictly order
>> CPU lockup < RCU stall < workqueue lockup < task hung < silent loss,
>> so that RCU stall is not detected as task hung and task hung is not
>> detected as silent machine loss. The large variance in task hung
>> detection timeout requires setting silent machine loss timeout to
>> a very large value (e.g. if task hung is 3 mins, then silent loss
>> need to be set to ~7 mins). The additional 3 minutes significantly
>> reduce testing efficiency because usually we crash kernel within
>> a minute, and this can add hours to bug localization process as it
>> needs to do dozens of tests.
>>
>> Allow setting checking interval separately from timeout.
>> This allows to set timeout to, say, 3 minutes,
>> but checking interval to 10 secs.
>>
>> The interval is controlled via a new hung_task_check_interval_secs
>> sysctl, similar to the existing hung_task_timeout_secs sysctl.
>> The default value of 0 results in the current behavior:
>> checking interval is equal to timeout.
>
> I suppose we shoold do this:


Hi Andrew,

I see you added the patch and fixup to mm tree. Do you want me to
resend v3 with the fixup included, or how does this work?

Thanks


> --- a/kernel/sysctl.c~kernel-hung_taskc-allow-to-set-checking-interval-separately-from-timeout-fix
> +++ a/kernel/sysctl.c
> @@ -145,7 +145,10 @@ static int minolduid;
>  static int ngroups_max = NGROUPS_MAX;
>  static const int cap_last_cap = CAP_LAST_CAP;
>
> -/*this is needed for proc_doulongvec_minmax of sysctl_hung_task_timeout_secs */
> +/*
> + * This is needed for proc_doulongvec_minmax of sysctl_hung_task_timeout_secs
> + * and hung_task_check_interval_secs
> + */
>  #ifdef CONFIG_DETECT_HUNG_TASK
>  static unsigned long hung_task_timeout_max = (LONG_MAX/HZ);
>  #endif
