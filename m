Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CD5C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00D7208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VC0o7gg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00D7208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933222AbeGJJeM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:34:12 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50703 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932949AbeGJJeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:34:10 -0400
Received: by mail-it0-f66.google.com with SMTP id w16-v6so8165147ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 02:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m21NTN9XH7bWkwjc2z8xwMHLUyQgA4Irsh1mdRC5Ym0=;
        b=VC0o7gg93RGsiSN10gvrjZrT5k3JjivhSxAKdQw8HyL+aVJqzdhd3azTmn3Irg611G
         g4g8zvJOvDFBbmR2AHBeKPN8JuHLgEMAMX6VQIj4JLBjBuPLBPNfmRgKl9AnUzjGAaKP
         OsDaOY2luOhqH2Qd2xHIRtKnz4E6+jVfESChs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m21NTN9XH7bWkwjc2z8xwMHLUyQgA4Irsh1mdRC5Ym0=;
        b=EtTuSUxtCFoyVNlCFNiXEuDOY0Qtc2kBwtGLfQVJzcvO3a391aNpDtqmeKKS3+5gv1
         jZiJvwkCKsppAXuTpVwmvUEgPqOIr+n5vZu0mlYNAG/coNWCIJj97zUmqEjhLWv+YsgQ
         HvEg+kd5jYdazrCP1rYXA3+XZ3OUacp1PyFIsM3YKEuxKwp0ZiddlVmv5bV3vBsyKK0O
         std+CzEQik/rIQhAUoCKn3mwIN91mW3eNoKAn+bI70026SSQ6hvvL0krKWAmV5IlEhLw
         m3r2J/AFLX2qGlFCxfW9d6r5GJdav/ZH1bkJqe3bbKa9nbm/cwaBzAgfkAtrW09i7B74
         mFQQ==
X-Gm-Message-State: APt69E0BYBt4NQg+SIcCfD05jzNffZkQd37Qticb2dF+URYaJvP91LyL
        HEOqRFKmx6Om9xvrnKRVV43NOB9pPCUCLKN876LnLg==
X-Google-Smtp-Source: AAOMgpdSLQ5Fsm3RfnGTcS0JzYXZYU2i8LgilhR/3Wm5frLQkOKUOjh5R+krC5JmR1dpZjbNa6QhyqbCOi5vye8Zy+c=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr20281474itc.102.1531215250064;
 Tue, 10 Jul 2018 02:34:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 02:34:09
 -0700 (PDT)
In-Reply-To: <1531209943.3163.31.camel@pengutronix.de>
References: <ab0c7997bdb0caf6fe7e842315bb9565c2cb059d.1530895248.git.leonard.crestez@nxp.com>
 <CAPDyKFqb6eZ2SYG612yqiNisv7UV1q3UHYfZfemmvv9Q4w=Png@mail.gmail.com> <1531209943.3163.31.camel@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Jul 2018 11:34:09 +0200
Message-ID: <CAPDyKFrd=jvYfCgtUD6ocEYLHhm1r73SpKB-c7syT3FmwWtaHw@mail.gmail.com>
Subject: Re: [PATCH v3] soc: imx: gpc: Turn PU domain on/off in sleep on 6qp
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 July 2018 at 10:05, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Dienstag, den 10.07.2018, 00:27 +0200 schrieb Ulf Hansson:
>> > On 6 July 2018 at 18:46, Leonard Crestez <leonard.crestez@nxp.com> wrote:
>> > On imx6qp power gating on the PU domain is disabled because of errata
>> > ERR009619. However power gating during suspend/resume can still be
>> > performed.
>>
>> Sounds a bit hand wavy. Exactly why can it be done during system suspend/resume?
>
> Power gating this domain in normal operation may introduce a glitch in
> unrelated modules, potentially disturbing a running display scanout.
> This is not a concern when the whole system enters suspend state, so
> it's safe to do in this case.

Makes sense. Could we please fold this information into the commit
message to make this clear!?

>
> Regards,
> Lucas
>
>> >
>> > Enable this by implementing SLEEP_PM_OPS in imx_pgc_power_domain_driver.
>> >
>> > In order to ensure correct ordering add device links from devices inside
>> > the PU domain to the pgc platform_device.
>>
>> In genpd, the PM domain gets powered off after all device's
>> corresponding ->suspend_noirq() callback has been invoked - and it
>> also considers if there are some wakeup settings enabled, possibly
>> avoiding to do the power off.
>>
>> It sound like the imx's power domain driver ->power_off|on() callback
>> should deal with this, to make get a consistent behavior. I understand
>> that you currently can't tell under what circumstances the
>> ->power_off|on() callbacks are being invoked, that may need some
>> changes in genpd.
>>
>> Currently we have a flag, GENPD_FLAG_ALWAYS_ON which makes genpd to
>> always prevent power off. Perhaps we should add a new flag
>> "GENPD_FLAG_RUNTIME_ON", which makes genpd to call the
>> ->power_on|off() callbacks, but only during system wide PM.
>>
>> Thoughts?
>
> Yes, this might work for this case.

Alright. I can help to implement, if you want. Just tell.

Kind regards
Uffe
