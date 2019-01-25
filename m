Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F046DC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C819021A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfAYIWE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:22:04 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45053 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfAYIWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:22:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id m6so7065950oig.11;
        Fri, 25 Jan 2019 00:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pMmRtOnlS9JmHS0lIi3rNLpuFdy8D/BTQQ+ROOLSja8=;
        b=mGh+n/UAoDVquv1xLoYyp7Vxu9MmqB25D1Yc3hHUxO1UAEzTsrGflkeyIXSGdacgJV
         umg95aqaFAw7PJiRlGfNFbK82dH+mhe2gvsq+ZYYTVU4nvp7m9X7dplYa8AWc+SH5TUz
         plv91ZZZJ8touI0O2/StZigLaOaYLu5NvjF8dG7NkN81F2bc/nW3GWcNwPlTs665QJfS
         wb6BAUrbKz+HU02fHmM0HJSArYoWvESsjYJm5cSc+QLSC3CxEVZlG72OZhemoh9xvgtN
         veKEl74rNgoTgEB40gPJ/LKonCmGndwvezuOXYdAACnUofM0I38fqfyqQXzUglTsLwvZ
         ZP8g==
X-Gm-Message-State: AJcUukeG03zHiZxnv3zKQuMo3YwTGmoQLbUPfKqv1Q/COQvfi6DKBjjF
        0uEVP1ULayZ0yhXGQRHFtihW+/GCyzi0RSP0WXA=
X-Google-Smtp-Source: ALg8bN7WJwR/Rdg4MFCPOmYC9QXLPe8ClifnecdpFteEcAg7nc98yZ65ypwDrMAVMV658EErNMHf4+5H8LwZ4eGxt7c=
X-Received: by 2002:aca:b05:: with SMTP id 5mr761641oil.258.1548404522077;
 Fri, 25 Jan 2019 00:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20181212220922.18759-1-paul@crapouillou.net> <CA+7wUszMOvGoPSVOKP7F_KHxgJvjBGT7oJmn5EO62hGGTQK4KA@mail.gmail.com>
 <1548366095.3881.1@crapouillou.net>
In-Reply-To: <1548366095.3881.1@crapouillou.net>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 25 Jan 2019 09:21:51 +0100
Message-ID: <CA+7wUsxhjiLQ6n40AZGWHeqL0o8NvR3hn+pWgmh=7hdPTBrKtg@mail.gmail.com>
Subject: Re: [PATCH v8 00/26] Ingenic TCU patchset v8
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Thu, Jan 24, 2019 at 10:41 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Mathieu,
>
> Le jeu. 24 janv. 2019 à 18:26, Mathieu Malaterre <malat@debian.org> a
> écrit :
> > Paul,
> >
> > On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil <paul@crapouillou.net>
> > wrote:
> >>
> >>  Hi,
> >>
> >>  Here's the version 8 and hopefully final version of my patchset,
> >> which
> >>  adds support for the Timer/Counter Unit found in JZ47xx SoCs from
> >>  Ingenic.
> >
> > I can no longer boot my MIPS Creator CI20 with this series (merged
> > opendingux/for-upstream-timer-v8).
> >
> > Using screen+ttyUSB, I can see messages stopping at:
> >
> > ...
> > [  OK  ] Started Cgroup management daemon.
> >          Starting Regular background program processing daemon...
> > [  OK  ] Started Regular background program processing daemon.
> >          Starting System Logging Service...
> >          Starting Provide limited super user privileges to specific
> > users...
> >          Starting Restore /etc/resolv.conf if the system cras...s
> > shut down....
> >          Starting WPA supplicant...
> >          Starting D-Bus System Message Bus...
> > [  OK  ] Started D-Bus System Message Bus.
> >
> > Nothing really stands out in the error messages. Could you suggest
> > things to try out to get into a bootable state ?
>
> I'm debugging it right now on jz4740, it seems to happen when the
> clocksource
> from the ingenic-timer driver is used. Is it your case? It should not
> happen
> if you have CONFIG_INGENIC_OST set.

Here is what I see:

$ grep CONFIG_INGENIC_OST arch/mips/configs/ci20_defconfig
CONFIG_INGENIC_OST=y
$ make O=ci20 ARCH=mips CROSS_COMPILE=mipsel-linux-gnu- ci20_defconfig
$ grep CONFIG_INGENIC_OST ci20/.config
CONFIG_INGENIC_OST=y

The setting is coming from your commit:

8f66e6b9c98f MIPS: CI20: defconfig: enable OST driver

In an attempt to solve the symptoms I even played with the clock rates
with no success:

&tcu {
/* 3 MHz for the system timer and clocksource */
assigned-clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>;
assigned-clock-rates = <750000>, <750000>;
};


> >>  The big change is that the timer driver has been simplified. The
> >> code to
> >>  dynamically update the system timer or clocksource to a new channel
> >> has
> >>  been removed. Now, the system timer and clocksource are provided as
> >>  children nodes in the devicetree, and the TCU channel to use for
> >> these
> >>  is deduced from their respective memory resource. The PWM driver
> >> will
> >>  also deduce from its memory resources whether a given PWM channel
> >> can be
> >>  used, or is reserved for the system timers.
> >>
> >>  Kind regards,
> >>  - Paul Cercueil
> >>
>
