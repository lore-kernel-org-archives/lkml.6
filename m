Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF71DC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C4A278ED
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E2J2boL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C4A278ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753939AbeF2EZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 00:25:24 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42307 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbeF2EZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 00:25:23 -0400
Received: by mail-wr0-f196.google.com with SMTP id p1-v6so7458730wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 21:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H3D3Hy5wFEz8V45woe1oALnVOajfIhtfUGYByhmIPjI=;
        b=E2J2boL/wnvtulBUYrFr82tGxTwS2FuJaOPA1iEUXPYTro8oQ3qd3Hnn3KpxsqJgYQ
         /iZJ6BmpL5g1Bjci0E/udfCH4z88q0HuRJk2HNKr4YSsxmQwx+AM+m2M8RnbgCJUTvId
         6jBlNHlmYMbjyzQ0OWfpxF8Dvguj3sHZlaftg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H3D3Hy5wFEz8V45woe1oALnVOajfIhtfUGYByhmIPjI=;
        b=UvuAKPUPTq9zxDh6WO8pPvO00up3NK4TQZbmkxs1AlOlYLfgkZAbeJnZWZ5BJ6lN0V
         wjNFnQZV28XxsXkEWt59aDIUCveU1wrW+cuQI9UToEASXwG4GdzUA9z1r23xsRZft/ab
         KBYRQIdNE0nIuh2UInamG/OVXEWPCbLxFT0IFefSpNXtFXD6aiApX/sdjqSUeSnkwmpB
         bGsA51vchWWZD1Qi3kMWZL8bDcZRLZ7eJLJBWdenyU5JEzTObC1cfuCd/Mv8O2T5eOl0
         CpXkkkmJzca3sOLM/cVydwSyEonnMX1Y/FEQBhY1PX4rzVxULaY3d+aMMWU+YSJbVkXt
         vByA==
X-Gm-Message-State: APt69E3SiFaOxr7JykwF+ZlNoFGQZCqxLBQL6i3CVkvt2rAXxvg/+oH6
        xageSwiY6zc2cax4fpWLsI7jXIgNwEHtE8GNYJSXrA==
X-Google-Smtp-Source: AAOMgpfVH+VjBXGM5IHY5x82UboQ/jjUkf4HzKhW8CdBycvx2HdmKEAEcVVgJ0Znw6ZaYaf0LpuhZ0PmNZQcPCUzFns=
X-Received: by 2002:adf:f342:: with SMTP id e2-v6mr10715786wrp.161.1530246322136;
 Thu, 28 Jun 2018 21:25:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c202:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 21:25:21
 -0700 (PDT)
In-Reply-To: <20180626132704.922098090@linutronix.de>
References: <20180626132130.345959379@linutronix.de> <20180626132704.922098090@linutronix.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 28 Jun 2018 21:25:21 -0700
Message-ID: <CALAqxLV_qDmWf9MU0hUqqHmPdM7hKmQ4qskfiHGyX9F6JeGvyw@mail.gmail.com>
Subject: Re: [patch 1/2] posix-timers: Make forward callback return s64
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
> The posix timer ti_overrun handling is broken because the forwarding
> functions can return a huge number of overruns which does not fit in an
> int. As a consequence timer_getoverrun(2) and siginfo::si_overrun can turn
> into random number generators.
>
> As a first step to address that let the timer_forward() callbacks return
> the full 64 bit value.
>
> Cast it to (int) temporarily until k_itimer::ti_overrun is converted to
> 64bit and the conversion to user space visible values is sanitized.
>
> Reported-by: air icy <icytxw@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Looks ok, and doesn't trip any regressions in testing so far.

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
