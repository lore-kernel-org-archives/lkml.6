Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C04C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE58B20871
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZhB33NA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE58B20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933729AbeGIRJb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:09:31 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33248 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933573AbeGIRJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:09:29 -0400
Received: by mail-wr1-f51.google.com with SMTP id g6-v6so2845937wrp.0;
        Mon, 09 Jul 2018 10:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JZ8rfB73O2XyfRaAOsUNiWM58KzCQ1kzNFSImL8bASA=;
        b=rZhB33NAn4XjiIjU8+e3hZU4EKUCHDqZbqAiaz5tMlmkoJLGTLjZdLMjBncHRrGZw+
         OxZ9yezbg6rZ/P7LiDPLL1Q7+BRe5gAjrknjWNZ8PgUtx0TZH5vA3m388gyyN4qFQjfi
         jCSlwvw3LfKDsRCAefTeomrSKogqqVFxbVudm5EhGtoQRqFqEJ3z8EPJOD8ECxCFEMrF
         gIYsYCNZ/mDDzeSntrgveVUHnjHBgFF+PIgc2Bmi56od5fCGoiIoHeyL4bJipGR+C1Mo
         0+bRQoHbf9B5c6hRGur4n51C3qcGcwHc5CpduuEJ/jvbIlovJanv7zVVDKMnmPB1P43y
         8OCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JZ8rfB73O2XyfRaAOsUNiWM58KzCQ1kzNFSImL8bASA=;
        b=V+QBbknBDnQrfoBgPs9DZ7No9Ukcff6zqFatjB8tDEVfHSsWF16fMSQky3djpBSO03
         dBlGlouTpKs2WHbeae6j5MO8Xd3GjJyNur0fSIf0wg3VHT2hIP/PafMZQR5LQ2J4tA1E
         5nmUZl1G8muTXhAe5Zr4dwnfl+M8d4tmiuk1sCboVFQVuRliF6qalL7O0UFLZ02YxIJ0
         v+fEu03XKKn6vRlpVdSIvyZ+eWaZ2nRXtM0nKMrgWlJ56Pqd36v4+/7I2P/WEh5dL3E9
         yyVhjc3+hHJXUlD+3kdHlVH0dn6WmRukbO+0vEbEsUuwFaFWKvDskYUZM7L/4CzVSasp
         L9tw==
X-Gm-Message-State: AOUpUlHKwpt992qUvplAIU4hrxotyJLntwhEysgXFUarggrwTjpCFRd7
        K8uqrmYnMHqVNIJUlkBSLbo=
X-Google-Smtp-Source: AAOMgpfv+DXnmOfP5AJRQ0sunCxjxYJ/DmkgSMrNtGDEgcgaLi7mLqQMzQs4b/CYPlHdowDEMRQXbw==
X-Received: by 2002:adf:b456:: with SMTP id v22-v6mr4912054wrd.187.1531156168100;
        Mon, 09 Jul 2018 10:09:28 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id 64-v6sm6469042wrj.50.2018.07.09.10.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 10:09:27 -0700 (PDT)
Date:   Mon, 9 Jul 2018 19:09:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     shenwei.wang@nxp.com
Cc:     linux-pwm@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] pwm: fsl-ftm: Added a dedicated IP interface clock
Message-ID: <20180709170926.GF26651@ulmo>
References: <20180608192237.11063-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Content-Disposition: inline
In-Reply-To: <20180608192237.11063-1-shenwei.wang@nxp.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 02:22:34PM -0500, shenwei.wang@nxp.com wrote:
> The current driver assumes that the ftm_sys clock works as
> one of the clock sources for the IP block as well as the IP
> interface clock. This assumption does not apply any more on
> the latest i.MX8x SoC family. On i.MX8x SoCs, a dedicated IP
> interface clock is introduced and it must be enabled before
> accessing any FTM registers. Moreover, the clock can not be
> used as the source clock for the FTM IP block. This patch
> introduces the ipg_clk as the dedicated IP interface clock
> and by default it is the same as the ftm_sys clock if not
> specified.
>=20
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/pwm/pwm-fsl-ftm.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

Applied, thanks.

Thierry

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDlsYACgkQ3SOs138+
s6H7ug//cl3hko1skwatxl1IG+MUyKAwMQQxnMG/Kok0DrIimWyXFsZpHr0xDsu/
pK7X/IHFkpSMBeyUc54A7iiFF9JZvTIcZLkP/LV01Gz6QfexJTFja/c9WcsmvpMk
QjezjZfIxKIaRl6rtU02pRLz9Vcm5J735h9WWq89sUYBArQtKnh2JjTyQxFd/TJh
Rl5yuizCdJQBk2VmmkOHqSKqr2m5dLTMgtPJXWf7YmOO15sWw0MdzpXZFFZXLBjd
O1ltQD/Jqe9E/NaQDwUxqoOBqvNWNn9+RqzCT1B30zyiMdPMXz2ea0ueeMeekAtF
ia9tf8L0LVOsmxNd6gzQc+dnENFBUK9QVZrCJ3fIsiNv11Zw4YwHuQlszBra5bfb
GeoDbVr2iSkTvn4+DABjozVPA2R/k9eGwPyZFWOEgcrVDTULWBwV3P2/EKr6dynd
1jLpw4yw6PX4t2oA5HFDbV2JuXq2KLHM5nHHH2JbGTKus6IGKqnJJfbOADuDb/LE
8htxlSJrbR2+JXdchnmcLOfOGV4aGEFtuhpFbjoiesdcM7+m3EdjsIhisWNeuDc7
uHJRSd7doJ3dspxlJQKCAzY9dCU+Hwak+FKX2Z/Rereo/osz7KCCVrzIGVGsRy6D
/sFHXxqhf12bE7bBG0np9PQhnIZnv7tdP2GjB8gCLIJehKW/a8Y=
=9/jk
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
