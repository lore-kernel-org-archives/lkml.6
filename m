Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE95C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE9E21773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549884915;
	bh=tZHM7+rLTmXHl6qUUR3voaPwyqlFBHoe0W+qn/KqtoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XBGOAiudZj7UL4bq07lp1HGe6ZRBEdejJ2tlkHJJ0RdkV66yyGtfLYT0L+VKJuR75
	 tLiP3S6dQKQPnt3lmUaKMAB+cgZKwZLl7O11+7nGYXia+pcU1O6cxdOqpUhx+CwrEW
	 AInO5kJHYlNxtQrm1W4nvmtF57tHWoWDHes7/xNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfBKLfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbfBKLfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:35:13 -0500
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C6C3217D9;
        Mon, 11 Feb 2019 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549884912;
        bh=tZHM7+rLTmXHl6qUUR3voaPwyqlFBHoe0W+qn/KqtoQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KP77AmPTUs/uWr/de90sN79Pmt6EnSgp//FnSD9WotPrsN9u9UY3TUBDdZmsDgrRH
         Fq0bBsAJNzw+WzFXnptjWKXJJF2d1+sLcY+FHwzp7gfnpti+vHV/wxRJ/uO4BKYjFo
         kLz8SqYNvx7TMqpZ02eKb2fdq0IRCk50gRQIQlUQ=
Received: by mail-lj1-f181.google.com with SMTP id x25-v6so4808207ljj.13;
        Mon, 11 Feb 2019 03:35:12 -0800 (PST)
X-Gm-Message-State: AHQUAuaB7EIFbgXMH7lg4ymXTxfWZ+uYNFNekk8P5B+vOb/JktuwwJVj
        PFkeH+Tw1hmKK1JM+VCYljanO5SOf6AhAiZDoFc=
X-Google-Smtp-Source: AHgI3IZPQjrXU7wN2m+yvfTQj0zh5T+3sH5Qvr8njEtSv/vNlRFUCD06dmsoLc2+2h9CBc+piE3KTCvx9JYmQP9jjJk=
X-Received: by 2002:a2e:890b:: with SMTP id d11-v6mr23037595lji.113.1549884910274;
 Mon, 11 Feb 2019 03:35:10 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190210225147epcas3p4cedebfc5692274bc6135ceabbcf2642d@epcas3p4.samsung.com>
 <20190210225114.20110-1-stuart.menefy@mathembedded.com> <e22c175a-d88a-81a7-9faa-42bb4fe09a22@samsung.com>
 <e3637f0f-1e72-db3a-f744-ade0e878cfc5@linaro.org>
In-Reply-To: <e3637f0f-1e72-db3a-f744-ade0e878cfc5@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 12:34:58 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfguCS5jFNhdfJ8poA1yC3JVb0jnra4af-EBXfwy2P8Gw@mail.gmail.com>
Message-ID: <CAJKOXPfguCS5jFNhdfJ8poA1yC3JVb0jnra4af-EBXfwy2P8Gw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Subject: [PATCH 0/2] clocksource: exynos_mct: Clear
 timer interrupt when shutting down
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Stuart Menefy <stuart.menefy@mathembedded.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kukjin Kim <kgene@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 at 12:23, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 11/02/2019 08:14, Marek Szyprowski wrote:
> > Hi Stuart
> >
> > On 2019-02-10 23:51, Stuart Menefy wrote:
> >> When debugging suspend problems on Exynos 5260, I had a large number
> >> of debugging prints going to the serial port after interrupts
> >> had been disabled but before the timer interrupt was shutdown. This
> >> was long enough for a timer tick to occur, but as interrupts were
> >> disabled the ISR didn't run, and so the interrupt wasn't cleared.
> >> Later when the timer was shutdown the interrupt was left asserted and
> >> so the wfi at the heart of the suspend code didn't wait, causing
> >> the suspend to fail.
> >>
> >> Currently the code which stops the timer when it is on one-shot mode
> >> and the interrupt occurs is in exynos4_mct_tick_clear(), meaning if we
> >> called this from the shutdown code exynos4_mct_tick_stop() could be
> >> called twice. So first restructure the existing code, so the check for
> >> one-shot mode and stopping the timer is moved to the ISR, leaving
> >> exynos4_mct_tick_clear() just clearing the interrupt flag.
> >>
> >> Once this has been done simply call exynos4_mct_tick_clear() from
> >> set_state_shutdown().
> >
> > This also fixes mysterious suspend failures on Odroid XU3/XU4/HC1 :)
> >
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Applied. Shall I add the stable@ tag?

Makes sense - for the second patch, although first is a prerequisite.
It should be backported up to v4.3 (the code differ a lot on older
versions).

Best regards,
Krzysztof
