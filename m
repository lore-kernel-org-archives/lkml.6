Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C921C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC574219D6
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="b5tsJlLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391013AbeLVRH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:07:56 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:35386 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbeLVRHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1545476981; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eHVD3wuv5y8Wv1Q5MfEgEhtMxuWsgAkJR+tNwfVbxZ0=;
        b=b5tsJlLSv/CS3iwe3R0J0G1OQLEYllzfVovCYsD571DHGNeJNPhF3iBtVLTyW6dCIo0lFw
        EbLe5itbVY/DNzlDo8nkWLJS5OtjonqchYUXhrzlezWLJajoNBbkp45xYihLtjkHbGm26R
        01rLbYTMOJvMMSg/1TCyRQid7fRWrAQ=
Date:   Sat, 22 Dec 2018 12:09:32 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 03/26] dt-bindings: Add doc for the Ingenic TCU drivers
To:     Rob Herring <robh@kernel.org>
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
Message-Id: <1545476972.2113.1@crapouillou.net>
In-Reply-To: <CAL_JsqLhnitSM7-S1hq8M7S-7BHO5oYByXQ8QD2JkUY3jb63fQ@mail.gmail.com>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <20181212220922.18759-4-paul@crapouillou.net> <20181217210531.GA29770@bogus>
        <1545084222.1958.0@smtp.crapouillou.net>
        <CAL_JsqLhnitSM7-S1hq8M7S-7BHO5oYByXQ8QD2JkUY3jb63fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mar. 18 d=E9c. 2018 =E0 17:36, Rob Herring <robh@kernel.org> a =E9crit :
> On Mon, Dec 17, 2018 at 4:04 PM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Hi Rob,
>>=20
>>  Le lun. 17 d=E9c. 2018 =E0 22:05, Rob Herring <robh@kernel.org> a=20
>> =E9crit :
>>  > On Wed, Dec 12, 2018 at 11:08:58PM +0100, Paul Cercueil wrote:
>>  >>  Add documentation about how to properly use the Ingenic TCU
>>  >>  (Timer/Counter Unit) drivers from devicetree.
>>  >>
>>  >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  >>  ---
>>  >>
>>  >>  Notes:
>>  >>       v4: New patch in this series. Corresponds to V2 patches=20
>> 3-4-5
>>  >> with
>>  >>           added content.
>>  >>
>>  >>       v5: - Edited PWM/watchdog DT bindings documentation to=20
>> point
>>  >> to the new
>>  >>             document.
>>  >>           - Moved main document to
>>  >>            =20
>> Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>>  >>           - Updated documentation to reflect the new devicetree
>>  >> bindings.
>>  >>
>>  >>       v6: - Removed PWM/watchdog documentation files as asked by
>>  >> upstream
>>  >>           - Removed doc about properties that should be implicit
>>  >>           - Removed doc about ingenic,timer-channel /
>>  >>             ingenic,clocksource-channel as they are gone
>>  >>           - Fix WDT clock name in the binding doc
>>  >>           - Fix lengths of register areas in watchdog/pwm nodes
>>  >>
>>  >>       v7: No change
>>  >>
>>  >>       v8: - Fix address of the PWM node
>>  >>           - Added doc about system timer and clocksource children
>>  >> nodes
>>  >
>>  > I thought we'd sorted this out...
>>=20
>>  Yeah, well I just can't please everybody. V6/V7 didn't have the
>>  system timer or clocksource in devicetree, which was good for
>>  you, but then the driver nearly doubled in size and complexity,
>>  and Thierry rightfully refused it. Now I'm at the point where
>=20
> You mean Daniel?

Oops - I meant Daniel yes.

>>  I'm trying alternative ways of encoding the information in
>>  devicetree, as suggested by various people, just so that you
>>  accept it. Because I don't see any other option.
>=20
> Does the problem boil down to needing to reserve channel x to use PWMx
> pin? If so, just do a mask property of reserved for PWM channels.

Yes, that's exactly the problem. I will go with a property then. Thanks!

> Sorry this is going in circles.
>=20
> Rob
=

