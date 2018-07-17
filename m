Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3431FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D850620858
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="ZDCpW6Xi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D850620858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbeGQPNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:13:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55207 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbeGQPNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:13:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so1770238wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=nA2iznopCjFdlLv8dqs/g3O3xKgoxRNxzVc0JmokCcI=;
        b=ZDCpW6XiCxH0gr2DpPmQulKSsrf7tJwWoH+5pMADV/lFndgu0HEN71n9L+vhKFHhJI
         0fFvCfa8PBi0cgk1ScKxLVDYll31Emp8icQkyRlgJsXO++qhwL0T/Wcg6UxM/bsViRfJ
         ST9dSrMbJ5XdrEiWybEqGpzpY1Kp5grTDGkEMhg0VGgnqm3OURTEquA3QmaE57MVvq9K
         P/f/3sRm8fbGg0YilKIexNjNXZfPcWw/g+vxjKVnSwk7QOccKqRxwXqb9edPd/MSuwxf
         aV1mj8J5xYFepoumWBLQyuFB935hxNzNFeHsaPJgJ0WylPjlF3Pjke1O+wdOFMuObEyx
         qMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=nA2iznopCjFdlLv8dqs/g3O3xKgoxRNxzVc0JmokCcI=;
        b=UdCzQPZoZIpWapy1+KOI7z8Djwd9n7FrL6byr3uGw9sASJanZwBhZP6PG0N8TJx+q4
         LknEg1rpAG1gXy3Kpaq81YNXYmRA088vi3cgBlvRugY5BzS2DAXR9dn+S0hAylT5D9jU
         CSdQwtzfiQ+bh+7GwKabDFg7g3cmBEvQhgcsp7hbodSB0eStpjo4c/zE8NCz3nqmoeCV
         UbGTPFvOH59pS/QANBOyswjJPjSstS9Cy/wxMFSmKjUTsvvLhhRCgerxijuD/4wL10qj
         ijV4LfohCG8emqjqOSONjvZ3xy79S4ctOspcsZVC0/VxMdtJlAdS/yVx3B0YaXscuEUB
         vgsw==
X-Gm-Message-State: AOUpUlEUnrP0q5z3WkZf0LjGuBV0kgVJoPXMUqEkasLkRat/t5yFV7XN
        YI7hjeGh1bTAb2gYiZp+mgzO8w==
X-Google-Smtp-Source: AAOMgpdIl+mLC4erxX689USmQPaN990EcpAoBaLCSDD+oZK4zKovY4dNQVVxLU3OBJDS4ZH2IQhNGg==
X-Received: by 2002:a1c:7d58:: with SMTP id y85-v6mr1510859wmc.91.1531838430192;
        Tue, 17 Jul 2018 07:40:30 -0700 (PDT)
Received: from [173.194.76.109] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id q1-v6sm1845151wrw.42.2018.07.17.07.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 07:40:29 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] arm64: zynqmp: Use serdev for zcu100 BT
To:     Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <0ce3b4f588f1d9a83cfe99b93af3514f4d893273.1523452571.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <9e8bdff9-8239-56ea-8ede-472bb47baacd@monstr.eu>
Date:   Tue, 17 Jul 2018 16:40:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0ce3b4f588f1d9a83cfe99b93af3514f4d893273.1523452571.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="zMmpjYsj3gX0iHWT1XoIteXxD99uthBdL"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zMmpjYsj3gX0iHWT1XoIteXxD99uthBdL
Content-Type: multipart/mixed; boundary="wHVQIfImkgc6Tv4iVZTxwbvCmzhAo6xJe";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org
Message-ID: <9e8bdff9-8239-56ea-8ede-472bb47baacd@monstr.eu>
Subject: Re: [PATCH] arm64: zynqmp: Use serdev for zcu100 BT
References: <0ce3b4f588f1d9a83cfe99b93af3514f4d893273.1523452571.git.michal.simek@xilinx.com>
In-Reply-To: <0ce3b4f588f1d9a83cfe99b93af3514f4d893273.1523452571.git.michal.simek@xilinx.com>

--wHVQIfImkgc6Tv4iVZTxwbvCmzhAo6xJe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.4.2018 15:16, Michal Simek wrote:
> Mainline started to use serdev interface for uart attached devices.
> Change description to reflect it.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/a=
rm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index 3e862a9faf26..c7f713c8e69e 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -89,12 +89,6 @@
>  			gpios =3D <&gpio 25 GPIO_ACTIVE_HIGH>;
>  			default-state =3D "on";
>  		};
> -
> -		bt_power {
> -			label =3D "bt_power";
> -			gpios =3D <&gpio 8 GPIO_ACTIVE_HIGH>;
> -			default-state =3D "on";
> -		};
>  	};
> =20
>  	wmmcsdio_fixed: fixedregulator-mmcsdio {
> @@ -267,6 +261,10 @@
> =20
>  &uart0 {
>  	status =3D "okay";
> +	bluetooth {
> +		compatible =3D "ti,wl1831-st";
> +		enable-gpios =3D <&gpio 8 GPIO_ACTIVE_HIGH>;
> +	};
>  };
> =20
>  &uart1 {
>=20

Applied.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--wHVQIfImkgc6Tv4iVZTxwbvCmzhAo6xJe--

--zMmpjYsj3gX0iHWT1XoIteXxD99uthBdL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAltN/9YACgkQykllyylKDCGQSgCfQfqmmsBaP7q3On0LJivHZyex
pNYAn1sGPL1lCMM21pu7/MYWIvP5OTut
=zWFi
-----END PGP SIGNATURE-----

--zMmpjYsj3gX0iHWT1XoIteXxD99uthBdL--
