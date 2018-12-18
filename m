Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED79C43613
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E783218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151012;
	bh=mf4+sc8moYkidTXd88Q9pc3Ndqt4TNLyO0MJGzs+8zM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Yk005lzfgRtxrh21NHFnQz3WUnyeAkKzFljiPCnfM8Kx7LIvMeVnaDNSIW6op+jtm
	 5TQI6CGfXhdg6OgiMOMQmLmHqsa3kw18oy5jZIHuuy8zs2KohzplDQU/j3ei6JEyuE
	 e2/wjXXGnInvJ6HzrgKlC0PcJOAcMd2yEvh/xZ5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeLRQgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbeLRQgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:36:50 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44159218AF;
        Tue, 18 Dec 2018 16:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151009;
        bh=mf4+sc8moYkidTXd88Q9pc3Ndqt4TNLyO0MJGzs+8zM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M7vHFnzsY1SikD/wPVeRpIG25a+IhPTQrkEr4VnWS/7rHjkV7V0Ts0okqThKnrgAE
         mtrpaf2KQM6O5LX62eDEaZXbzoBFIbMe2oA/kfOlLmr5/Pqgudg9b6RP0r0ScpFOdi
         BJgRmc6CLeD+AJ0Cw2OSaGnd0NmBvi06Zjqh09Zg=
Received: by mail-qt1-f174.google.com with SMTP id t13so18873950qtn.3;
        Tue, 18 Dec 2018 08:36:49 -0800 (PST)
X-Gm-Message-State: AA+aEWYxrxq50bvPkgo1jEiir0WHhZxzNFLS8+oZB/SOLKBmRYCifsRi
        /aP668nGxNW3U4ulShTJIaD+dujNvR7oJZ8knA==
X-Google-Smtp-Source: AFSGD/W9EM9+0Y6Mvl/GEHksvVmaXWJznGtNOhtfD4esKHNUdIIlDROKbNz04PG/zjZcpSpax0QbKCTUY5SthD8Mpu0=
X-Received: by 2002:a0c:f212:: with SMTP id h18mr18194216qvk.106.1545151008366;
 Tue, 18 Dec 2018 08:36:48 -0800 (PST)
MIME-Version: 1.0
References: <20181212220922.18759-1-paul@crapouillou.net> <20181212220922.18759-4-paul@crapouillou.net>
 <20181217210531.GA29770@bogus> <1545084222.1958.0@smtp.crapouillou.net>
In-Reply-To: <1545084222.1958.0@smtp.crapouillou.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Dec 2018 10:36:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLhnitSM7-S1hq8M7S-7BHO5oYByXQ8QD2JkUY3jb63fQ@mail.gmail.com>
Message-ID: <CAL_JsqLhnitSM7-S1hq8M7S-7BHO5oYByXQ8QD2JkUY3jb63fQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/26] dt-bindings: Add doc for the Ingenic TCU drivers
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 4:04 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Rob,
>
> Le lun. 17 d=C3=A9c. 2018 =C3=A0 22:05, Rob Herring <robh@kernel.org> a =
=C3=A9crit :
> > On Wed, Dec 12, 2018 at 11:08:58PM +0100, Paul Cercueil wrote:
> >>  Add documentation about how to properly use the Ingenic TCU
> >>  (Timer/Counter Unit) drivers from devicetree.
> >>
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >>
> >>  Notes:
> >>       v4: New patch in this series. Corresponds to V2 patches 3-4-5
> >> with
> >>           added content.
> >>
> >>       v5: - Edited PWM/watchdog DT bindings documentation to point
> >> to the new
> >>             document.
> >>           - Moved main document to
> >>             Documentation/devicetree/bindings/timer/ingenic,tcu.txt
> >>           - Updated documentation to reflect the new devicetree
> >> bindings.
> >>
> >>       v6: - Removed PWM/watchdog documentation files as asked by
> >> upstream
> >>           - Removed doc about properties that should be implicit
> >>           - Removed doc about ingenic,timer-channel /
> >>             ingenic,clocksource-channel as they are gone
> >>           - Fix WDT clock name in the binding doc
> >>           - Fix lengths of register areas in watchdog/pwm nodes
> >>
> >>       v7: No change
> >>
> >>       v8: - Fix address of the PWM node
> >>           - Added doc about system timer and clocksource children
> >> nodes
> >
> > I thought we'd sorted this out...
>
> Yeah, well I just can't please everybody. V6/V7 didn't have the
> system timer or clocksource in devicetree, which was good for
> you, but then the driver nearly doubled in size and complexity,
> and Thierry rightfully refused it. Now I'm at the point where

You mean Daniel?

> I'm trying alternative ways of encoding the information in
> devicetree, as suggested by various people, just so that you
> accept it. Because I don't see any other option.

Does the problem boil down to needing to reserve channel x to use PWMx
pin? If so, just do a mask property of reserved for PWM channels.

Sorry this is going in circles.

Rob
