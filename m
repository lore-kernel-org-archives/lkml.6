Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF094C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58827213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP5xRqJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58827213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeGLKMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:12:01 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41246 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeGLKMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:12:01 -0400
Received: by mail-lf0-f67.google.com with SMTP id v22-v6so10256834lfe.8;
        Thu, 12 Jul 2018 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=vohhUvTLK/Nm/bUrAxYhKvfU9J1eiyAqqZbFyPCcoG0=;
        b=FP5xRqJ61R00XkmB3RK1R00t5fDrr7plMQPRueXSAUdcA3vXdGobP+iGOpW/PsrJcr
         wsItMZGqGfhen50hOkRPbMNokhk+Utjboax4r2MK5yQ330ljvFAjOqM3h02AuM7EpEhQ
         v4FiCS0r7D43Jff8d9CA7roRMZZIR1kWwz5HFaX9q49aTZh3pSAgt1QYdANKIa8RSEyd
         BGJ31uhRqXAHkhxxrUrClzA5x8Etq1rPsoUm9SCKafx6pr3pZZZNHMqPC2kd4sN62gwu
         tZ5QlREczNCHh98HdxhCpkEVKxt6l/1Uy5b97aTuCLCOG+DGnDmM/ErCblwFYlbhprq6
         9Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=vohhUvTLK/Nm/bUrAxYhKvfU9J1eiyAqqZbFyPCcoG0=;
        b=jaeMuYdP8dUlkyp3edOdG9Kx3VAMT38Rh9h/9hP+2jrbFlt8thjAhH3t2QFXCieq/N
         XFgdBuWkieBTvDU4yjFxSFQT3NsseaE4KBXHMY8V8dFbJq1hC5M/CUH1XBlPg54SnNTu
         j+QVko6RUBxjbn2+645IRn0q2FFJLjSEU5Kn9iuILi5rSXdI6+28l6m1Bw8/g6C7lwUm
         O1QV53GR8xHnwb0UlLY3WeTj++v97/A08Q2j1j9RdSVWKcxZPH2LBt1NEF9mDiZCoDMS
         m+Tjnmgy8+cMnnqOnWwQ5I3YpJ0yJREp74++DEwEbpZAnBRZK/ITd9Ohvq7KubBfzG/u
         cFig==
X-Gm-Message-State: AOUpUlF6yCcjXfktfyHnvQw6vTfWQnTEyAznv52dAaWrLvvwaYKybtsL
        1a0ADWqQyO+95P+UxJ7H5Dt15wGQYbCq9sw0vzM=
X-Google-Smtp-Source: AAOMgpeww6x0S3YazjLFknu5eT0K/yBYn30njQXpY9AOVsgZ7yX4znx+7uJ8lHJBpio6liTma4g8hWdk7zOc4KPv2u8=
X-Received: by 2002:a19:ea5c:: with SMTP id i89-v6mr1305765lfh.19.1531389787020;
 Thu, 12 Jul 2018 03:03:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 03:03:05
 -0700 (PDT)
In-Reply-To: <20180712104658.220ef8f6@bbrezillon>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-2-boris.brezillon@bootlin.com> <CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com>
 <20180711164120.3e32fb08@bbrezillon> <CAK8P3a2EZB_tMS_47wv6M2Qpm79ZocxxhG5zLxXsBM_YjZgkyA@mail.gmail.com>
 <20180711191212.3855bb25@bbrezillon> <CAK8P3a2djk8c6STaxJC0MCkBddyOafk4WbG2LdfPf0V1EYiqmQ@mail.gmail.com>
 <20180712000932.3b04ee9d@bbrezillon> <CAK8P3a13GX67YEci2J8Rxn6O4FBjjD82X+w3hyGMT3TDbtFkTg@mail.gmail.com>
 <20180712104658.220ef8f6@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Jul 2018 12:03:05 +0200
X-Google-Sender-Auth: vjTsw7aCudRWguPyQZc7X7O1-7A
Message-ID: <CAK8P3a3raE9rmyvgxR0YVmYSCN4tumYS1TCexCuTEUXjy_9kSw@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:46 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Thu, 12 Jul 2018 10:21:40 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thu, Jul 12, 2018 at 12:09 AM, Boris Brezillon <boris.brezillon@bootl=
in.com> wrote:
>> > On Wed, 11 Jul 2018 22:10:26 +0200 Arnd Bergmann <arnd@arndb.de> wrote=
:
>> >> On Wed, Jul 11, 2018 at 7:12 PM, Boris Brezillon <boris.brezillon@boo=
tlin.com> wrote:
>> >> > On Wed, 11 Jul 2018 17:39:56 +0200 Arnd Bergmann <arnd@arndb.de> wr=
ote:
>> >> >> On Wed, Jul 11, 2018 at 4:41 PM, Boris Brezillon <boris.brezillon@=
bootlin.com> wrote:
>>
>> If we can ignore the case of handing over between two masters that
>> we both own, we end up being in just one of two states:
>>
>> a) currently we are the master
>> b) we are not currently the master but have asked the current
>>     master to transfer ownership back to us. For this, we have to
>>     know who the current master is of course.
>>
>> I think that's the simplest case that would work with the specification,
>> but it relies on the assumption that the master controlled by Linux
>> is always more important than any other master, and that we just
>> hand over ownership for as long as the others want it.
>>
>> If that is not the case, we also need a third state
>>
>> c) we have handed ownership to another master that is equally
>>     important, but no i2c device driver is currently trying to talk
>>     to a device, so we don't need ownership back until a slave driver
>>     changes state.
>
> That was the solution I was opting for.
>
>>
>> The main difference between b) and c) that I see would be what
>> happens with in-band interrupts. If I understand the specification
>> correctly, only the current master receives them, so if you have
>> any i2c device that uses interrupts to talk to a Linux driver, we
>
>       ^ you mean i3c here, right?

sure

>> want to be in b) rather than c). An example of this would be
>> an input device on a PC: If the user operateds the keyboard
>> or pointer and we have handed off ownership to a sensor hub,
>> we never get an input event, right?
>
> Correct. I guess we could try to regain bus ownership in case we have
> IBIs enabled. Or we let the secondary master give the bus back to us
> when it sees IBIs it can't handle, as described in section 5.1.7:
>
> "
> Once granted control of the Bus, the Secondary Master maintains
> control until another Master is granted Bus control. After the
> Secondary Master transitions to the Current Master role it could
> encounter Bus management activities besides the data transfers that it
> itself initiates. Some examples are the In-Band Interrupt, or the
> Hot-Join request. One optional possibility, shown at Section 5.1.7.2,
> is that the Secondary Master performs the Current Master=E2=80=99s action=
s with
> the full capabilities of the Main Master. Another optional possibility
> is that the Secondary Master, while serving in the Current Master role,
> could defer some actions to a more capable Master, as described in
> Section 5.1.7.3.
> "

Ah, so the current master can ask a secondary master to take over
again even if  the secondary master has not requested to be come the
current master?

>> > I agree. This being said, moving to a representation where the bus is
>> > implicitly represented by the master_controller instance shouldn't be
>> > too difficult. So, if you think we should try this approach I can do
>> > the modifications in my v6.
>>
>> I'd say let's wait before you do that change, possibly add a comment
>> in there now to remind us of what an alternative would be.
>
> You mean I should keep the i3c_bus object?

I mean the ongoing discussion shouldn't stop you from posting a v6.

        Arnd
