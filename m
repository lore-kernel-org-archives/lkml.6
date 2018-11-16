Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767E4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 03:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F5E20818
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 03:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XceORhZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F5E20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbeKPNfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 08:35:22 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45168 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeKPNfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 08:35:22 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so15598460lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 19:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fa0yXKxosJHyr5fKZzlj1BRx9gJOyGWfdXPzrBU52DM=;
        b=XceORhZOCr1m76Da2/72Ix/ariKkng/GG5GcoiyBhyLASXdIFZIHu4vTgQIkvr+yJ6
         3o7gzGuSD8yQPo5B8WUML1Ko1lFvQAqKMckINR+S+mOKAi/UaOkhsF2tzW8gWJr3JyQs
         b/8gygzqWIVVYQnJwR3AuNZyfv/z3J6oc1cvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fa0yXKxosJHyr5fKZzlj1BRx9gJOyGWfdXPzrBU52DM=;
        b=OLnDyzwuC4qvqIoZKwqcSeqoGBVLF+FETr+DK/7EOCaSgk7uXamwCRSVvDqPNchS7g
         X6ozWgGvE83SlOuWI1oGY3bNPiqOlCjg1+rbZ/Q34K7H45OTilD2MRU684+dbXRnzKPE
         23T+ai+c9tDYioB7kLE6ZR8SbC+9q5sNxMo6gf9sWU9JkStOxK48d4djA02sD782IvMl
         YKVDgAf0Rf187Ya8EjJoGKsjiTyudMwE/NN4u1A8XqnEItcdkyvcKDINVqUdTJEn5Hb1
         6bi1JY8YART2N4Z1J0+Iqe3FSJdZtopcsoHQmy+HAkEU6Y6t//P02gIs/zwDT7VD71YF
         bx8Q==
X-Gm-Message-State: AGRZ1gLfnfZDFgCfUBIkNA/ki0355ANGsG3qKKERVQHO6ys4fsd6LOwL
        fvIfJE6c2cCS5PcqQDOvcZb7M/t8N3qYD4ASwmbdkw==
X-Google-Smtp-Source: AJdET5d6QvB0EHQZx9uCQT0+gCRTa06PmFcm5lkTSR+WWvFvWIvpML8PgcXWC1yDcjmysRCaXdRcofSptBo31RKwQy0=
X-Received: by 2002:a19:2203:: with SMTP id i3mr5043106lfi.2.1542338682454;
 Thu, 15 Nov 2018 19:24:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:95ca:0:0:0:0:0 with HTTP; Thu, 15 Nov 2018 19:24:42
 -0800 (PST)
In-Reply-To: <20181115133203.28567-1-linus.walleij@linaro.org>
References: <20181115133203.28567-1-linus.walleij@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 16 Nov 2018 11:24:42 +0800
Message-ID: <CAMz4kuKvqX7B1tundeLTHvttTvE7kv3unLiu-G5z9w5zpQpf8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] clocksource: Demote dbx500 PRCMU clocksource
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 November 2018 at 21:32, Linus Walleij <linus.walleij@linaro.org> wrote:
> Demote the DBx500 PRCMU clocksource to quality 100 and
> mark it as NONSTOP so it will still be used for
> timekeeping across suspend/resume.
>
> The Nomadik MTU timer which has higher precision will
> be used when the system is up and running, thanks to
> the recent changes properly utilizing the suspend
> clocksources.
>
> This was discussed back in 2011 when the driver was
> written, but the infrastructure was not available
> upstream to use this timer properly. Now the
> infrastructure is there, so let's finalize the work.
>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Glad to see new driver uses the suspend clocksource.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

>  drivers/clocksource/clksrc-dbx500-prcmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
> index c1b96dc5f444..4054539fe066 100644
> --- a/drivers/clocksource/clksrc-dbx500-prcmu.c
> +++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
> @@ -46,10 +46,10 @@ static u64 notrace clksrc_dbx500_prcmu_read(struct clocksource *cs)
>
>  static struct clocksource clocksource_dbx500_prcmu = {
>         .name           = "dbx500-prcmu-timer",
> -       .rating         = 300,
> +       .rating         = 100,
>         .read           = clksrc_dbx500_prcmu_read,
>         .mask           = CLOCKSOURCE_MASK(32),
> -       .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
> +       .flags          = CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
>  };
>
>  #ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
> --
> 2.17.2
>



-- 
Baolin Wang
Best Regards
