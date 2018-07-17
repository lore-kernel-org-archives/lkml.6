Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2576AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D200D2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eIHNnKXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D200D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbeGQUoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:44:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37167 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbeGQUoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:44:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id q10-v6so2427037wrd.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+G0S39J+Vy75Rg5jyaCIHI9BgUpN8rrwAB9oj0wbW/s=;
        b=eIHNnKXG0lF7WuI8l6/FJeCtAmM+CXjAf7sWSCX4LJeoMTWZZ68b00rFxrOTHDj6BI
         wuwI9VJMIV1SDXLgNTcxMHLHMlnu1OpTJqyRK6grolZ+zOUKtkKPN9/V/qbuNGs55KnZ
         Vw85q5lrDKRaecFsEZ0rFqlFDXa6FglWgFnyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+G0S39J+Vy75Rg5jyaCIHI9BgUpN8rrwAB9oj0wbW/s=;
        b=ClsXmaBdmEE0aBxGgr6i66OeGcI3bdtcm/tbahcq7Y5n0n/wbDgWFZZFzA0M6uEHyB
         XuEmEYqxsNaPc6osnAub4uauN+VQ2EL+f5jR+dE1zicCFHeANuQiz4Lu3SP6peE+vcpV
         fwr9etnHvCBTt3rfAhxPvsO5j0ECZSZlW0bbO9owoOD9LXkzD1Dyyzwv4hBX3bDuROQL
         4YR8L26WWeEJJo/GvqQkHGMey19DJ4W3NG+4cAyTntr657EVunEu3brvA6lpLuOzuyJ1
         J9c30sCQabTmbWR+g08KzXZ11W0c/NFSPBdQ0eWrg2N7N5hzb8TbUjIy+5n19gLZVEzC
         idUQ==
X-Gm-Message-State: AOUpUlEni9VwT6rN14TyPqQEJwptGoX9mXburfDgh3icc5h+MCcJqAqW
        KOR/2gmekzx0nhEF6WMI54U2kBXGx+fpB1s6/aaeeUeO
X-Google-Smtp-Source: AAOMgpemsEyXEtQwEoUmXtnqwJ7ev1oIrbuRtovDAaBCk6B6Z8oiKIBwtMtUrc823rJik+cG6+PuJTjpFGf+9u4CQFk=
X-Received: by 2002:adf:b243:: with SMTP id y3-v6mr2505107wra.90.1531858204825;
 Tue, 17 Jul 2018 13:10:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 13:10:04
 -0700 (PDT)
In-Reply-To: <1531809089-8927-1-git-send-email-mojha@codeaurora.org>
References: <1531809089-8927-1-git-send-email-mojha@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 17 Jul 2018 13:10:04 -0700
Message-ID: <CALAqxLWRrbavqjcX+n1EqFhi9Mf8e_qFkyBZBynmDOTPwkFszA@mail.gmail.com>
Subject: Re: [PATCH v5] time: Fix extra sleeptime injection when suspend fails
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, gkohli@codeaurora.org,
        cpandya@codeaurora.org, neeraju@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 11:31 PM, Mukesh Ojha <mojha@codeaurora.org> wrote:
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
> {sleeptime injected again which was not required as the suspend failed}
>
> Fix this by handling the boolean logic properly.
>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
> Changes in V5:
>  * Took extra variable `inject_sleeptime` to take care of injecting sleeptime
>    inside timekeeping_resume().
>  * Inverted the return logic inside timekeeping_skipresume() instead of doing
>    it in rtc_resume().
>  * Updated commit description.


Thanks again, I'lll get this queued up for testing.

thanks
-john
