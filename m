Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F23C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F03218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="bfG5KTix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfAYRFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:05:09 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:38942 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfAYRFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548435905; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZ59XwrYk5c3GgKBnBdYsNOPHkGSmweRQUQFHvZ+qas=;
        b=bfG5KTixtBu5/Vr7zT7aIUv1MxWIJy7x3gzXr6RQfq5yWAkCbeKdWNdcyhM6+POGzSeelh
        0gZgOX8b/5kfSaFslV8lWDQ1oM0X/Z9xqjArrkXurhZPE7fGh7/ywR18ooQTdqNmi1PDSs
        5r70ypMlZGqx8/XRd7xHW47Hschudy4=
Date:   Fri, 25 Jan 2019 14:04:50 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 00/26] Ingenic TCU patchset v8
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org
Message-Id: <1548435890.1804.0@crapouillou.net>
In-Reply-To: <CA+7wUsxhjiLQ6n40AZGWHeqL0o8NvR3hn+pWgmh=7hdPTBrKtg@mail.gmail.com>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <CA+7wUszMOvGoPSVOKP7F_KHxgJvjBGT7oJmn5EO62hGGTQK4KA@mail.gmail.com>
        <1548366095.3881.1@crapouillou.net>
        <CA+7wUsxhjiLQ6n40AZGWHeqL0o8NvR3hn+pWgmh=7hdPTBrKtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 25, 2019 at 5:21 AM, Mathieu Malaterre <malat@debian.org>=20
wrote:
> Paul,
>=20
> On Thu, Jan 24, 2019 at 10:41 PM Paul Cercueil <paul@crapouillou.net=20
> <mailto:paul@crapouillou.net>> wrote:
>>=20
>>  Hi Mathieu,
>>=20
>>  Le jeu. 24 janv. 2019 =E0 18:26, Mathieu Malaterre <malat@debian.org=20
>> <mailto:malat@debian.org>> a
>>  =E9crit :
>>  > Paul,
>>  >
>>  > On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil=20
>> <paul@crapouillou.net <mailto:paul@crapouillou.net>>
>>  > wrote:
>>  >>
>>  >>  Hi,
>>  >>
>>  >>  Here's the version 8 and hopefully final version of my patchset,
>>  >> which
>>  >>  adds support for the Timer/Counter Unit found in JZ47xx SoCs=20
>> from
>>  >>  Ingenic.
>>  >
>>  > I can no longer boot my MIPS Creator CI20 with this series (merged
>>  > opendingux/for-upstream-timer-v8).
>>  >
>>  > Using screen+ttyUSB, I can see messages stopping at:
>>  >
>>  > ...
>>  > [  OK  ] Started Cgroup management daemon.
>>  >          Starting Regular background program processing daemon...
>>  > [  OK  ] Started Regular background program processing daemon.
>>  >          Starting System Logging Service...
>>  >          Starting Provide limited super user privileges to=20
>> specific
>>  > users...
>>  >          Starting Restore /etc/resolv.conf if the system cras...s
>>  > shut down....
>>  >          Starting WPA supplicant...
>>  >          Starting D-Bus System Message Bus...
>>  > [  OK  ] Started D-Bus System Message Bus.
>>  >
>>  > Nothing really stands out in the error messages. Could you suggest
>>  > things to try out to get into a bootable state ?
>>=20
>>  I'm debugging it right now on jz4740, it seems to happen when the
>>  clocksource
>>  from the ingenic-timer driver is used. Is it your case? It should=20
>> not
>>  happen
>>  if you have CONFIG_INGENIC_OST set.
>=20
> Here is what I see:
>=20
> $ grep CONFIG_INGENIC_OST arch/mips/configs/ci20_defconfig
> CONFIG_INGENIC_OST=3Dy
> $ make O=3Dci20 ARCH=3Dmips CROSS_COMPILE=3Dmipsel-linux-gnu- ci20_defcon=
fig
> $ grep CONFIG_INGENIC_OST ci20/.config
> CONFIG_INGENIC_OST=3Dy
>=20
> The setting is coming from your commit:
>=20
> 8f66e6b9c98f MIPS: CI20: defconfig: enable OST driver
>=20
> In an attempt to solve the symptoms I even played with the clock rates
> with no success:
>=20
> &tcu {
> /* 3 MHz for the system timer and clocksource */
> assigned-clocks =3D <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>;
> assigned-clock-rates =3D <750000>, <750000>;
> };

This driver didn't see any big change since v6, and we're at v9 now.
I swear it worked fine before, I think even Paul Burton tested it and
reported it working fine. What kernel are you testing on? Could you try
on top of an older kernel, e.g. 4.18?

>>  >>  The big change is that the timer driver has been simplified. The
>>  >> code to
>>  >>  dynamically update the system timer or clocksource to a new=20
>> channel
>>  >> has
>>  >>  been removed. Now, the system timer and clocksource are=20
>> provided as
>>  >>  children nodes in the devicetree, and the TCU channel to use for
>>  >> these
>>  >>  is deduced from their respective memory resource. The PWM driver
>>  >> will
>>  >>  also deduce from its memory resources whether a given PWM=20
>> channel
>>  >> can be
>>  >>  used, or is reserved for the system timers.
>>  >>
>>  >>  Kind regards,
>>  >>  - Paul Cercueil
>>  >>
>>=20

=

