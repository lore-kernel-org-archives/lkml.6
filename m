Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C805EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896362147C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPpvutzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896362147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeK3TZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbeK3TZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:25:08 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19E51206B7;
        Fri, 30 Nov 2018 08:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543565798;
        bh=TO0T4SzivIpQeoHDCzPgm4w+v6PSc+ghOTE5fXmyclY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=fPpvutzv6AwMQy1Lou+YmR74oqGJbrhqB9cNpbEJn8kLBzdKp7QLzC+Md5CaubC4h
         v6fkO1ysqfP3Nh8fndksxbVi9bfe1b0ybSyHkVqaqe8kBjAglW6Zu3fizBslVRN00s
         rpLuoLbqDESVckWFCMyu7DMOaSexMjuF9yku1Dik=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Sugaya, Taichi" <sugaya.taichi@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <c746a3de-a9e3-9f25-ecb9-703ceb7e62d0@socionext.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
 <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
 <c746a3de-a9e3-9f25-ecb9-703ceb7e62d0@socionext.com>
Message-ID: <154356579701.88331.5043467509900444879@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline
 description
Date:   Fri, 30 Nov 2018 00:16:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sugaya, Taichi (2018-11-29 04:24:51)
> On 2018/11/28 11:01, Stephen Boyd wrote:
> > Quoting Sugaya Taichi (2018-11-18 17:01:07)
> >>   create mode 100644 Documentation/devicetree/bindings/soc/socionext/s=
ocionext,m10v.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext=
,m10v.txt b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.=
txt
> >> new file mode 100644
> >> index 0000000..f5d906c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.t=
xt
> >> @@ -0,0 +1,12 @@
> >> +Socionext M10V SMP trampoline driver binding
> >> +
> >> +This is a driver to wait for sub-cores while boot process.
> >> +
> >> +- compatible: should be "socionext,smp-trampoline"
> >> +- reg: should be <0x4C000100 0x100>
> >> +
> >> +EXAMPLE
> >> +       trampoline: trampoline@0x4C000100 {
> > Drop the 0x part of unit addresses.
> =

> Okay.
> =

> =

> >> +               compatible =3D "socionext,smp-trampoline";
> >> +               reg =3D <0x4C000100 0x100>;
> > Looks like a software construct, which we wouldn't want to put into DT
> > this way. DT doesn't describe drivers.
> We would like to use this node only getting the address of the =

> trampoline area
> in which sub-cores wait.=C2=A0 (They have finished to go to this area in =
previous
> bootloader process.)

Is this area part of memory, or a special SRAM? If it's part of memory,
I would expect this node to be under the reserved-memory node and
pointed to by some other node that uses this region. Could even be the
CPU nodes.

> =

> So should we embed the constant value in source codes instead of getting =

> from
> DT because the address is constant at the moment? Or is there other =

> approach?
> =


If it's constant then that also works. Why does it need to come from DT
at all then?

