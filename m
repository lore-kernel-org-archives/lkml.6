Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE715C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C093C2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C093C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeKTTxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:53:33 -0500
Received: from smtpq3.tb.mail.iss.as9143.net ([212.54.42.166]:51204 "EHLO
        smtpq3.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbeKTTxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:53:32 -0500
X-Greylist: delayed 961 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Nov 2018 14:53:31 EST
Received: from [212.54.42.132] (helo=smtp8.tb.mail.iss.as9143.net)
        by smtpq3.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <jongk@linux-m68k.org>)
        id 1gP229-0002Gi-Ki
        for linux-kernel@vger.kernel.org; Tue, 20 Nov 2018 10:09:25 +0100
Received: from mail-lj1-f175.google.com ([209.85.208.175])
        by smtp8.tb.mail.iss.as9143.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <jongk@linux-m68k.org>)
        id 1gP229-000216-IS
        for linux-kernel@vger.kernel.org; Tue, 20 Nov 2018 10:09:25 +0100
Received: by mail-lj1-f175.google.com with SMTP id z80-v6so961074ljb.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 01:09:25 -0800 (PST)
X-Gm-Message-State: AA+aEWYBhNnwrCD1HbEkfhpmGetyGWnmvHJKK72yhz7AwP5vQ4g0gnAU
        G9nfgeFHXwy6hMXM1NosXdjw5amRXfFw9zUUuUU=
X-Google-Smtp-Source: AFSGD/V7a4zHAaF7WTNRjMyznBUevPJIs8vqGrQY7ES6A5K31U8ycoRZpnx4XnJul664GhJcsqggSq4AHPjBrUyisvY=
X-Received: by 2002:a2e:63cd:: with SMTP id s74-v6mr665076lje.117.1542704964978;
 Tue, 20 Nov 2018 01:09:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542589838.git.fthain@telegraphics.com.au> <eb676d37a8e40b88f6c577b372b6512bc19a3394.1542589838.git.fthain@telegraphics.com.au>
In-Reply-To: <eb676d37a8e40b88f6c577b372b6512bc19a3394.1542589838.git.fthain@telegraphics.com.au>
From:   Kars de Jong <jongk@linux-m68k.org>
Date:   Tue, 20 Nov 2018 10:09:13 +0100
X-Gmail-Original-Message-ID: <CACz-3rh6Qw7YxeFK41KG_ju-bWHRoCaciWvv7JLeURn7wGVAOg@mail.gmail.com>
Message-ID: <CACz-3rh6Qw7YxeFK41KG_ju-bWHRoCaciWvv7JLeURn7wGVAOg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/14] m68k: hp300: Remove hp300_gettimeoffset()
To:     fthain@telegraphics.com.au
Cc:     geert@linux-m68k.org, philb@gnu.org, schwab@linux-m68k.org,
        arnd@arndb.de, schivers@csc.com.au, tglx@linutronix.de,
        daniel.lezcano@linaro.org, schmitzmic@gmail.com,
        john.stultz@linaro.org, linus.walleij@linaro.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-SourceIP: 209.85.208.175
X-Authenticated-Sender: karsdejong@home.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=aNtEVo1m c=1 sm=1 tr=0 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=IkcTkHD0fZMA:10 a=JHtHm7312UAA:10 a=8981fWPbAAAA:8 a=WtWjpamJeDu0b-qHKIQA:9 a=QEXdDO2ut3YA:10 a=o72u2rHnfW5qNJ_4I8LD:22
X-Ziggo-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op ma 19 nov. 2018 om 02:10 schreef Finn Thain <fthain@telegraphics.com.au>:
>
> hp300_gettimeoffset() never checks the timer interrupt flag and will
> fail to notice when the timer counter gets reloaded. That means the
> clock could jump backwards.
>
> Remove this code and leave this platform on the 'jiffies' clocksource.
> Note that this amounts to a regression in clock precision. However,
> adopting the 'jiffies' clocksource does resolve the monotonicity issue.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
> hp300_gettimeoffset() cannot be used in a clocksource conversion
> unless it can be made monotonic. I can't fix this without knowing the
> details of the timer implementation, such as the relationship between
> the timer count and the interrupt flag.

I don't really like this regression...

According to NetBSD sources, there are 3 timers in the chip
(originally an MC6840 PTM). Timer 1 is used as the system timer, timer
3 runs at the same rate and is unused on Linux (on NetBSD it is used
as the statistics/profiling timer), and timer 3 is connected to timer
2 so you can make a 32-bit timer out of the two timers together (also
unused on Linux).

Timers 1 counts down at 25 MHz. The interrupt flag is set when the
counter reaches 0 after which it is automatically reloaded and starts
counting down again.

> ---
>  arch/m68k/hp300/time.c | 19 -------------------
>  1 file changed, 19 deletions(-)
