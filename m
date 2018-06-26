Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D3BC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDAE26D80
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="GZhTzBdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDAE26D80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeFZQCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:02:45 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:40965 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeFZQCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:02:42 -0400
Received: by mail-ot0-f169.google.com with SMTP id d19-v6so19592762oti.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 09:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TH/0JR+gGfO3hdsAdV7iu25tdyjvztqA54yMTwy8Hr4=;
        b=GZhTzBdof8O/tv2u0FfDFVNSkZ6MDj/NrxGlCwwlaixB3NGXTlFj61UDh6tCnHIQdG
         i9/chUnRdECBCtZUDlIqUmoEAOLNXr5qzYMGCtehxdXyr+opADdSlmkWQWKiD+nTpw+N
         qj2dOf+m4yHzx3Sdvi1xZH74MDbRM17cP2cR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TH/0JR+gGfO3hdsAdV7iu25tdyjvztqA54yMTwy8Hr4=;
        b=t277S5kl0E1BJ+wA7KXNMA7wOW4DpF8UPtaomuhP8539XFYBybHxgTVutG00EzzhCV
         xcoQAaTqiqFD2uM78nwMnmmXAbG3u2wgTq6IXyZGOLdzsuCNtnpIi6amdxVhh/87qndK
         uGBp58T4SU9bEDMJXma7aV0bWDsCWQBWO7w6GfCEq5lKH0xN2vdfBkaTPVGn1P2UPex1
         ar/7ElSrf3fAOQVGQlKbRm8jhnC4gFrVn3RBU0e2k7OBGq5TEhT6Pj/9uwJ07qCPTJph
         gUQOiz0ECIy5MhDs6oVbPeI+KMAFNHpmkrTSk+dJX0brvPyTO9zE2EZTfXksvBTmgtQr
         WqmA==
X-Gm-Message-State: APt69E0cvxbCPI9FGTYJJDP5ECvUvSqqVsqUGqUFFj1ZUXzpzehJcq63
        7vUeSe1h6TIBJ3/5Jlwhq04Gyw==
X-Google-Smtp-Source: AAOMgpevo7zTU4Q7tQuag1FoXa/FATcIXvppljjRNSg1KbeMvC5th86L4zsvcB9U4ktJ4DnJlsSQ8A==
X-Received: by 2002:a9d:300d:: with SMTP id d13-v6mr1284446otc.103.1530028961020;
        Tue, 26 Jun 2018 09:02:41 -0700 (PDT)
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id h203-v6sm657218oib.23.2018.06.26.09.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 09:02:40 -0700 (PDT)
Received: by mail-oi0-f52.google.com with SMTP id n84-v6so8884483oib.9;
        Tue, 26 Jun 2018 09:02:39 -0700 (PDT)
X-Received: by 2002:aca:acd7:: with SMTP id v206-v6mr1235235oie.320.1530028959375;
 Tue, 26 Jun 2018 09:02:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:1141:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 09:02:38
 -0700 (PDT)
In-Reply-To: <5e6b2d6a-f413-7547-6c03-c41dff21453c@suse.de>
References: <CAC=mGzijVyqEG=DXH4v9WkD0kXR2WOJC4KBPzoT7g5wqVrPGXA@mail.gmail.com>
 <677E6987-24AE-4D7C-9BF2-6BE3F43212C7@holtmann.org> <CAC=mGzj-GNQ0Xz3PodDHyypNtFsOEfBdNBnNkysW2ZZ8Wwuijg@mail.gmail.com>
 <5e6b2d6a-f413-7547-6c03-c41dff21453c@suse.de>
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date:   Wed, 27 Jun 2018 00:02:38 +0800
X-Gmail-Original-Message-ID: <CAC=mGzhs-YVDWePHKJcJt7Ea8ercVjGc-ZUzY4C=VkRS-4xEHw@mail.gmail.com>
Message-ID: <CAC=mGzhs-YVDWePHKJcJt7Ea8ercVjGc-ZUzY4C=VkRS-4xEHw@mail.gmail.com>
Subject: Re: [RFC] net: Add new LoRaWAN subsystem
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

2018-06-24 23:49 GMT+08:00 Andreas F=C3=A4rber <afaerber@suse.de>:
> Hi Jian-Hong Pan,
>
> Am 13.05.2018 um 04:42 schrieb Jian-Hong Pan:
>> Hi Jiri and Marcel,
>>
>> 2018-05-11 23:39 GMT+08:00 Marcel Holtmann <marcel@holtmann.org>:
>>> Hi Jian-Hong,
>>>
>>>> A Low-Power Wide-Area Network (LPWAN) is a type of wireless
>>>> telecommunication wide area network designed to allow long range
>>>> communications at a low bit rate among things (connected objects), suc=
h
>>>> as sensors operated on a battery.  It can be used widely in IoT area.
>>>> LoRaWAN, which is one kind of implementation of LPWAN, is a medium
>>>> access control (MAC) layer protocol for managing communication between
>>>> LPWAN gateways and end-node devices, maintained by the LoRa Alliance.
>>>> LoRaWAN=E2=84=A2 Specification could be downloaded at:
>>>> https://lora-alliance.org/lorawan-for-developers
>>>>
>>>> However, LoRaWAN is not implemented in Linux kernel right now, so I am
>>>> trying to develop it.  Here is my repository:
>>>> https://github.com/starnight/LoRa/tree/lorawan-ndo/LoRaWAN
>>>>
>>>> Because it is a kind of network, the ideal usage in an user space
>>>> program should be like "socket(PF_LORAWAN, SOCK_DGRAM, 0)" and with
>>>> other socket APIs.  Therefore, the definitions like AF_LORAWAN,
>>>> PF_LORAWAN ..., must be listed in the header files of glibc.
>>>> For the driver in kernel space, the definitions also must be listed in
>>>> the corresponding Linux socket header files.
>>>> Especially, both are for the testing programs.
>>>>
>>>> Back to the mentioned "LoRaWAN is not implemented in Linux kernel now"=
.
>>>> Could or should we add the definitions into corresponding kernel heade=
r
>>>> files now, if LoRaWAN will be accepted as a subsystem in Linux?
>>>
>>> when you submit your LoRaWAN subsystem to netdev for review, include a =
patch that adds these new address family definitions. Just pick the next on=
e available. There will be no pre-allocation of numbers until your work has=
 been accepted upstream. Meaning, that the number might change if other add=
ress families get merged before yours. So you have to keep updating. glibc =
will eventually follow the number assigned by the kernel.
>>
>> Thanks for your guidance.  I will follow the steps.
>
> I have been working on a similar thing on and off since proposing it at
> FOSDEM 2017:

Wow!  Great!  I get new friends :)

> At https://github.com/afaerber/lora-modules you will find my proof of
> concept of PF_LORA with SOCK_DGRAM and stub drivers for various modules.
> My idea was to layer LoRaWAN on top of LoRa later.

We have the same idea here.

> The way I have developed this was to simply reuse numbers unused in our
> distro kernel and built my modules against the distro kernel, to avoid
> frequent reboots and full kernel builds.

I use the the AF_MAX number as AF_LORAWAN and the new AF_MAX will be
the old AF_MAX + 1
And so on ...

> Not having looked at your code yet, do you think our implementations are
> fairly independent at this point, or do you see conflicts apart from
> number allocation? Like, I am currently using lora0 as name - are you
> planning to use lorawan0 or rather something more generic like lpwan0?

The interface name I created is loraX, X will be 0, 1, 2 ...

4: lora0: <NOARP,UP,LOWER_UP> mtu 20 qdisc noqueue state UNKNOWN group
default qlen 1000
    link/[830] 01:02:03:04 brd ff:ff:ff:ff

> We might place your code in net/lora/lorawan/ and mine in net/lora/?

My implementation is:
LoRaWAN class module: net/lorawan/
LoRa device drivers: drivers/net/lorawan/sx127X ...

> More problematic would be the actual device drivers, where some devices
> would support both modes - some with soft MAC, others with full MAC. Do
> you have any ideas how to handle that in a sane way?

Let me guess!  You have the LoRa "chips" and "modules", am I correct?

If I am right, here is my opinion:
Most of the LoRa chips go with the SPI interface.  These are okay.

However, the LoRa modules go with their own protocols (like AT
commands) over the serial port.
The modules also are the combination of an MCU and a LoRa chip. Users
can flash the firmware of the MCU on their own directly.  I prefer having u=
ser
space applications deal with these modules, until there is a formal spec fo=
r
these kind of modules.

Regards,
Jian-Hong Pan

> Please keep me CC'ed on any follow-ups.
>
> Regards,
> Andreas
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=C3=BCrnberg)
