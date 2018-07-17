Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C167ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3101020693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwFTbvTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3101020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbeGQUpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:45:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39022 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbeGQUpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:45:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so2417440wre.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zJsq8G2P8bIdQvslkErgpO7Ux1/Wb7gZWH3pIsDvxec=;
        b=cwFTbvTOUWFjiwxwXIJvrsjjoM+zNV/szK7vFxP6awhty/z3qKgvkWeZWljBno1w/1
         vzAIix6voaxJsi3JmqaaGJSyGPCKa4YIpkPLb5yK4Mgo18VsVAil7oI1DfLQ9oIPf8OP
         GaSFmTB64hCVUVBHkEEIj9lMKkDZH9u78c2CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zJsq8G2P8bIdQvslkErgpO7Ux1/Wb7gZWH3pIsDvxec=;
        b=s7QiKDAu2UTBu8h7FTtM8Lv8k+cxFSblg1PxH7eYRTHk5tdYzDpRCzMA2AMeSDgB0s
         nDsYMl3u0GIvPFwy/dPY8pBYaYSDC/FmcPTzdw2Od1yEwgnSYfU6BS5c0Czw0sftRkdy
         mb/+PSO5/4gThyGCxRO98enUEwVd5KWNvEvWboZ3OtrjJPl0aYTXuOfM/gxeVrJ9TcH6
         Pq1J+UzFbQWmWGkG5MLgwtJO3WgRG/KegjAGtL2q6BixvJt6uWINnT2TRYQMENeotWz6
         mncD/nlxUjHCjaQJ1vr9g4EQi5Ah/yjumkD1j8+1Qe9R21g+jtxnF7sTUfLSlr/9n3X2
         OBJA==
X-Gm-Message-State: AOUpUlGxjF59wvJodHL0czznfdK0l4c5McIEh4xRSqHo5+4aROfqALIj
        TFoojBicD1AXLDCMctJacIL9k1CudrTlqVtLzCq0IQ==
X-Google-Smtp-Source: AAOMgpearSJ90pyc8N3ShGvZg+j08eQIPvURHiXTkdrTubkZxJ1Ys5MBcy2XJo/0W3Q5Oru+lInmc0iCMyCmuzJejO4=
X-Received: by 2002:adf:f342:: with SMTP id e2-v6mr2331263wrp.161.1531858294351;
 Tue, 17 Jul 2018 13:11:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 13:11:33
 -0700 (PDT)
In-Reply-To: <c233469f487d9e187de3fdaf79db4e1a7ca7486d.1531812082.git.baolin.wang@linaro.org>
References: <c233469f487d9e187de3fdaf79db4e1a7ca7486d.1531812082.git.baolin.wang@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 17 Jul 2018 13:11:33 -0700
Message-ID: <CALAqxLXt=g-w8-+hy=jL2jQcyBw1Yrob0CegQCRb7JoEDzLF-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] time: Introduce one suspend clocksource to compensate
 the suspend time
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:55 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> On some hardware with multiple clocksources, we have coarse grained
> clocksources that support the CLOCK_SOURCE_SUSPEND_NONSTOP flag, but
> which are less than ideal for timekeeping whereas other clocksources
> can be better candidates but halt on suspend.
>
> Currently, the timekeeping core only supports timing suspend using
> CLOCK_SOURCE_SUSPEND_NONSTOP clocksources if that clocksource is the
> current clocksource for timekeeping.
>
> As a result, some architectures try to implement read_persistent_clock64()
> using those non-stop clocksources, but isn't really ideal, which will
> introduce more duplicate code. To fix this, provide logic to allow a
> registered SUSPEND_NONSTOP clocksource, which isn't the current
> clocksource, to be used to calculate the suspend time.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from RFC v1:
>  - Improve commit message.
>  - Remove the WARN_ON_ONCE().
>  - Fix some coding style issues.
>  - Do not force to select a replacement suspend clocksource.

Thanks again, I'll get this queued up for testing.

thanks
-john
