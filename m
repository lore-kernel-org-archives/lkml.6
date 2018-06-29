Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1EEC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A254278ED
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/J3F+XH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A254278ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753866AbeF2EYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 00:24:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39301 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753356AbeF2EYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 00:24:44 -0400
Received: by mail-wr0-f194.google.com with SMTP id b8-v6so7442905wro.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 21:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G1CdiFgHhSRQTJ/Zy/86vkl0Wiaei4ZIbTRAz4Wuebk=;
        b=Z/J3F+XHAmHid8S7cawmF71OGzh1GUs4rWwfR3ZQUyH97qCQWDq/iuu7+6zrsi0MvV
         Il9h+sKRIV8Yszf6c6wRU4B77tJ6zgOv9EOJSvKSZfNAy6wQwNbC10yOgEhi2u0TD7N8
         kjtlF9PVPVaF9xj3bvmS2OG+oyEnx4982N00A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G1CdiFgHhSRQTJ/Zy/86vkl0Wiaei4ZIbTRAz4Wuebk=;
        b=G/XnbV/s9+G4rKNRfwqM+nOlX/NG/TsgibY7Q5k+TJuKA1mFN+Fz9tnIKKcynbuFuK
         +s3zkqnSw2Xt4nQ2r24UF2r+W+w9LCuZfMd2EX+yVBe95rGk7elF4P48Yn3TqrIeu//T
         Vy2iD+sBku5aySVWxlxvIqiu5ozW7e1l4Kk7/NQhNom02ahyBUN+UPA/UmcM9TpyTi9n
         cRB2Cc+0HN3dHrazh1/l+PnaYTcXm4bx73SQkt0+3sQWEM7Hh1TyYaECWsBTITXv8Beo
         Tz1hVsLP2DS58CW9Wt5kjTQ0mxlvZ9aPjmLdMU0cadk6wCKexH8AhyI73wjFoqDDCNAX
         ky4Q==
X-Gm-Message-State: APt69E0U4lThBZ0lA1wyb+4sdCbMDyedp1g1375h+4RNfl77OP//OM2v
        A5zk+k0kvnWsTw1WN+Rrcf3h89Cpm0ntY3giVj0SMA==
X-Google-Smtp-Source: AAOMgpfvizU6hoiziBE2wthumLVMMIM7IZjz1ZetQvR1NBKeZuNTeVAUG30NIzem3cTkMzKflYpaf8OWTTP1KkBVso0=
X-Received: by 2002:adf:b909:: with SMTP id k9-v6mr10773850wrf.116.1530246283261;
 Thu, 28 Jun 2018 21:24:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c202:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 21:24:42
 -0700 (PDT)
In-Reply-To: <20180626132705.018623573@linutronix.de>
References: <20180626132130.345959379@linutronix.de> <20180626132705.018623573@linutronix.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 28 Jun 2018 21:24:42 -0700
Message-ID: <CALAqxLUKXf5U=nv3Y932Wf=Ln4ZKpbcivkCfp4qd1EZt_FVngw@mail.gmail.com>
Subject: Re: [patch 2/2] posix-timers: Sanitize overrun handling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        air icy <icytxw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 6:21 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> The posix timer overrun handling is broken because the forwarding functions
> can return a huge number of overruns which does not fit in an int. As a
> consequence timer_getoverrun(2) and siginfo::si_overrun can turn into
> random number generators.
>
> The k_clock::timer_forward() callbacks return a 64 bit value now. Make
> k_itimer::ti_overrun[_last] 64bit as well, so the kernel internal
> accounting is correct. 3Remove the temporary (int) casts.
>
> Add a helper function which clamps the overrun value returned to user space
> via timer_getoverrun(2) or siginfo::si_overrun limited to a positive value
> between 0 and INT_MAX. INT_MAX is an indicator for user space that the
> overrun value has been clamped.
>
> Reported-by: air icy <icytxw@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Looks ok, and doesn't trip any regressions in testing so far.

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
