Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D964C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD192070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0Z0zz8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbfAIObL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:31:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46951 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730380AbfAIObK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:31:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id y14so5760870lfg.13;
        Wed, 09 Jan 2019 06:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kuRc1byMVfVvYAQSmiN0h3OtipOlQk0WsxsJ7A6MPuI=;
        b=g0Z0zz8xa9oDo0mjfvt1dUTlQzcDVLhqpB7hOX+W1u32+4T2FS9v/nJeUCNXvXbFxf
         inhUeRiJmSXlxTBmlFFTncHRtUngzLs3nvfznrJptWjJbfN80CL9uWJ/OfgZJl1/RS92
         NQo5UMVLqf94Ok2nxnmTkjR8hkPo8Sk4diwFGguWnPCDt5t6reVAxNaxNMeSltUoO9Kk
         vPGD4vhvtnMLsmAgDXEKk/bcRMdfT6Jz7Le7aQZ0t8W1KD3OUgA3/cpC0hTVVfX+re6H
         vefgjz2EW/viVJXHpR2lfFnDQfSfoJnuzFpmmZVDJSmf7MTLu5N84KetsCYeNbo5PR1W
         4pNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kuRc1byMVfVvYAQSmiN0h3OtipOlQk0WsxsJ7A6MPuI=;
        b=dPW1/NespzaNO+u9HDjUI29VYQ254phTzTi70B74wqni38ZVIfw4ncXhXFSF0v9TCG
         4XlviU4HFRMjWyKYzF61UtLt0fOBsvfVtgBPNY0uu+KGBXsrvcnnD7UWaqYxrR4K3Y3s
         APyCuNwv7Va5GeTzk4H1rBZ6k/oYgghqnFiQO2/ac5nlehg7wMWT/BlZwBfYr6uAaCJs
         DByxFCUEeWZ/Z++jBXsF603A3k3gFUfS+rqewLqEOuxvPYPOaaFXiX0rOLVTSUwE6TFu
         SOG6L7JIXUHcZzor055Km6P3IfpAHGnJRi0LKbi+sU/Zph7Cu5vpRCQGc2WRvVKgpWBZ
         tvKg==
X-Gm-Message-State: AJcUukfFbu8/R33bdCfsxsjHxzexszjsL4pL8LxcNiHKQutwQOiktDS1
        +x6w9uitW7QCpKw6U7xxZUs=
X-Google-Smtp-Source: ALg8bN6EhaBj6aNB7S/H0Fg/oAyB7pzLg450eevrpw+jQVhMe4d7grezXYVPDnwY4C2UBqUrhU0g7w==
X-Received: by 2002:a19:945b:: with SMTP id w88mr3416873lfd.15.1547044268297;
        Wed, 09 Jan 2019 06:31:08 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:c1c3:bc43:64cd:2432])
        by smtp.gmail.com with ESMTPSA id g15sm13540758lfb.1.2019.01.09.06.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 06:31:07 -0800 (PST)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH] ARM: dts: s5pv210: Fix onenand's unit address format warning
Date:   Wed, 09 Jan 2019 15:31:06 +0100
Message-ID: <2629067.mKC4sQJUgE@acerlaptop>
In-Reply-To: <1547041383-16924-1-git-send-email-krzk@kernel.org>
References: <1547041383-16924-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia =C5=9Broda, 9 stycznia 2019 14:43:03 CET Krzysztof Kozlowski pisze:
> According to Devicetree specification, the unit-address must match the
> first address specified in the reg property of the node.  Fix the DTC
> warning onenand node:
>=20
>     arch/arm/boot/dts/s5pv210.dtsi:81.29-93.5:
>         Warning (simple_bus_reg): /soc/onenand@b0000000: simple-bus unit =
address format error, expected "b0600000"
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> ---
>=20
> The remaining warning is wrong clock-controller subnode of fimc camera.
>     arch/arm/boot/dts/s5pv210.dtsi:578.32-580.6: Warning (simple_bus_reg)=
: /soc/camera/clock-controller: missing or empty reg/ranges property
> The subnode in my understanding does not follow bindings and the driver.
> The driver with current s5pv210.dtsi will not register a clock provider..=
=2E but
> I do not have a device to confirm this.
> ---
>  arch/arm/boot/dts/s5pv210.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.d=
tsi
> index cc22c9db80d2..26ea5c66d8ce 100644
> --- a/arch/arm/boot/dts/s5pv210.dtsi
> +++ b/arch/arm/boot/dts/s5pv210.dtsi
> @@ -78,7 +78,7 @@
>  			};
>  		};
> =20
> -		onenand: onenand@b0000000 {
> +		onenand: onenand@b0600000 {
>  			compatible =3D "samsung,s5pv210-onenand";
>  			reg =3D <0xb0600000 0x2000>,
>  				<0xb0000000 0x20000>,
>=20
Checked on Samsung Galaxy S (with local, not yet submited patches for devic=
etree support for onenand, which is missing in mainline) and it looks ok (d=
evice probed, was able to use ubi tools).
Tested-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>



