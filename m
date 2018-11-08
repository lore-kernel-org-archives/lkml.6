Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3534C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773D320827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epA3kKF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773D320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeKHWXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:23:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52521 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeKHWXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:23:54 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so1133379wmb.2;
        Thu, 08 Nov 2018 04:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F3gm0NlI50w7dtXTnr8YUydkUWn8YlB45N6wO1n6b5g=;
        b=epA3kKF7lkd8zwnjjAjWOhVlT4GgHX9te40c77QDSc4lGPtoY9Qd+vG/dHN7lQSpL8
         8qLHKD+BhjGyjEFe7yiGaH4qPBYhXFObRMS1kbcUJEWAMWLndPGXwrxsPP9bjgZXdbVo
         XyhH9od7GfR5nOdPZK0EYw6MI7zpKeIZqPXsURflSW3Qu2RoSclSyo3JRR5JMOkXAiP0
         PJBdSbcl9LlPzsK/7oltlPRBBYR+NkSmRofed/ApXm8aV5e9iZjCoMhQTOGl5mElJKKh
         6Mkve0ENbj8tHJrpmpC8pSLoU+e/7ROF3u6fcD5my7XjVEjjqxcyZTzB7wktQZFWQAzZ
         13mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F3gm0NlI50w7dtXTnr8YUydkUWn8YlB45N6wO1n6b5g=;
        b=hm6OsNFklfpJV0Kv0qxONFxIRaHYHB6Lan0fwiM+dx9jtabI4HrDLxZXNvPFyCRuv5
         lKQbnrNy5vGj4K1kDkzDbgev2Ss2WjVgtX6WsHkrqFPqrLiG8GDJECGwloExDlhn5Eke
         oZlf96TjkHgDKWt6QSoRxlDrjEs7Qi+JBiWdwotSodi6UbuZvLAFO/RmEDTLDzT6tCkc
         0/ZGmBc0BAXtYp75MesNreO2S8x0RkDXmP7CKfcpMgVXonPtW7SnT+9+XrDE6h8tNnq9
         Ak0t2bG8QmV+O4Kyqj7jSoa/7AqlMmT9yPVWGCAdYwUVgh1CTdhUqt9YKUm2VLK7InHy
         I0XA==
X-Gm-Message-State: AGRZ1gIrzix3PwYDl+c9LMfFbaU8ce3WuaOFDJClAiEU9WIYK89kSi1T
        NxqQVsSBttzt+svUd8nxf0k=
X-Google-Smtp-Source: AJdET5c+2Dx3rmrNheQ/g62ggdfHz24Jwsuwea76uaH/TONogHPEs2PoLYufz7t5P18t1fbuIQTxaQ==
X-Received: by 2002:a1c:8c53:: with SMTP id o80-v6mr1114830wmd.30.1541681311972;
        Thu, 08 Nov 2018 04:48:31 -0800 (PST)
Received: from localhost (p200300E41F201D007494A3C25E2F6EAF.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:7494:a3c2:5e2f:6eaf])
        by smtp.gmail.com with ESMTPSA id g16-v6sm4282531wrr.38.2018.11.08.04.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 04:48:31 -0800 (PST)
Date:   Thu, 8 Nov 2018 13:48:30 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, edubezval@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] thermal: tegra: continue if sensor register fails
Message-ID: <20181108124830.GF1340@ulmo>
References: <1541410354-19090-1-git-send-email-wni@nvidia.com>
 <1541410354-19090-2-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Content-Disposition: inline
In-Reply-To: <1541410354-19090-2-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 05:32:31PM +0800, Wei Ni wrote:
> Don't bail when a sensor fails to register with the
> thermal zone and allow other sensors to register.
> This allows other sensors to register with thermal
> framework even if one sensor fails registration.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvkMJ4ACgkQ3SOs138+
s6H76Q//Xl61SgcHlWOlZTtGrUdMtSNgfPSxn9NLzx3+40d9/xBxl0n8wTxLFd70
+YBiZQpltYL4Q0riq5NbWTpdCJM9ji6Jevv1Digf22YNb4lh3S0uicAdePry1nZ2
OuTgZZYSRlHY2wRdzUphauVj3M3S4l/A1KKmln1DHIN61zF00Fo1GEBFMrTsdFHb
Ypb9unj+HqTk2qOnoXqN9Gl9VwyBs3BRPiv45VjzkYFyvJi/6+vbHlbb5faM/u4b
bcezKerELV/TiGt41E6eumCSr8y6/mMJH7kpAMNZ7sKORKQih5bBHrDHZkfmkKcf
OaZv/I0UmRkmMehSncB37sP88YhPr8HKGJHV6jXodm9x5wmDdSb2PM2SjQFb7CBR
uCbOVu9cMAFIDVWeHatc4KGyLHNjZzq8ImP2qHFSDchBObsI/0Xg607M48EYryYv
LQrJabHQtrbSpaUr4giIoWAbcbUfQcgc2Gjt31qZ/1f1PLI3/V5IE2EGZgyH1DZE
0u/+kSzQPsLcFPvyTZyESUPwxaln3BYAGW+RsDip1jgunGCBSOIvtV933qhB6bDC
NoG4VWN9X13WAlZWyoyJ4DRP7E/1iiF0kKOjQWsNOpHGjZBn4Y18U8FONDWtyVk/
TVTsUwWcnXVcqOx6ndK6aqh1ba9Zuv/vSeH5dCVG0k+WkwhenW8=
=TVwF
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--
