Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71786ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AC8208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="T0eBSrHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AC8208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbeGQHXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:23:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35966 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbeGQHXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:23:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id t3-v6so273227eds.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 23:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Y2VT96Dzb9KkvN2ETOR/Y98yd1w4rO12SUZR0So5veU=;
        b=T0eBSrHubFWq+AaNYLY/dlOl8NykPZgWrVk6OIfL3A9YV9Bzh0nhpAqN5respMsgZM
         RkyotZgmZAR/QyXCOB5rsmD4ka4FRHmK6yXXcEKv4qJUxpW3cG+FhrnD4FHsZbR6VXQ1
         SoYg46q2bYB0xRRfFi4VeTR6mwWBcPJo8+vqC1YykguWVOKyaBY1/RohN5/bXynDXNyQ
         dKaw29yZ3iGuHvaeHg38zqbWDl631nKd/ZuGGZktHfagt8or9qSzAYlbIEAEQwLtPTwT
         S4yZ806Vvbjw6is01G/EP1Vf7PPLsH/DmQYokXGrhsmWjsIoA/YkcYh1kpjaR2qUq4+b
         yh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Y2VT96Dzb9KkvN2ETOR/Y98yd1w4rO12SUZR0So5veU=;
        b=Sh581FgEVhNzTgnx5VJm1UsIkDuKN9LnA+0UmklburMzzXM3bUFPmYY2eVLQrLDBG2
         yiLjx8zLKqEM4p1cBnud0DQElPBC+Hl0B4HZYekLFBgF4l/G3DlIny4WysllCjghDhXk
         +doloTX/skiSkwk5qhnHhzNUE2LZU6oduF3JnavKm5rQdJ77GscS1Ulc7KNckx91OZSA
         93Oe4j4UVt0ljoSya+6tmx8wPbg0EvnvRqvuj/6vuGXZNQy6qvuWV6v32VShApvfoRx2
         KuEAw1xHHRTWWmD+J18UBHs1HrOQ0CP+55SclkelRDM8y7xUZdZkUdrdxTMk/B/WLHmk
         ioPg==
X-Gm-Message-State: AOUpUlHSbjWg+q8IuLcnBCJBK8AzYEInauTrelKCNt/G8YE26sU0Qb4J
        zV5tG5GN0RY9qeBqsnXa6vAbTA==
X-Google-Smtp-Source: AAOMgpeavX275XWBVe9HdxYrOFdIy9H/UT00h62WNEzyN+Dm3ULrbrTgEp0CVPIdn5Eu4bQ65PIVSQ==
X-Received: by 2002:aa7:da9a:: with SMTP id q26-v6mr958696eds.115.1531810351554;
        Mon, 16 Jul 2018 23:52:31 -0700 (PDT)
Received: from [172.20.0.85] ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id g8-v6sm187939edh.87.2018.07.16.23.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 23:52:31 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.15\))
Subject: Re: [PATCH v5 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board
 support
From:   Koen Kooi <koen@dominion.thruhere.net>
In-Reply-To: <20180717063631.GZ99251@atomide.com>
Date:   Tue, 17 Jul 2018 08:52:30 +0200
Cc:     linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <800297F2-B482-42B2-A9D3-A78184B2C1BA@dominion.thruhere.net>
References: <1531808688-9716-1-git-send-email-koen@dominion.thruhere.net>
 <1531808688-9716-3-git-send-email-koen@dominion.thruhere.net>
 <20180717063631.GZ99251@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3445.100.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Op 17 jul. 2018, om 08:36 heeft Tony Lindgren <tony@atomide.com> het =
volgende geschreven:
>=20
> * Koen Kooi <koen@dominion.thruhere.net> [180717 06:28]:
>> +&i2c0 {
>> +	lps331ap: barometer@5c {
>> +		compatible =3D "st,lps331ap-press";
>> +		st,drdy-int-pin =3D <1>;
>> +		reg =3D <0x5c>;
>> +		interrupt-parent =3D <&gpio1>;
>> +		interrupts =3D <26 IRQ_TYPE_EDGE_RISING>;
>> +	};
>> +
>> +	mpu6050: accelerometer@68 {
>> +		compatible =3D "invensense,mpu6050";
>> +		reg =3D <0x68>;
>> +		interrupt-parent =3D <&gpio0>;
>> +		interrupts =3D <2 IRQ_TYPE_EDGE_RISING>;
>> +		orientation =3D <0xff 0 0 0 1 0 0 0 0xff>;
>> +	};
>> +
>> +	usb2512b@2c {
>> +		compatible =3D "microchip,usb2512b";
>> +		reg =3D <0x2c>;
>> +		reset-gpios =3D <&gpio0 29 GPIO_ACTIVE_LOW>;
>> +		/* wifi on port 4 */
>> +	};
>> +};
>=20
> Thanks for updating it, should the last one be usb-hub@2c?

Yes, it should be. Never update patches halfway through your first =
morning coffee :) V6 coming up!

regards,

Koen=
