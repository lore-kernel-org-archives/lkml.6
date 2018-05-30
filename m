Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755379AbeE3CUo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 22:20:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51389 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeE3CUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 22:20:41 -0400
X-Google-Smtp-Source: ADUXVKL6ijweZbQU9e0G2sWkCbw2owqYWl8bnMQjpWlr1rZ+MwpvMGYI+wmXd2fviUF6dAQcLAKOyJ3PghTUn30qfDw=
MIME-Version: 1.0
In-Reply-To: <1527587351-26634-1-git-send-email-mojha@codeaurora.org>
References: <1527587351-26634-1-git-send-email-mojha@codeaurora.org>
From: John Stultz <john.stultz@linaro.org>
Date: Tue, 29 May 2018 19:20:38 -0700
Message-ID: <CALAqxLWsD7rpgGYhdpDCVuH3Sss+RkqmFgunDejFYpKZ7=JTng@mail.gmail.com>
Subject: Re: [PATCH RESEND] time: Fix sleeptime injection for non-stop
 clocksource & persistent clock
To: Mukesh Ojha <mojha@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, neeraju@codeaurora.org,
        gkohli@codeaurora.org, cpandya@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 2:49 AM, Mukesh Ojha <mojha@codeaurora.org> wrote:
> Currently, for both non-stop clocksource and persistent clock
> there is a corner case, when a driver failed to go suspend mode
> rtc_resume() injects the sleeptime as timekeeping_rtc_skipresume()
> returned 'false' due to which we can see mismatch in time between
> system clock and other timers.
>
> Success case:
>                                          {sleeptime_injected=true}
> rtc_suspend() => timekeeping_suspend() => timekeeping_resume() =>
>   rtc_resume()
>
> Failure case:
>              {failure in sleep path} {sleeptime_injected=false}
> rtc_suspend()          =>            rtc_resume()
>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>

I'm not sure this patch makes sense yet (since I don't really see how
its used - mind cc'ing me on the patch that makes use of this?)

And more problematic, the patch doesn't seem to apply to mainline.
Could you respin and resend?

thanks
-john
