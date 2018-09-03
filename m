Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C80BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E775720867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="ALgaFeBs";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="NZTN4Cje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E775720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbeICXhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:37:45 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:35922 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727493AbeICXho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:37:44 -0400
X-Greylist: delayed 640 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Sep 2018 19:37:43 EDT
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w83J5FU8024021
        for <linux-kernel@vger.kernel.org>; Mon, 3 Sep 2018 20:05:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type : content-transfer-encoding; s=pp;
 bh=k6PzykZi04mh7DFgvNFZOmZB/0H8YUQxLjGBxTVEXxc=;
 b=ALgaFeBsW4xW3FgmQQ/lz+8VjdFGP52Z29tp/XbQB3fOZr6tB1JDI5nF4J60gu6NYqbA
 r2YT5JDSNBUyWMtwpbCGs3CHBzg2yUF7Tnl3SmUcVKxhWnIkkG1GzT875ZoSmf901P21
 c6ZuzGj58N3uCsjvkKVbBN5FRNn/dopaL2pzIMdsbkGFLfqftNwCr84qGdnjhZ3w78Ih
 CWeeD00BEcs7DW05HWjuryHaSURjMxxxWLL79fPfPmvAmi/B019pIlwOrMzO9v9OpgWn
 J2iRwvYP/i4EQ41qPh9K1b2j2q2c0kjWqthjaJWVG5RDdAD9o6K/wXneFPqcVRlitmhq Mg== 
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        by mx08-00252a01.pphosted.com with ESMTP id 2m7f8fh6yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 20:05:32 +0100
Received: by mail-wr1-f71.google.com with SMTP id o43-v6so1250024wrf.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k6PzykZi04mh7DFgvNFZOmZB/0H8YUQxLjGBxTVEXxc=;
        b=NZTN4CjegcX+1/hN+Ixu/mKfEodSpl/HeScOmdsTkQY4hInsDRQIy/K6+X0Kp1b3SD
         0nVj5fMKIEe6KfIFuRGz0nhb4vxrobKR8J0VpcMz3OVGsQWtYzgd9i9uZYBkzasmfl7n
         CfKOQcP7zlBfiS9ixXh6gLBu8LS0JxBhTwHy8tdlEzHN9frVwtvthciCkfz0AqkT/JbC
         JuUb5u1DYeOTY0oxZOYZ0GIJ+ErdLatkFXiWiidHyNGCL6961tNPx7/2w2RqeL23itAD
         XomdjKByldceNZjv3OlyZVj1vjhFjAXzoSq/X9LrwDqqPMGIa0dCo/IOEa3DfKEqVKdN
         IA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k6PzykZi04mh7DFgvNFZOmZB/0H8YUQxLjGBxTVEXxc=;
        b=lAVDrijNo55/OJ239UsKJ7H3saKw4Su9Qx1nbuwWsLuqZLjrIB+AC0BD7ozAHfBhhA
         aVWx7tRkv2b8vyOB3pLfGAiyosqblEH8kbnX4e1Veiq7YPm3UrWJNFzXp/eAc/z0bRv4
         VZC6j4u9vanSIHdPtqCUs6AMZMGGQ4bPQCtcKXO22QBT1s8o/bbypXlajbG0bKf6xPRI
         MfL/Ivh4mEBW2mazebsWpXReCFCy9tVuOLRENB7QOGSBJjn/6IG/0pawnzR76AkqCKH+
         WGqGhm8wEFFuTyBQYfr8jJ8jj+2wTZbS7GiEpzVpHGkynNHZvIS/ZM0MkhTu39GB6XAj
         WGtw==
X-Gm-Message-State: APzg51Asdn6xaiIZaF4LlvaCqtvXvFVTx1yBVZcognwe7ezDWPRZH6oO
        Pn5P8m0plqgb9THP1WHa6GPgL+V9aeq8L/ztDPhpol4F8lzUYyQxRNV3sWW0xd5qDnTmq+gW4eD
        1WNrpzlFOvj4ub9J/G+JmU78bsm7uT1zKay49em7j
X-Received: by 2002:a5d:674d:: with SMTP id l13-v6mr19532685wrw.197.1536001531696;
        Mon, 03 Sep 2018 12:05:31 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdY6nFLM4Darhw38vGC3+SJR+HqGdoqY/vJqkCuZwaQ4jBNGTgPL5E5kBFm0fmLu/WbNkL6qM7rPd2KTxHpaKuY=
X-Received: by 2002:a5d:674d:: with SMTP id l13-v6mr19532671wrw.197.1536001531475;
 Mon, 03 Sep 2018 12:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <1535887251-29515-1-git-send-email-stefan.wahren@i2se.com>
 <99ca4f6d-d2b2-36e7-9f27-189df379cfaf@roeck-us.net> <67224834.51159.1535905604770@email.1und1.de>
 <e8d4e69c-2668-2794-6474-79749bf8b577@roeck-us.net> <829194253.51526.1535908415057@email.1und1.de>
 <642d46f3-7c1d-2b97-5d49-8772c75be530@gmail.com> <698422655.399555.1536000906069@email.1und1.de>
In-Reply-To: <698422655.399555.1536000906069@email.1und1.de>
From:   Serge Schneider <serge@raspberrypi.org>
Date:   Mon, 3 Sep 2018 20:05:20 +0100
Message-ID: <CAJb4yHw-FFbiRFOWH+J8KtmT6=QGXAR6s7mszyyGTVJJzuEaKg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] hwmon: Add RPi PoE HAT fan driver
To:     stefan.wahren@i2se.com
Cc:     f.fainelli@gmail.com, linux@roeck-us.net, robh+dt@kernel.org,
        linux-rpi-kernel@lists.infradead.org, eric@anholt.net,
        mark.rutland@arm.com, bcm-kernel-feedback-list@broadcom.com,
        Phil Elwell <phil@raspberrypi.org>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-03_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 7:55 PM Stefan Wahren <stefan.wahren@i2se.com> wrote=
:
>
>
> > Florian Fainelli <f.fainelli@gmail.com> hat am 3. September 2018 um 20:=
31 geschrieben:
> >
> >
> >
> >
> > On 9/2/2018 10:13 AM, Stefan Wahren wrote:
> > > Hi Guenter,
> > >
> > >> Guenter Roeck <linux@roeck-us.net> hat am 2. September 2018 um 18:49=
 geschrieben:
> > >>
> > >>
> > >> On 09/02/2018 09:26 AM, Stefan Wahren wrote:
> > >>> Hi Guenter,
> > >>>
> > >>>> Guenter Roeck <linux@roeck-us.net> hat am 2. September 2018 um 16:=
23 geschrieben:
> > >>>>
> > >>>>
> > >>>> On 09/02/2018 04:20 AM, Stefan Wahren wrote:
> > >>>>> This series is an early stage of the hwmon driver for the fan on =
the
> > >>>>> Raspberry Pi Power over Ethernet HAT [1]. At the end this should =
use a
> > >>>>> Device Tree Overlay.
> > >>>>>
> > >>>>> Changes by Stefan based on [2]:
> > >>>>> - reformat the downstream patches for submission
> > >>>>> - drop reboot notification
> > >>>>> - fix remaining checkpatch issues
> > >>>>> - add COMPILE_TEST to Kconfig
> > >>>>>
> > >>>>> The driver is mostly copy & paste from pwm-fan, which isn't good.=
 Personally
> > >>>>> i see two options:
> > >>>>>
> > >>>>> 1) integrate the driver function into the pwm-fan driver (new com=
patible)
> > >>>>> 2) implement the core function as a PWM driver and use the pwm-fa=
n driver on top
> > >>>>>
> > >>>>
> > >>>> I don't really see the point of thise driver. Why not implement ei=
ther of those ?
> > >>>
> > >>> i'm not sure about your question. Since the fan is placed over the =
SoC, the fan should takes care of the SoC temperature. AFAIK the firmware s=
hould have exclusive access to the I2C. So why we need this mailbox interfa=
ce instead of a I2C driver.
> > >>>
> > >>
> > >> The driver sets pwm values. The pwm-fan driver sets pwm values. A pw=
m driver
> > >> sets pwm values. The pwm-fan driver uses a pwm driver to set pwm val=
ues.
> > >> You appear to be arguing that the pwm-fan driver for Rpi is differen=
t than
> > >> a pwm-fan driver for all other hardware and should _not_ use a pwm d=
river
> > >> to set pwm values.
> > >
> > > thanks for your explanation. Now i think i understand and sorry for t=
he confusion. We need a driver which translate the pwm values into the mail=
box properties. "My" RFC series is only a starting point (not intended for =
merge and not an option) for a discussion and i'm perfectly fine with 2).
> > > Both options would be feasible in general. I only wanted to know your=
 opinion before i start to implement one of them.
> >
> > Is not there a way to expose the PWM pins directly to the kernel instea=
d
> > of going through the firmware to do that for us? I am just asking
> > because sometimes this appears to be possible, guess not in this case?
>
> According to this blog entry (no schematics available so far) [1], this i=
s my understanding of the fan control:
>
> | Raspberry Pi 3B+               | PoE HAT               |
> ARM core -Mailbox-> VideoCore4 -I2C-> Atmel MCU -PWM-> FAN
>
> The only chance would be to bypass VC4 and talk to the Atmel microcontrol=
ler directly. But this would require a specification of the I2C protocol or=
 some time of reverse engineering.
>
> Maybe the foundation guys can say something about that?

That's spot on. The communication is done through the mailbox because
it's connected to the I2C periperal that's normally reserved for the
firmware.

The interface itself is very simple. Device address is 0x51. Register
0xF0 contains the current PWM value. 0xF1 contains the default PWM
value that's loaded on power-on.

>
>
> [1] - https://www.raspberrypi.org/blog/introducing-power-over-ethernet-po=
e-hat/
>
> > --
> > Florian
