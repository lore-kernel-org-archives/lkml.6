Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6B0C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95920218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfAXV0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:26:24 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36572 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAXV0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:26:24 -0500
Received: by mail-oi1-f194.google.com with SMTP id x23so6120205oix.3;
        Thu, 24 Jan 2019 13:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BKASeLMZBaJ/TSA8g4AVbiUtB0M/I+YsAh4EUI6f1I=;
        b=mDtGIznVqujHLrgFv5n+7AyN5AubPd3qnXa+qSLCYmp0zzvpxKZWx4ahzJWfcG1d2p
         BxJ4ACl3yaIDL2T+bvHqWvUBet4fJol6Q4DwJ9W4bv2EgSMhNnE1f/tth9zxwlQQ+4oE
         Kl0r2p8MwQr5u/kcrOS830UlZDZmaf/Rk33fUa+Oo3HqNi59JPD2itaQ39tCXAZLY0Zr
         DTsFUlsWGq2DXlB2c+cEjCgexOragOK742bQyypeGwLYZ6TIgj76beeRGZRi2MDG5XMA
         iUalQOSe3p2RP+WGFF13QxgvQc3gV6kOwUmXTRLmpihwck8yyGv+foFm7fuslMcvpo3u
         DzYw==
X-Gm-Message-State: AJcUukerRzh2GAGduKjuMY0STW1N8gXROmUXczutRcKaQTFd0iTpNFGa
        QssSBU1Gm69iinqS7y1RDvirnEO3gXV4rz+x0wA=
X-Google-Smtp-Source: ALg8bN7I3dzDDE37T4ya0I4Yuv8D8lZBMBAURA28lB6dUyh12DiW6fMx2EYsyoDEAfqqSDW+YjKTTsdBaZHHFjc0U1s=
X-Received: by 2002:aca:5117:: with SMTP id f23mr2405614oib.72.1548365182672;
 Thu, 24 Jan 2019 13:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20181212220922.18759-1-paul@crapouillou.net>
In-Reply-To: <20181212220922.18759-1-paul@crapouillou.net>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Thu, 24 Jan 2019 22:26:11 +0100
Message-ID: <CA+7wUszMOvGoPSVOKP7F_KHxgJvjBGT7oJmn5EO62hGGTQK4KA@mail.gmail.com>
Subject: Re: [PATCH v8 00/26] Ingenic TCU patchset v8
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi,
>
> Here's the version 8 and hopefully final version of my patchset, which
> adds support for the Timer/Counter Unit found in JZ47xx SoCs from
> Ingenic.

I can no longer boot my MIPS Creator CI20 with this series (merged
opendingux/for-upstream-timer-v8).

Using screen+ttyUSB, I can see messages stopping at:

...
[  OK  ] Started Cgroup management daemon.
         Starting Regular background program processing daemon...
[  OK  ] Started Regular background program processing daemon.
         Starting System Logging Service...
         Starting Provide limited super user privileges to specific users...
         Starting Restore /etc/resolv.conf if the system cras...s shut down....
         Starting WPA supplicant...
         Starting D-Bus System Message Bus...
[  OK  ] Started D-Bus System Message Bus.

Nothing really stands out in the error messages. Could you suggest
things to try out to get into a bootable state ?


> The big change is that the timer driver has been simplified. The code to
> dynamically update the system timer or clocksource to a new channel has
> been removed. Now, the system timer and clocksource are provided as
> children nodes in the devicetree, and the TCU channel to use for these
> is deduced from their respective memory resource. The PWM driver will
> also deduce from its memory resources whether a given PWM channel can be
> used, or is reserved for the system timers.
>
> Kind regards,
> - Paul Cercueil
>
