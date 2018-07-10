Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6EAC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C966D20B80
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KeiezXPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C966D20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbeGJUOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:14:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44891 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732354AbeGJUOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:14:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so15885571wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/B7E6VG0yqE+/NWzoM2gNQyl88scAfku1P4y5N7GhMM=;
        b=KeiezXPuF0adi5ZwOribeWdYSoFRWJ/Uf+2+brXxssQfmuP+o5YJwlEZ4e/0xc4Q7I
         nI9v6cgkq4eL+TqPzaAw63teCKWu3qaBEdafExG3PhY/QDDNOG34e0rXTiEtftJWbLX5
         uy1qWq6Xd9EW5Poc3qvhVM68ajXwOSg+wJ/L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/B7E6VG0yqE+/NWzoM2gNQyl88scAfku1P4y5N7GhMM=;
        b=pg96DwwkwIdWNYfwXjZsB3+0f4sNSpzgDFjsx6SefNkpmS5l5jrnVmbSab9s7PTMrd
         OgnTHQBWF/jNQ0lGsPB8vVeGZcFM87AQPvPZlUq/2nH2kI/s0a09YkwEkGfS9vwDjlp3
         gtlaaJ7nvHIz4rJTHa2vM+xmJXEYd2Em1oRBbSCREMW+6SVp+ul2WFw34zTKzLfvIpF+
         npznbwFcO4WgLr3WsOozEIwmmJ+Whi5us6QjtligLE42I+3dWxrpWXjsK8nXArHWgoTV
         efNgiOgTtEpAlJmNcQpiBNzbe7mMYzizdkFkf7G4w/Bp8LGiou/2kk/tyH8OzFGdRuHZ
         07ww==
X-Gm-Message-State: APt69E1enrdFgHOqxYhDDZ8pv48ClcAq67fqglaE90WA1KouJj7hlvcN
        BhwN1WZ8r1MgsGpdhimkk8569Dc6IvwGfpdqvhEjDWoSFco=
X-Google-Smtp-Source: AAOMgpcK3EI4sQx4vJotcemTxGoWYqfzq1ZXCzrZqU+dTAzUqXoH/uanezdyuiWuxDT18xLDmhY5/JDCsKrRNi0CVoM=
X-Received: by 2002:a5d:4985:: with SMTP id r5-v6mr19195456wrq.116.1531253616484;
 Tue, 10 Jul 2018 13:13:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c202:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 13:13:35
 -0700 (PDT)
In-Reply-To: <1530883047-17452-1-git-send-email-mojha@codeaurora.org>
References: <1530883047-17452-1-git-send-email-mojha@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 10 Jul 2018 13:13:35 -0700
Message-ID: <CALAqxLVs=EbbJ83bw=YRb=1B7E2uLcnrUh+qWEjm9U3iYd7FAg@mail.gmail.com>
Subject: Re: [PATCH v3] time: Fix incorrect sleeptime injection when suspend fails
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, gkohli@codeaurora.org,
        cpandya@codeaurora.org, neeraju@codeaurora.org,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 6:17 AM, Mukesh Ojha <mojha@codeaurora.org> wrote:
> Currently, there exists a corner case assuming when there is
> only one clocksource e.g RTC, and system failed to go to
> suspend mode. While resume rtc_resume() injects the sleeptime
> as timekeeping_rtc_skipresume() returned 'false' (default value
> of sleeptime_injected) due to which we can see mismatch in
> timestamps.
>
> This issue can also come in a system where more than one
> clocksource are present and very first suspend fails.
>
> Fix this by handling `sleeptime_injected` flag properly.
>
> Success case:
> ------------
>                                         {sleeptime_injected=false}
> rtc_suspend() => timekeeping_suspend() => timekeeping_resume() =>
>
> (sleeptime injected)
>  rtc_resume()
>
> Failure case:
> ------------
>          {failure in sleep path} {sleeptime_injected=false}
> rtc_suspend()     =>          rtc_resume()
>
> sleeptime injected again which was not required as the suspend failed)
>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
> Changes in v3:
>  * Updated commit subject and description.
>  * Updated the patch as per the fix given by Thomas Gleixner.
>
> Changes in v2:
>  * Updated the commit text.
>  * Removed extra variable and used the earlier static
>    variable 'sleeptime_injected'.
>
>  kernel/time/timekeeping.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 4786df9..32ae9ae 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1510,8 +1510,20 @@ void __weak read_boot_clock64(struct timespec64 *ts)
>         ts->tv_nsec = 0;
>  }
>
> -/* Flag for if timekeeping_resume() has injected sleeptime */
> -static bool sleeptime_injected;
> +/*
> + * Flag reflecting whether timekeeping_resume() has injected sleeptime.
> + *
> + * The flag starts of true and is only cleared when a suspend reaches
> + * timekeeping_suspend(), timekeeping_resume() sets it when the timekeeper
> + * clocksource is not stopping across suspend and has been used to update
> + * sleep time. If the timekeeper clocksource has stopped then the flag
> + * stays false and is used by the RTC resume code to decide whether sleep
> + * time must be injected and if so the flag gets set then.
> + *
> + * If a suspend fails before reaching timekeeping_resume() then the flag
> + * stays true and prevents erroneous sleeptime injection.
> + */
> +static bool sleeptime_injected = true;

I worry this upside-down logic is too subtle to be easily reasoned
about, and will just lead to future mistakes.

Can we instead call this "suspend_timing_needed" and only set it to
true when we don't inject any sleep time on resume?

I think that will help make things a bit more clear, no?

thanks
-john
