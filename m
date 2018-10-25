Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0C1ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3502085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjGJPcor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3502085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbeJYXBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:01:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39966 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbeJYXBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:01:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id b203-v6so1740855wme.5;
        Thu, 25 Oct 2018 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PA2vwiYnUJsibpeT5HhJG+V8BQSz02UWwYTlq/UYqcg=;
        b=qjGJPcorsL4TOeVbHhwqEfzd5aybN21PlwER2eMuIwcOgFWlUaYfIrqPiNxzjANSgB
         4S4MXPsPuknShVF9SseWkeiVTYmp730NZ99mJ0Zj/kVF80AvVpaivWB89UobyqWmU1ZE
         mhOBC2Vj7BFOm8NEzaYXhxQOu96EEVdxVPEyVhVU9UzZXp5czA2gooVLbYdflZXj85kA
         vCDDwOxXLG9APsEvNZ++CqU737sMdd7MA3KTDycVxGLIwMZmEiQ923y5kc6T5iAlGsV+
         RLlCHI5JHzeVwobSiIQWyWsuBDcA4UXL72JXcF5lFl2BqetqF5eBX2kLTDGU3PR7l1BN
         UW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PA2vwiYnUJsibpeT5HhJG+V8BQSz02UWwYTlq/UYqcg=;
        b=kwJu8HqLWFJNoS3+Bn0Z2oWceacIjv319o9ViJ064PLRgdTYZ6MUqE9LyrJSRldq76
         Md8UiN2y2bUM6KmP30lQFDTHsZBAQ0Z8X03OtzycA/4WL6hFnz5RIfXiPc84Sw90z4Ko
         4tV+j2+YxgK4GfRZpP9te9ShflxYzwtg4p2oUyVHDPc0p7UJEA76dJ0eTlI6kUUQD04V
         LGHl/2Bsh4RsHy/jFw5ahUwOJoTar4H88wkhEo9pb2zt750HJdmvX62n0SmB5KXHNgX8
         EC4GnFakTVY5sOO8hakwgg+oFm+KS+UCClexnPMi4j518Xj1YNXBPMoJe0wK6v+FRsya
         7UCw==
X-Gm-Message-State: AGRZ1gLykqKQ3hUejkFzHV5xRU4OFCYF165ocaghCKZY68Vwin1dv27s
        onNzX6ghPIcOJ1diVmAVppYYyPNn
X-Google-Smtp-Source: AJdET5ehpCQmUdcSk0VXIPo8QG4YO4V1qWlX3TRKzOEq0a4oJmidOJacl5ouLNsGvs/ywrQeVGdBSw==
X-Received: by 2002:a1c:9b91:: with SMTP id d139-v6mr2280594wme.62.1540477687728;
        Thu, 25 Oct 2018 07:28:07 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id 60-v6sm4686461wra.35.2018.10.25.07.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:28:06 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:28:06 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/8] ARM: dts: tegra20: Add interrupt entry to
 External Memory Controller
Message-ID: <20181025142806.GG21521@ulmo>
References: <20181021183052.32023-1-digetx@gmail.com>
 <20181021183052.32023-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j2AXaZ4YhVcLc+PQ"
Content-Disposition: inline
In-Reply-To: <20181021183052.32023-5-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j2AXaZ4YhVcLc+PQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21, 2018 at 09:30:48PM +0300, Dmitry Osipenko wrote:
> Add interrupt entry into the EMC DT node.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra20.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-4.21/arm/dt, thanks.

Thierry

--j2AXaZ4YhVcLc+PQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvR0vUACgkQ3SOs138+
s6GuaBAArDmbIU/du2PiKJA+bN1ZLV5oNlAZGZ4tA2AdbquIiYpfnu+ptiAkQ6di
pcEhyq8h4cz68/hMMuMP/Qz7fb21aX21F5fSWMN9dM36A5zwuJCpY5Uxe2stA+tm
I3hF34A082bk+Xcc+59iOxODLBGi4rN8ecBsbggN7/jZ/YkX7jY21j1YWwwcl+Y3
rlWhz/jiAmFjZELgUeiovNzDVCDa+AoHQSa/40nvVfsXQCg816rkzbBkTa5cJJR8
RWO1cUHrU9shS1hcwYZ0/N/LLm0xzffUks8vHxKKoLMclnP4BzcQnHxTzToF3f8p
aawImNi58trs5EqQ3lmGQD9G1JsA2Q4FnlJGVbvGWc2rQTZma3sVvgTcw4R1ts2j
8UqxExaSt3frrzaqWzgy7AJlS249hUvjqS/n0Y4loxLxk80wKk4eEBHJwepFzPNt
/mz9YF79GNQMCcgvKrgLOfsh6i/L3nCItjbRfK2Rrz69SlXeroeO4fJgrFNkM1Ml
UUhZ3KBNm3aXM0FLbGxCMfwbimbEvJSB76YhSC2J1u06xzyiwOsB8P9V80RKN7Oz
D5Zr4UyRZAWh8ShjbX9K4Go8JJLq28sBHbUs28ZB72j5g38+sMLkoDNxp/jy27ud
WGqgbfWOjR0rVKWv4q8HB/KO0i4KULbHjI9rh9bIdAXBrmaZQ7w=
=oNKl
-----END PGP SIGNATURE-----

--j2AXaZ4YhVcLc+PQ--
