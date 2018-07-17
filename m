Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6200ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB84208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="vWZ6y8/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB84208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbeGQG5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:57:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38046 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbeGQG5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:57:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id t2-v6so219357edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 23:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uCSPetpzvxrt9KQUemtsobb5tIU35KL3xF/yRyEHVMg=;
        b=vWZ6y8/kenlokd+z5vyUmSxc45aMAA+D2R9BfugQCoz+P2A/gb60He2dKMNQopE/oH
         9iJy5gzLP2xEEFItaCiZS2+8W0WHCzAJgGGh6aZPAha/f3H8Ljlyq40ZtKqLzNfaQLr/
         1GGsN/MAryo7JzmODAZ7utW+TAz+A3hcxoijWv4iB99NL5wwNScpk39Rfnj+ZaSPmvK1
         VSajVxn2qoh7QDM+Z6r+ynzBttsNrDg6vthUVOBfVtecMH/stljGM/tj+pFBDqUvpHWm
         CRrk0oMImqTHv0i1L6gcVabLLkDwY1kD6EfGYVnaPbifLBlOz2Xftm2eboZsCAXfCHvo
         03Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uCSPetpzvxrt9KQUemtsobb5tIU35KL3xF/yRyEHVMg=;
        b=mVWCl+FwKekjal5P7wlGvLUUCFW4sidBwtw1fujZlgY+qqG2HxWcwM6zmeVemT1gtO
         q1gSW5C02lU1/lzJ8R1a46QTcbevKwhe9i2uel3kAlze5UevlN9bO4+E5K9/abTVVPii
         cCQebHi43PhBltWDsUo3s2T0xO9SHXXbkZkLd6bxChb8yna3Ewgjolwru1MfCTwO3fS7
         VuxB1fq+RQ1CfnTYougRZ6X+y7SQEODE0k7JqsEkbQroRDbugjrY/hdnyxU8TrvW+7Wc
         ahcW1IL2qky8a8sUwFv7IDncBsObP1o+usJU+rFR533Sx35Yr6iorUFsYbPA3d5Psc1M
         dWDw==
X-Gm-Message-State: AOUpUlGQEFE2hhPdZR5sawrUn7BDwuC4ylHlLObYBzmqW4Oers5jmVfF
        Tv1e+XgLMNQ0MpFFtHuZFPRVCQ==
X-Google-Smtp-Source: AAOMgpdrLEkSiHnP+POIXnSGnmiuaS7GYlnSgW0yir5SdA40n1Nop4YJrrnozTX8h25SIERbFMTTLg==
X-Received: by 2002:a50:8466:: with SMTP id 93-v6mr902113edp.304.1531808782820;
        Mon, 16 Jul 2018 23:26:22 -0700 (PDT)
Received: from [172.20.0.13] ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id s23-v6sm164259edm.74.2018.07.16.23.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 23:26:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.15\))
Subject: Re: [PATCH v4 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board
 support
From:   Koen Kooi <koen@dominion.thruhere.net>
In-Reply-To: <20180717061640.GX99251@atomide.com>
Date:   Tue, 17 Jul 2018 08:26:21 +0200
Cc:     linux-omap <linux-omap@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CF84BA0-DF94-4692-A76C-B7A5CE74A226@dominion.thruhere.net>
References: <1531463123-30340-1-git-send-email-koen@dominion.thruhere.net>
 <1531463123-30340-3-git-send-email-koen@dominion.thruhere.net>
 <20180717061640.GX99251@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3445.100.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Op 17 jul. 2018, om 08:16 heeft Tony Lindgren <tony@atomide.com> het =
volgende geschreven:
>=20
> Hi Koen,
>=20
> Just noticed there should be generic node names here too, see below.
>=20
> * Koen Kooi <koen@dominion.thruhere.net> [180713 06:28]:
>> The "Beaglebone Enhanced" by Sancloud is based on the Beaglebone =
Black,
>> but with the following differences:
>>=20
>> * Gigabit capable PHY
>> * Extra USB hub, optional i2c control
>> * lps3331ap barometer connected over i2c
>> * MPU6050 6 axis MEMS accelerometer/gyro connected over i2c
>> * 1GiB DDR3 RAM
>> * RTL8723 Wifi/Bluetooth connected over USB
>=20
>> +&i2c0 {
>> +	lps331ap: lps331ap@5C {
>> +		compatible =3D "st,lps331ap-press";
>> +		st,drdy-int-pin =3D <1>;
>> +		reg =3D <0x5C>;
>> +		interrupt-parent =3D <&gpio1>;
>> +		interrupts =3D <26 IRQ_TYPE_EDGE_RISING>;
>> +	};
>=20
> lps33lap: barometer@5c
>=20
>> +	mpu6050: mpu6050@68 {
>> +		compatible =3D "invensense,mpu6050";
>> +		reg =3D <0x68>;
>> +		interrupt-parent =3D <&gpio0>;
>> +		interrupts =3D <2 IRQ_TYPE_EDGE_RISING>;
>> +		orientation =3D <0xff 0 0 0 1 0 0 0 0xff>;
>> +	};
>=20
> mpu6050: accelerometer@2c
>=20
> And so on. Please check the lower case hex numbers too as
> that=E2=80=99s what Linux typically uses.

Thanks for the feedback! Fixed both issues, v5 sent out.=20

regards,

Koen

>=20
> Thanks,
>=20
> Tony

