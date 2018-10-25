Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC05C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200962083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtLcmTFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200962083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbeJYXEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:04:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44415 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJYXEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:04:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id q6-v6so9558919wrw.11;
        Thu, 25 Oct 2018 07:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WErQpG8wg1Wmtq6nHDyKzBNyscpt1Bdw9h5S8/O/kqE=;
        b=DtLcmTFhtfOSDHj/m/ugA7Uqzq/zh+naBNlqT2/OgHbPPAGsjad9wOrhbHc9P3UQWo
         UaNOIF6jTmht04ZZqSY80SZxU7YF9oow6cTbZETrnMbVBzSbDiG0hsoCeoKVFjwhbTrc
         Bapxj5pB0aLFbaLIlr0UTE6WfQ7wGpV9RlENHBiiMXYCIMVh9houW0uFWtyBi+MrD8gf
         tqghAUDRJUVG8t9AL2leTRjTuFuQTzyRpzijelOjqGY3Tb8OMChjynprcAXAAatBcAXO
         0R0a7Af9DD/lT0xhUbKZL1xwVvSU8eJHYK7T2s0u1p6N5gj+auKndJYSOgGy7V6YkZaI
         29gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WErQpG8wg1Wmtq6nHDyKzBNyscpt1Bdw9h5S8/O/kqE=;
        b=D+RVcRPO2J2bZvn5ROeThRO1IghICljK0fSyuAjo3OqiNB6zTASOfe+fWpao27nGQ4
         xEydj/8aCBqm5iss6Krsh3eUudLL6xu7SZhEaXFHVSOgyi54vDPEDEN20OZPWqLfUwRU
         RYgfkZlv3GCbcHApkkguRZ44btNsQhN3x+U+rJfLe792erj210Rw25gUDEAc6/H5dMXR
         khDJAmjwC8P4M8QjTcY72S2adNivBdtQiBDQoyHCsR1I9f+DxTq+xRWvumIpbtZ+L18i
         TssJeTe8xSs0G+dV0o/xFPexi7HgW0HGGo1MS1BPRVHRJq4kd/lCvgmRCftnKPeyZ9pU
         nc9g==
X-Gm-Message-State: AGRZ1gLY/mocBC5H9MlXUXzbp5VwKAwgg6UYCsvbHruG9WhsWaueC2BN
        mv6sexts2CzqZL5cdZN8mCg=
X-Google-Smtp-Source: AJdET5fkKGZBsAFG/px/flZUpq/W5r9dwdzdB+YIzHnA0UXqKmPNNMcG1/tR9HLYxTjVck0O6O47OA==
X-Received: by 2002:a5d:608e:: with SMTP id w14-v6mr2249219wrt.193.1540477903394;
        Thu, 25 Oct 2018 07:31:43 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id 64-v6sm9934952wrr.64.2018.10.25.07.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:31:42 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:31:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/8] clk: tegra20: Check whether direct PLLM sourcing
 is turned off for EMC
Message-ID: <20181025143141.GK21521@ulmo>
References: <20181021183052.32023-1-digetx@gmail.com>
 <20181021183052.32023-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z9t8O/5YJLB6LEUl"
Content-Disposition: inline
In-Reply-To: <20181021183052.32023-8-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z9t8O/5YJLB6LEUl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21, 2018 at 09:30:51PM +0300, Dmitry Osipenko wrote:
> Ensure that direct PLLM sourcing is turned off for EMC as we don't support
> that configuration in the clk driver.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/tegra/clk-tegra20.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied to for-4.21/clk, thanks.

Thierry

--Z9t8O/5YJLB6LEUl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvR080ACgkQ3SOs138+
s6FyqBAAgtHHN3T6xW1Y/Dr30FKTXDoDZ/+OfYWpm1EQkHr6G6NuQ/RolegyZPA2
Tm1B7qKy2zS1zXHHesd/B1juotJomXkBtJERZMfYMS9gYDfrCD5s+eScXWM+jsji
hoylAC0snye0liLZ6+N48Nyf60kFiTYIBQTRzxRGkddpJmVmFWE/xG/kPjItk9qM
oR0QftxAaPUi5LxOWEAxy4+7D6ZWWmdjJuqBc0s0nW+noNAk79xqCwdmvrZK7YyL
A+zh5MDmYBMDVqup51mAUom6O6cicRIiv2nOHmElYs2NI4t9d8dOgXboJi7p5gjA
IcFiN2s155e9egLUK3DJu5FSIpigy5ssEQQembH/Rq1MLG2PzY9zveDPW35DNNjk
cuc4qxb6PsO7sOApgbVsiN7vpEIhEcjNaLF1XagzaKsHBSFO0tBLt9LAGf3KwHQ5
ZR6ET5oLRMRJmMBSJxH7yzceyLIaVNd1D+TKHEWF61Y2iQptt6EBRv61X1gmHt85
EgPpCWUgmTS4FFIeLKF5BpktA/u4MofIGKqqYJXEGBKDbhS9WAYXkV0JJ2rwM0v8
zfSLrRXOYSRJTw5SA7I0167Z9UxpgcogpG3zXez8wA0I+yuGnL56vCtM2OFbWGCA
dPewRlRuYh/tMwehkhoRaQjr/IOarvcEEpDtmGVo5QsH5yhMNts=
=1zbT
-----END PGP SIGNATURE-----

--Z9t8O/5YJLB6LEUl--
