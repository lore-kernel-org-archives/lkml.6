Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01227C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF9420850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="bTZ1PuyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF9420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeLEQlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:41:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53350 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeLEQlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:41:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so13901037wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 08:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=t+ERgg1eaXTOvL5+/CW0FYWcnkQTv0amFM+Fl+3L5lY=;
        b=bTZ1PuyIEars8s6JsZlDa2fPUrterySMr5HC/5XF78LRKmFM0XNdaJNeyrapviMB8p
         Gmf/JbLE5QP4qEy7JNisdDPKJocYilsOnNHybm0zaNikGJ8D4Gb+dKP3LaLAp/tMuoKg
         Ni7DBIoEvJx03P3vLPQBRpluNJi+5sOJVJ1V19xzyNUzXdGBfeUjBaeGGbKLLPV8Zz5z
         l3xPu4E+Be53eIRzzmOuJDu+yQOBV8sn4i5gEMYh18u07G5WE9Bd1wZntQOgnqfBkN+u
         ChstHKc2s89/1Tg/ufzbb+r65GDO4VnQm/o2MNi+qxcnHhGDgWG4gu3PJD28jmbBk6+O
         09BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=t+ERgg1eaXTOvL5+/CW0FYWcnkQTv0amFM+Fl+3L5lY=;
        b=I3fDU5fg0t8JXBIkHTPAQHSyPmu/hO2akVbPXalMkSAqoh/XQLRwiKQO5Z/1/NZm3c
         tPpTghThM8+kopnCg/kfep7RKIXTwI3IYSpFnjWpIRv0T8Pv8PMpfvcWXZ8rzVps3AG0
         D+gZCTqHwL96WMn8SgTknOwhUBWFIhpy4avbMN5YoopzclgXKtlstTjZMrMTIWto29DZ
         kRkHYIzNOOBdCerLg+c4Jfl1IOEHTBcYSUbHa9wGe7DXUKkZC1cRRZlh53u/FLL36/Ru
         gDOL9Mh9Z1FyCp+vpOLhVjrWfWDBMaWJvZmzwM8BTb/Kc3hHJ7o/5ucdh64lV7D0tl/F
         6PFA==
X-Gm-Message-State: AA+aEWbtpuoyoZsKI5unFdg5FQZRQn2Ii5FMM5ltlVkGlttSb67GpBjc
        KNrlyyfHwfqYObm+9UbTgW57fg==
X-Google-Smtp-Source: AFSGD/USBcuZD0Tyg2nUHTmL6eTOJrZnwV6r68TLqqC2D+h6px2QOy9j2wV960Q0V+TW3rNAFtpQSw==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr17319304wmc.116.1544028068331;
        Wed, 05 Dec 2018 08:41:08 -0800 (PST)
Received: from [173.194.76.108] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id v1sm23454177wrw.90.2018.12.05.08.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 08:41:07 -0800 (PST)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 0/7] microblaze: fix various problems in building boot
 images
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <dd726c23-7c37-2b38-5b9f-a4edc391511d@monstr.eu>
Date:   Wed, 5 Dec 2018 17:41:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="svNOVL13q6FxCdhSHHW6hgLU8MdLu4uy6"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--svNOVL13q6FxCdhSHHW6hgLU8MdLu4uy6
Content-Type: multipart/mixed; boundary="MSVYFBXQIqseltohcSuoSjzf0VJrIOtDM";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Message-ID: <dd726c23-7c37-2b38-5b9f-a4edc391511d@monstr.eu>
Subject: Re: [PATCH 0/7] microblaze: fix various problems in building boot
 images
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>

--MSVYFBXQIqseltohcSuoSjzf0VJrIOtDM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03. 12. 18 8:50, Masahiro Yamada wrote:
> This patch set fixes various issues in microblaze Makefiles.
>=20
> BTW, "simpleImage.<dt>" works like a phony target to generate the
> following four images, where the first three are just aliases.
>=20
>  - arch/microblaze/boot/simpleImage.<dt>:
>          identical to arch/microblaze/boot/linux.bin

It is not - fdt section should be empty.
simpleImage has this section filled.

>=20
>  - arch/microblaze/boot/simpleImage.<dt>.unstrip:
>          identical to vmlinux

The same here with filled section.

>=20
>  - arch/microblaze/boot/simpleImage.<dt>.ub:
>          identical to arch/microblaze/boot/linux.bin.ub

as above.

>=20
>  - arch/microblaze/boot/simpleImage.<dt>.strip:
>          stripped vmlinux

And this is there because unstrip version is quite huge and for early
issues you need to know only some symbols that's why debugger is not
overflow with stuff which none needs.
Maybe this is not an issue now but that strip version is used a lot.


>=20
> I am not sure how much useful those copies are,
> but, I tried my best to keep the same behavior.
>=20
> IMHO, I guess DTB=3D<dt> would be more sensible,
> but it is up to Michal.

What do you mean by this exactly?

Definitely thanks for looking at this.
Michal



--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--MSVYFBXQIqseltohcSuoSjzf0VJrIOtDM--

--svNOVL13q6FxCdhSHHW6hgLU8MdLu4uy6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlwH/54ACgkQykllyylKDCEAqgCfR9/DxCsXl6NlRGgU9JZ31euK
5zoAn17ir1wuoX67oPoeL52wjTf5mTXt
=jAbi
-----END PGP SIGNATURE-----

--svNOVL13q6FxCdhSHHW6hgLU8MdLu4uy6--
