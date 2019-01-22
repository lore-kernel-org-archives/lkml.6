Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E63C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE5A2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfAVQ3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:29:40 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35375 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbfAVQ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:29:40 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so21217997ljb.2;
        Tue, 22 Jan 2019 08:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t9n/5sXdoTPr3CpWzcc788OMKiVQhMebV1SwmFqOkDM=;
        b=kc4ImfRHJ2aMVsf55zZP8lUCmmJ37QbdjsKPhci54UIIqIlRGs2wRGzNv8ZhlB3wI5
         hM9ZIo0+HzErsWrrJ/YTQtSObY6+YEHYaC+renfJVgV2301Rw7y+coMkk+Xf504OVmDM
         FI1nlLzULKU/ipD3z3/oqzUMbifHQcX5IDin5WlVPEGtEvK56tsxtV8Gu2s8xIXUEUUQ
         IALpk/uGeHl/0XuTIMaURd02vRx+GIIQRcE3nF17RxvZNOq6LRXkuoTigclJD92bnJfd
         CtwnhSLEZ22YZJsUxilESOQ3XDL9daL4nBJSmDQ30+KUVx5jOyUhRTwIssclrwa9m+5w
         YdvA==
X-Gm-Message-State: AJcUukeDof6kSjknN4fYDyk+y0kBgniHQ3V5AkbxjgWSt0SdHXXgf4xq
        rQ9vKRz6nTvmaGKZWG67ghg=
X-Google-Smtp-Source: ALg8bN5YUVS7ySRm9No2eyYMF5Ufbs7NAJdPtgs1BAemEDk2cT7J3LmrPSOqxFA2z0aqGFT6E7LeOA==
X-Received: by 2002:a2e:914b:: with SMTP id q11-v6mr8884858ljg.164.1548174576827;
        Tue, 22 Jan 2019 08:29:36 -0800 (PST)
Received: from localhost.localdomain (82-203-157-3.bb.dnainternet.fi. [82.203.157.3])
        by smtp.gmail.com with ESMTPSA id h22-v6sm87861lji.45.2019.01.22.08.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 08:29:36 -0800 (PST)
Date:   Tue, 22 Jan 2019 18:29:31 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     mazziesaccount@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [RFC PATCH v1 11/13] rtc: bd70528: Initial support for ROHM
 bd70528 RTC
Message-ID: <20190122162931.GB2559@localhost.localdomain>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <ebe1618710baf7cf59622c878e40052ca48cc7c3.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <390e9379-329b-02dc-13f6-763aeae703e1@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390e9379-329b-02dc-13f6-763aeae703e1@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 06:48:21AM -0800, Guenter Roeck wrote:
> On 1/22/19 1:47 AM, Matti Vaittinen wrote:
> > +
> > +static int bd70528_set_rtc_based_timers(struct bd70528 *bd70528, int new_state,
> > +							int *old_state)
> 
> Passed parameter is an int, not int *. I'd be quite surprised if this compiles
> without warning.
> 
> > +static int bd70528_re_enable_rtc_based_timers(struct bd70528 *bd70528,
> > +							int old_state)
// snip
> > +	return bd70528_set_rtc_based_timers(bd70528, old_state, NULL);

and

> > +static int bd70528_disable_rtc_based_timers(struct bd70528 *bd70528,
> > +							int *old_state)
// snip
> > +	return bd70528_set_rtc_based_timers(bd70528, 0, old_state);

I'm not quite sure I understand what you mean by that. Second parameter is int,
third one is is int *.

> > +static int bd70528_re_enable_rtc_based_timers(struct bd70528 *bd70528,
> > +							int old_state)
> > +{
> > +	if (bd70528->rtc_timer_lock)
> > +		mutex_unlock(bd70528->rtc_timer_lock);
> > +
> Unlock before calling bd70528_set_rtc_based_timers is odd, especially since it
> is called after locking below.
> 

Yet another brainfart. Thanks for pointing this out! Will be fixed as
well.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
