Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0704DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F4820658
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pk4fSNac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F4820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeIEAJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:09:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40668 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIEAJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:09:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id j62-v6so4208795edd.7;
        Tue, 04 Sep 2018 12:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hfMxKwrRx8ggzaGxY9FLLkVh7vSxglqVuDZMjcZ7zRk=;
        b=pk4fSNackiCEeZitC8iHqgNCytMm5HdyJk+E49oXr+cEWH6PlWo0z0WqDAH6NUOIu0
         vMleilBma1AxweqoqdfcGW8z8qvyTBrcCMM7d5BpjHQkmOdFFQ+mNm2LSnzkLgxN8oa6
         Ws1yxF07hhrVjKIOflSlMkfUFOlEaoFhtsUK8eEYvV7qGhcasknoZkRNaUffAHy51LQC
         OjBJwgSjOVe7h2cCP8EZF6giWS7Hb7lpov8XEP7sulXSBOsh4BD8y+6LfKb0fD7mehcm
         nHtcZhQ0vni+VNFVjTzZ4ojFp/02sqMmentjxGxRn1RUrlXxnukWPapZN6IkxNO7paml
         IgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hfMxKwrRx8ggzaGxY9FLLkVh7vSxglqVuDZMjcZ7zRk=;
        b=MNtvesIFAyNnm8FQxM9aUOiGQVdpUsboUA+6m2T+2y15lwhH3wRvYklSA74vhEScFB
         yxzuUswvxQaRMl/2Rsep6+rgjcmbE3PiF8nghKeGgK4JYIGpMy8cLz4OKBEbrWPYqhd1
         Msp+vzsDt5eH43BWk9iSz5tjO+Kat5JLAXs6YKY71WYOg7YWSMCT6xxsddH/paez6Ink
         DAOG8JRlCKK9u9MbC3MjUGaDdfhy/oSRFgGey/KWmCKNEI/1Xse/dTTfPCRqSXQ7WPvH
         T6b5UKmYBy2KoM61sQx1C99Jy1wzLiD5hrTYW7d3zK2LCEJiMCJP7at+qeLtuzfZDJrV
         CYgw==
X-Gm-Message-State: APzg51BhlDAA45TpYGAotrlzpCIk/ReBK6sIejNmEjtgsf2osgKEIlvc
        WKDucd8XAy5Bxrtj5Ys0jdg=
X-Google-Smtp-Source: ANB0VdYjBIJ7tXTSc5LzD9WvGFJzS7VWm+ZbUcBOYou8OWORKsxc6AUTf6r7U/2U0eK2kHrTydZ+7A==
X-Received: by 2002:a50:9935:: with SMTP id k50-v6mr37420886edb.175.1536090157726;
        Tue, 04 Sep 2018 12:42:37 -0700 (PDT)
Received: from [127.0.0.1] ([138.68.75.163])
        by smtp.gmail.com with ESMTPSA id s41-v6sm21818edd.61.2018.09.04.12.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 12:42:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] ARM64: dts: meson-gxbb-wetek: add ttyAML1 uart for
 Bluetooth
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <CAFBinCAQFcYKRCr72vOtuB9x=Zdt4Ox=pY0E9oxZFCO2XKF7oQ@mail.gmail.com>
Date:   Tue, 4 Sep 2018 23:42:32 +0400
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, carlo@caione.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <84ED3B83-82E2-4ABE-AA03-9F4950EAF4A4@gmail.com>
References: <1536072290-28015-1-git-send-email-christianshewitt@gmail.com>
 <CAFBinCAQFcYKRCr72vOtuB9x=Zdt4Ox=pY0E9oxZFCO2XKF7oQ@mail.gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 4 Sep 2018, at 11:05 pm, Martin Blumenstingl =
<martin.blumenstingl@googlemail.com> wrote:
>=20
> Hi Christian,
>=20
> On Tue, Sep 4, 2018 at 4:47 PM chewitt <christianshewitt@gmail.com> =
wrote:
>>=20
>> This change adds the ttyAML1 uart used by the brmcfmac sdio module in
>> the WeTek Hub and WeTek Play 2 devices.
> do you know which Broadcom chip this is exactly?

It=E2=80=99s an AMPAK 6335 module. WiFi shows as BCM4339, BT shows as =
BCM4335(rev C0). I=E2=80=99ve submitted a patch to add the BT id =
earlier, see:
(https://marc.info/?l=3Dlinux-bluetooth&m=3D153608351032693&w=3D2)

> I assume you want to use the "patchram" userspace program (or
> something similar) to initialize the HCI controller?
> it's been a while since a similar patch was rejected, but things have
> gotten better since then. more details below
>=20
>> Signed-off-by: chewitt <christianshewitt@gmail.com>
>> ---
>> arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi =
b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
>> index 70325b2..9476868 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
>> @@ -10,6 +10,7 @@
>> / {
>>        aliases {
>>                serial0 =3D &uart_AO;
>> +               serial1 =3D &uart_A;
> this can be dropped if you read on
>=20
>>                ethernet0 =3D &ethmac;
>>        };
>>=20
>> @@ -239,6 +240,13 @@
>>        vqmmc-supply =3D <&vddio_boot>;
>> };
>>=20
>> +/* This is connected to the Bluetooth module: */
>> +&uart_A {
>> +       status =3D "okay";
>> +       pinctrl-0 =3D <&uart_a_pins>, <&uart_a_cts_rts_pins>;
>> +       pinctrl-names =3D "default";
> insert bluetooth child-node from [0] here (with the correct max-speed,
> *-gpios and clock* properties for this board)
>=20
> some background: with Rob's serdev framework some Bluetooth controller
> drivers recently gained the ability to get the controller into a
> working state without any userspace utility. if you add the bluetooth
> child-node here the kernel will:
> - not create a /dev/ttyAMLn
> - load the matching Bluetooth controller driver (the Broadcom one in =
your case)
> - do the "initialize this Bluetooth controller with all the vendor
> specific magic" dance (toggling GPIOs, loading firmware from userspace
> via standard request_firmware, etc.)
> - provide you with a ready-to-use hci0 interface

No problem, i=E2=80=99ve done that for another device. I=E2=80=99ll =
investigate.

>=20
> Regards
> Martin
>=20
>=20
> [0] =
https://elixir.bootlin.com/linux/v4.18/source/Documentation/devicetree/bin=
dings/net/broadcom-bluetooth.txt

