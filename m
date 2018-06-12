Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7B007C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDEA208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="HjOEDfWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDEA208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754069AbeFLKr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:47:59 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36195 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752665AbeFLKr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:47:57 -0400
Received: by mail-wr0-f195.google.com with SMTP id f16-v6so23565707wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=Db6D0XAanflAP71f7xhLlXHrFkjcI5Cytz4fAgdEAKQ=;
        b=HjOEDfWbfN7vjpgONuXnUNV5z0fhQUcB48kMqhldiEYzp4icgOdp7WVU7s6B6gM+Yv
         esKCcc1HroNMFp7QmphSLucJzsI83UK5cSXkfN3At45SyOCnqGQKfV6ZEFI/8+3SajAI
         3CIx83DAzqINLEIYMbYytoNZjkKcOOvUHVz+KwkDmrFD6ckaNeEQvpY5Jz6McXVgpKn3
         QembZqcRaW/mhkgHRItPL8SRoSdxasUjB8pCkDhoKszmpFNbmJlsWoyvkPvM5fQZb1ep
         UxOpRK0DBU6DIC/6tqKH2CGbOlrNMRwz5iWG1w5acpA7EgdxzSzH8WS+NdxboyIdeFAR
         WDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=Db6D0XAanflAP71f7xhLlXHrFkjcI5Cytz4fAgdEAKQ=;
        b=Q/Jka+KB+kOMjToZ6JAcj9YHWYr6vjhVTrmIK0a4clke5lD3s/kR0r6pGINfWs1gnq
         srjaN8+NxmnA7attWJeHvDDXTRWfUKB4I20UQ6tPqbTaG5fwHd/E/h60S1bAWyWLhEhH
         hRCWDn5lZ9vkomwRiwM8bvde21SVSIGsgvQgvzNt4QhrCuG33UYjmCS5jX1CQ03urhXG
         6MVrkMt/Lj0cxeoxuc5BOZCQnDxCgumfQ+GMbRdqZ8jOeyLJdtPiNn6Kf97dB0QMKRzk
         wsgur7xWaVmAv7nkwC2zMTAJb5244827jSAzFAuOeuWKehhibEZe7Ul+IQfA/23MYvq3
         rx4A==
X-Gm-Message-State: APt69E0Ngc1xX7NiCJxjZNgb0pr36odfBrD9Sf7chORoOBXqr8HtD1qU
        9OMATBjk/BS2e1rdjeCFoiqa8g==
X-Google-Smtp-Source: ADUXVKK/CMjAXlyLGHb6oSCJfJIWf8nwPHVtGpfP3SqNUKSfkFo5mHoGbLehV6WnCkisSbt+0dKiCw==
X-Received: by 2002:adf:8e89:: with SMTP id q9-v6mr2232944wrb.269.1528800475746;
        Tue, 12 Jun 2018 03:47:55 -0700 (PDT)
Received: from [66.102.1.108] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id i76-v6sm227965wmd.20.2018.06.12.03.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 03:47:54 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] microblaze: heartbeat: fix missing prom.h include
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>
References: <20180611145836.21128-1-robh@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <c924d227-38aa-bc92-b47b-d59bdcc6639c@monstr.eu>
Date:   Tue, 12 Jun 2018 12:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611145836.21128-1-robh@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="riZbeZqGdQUSN4A43K0fm52ksrrnYEiIz"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--riZbeZqGdQUSN4A43K0fm52ksrrnYEiIz
Content-Type: multipart/mixed; boundary="7b7147pK8FsL9iYxqu7Ge90HKzSzXd12a";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>
Message-ID: <c924d227-38aa-bc92-b47b-d59bdcc6639c@monstr.eu>
Subject: Re: [PATCH] microblaze: heartbeat: fix missing prom.h include
References: <20180611145836.21128-1-robh@kernel.org>
In-Reply-To: <20180611145836.21128-1-robh@kernel.org>

--7b7147pK8FsL9iYxqu7Ge90HKzSzXd12a
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.6.2018 16:58, Rob Herring wrote:
> Since commit 96f0e6fcc9ad ("microblaze: remove redundant early_printk
> support") prom.h was removed and one instance in heartbeat.c remained.
> Include of.h as it is the actual header needed.
>=20
> Fixes: 96f0e6fcc9ad ("microblaze: remove redundant early_printk support=
")
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/microblaze/kernel/heartbeat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/microblaze/kernel/heartbeat.c b/arch/microblaze/kerne=
l/heartbeat.c
> index 2022130139d2..87aa942eee8c 100644
> --- a/arch/microblaze/kernel/heartbeat.c
> +++ b/arch/microblaze/kernel/heartbeat.c
> @@ -11,10 +11,10 @@
>  #include <linux/sched.h>
>  #include <linux/sched/loadavg.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
> =20
>  #include <asm/setup.h>
>  #include <asm/page.h>
> -#include <asm/prom.h>
> =20
>  static unsigned int base_addr;
> =20
>=20

Applied before heartbeat removal patch I sent yesterday.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--7b7147pK8FsL9iYxqu7Ge90HKzSzXd12a--

--riZbeZqGdQUSN4A43K0fm52ksrrnYEiIz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlsfpNUACgkQykllyylKDCGXiACeNiWsxxSNorYUpJGrEIS5tfJ5
z1gAn2mFntd5WpVgftG6QY/NwDrZLZEV
=YWPI
-----END PGP SIGNATURE-----

--riZbeZqGdQUSN4A43K0fm52ksrrnYEiIz--
