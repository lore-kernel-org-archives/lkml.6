Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vEFQAxxaHlvODAAAmS7hNA
	; Mon, 11 Jun 2018 11:16:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E70BA60792; Mon, 11 Jun 2018 11:16:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hyri2Jsb"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5778360351;
	Mon, 11 Jun 2018 11:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5778360351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932845AbeFKLQl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 07:16:41 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38992 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932604AbeFKLQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:16:40 -0400
Received: by mail-pf0-f193.google.com with SMTP id r11-v6so10070701pfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 04:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OPy3l4kMxvfzEYla4ZEFuKahBnUdOVuZtsdxSkKNw/I=;
        b=hyri2JsbYZURrqT1ZRMP1hWbyPcVZV2Z/GdIjcm8PoojHfvjpoXtsX6AEBg90lS+Ru
         qNPzgwNBbutzbWnYPtW/3jHxaZ1z973fmPrjg+uicwq6R/29c9HasMKeRrAENliEI8zK
         k3dtVonw4duGNM8NK+5XGrf9pcOYi4J2R67Ceg3tE+7Zwe2h0XLBVLimrtodGudwqvt0
         L5U7sDV8JWXQGsat8n704093xUG+CQPRVR36QJBdn1tt6oVITFwNMGd6Doa0nuPR+xhd
         jXEbVou80sfAnQh+MuXvY1p5lkFLSHKsyJQpdXMMf8JiXHRv/keoLcS2uNl5bBJqQ5Ec
         4ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OPy3l4kMxvfzEYla4ZEFuKahBnUdOVuZtsdxSkKNw/I=;
        b=NQ3v3fDSPWGjm++6Xi+94dnzS5dXj8IsvLcYZSG7YIuPkhwlZilbl8B1ITdvS4ze4g
         wN3zmLxWDXRDcIsZpc/sJq+9+KawsKimsAA9hRuTre3x7Y6YAKSplDfPi/wPzd3hD5Tf
         mcDUKe01uJDE918Seo2jGVMUSdFw2kPjZoLN7zuT3u/P2BPc0X027E5Xb5LVLW+m9F4U
         WtFMrmRhv8xcnTX1qt3Nd5WcAqluLFqI2daFK84J1uCyuu/O48PdLw6y7WH6+iGyRewD
         j6wVG1UBi9ShWvw3IZ7WUVx8MnWmP/18o/NO75bsmGZbmpmT5TLlbWYC8VztDCVgcsNq
         JNfQ==
X-Gm-Message-State: APt69E0SYQXKocJBWMvpGCLuQ4MdrToqBqow2Gm0nTm08Ngd8qC1yG2o
        CVe7YVucoEs0ILxBxxjDWa4KE0rBWkLe4xXGV3iTcw==
X-Google-Smtp-Source: ADUXVKLwPSGVUAgW48GNEizbcXGIzay/re2Adaw6PpUr4b4KTVHNGZrYwwHu9WhsUqxMUGvhpSANEwceHshIaSaqPmQ=
X-Received: by 2002:a62:b612:: with SMTP id j18-v6mr17217625pff.199.1528715799290;
 Mon, 11 Jun 2018 04:16:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 11 Jun 2018 04:16:18
 -0700 (PDT)
In-Reply-To: <4d9f8cd8-1b2c-28ef-1705-2400e5af9b51@i-love.sakura.ne.jp>
References: <20180608133043.203744-1-dvyukov@google.com> <20180608145821.ec20a15944d1d19b683695e7@linux-foundation.org>
 <4d9f8cd8-1b2c-28ef-1705-2400e5af9b51@i-love.sakura.ne.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 11 Jun 2018 13:16:18 +0200
Message-ID: <CACT4Y+adbYJdmgzuLVV+iy+Q+tii_cnKm=VwCfdkr8uKWbww+Q@mail.gmail.com>
Subject: Re: [PATCH] kernel/hung_task.c: allow to set period separately from timeout
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 9, 2018 at 9:00 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/06/09 6:58, Andrew Morton wrote:
>> On Fri,  8 Jun 2018 15:30:43 +0200 Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>>> Currently task hung checking period is equal to timeout,
>>> as the result hung is detected anywhere between timeout and 2*timeout.
>>> This is fine for most interactive environments, but this hurts automated
>>> testing setups (syzbot). In an automated setup we need to strictly order
>>> CPU lockup < RCU stall < workqueue lockup < task hung < silent loss,
>>> so that RCU stall is not detected as task hung and task hung is not
>>> detected as silent machine loss. The large variance in task hung
>>> detection timeout requires setting silent machine loss timeout to
>>> a very large value (e.g. if task hung is 3 mins, then silent loss
>>> need to be set to ~7 mins). The additional 3 minutes significantly
>>> reduce testing efficiency because usually we crash kernel within
>>> a minute, and this can add hours to bug localization process as it
>>> needs to do dozens of tests.
>>>
>>> Allow setting checking period separately from timeout.
>>> This allows to set timeout to, say, 3 minutes, but period to 10 secs.
>>>
>>> The period is controlled via a new hung_task_period_secs sysctl,
>>> similar to the existing hung_task_timeout_secs sysctl.
>>> The default value of 0 results in the current behavior.
>>
>> I'm rather struggling to understand the difference between "period" and
>> "timeout".  We would benefit from a clear description of what these two
>> things do.  An appropriate place for this description is
>> Documentation/sysctl/kernel.txt, which this patch forgot to update.
>
> My understanding is that "period" is "how frequently we should check"
> and "timeout" is "how long a thread remained uninterruptible". Maybe
> hung_task_check_interval_secs would be better than hung_task_period_secs.

Hi Tetsuo, Andrew,

I've just mailed v2:

    Changes since v1:
     - add entry to Documentation/sysctl/kernel.txt
     - rename hung_task_period_secs sysctl to hung_task_check_interval_sec

Hopefully now it's more clear what's the difference and what it is doing.



> timeout = 60 and period = 1 would allow hung task to be reported as soon
> as it remained uninterruptible for 60 seconds. That makes me easier to
> narrow down relevant kernel messages and syzbot program.
>
> Well, showing exact slept time, along with all threads which slept more
> than some threshold (e.g. timeout / 2), might be helpful.

You mean if we report any task, then scan all tasks second time and
additionally report tasks that are blocked for (timeout/2 : timeout)?

Should we do this when hung_task_show_lock? Or only when
sysctl_hung_task_panic? Or when?
