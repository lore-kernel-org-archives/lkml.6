Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9767C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894B2218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="oChVkpbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfAXVmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:42:01 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:55058 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfAXVmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548366117; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CvRzEbTgAQ9trPEVGxl/lVEhzA9RVr/wI5nkhToSdgg=;
        b=oChVkpbeL3xIHMcvcFvke5Gn2a3wSxpeTab0ZXH0owYo46vXNHQYHSpDX9YndxIpSQSt6i
        /eU15Wt7jHeKzldO+xpCQfHnm9FN/2P16qqpq9nPweT/ILXKfKMFdsuJFfG9xrPFPaxXaB
        rIwv/bG+wLDX7Q1U3j0xecUFwp3P6OM=
Date:   Thu, 24 Jan 2019 18:41:35 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 00/26] Ingenic TCU patchset v8
To:     Mathieu Malaterre <malat@debian.org>
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
Message-Id: <1548366095.3881.1@crapouillou.net>
In-Reply-To: <CA+7wUszMOvGoPSVOKP7F_KHxgJvjBGT7oJmn5EO62hGGTQK4KA@mail.gmail.com>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <CA+7wUszMOvGoPSVOKP7F_KHxgJvjBGT7oJmn5EO62hGGTQK4KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Le jeu. 24 janv. 2019 =E0 18:26, Mathieu Malaterre <malat@debian.org> a=20
=E9crit :
> Paul,
>=20
> On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Hi,
>>=20
>>  Here's the version 8 and hopefully final version of my patchset,=20
>> which
>>  adds support for the Timer/Counter Unit found in JZ47xx SoCs from
>>  Ingenic.
>=20
> I can no longer boot my MIPS Creator CI20 with this series (merged
> opendingux/for-upstream-timer-v8).
>=20
> Using screen+ttyUSB, I can see messages stopping at:
>=20
> ...
> [  OK  ] Started Cgroup management daemon.
>          Starting Regular background program processing daemon...
> [  OK  ] Started Regular background program processing daemon.
>          Starting System Logging Service...
>          Starting Provide limited super user privileges to specific=20
> users...
>          Starting Restore /etc/resolv.conf if the system cras...s=20
> shut down....
>          Starting WPA supplicant...
>          Starting D-Bus System Message Bus...
> [  OK  ] Started D-Bus System Message Bus.
>=20
> Nothing really stands out in the error messages. Could you suggest
> things to try out to get into a bootable state ?

I'm debugging it right now on jz4740, it seems to happen when the=20
clocksource
from the ingenic-timer driver is used. Is it your case? It should not=20
happen
if you have CONFIG_INGENIC_OST set.

>>  The big change is that the timer driver has been simplified. The=20
>> code to
>>  dynamically update the system timer or clocksource to a new channel=20
>> has
>>  been removed. Now, the system timer and clocksource are provided as
>>  children nodes in the devicetree, and the TCU channel to use for=20
>> these
>>  is deduced from their respective memory resource. The PWM driver=20
>> will
>>  also deduce from its memory resources whether a given PWM channel=20
>> can be
>>  used, or is reserved for the system timers.
>>=20
>>  Kind regards,
>>  - Paul Cercueil
>>=20
=

