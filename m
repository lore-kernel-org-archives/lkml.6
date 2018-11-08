Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EFDC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9B120685
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYoiGRk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9B120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeKHWNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:13:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54621 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeKHWNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:13:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so1104157wma.4;
        Thu, 08 Nov 2018 04:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GKG8Cf7XOYQ3wbUuYxuaNmUAu5aF1+6GUjOeEnSlFJU=;
        b=sYoiGRk3bSovQBU72cX7moutpy0pGmUJc/SmNueThF+iFTfHjjCp7B67gQdRlLzhqz
         2SklaLrMecT7aPT3Eh8OPGSdki+O5NNtuj4asQNFowFWZooW1yIsyP5LLsZWdr/Ppia2
         eM7UyEo8qf+yU8Bnm/GIR1PjQUMCjXL6GILQe2z6oW9BvwN15D+xE3R9lnOt7cD4mK7x
         zVF4s25eeq7rA8jRAkk6sNLw2j4+c+GAHW/ws9a+vXtwDQelacVNJL5CJYn1+76nZOwA
         PU2XHa0wiKhFCcV6oow6vAsRlKsoysqIL6F1OKUI+NFlQ3i0Gp/02Hd992pSrtHL/VJa
         OFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GKG8Cf7XOYQ3wbUuYxuaNmUAu5aF1+6GUjOeEnSlFJU=;
        b=CRaFV6a2CheIu69btS3wemgjG9cSjqjrjtTX11qBeiRM0N0SJx3F4+WMymaxWyDq2f
         AfakgUGu7dtL1284Yqltfyi0nXGM5uXEpDIgFiD/4ITRg4Bqm2dVyclLsvNL+9FnldES
         H3mJADOhm9WRFaZnoCKA5N7q2y4qA49p6/ID9FD23uuG6TRyPbSCwcOHoAadpiY0LffO
         m10tBn5aFn5TgyjG3L5FSWZzoyYS6Vxezypt9ed6WDfnH6Bz5dbqmGptWBHmTJo3SqO2
         CezAirlQP+VDtXPbw6DJFwJDntVxhNNGkCaLMcpuT1p33pwEFHEr3APTrCT2TIePbXVk
         IMlA==
X-Gm-Message-State: AGRZ1gLMP8WWY9fXvnowJsTd509PePZVdWOGFtoXiBIRjQLTtL7TH973
        drmepxwMA3hQyjqRbHKM99M=
X-Google-Smtp-Source: AJdET5dK/le2VJeNJSuSTNR9NKj+b1n6mygrGT1QDGJ7ZjXDpt+HyU1c3E+YjVEVv7PV1GHuv3lApQ==
X-Received: by 2002:a1c:2387:: with SMTP id j129-v6mr1061053wmj.20.1541680681373;
        Thu, 08 Nov 2018 04:38:01 -0800 (PST)
Received: from localhost (p200300E41F201D007494A3C25E2F6EAF.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:7494:a3c2:5e2f:6eaf])
        by smtp.gmail.com with ESMTPSA id o9-v6sm4158488wra.42.2018.11.08.04.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 04:38:00 -0800 (PST)
Date:   Thu, 8 Nov 2018 13:37:59 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, edubezval@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] thermal: tegra: fix memory allocation
Message-ID: <20181108123759.GD1340@ulmo>
References: <1541410354-19090-1-git-send-email-wni@nvidia.com>
 <1541410354-19090-4-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <1541410354-19090-4-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 05:32:33PM +0800, Wei Ni wrote:
> Fix memory allocation to store the pointers to
> thermal_zone_device.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvkLicACgkQ3SOs138+
s6Elsw/5Aas+YpgirvdZ9IdbdolpHjvFwEAU5+cQ2nOUQvXW0loVcY76EtIB/OJr
rktUB0oZQxBk8M6Lhnkv01QozK48scohs25UrWX3SjUqRe/rDXIA1a+Q6O38PllB
oeLReEiMMlL7qxkrRaLuvgHWsJm9cbnFiKvVPxxv46fmADRHEgORAleHqMwV0HuN
XiopKVT4VQpCvLVGwYhaT7RmvPQMQih99a62QDYRdqxZ7LkDA7SVu6YaAjfjfd8/
Q3MurcL1sJHimXNaApcUJYXkuo8Gc8LR5CQxDt7KFyBqcCBbBB4wnY8T+BP5J8Mj
DG9ktJkuFj6/tHae2C6XiHrLQRLhCqiCpa2R2TSdfEayiuayQeppRwCzjZA0YpXr
y0L8FJV9+kqP6lsmA+reaNyFIJpLro9sCUCHl2Tgq1XR4N8AsPo9t8QNMGYhBT51
Qv6XQ5uUoiRE1hYDprgYX8QGn310jbmfHMNftyCs00m5imq/HAa5YG0jRQfZZYuM
GTxn6/OQl3VMdJiUsnP8rUaWmPsTtk+aHe57DCPKIuo/fA1RtSIJrmXW5NWbGpl2
FMfJCGp2I8LRwXD6VWKqVCseho91c7vF9o4Aa3dVLyFz6yjCerk8G94PqClfd0y+
/ZvctjOnfpUm0TLA87YmUhR7ps7i50HnaZGm5m4zgVU09A1vEaY=
=rsVD
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
