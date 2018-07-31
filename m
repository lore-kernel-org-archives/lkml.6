Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2719C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC55F208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="h32cCjul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC55F208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbeGaIO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:14:27 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:33767 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbeGaIO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533018941;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=BZ/JnPnFl0fL+3WgtHllJq3OJOzTu28euWK5jd0fzsg=;
        b=h32cCjulifeJwJxvMh98ZniqDXz79VUjAKy4VWYqdeufLHG7/0ZRZhFsColn/bnRHl
        72itZyM+aOFxe83L9/9pnLdZsmk2UmFouUsHy55ueroCXpQC79fkvij6WNHukRWDVEbE
        kovl0QEWUqasoNQyMEU6ZJIX4rxEj49RzppOdYRRN8dFtuAvPECNEQ3ZIO2XaTB+V1yb
        Xet1II4c4iWAHPgy+d1JHwWZCvF053xNQU3EoHRDGHbS4cGZMbT3DJeVzBnPZLpAgSta
        Chvep3ST0vX8mugBaRu3IQMoLm+bLeerjXfoxSNAt8uVZsx4CthK48lbyf51p/2kLUD8
        QGOQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5gpw91kgwllX1BqIbuk="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V6ZRwEc
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 08:35:27 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] pwm: pwm-omap-dmtimer: fix probing problems by returning EPROBE_DEFER
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180730185625.14c0feca.drivshin@awxrd.com>
Date:   Tue, 31 Jul 2018 08:35:26 +0200
Cc:     Ladislav Michl <ladis@linux-mips.org>,
        David Rivshin <drivshin@allworx.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-pwm@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BC0B4EAD-6DC1-4338-9185-FA319F998D41@goldelico.com>
References: <20180728165914.15871-1-andreas@kemnade.info> <20180728203501.GA16194@lenoch> <BE83C4E8-55B0-4EA7-8FF6-756460464264@goldelico.com> <20180729180804.GA18468@lenoch> <920A2836-9266-46F8-9A3F-111C01999C9E@goldelico.com> <20180730185625.14c0feca.drivshin@awxrd.com>
To:     David Rivshin <drivshin@awxrd.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 31.07.2018 um 00:56 schrieb David Rivshin <drivshin@awxrd.com>:
>=20
> On Sun, 29 Jul 2018 20:19:08 +0200
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>> Hi,
>>=20
>>> Am 29.07.2018 um 20:08 schrieb Ladislav Michl =
<ladis@linux-mips.org>:
>>>=20
>>> On Sun, Jul 29, 2018 at 08:32:41AM +0200, H. Nikolaus Schaller =
wrote: =20
>>>> Hi,
>>>>=20
>>>>> Am 28.07.2018 um 22:35 schrieb Ladislav Michl =
<ladis@linux-mips.org>:
>>>>>=20
>>>>> Hi Andreas,
>>>>>=20
>>>>> On Sat, Jul 28, 2018 at 06:59:14PM +0200, Andreas Kemnade wrote: =20=

>>>>>> I got this in the kernel log:
>>>>>> [    0.756042] omap-dmtimer-pwm dmtimer-pwm: dmtimer pdata =
structure NULL
>>>>>> [    0.756134] omap-dmtimer-pwm: probe of dmtimer-pwm failed with =
error -22
>>>>>>=20
>>>>>> the probe function has to wait until omap_dm_timer_probe() in
>>>>>> clocksource/timer-ti-dm.c has initialized pdata, so defer probing =
=20
>>>>>=20
>>>>> There already is a patch by David Rivshin addressing the same =
issue... =20
>>>>=20
>>>> Here it is:
>>>>=20
>>>> https://patchwork.ozlabs.org/patch/943148/
>>>>=20
>>>> but hasn't arrived in linux-next. =20
>>>=20
>>> That's because there'll be v3.
>>>=20
>>>> But it is questionable if a driver should dev_info() about doing =
deferred probing.
>>>> IMHO, it should just do it which is how Andreas' patch works. =20
>>>=20
>>> See here: https://patchwork.ozlabs.org/patch/949659/ =20
>>=20
>> Ah, I see (neither Andreas nor me did follow the original discussions
>> and therefore came up independently with the same thoughts).
>=20
> Seems a lot of us have tripped over this problem at roughly the same=20=

> time. I'm hoping Thierry picks it up in time for the 4.19 merge =
window.

Well, if possible it should be backported to 4.18 and 4.17.

>=20
>> So we will wait for the v3.
>=20
> FYI, v3 has been posted: https://patchwork.ozlabs.org/patch/951299/
> Let me know if you feel strongly enough about having no message
> (vs dev_dbg) for me to spin a quick v4.

I am fine with dev_dbg.

> Seems like each additional=20
> pair of eyes leans in that direction.
>=20
> Ladislav, I realized just after I sent that I forgot to add your ack
> to the commit message. Sorry for the oversight.
>=20

BR and thanks,
Nikolaus

