Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE85C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B11421523
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="CsShbP9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B11421523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeHLTQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 15:16:06 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36338 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbeHLTQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 15:16:05 -0400
Received: by mail-oi0-f67.google.com with SMTP id n21-v6so23531394oig.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 09:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8oI+CYFmGjJo0M0Y5LfMlTDO6BVd5dmNdV/p/lo0xag=;
        b=CsShbP9iMsFjrYz8/uQZJ7iHa7YCBCNYH54vpt7uAOBwQ8jTZe061qFAu5ZZ+O4hK/
         c+muPQCN77P+cIyr8TIWlAhY1D5hsA7PXgVTi6vsZ4xdMozdFsIyr/NmuiC5hKISGsjJ
         XadmqtmY/esNse+gWRiK2UCWLtkFXf6XAI8qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8oI+CYFmGjJo0M0Y5LfMlTDO6BVd5dmNdV/p/lo0xag=;
        b=cBzLn9Dv1wE9MoTgdnnTt0Pppm1T+FR5Vt9hgdiyPNrw3S6GI2UqeADBkvMdTfRvX0
         fw87A/exWl/Bmt8rXCKHQtHyN6WMiG7SanQyZUwlSGIKN3amQdvpRittSfshziOCQjoS
         4GD6AqoESKZlMljnW633CPyM5yVMdFsBERakIa8EuU8/PzzbH2tncONvUgwFKIXWdw6T
         PfJgb9aJ08nPz3T8I9oFKD/kIuy5wl36QZBelLrxXnPl4y6aJuMZarHWlFl77nGWhmyL
         XHGmROCaVInsL3MdS38LM/zuN2NQAh8q1mXJRgUogokv1axb7WsWXhqZw5OcjBfCTBhF
         NDfw==
X-Gm-Message-State: AOUpUlF8reMxQrfCVhxy4HX3+xbg1UX9RnjDBW+xWYO9jGAD85AvDIPr
        JHOSi3RmZjAoBsYWryu3edOpuA==
X-Google-Smtp-Source: AA+uWPwiM+5p88H9KMr2E7MZ8A1Qi4qrGM8c3Wq5RumrY2bsIWj3LgvdZuRyntXWLDf/Azk6mv7xqQ==
X-Received: by 2002:aca:c585:: with SMTP id v127-v6mr15833996oif.348.1534091849000;
        Sun, 12 Aug 2018 09:37:29 -0700 (PDT)
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id o125-v6sm30385953oig.44.2018.08.12.09.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 09:37:28 -0700 (PDT)
Received: by mail-oi0-f45.google.com with SMTP id j205-v6so23535377oib.4;
        Sun, 12 Aug 2018 09:37:27 -0700 (PDT)
X-Received: by 2002:aca:4d56:: with SMTP id a83-v6mr13821366oib.205.1534091847607;
 Sun, 12 Aug 2018 09:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180701110804.32415-1-afaerber@suse.de> <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de> <20180808213640.10a1d76f@alans-desktop>
 <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de> <20180809125939.39ac2cc9@alans-desktop>
 <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com> <20180810165711.59bf26f7@alans-desktop>
In-Reply-To: <20180810165711.59bf26f7@alans-desktop>
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date:   Mon, 13 Aug 2018 00:37:24 +0800
X-Gmail-Original-Message-ID: <CAC=mGzhaLiSj5-+euM-YTRLwNDi8QJY0fAbiZbUadkPhZGRh_Q@mail.gmail.com>
Message-ID: <CAC=mGzhaLiSj5-+euM-YTRLwNDi8QJY0fAbiZbUadkPhZGRh_Q@mail.gmail.com>
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org,
        "<linux-arm-kernel@lists.infradead.org\\" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?Q?Michael_R=C3=B6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?Q?Konstantin_B=C3=B6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>,
        "linux-kernel@vger.kernel.org>," <contact@snootlab.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        Alexander Graf <agraf@suse.de>,
        =?UTF-8?Q?Michal_Kube=C4=8Dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Pieter ROBYNS <pieter.robyns@uhasselt.be>,
        Hasnain Virk <Hasnain.Virk@arm.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Daniele Comel <dcomel@mipot.com>, shess@hessware.de,
        Xue Liu <liuxuenetmail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <gnomes@lxorguk.ukuu.org.uk> =E6=96=BC 2018=E5=B9=B48=E6=9C=8810=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:57=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> > Except saving power, mitigating the wireless signal conflict on the
> > air is one of the reasons.
>
> If the device level is always receiving when not transmitting it has no
> effect on this. The act of listening does not harm other traffic.

My friend had tested practically:
If he changes the LoRa interface to RX mode after TX completes
immediately, he will receive the signals like reflection echo some
times.
That is interesting!

There is a paper "Exploring LoRa and LoRaWAN A suitable protocol for
IoT weather stations?" by Kristoffer Olsson & Sveinn Finnsson
http://publications.lib.chalmers.se/records/fulltext/252610/252610.pdf
In chapter 3.2 Chirp Spread Spectrum, it describes the reflection echo
phenomenon.
I think that is why LoRaWAN places the RX delay time which avoids
receiving the reflection noise.

> > The sleep/idle/stop mitigate the unconcerned RF signals or messages.
>
> At the physical level it's irrelevant. If we are receiving then we might
> hear more things we later discard. It's not running on a tiny
> microcontroller so the extra CPU cycles are not going to kill us.

According different power resource, LoRaWAN defines Class A, B and C.
Class A is the basic and both Class B and C devices must also
implement the feature of Class A.
If the end device has sufficient power available, it can also
implement the Class C: Continuously listening end-device.
Here are the descriptions in LoRaWAN spec. for Class C:
- The Class C end-device will listen with RX2 windows parameters as
often as possible.
- The end-device listens on RX2 when it is not either (a) sending or
(b) receiving on RX1, according to Class A definition.
- 1. It will open a short window on RX2 parameters between the end of
the uplink transmission and the beginning of the RX1 reception window.
(*)
  2. It will switch to RX2 reception parameters as soon as the RX1
reception window is closed; the RX2 reception window will remain open
until the end-device has to send another message.

According to the LoRaWAN Regional Parameters, the DataRate (including
spreading factor and bandwidth) and frequency channel of RX1 and RX2
windows may be different.(*)

So, yes!  Class C opens the RX windows almost all the time, except the TX t=
ime.
And uses different channel to avoid the reflection noise (*).

However, Class C must also implements Class A and C is more complex than A.
I think starting from the simpler one and adding more features and
complexity in the future will be a better practice.

> > > How do you plan to deal with routing if you've got multiple devices ?
> >
> > For LoRaWAN, it is a star topology.
>
> No the question was much more how you plan to deal with it in the OS. If
> for example I want to open a LORA connection to something, then there
> needs to be a proper process to figure out where the target is and how to
> get traffic to them.
>
> I guess it's best phrased as
>
> - What does a struct sockaddr_lora look like

According to LoRaWAN spec, the Data Message only has the device's
DevAddr (the device's address in 4 bytes) field related to "address".
The device just sends the uplink Data Message through the interface
and does not know the destination.  Then, a LoRaWAN gateway receives
the uplink Data Message and forwards to the designated network server.
So, end device does not care about the destination.  It only knows
there is a gateway will forward its message to some where.
Therefore, only the DevAddr as the source address will be meaningful
for uplink Data Message.

> - How does the kernel decide which interface it goes out of (if any), and
>   if it loops back

There is the MAC Header in the Data Message which is one byte.
Bits 5 to 7 indicate which kind of type the message is.
000: Join Request
001: Join Accept
010: Unconfirmed Data Up
011: Unconfirmed Data Down
100: Confirmed Data Up
101: Confirmed Data Down
110: RFU
111: Proprietary

So, end device only accepts the types of downlink and the matched
DevAddr (the device's address) in downlink Data Message for RX.

> remembering we might only be talking to a hub, or we might even be a
> virtualized LORA interface where we are pretending to be some kind of
> sensor and feeding it back.
>
> Long term yes I think Alexander is right the inevitable fate of all
> networks is to become a link layer in order to transmit IP frames 8)

Yeah, maybe.  It will be easier for life.
But I have not seen the formal standard for that yet or I missed it.
If the standard appears, we can try to implement it.

Jian-Hong Pan
