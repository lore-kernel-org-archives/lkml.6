Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E359C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E903A2554C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOqB8lmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E903A2554C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeGBNNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:13:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51901 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbeGBNNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:13:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so26181wmc.1;
        Mon, 02 Jul 2018 06:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o4nJgI+imDZdy4rScghFt+ot0iXHv7SPVsNFLE0AYR4=;
        b=pOqB8lmrRhggBqey0jv/9jkw+2aP3N6HO1a/gOFQo9irjZZVPk4Q29qydgkxjl7+ln
         4XsFGjKX8mi669WwNtDjZ9yr5pGy87sNHpg4m8lhTlDsA/wepNrZDETjVRiLuZO1hsCV
         2J3tJjCJV2o7CLPcIajwi8vjva5qPCS/S/EELqqPJ0CGggxQ4VyK6SX9ArKfPvmnu0hE
         DfCaueRd3jww9w/hcU42O7oewAhxx+ePyaY0HmMpksGeQZ97y4X+Uc38haHUVNyhLWQ0
         QN6KmHoF8142V88fFX6eDn/OsNv2xRCk8udUuQ4/kiVMIWI8CKLBPFIzJ6XJQftpwBsO
         f/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o4nJgI+imDZdy4rScghFt+ot0iXHv7SPVsNFLE0AYR4=;
        b=Kq6NZ5jp178yraSkAiZ/Wbai48sfsMkE7rspfgohdtTiwBxBSejDw/gi7mTTcIZ6c4
         M3bYNhqJgoPodU4KcWVE6X3SuWQrO0XRrUMY4gVAykW2a+Fj56H/8PP25yryMxrZjTZv
         AmIvApiSHn1SX4w1cPYeAJQT9WKBhXZLOzYL5H55z9zzmJA074n5wlRT8FTWicJEI05C
         xbrJeQpCcyeYKy52Xx4MuBWLZKKju34DtYICaUw/SzV3jepEKN23ou0a0wBB5Jz9ZeX8
         yq/Sm3nibpktrkMm4mfO8SPfgwftScsI1HKRhd0wEnyfnJLWXR98dD3vSWw7kZJiCssp
         G7iw==
X-Gm-Message-State: APt69E1CcwIrvwxZ+xn/UiII3WTGHLBiyS7vEnf7yxtQZOUGNs/ghOQB
        tGwYlzt4zJ6TNAk7HCd+lIE=
X-Google-Smtp-Source: AAOMgpcSObLcyKKO3AxCPE8apAlB/yubalaA/506HHqMJs/usH+962KB6KTlQjVkSxWuo2juDLh9Vw==
X-Received: by 2002:a1c:2dc8:: with SMTP id t191-v6mr8551897wmt.94.1530537182639;
        Mon, 02 Jul 2018 06:13:02 -0700 (PDT)
Received: from localhost (pD9E51838.dip0.t-ipconnect.de. [217.229.24.56])
        by smtp.gmail.com with ESMTPSA id c4-v6sm11826219wrm.65.2018.07.02.06.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 06:13:01 -0700 (PDT)
Date:   Mon, 2 Jul 2018 15:13:00 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     jassisinghbrar@gmail.com, gregkh@linuxfoundation.org,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] mailbox: tegra-hsp: Add support for shared
 mailboxes
Message-ID: <20180702131300.GG13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-6-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Wtrm9ATX0sn6fFKv"
Content-Disposition: inline
In-Reply-To: <20180702114033.15654-6-mperttunen@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:30PM +0300, Mikko Perttunen wrote:
> The Tegra HSP block supports 'shared mailboxes' that are simple 32-bit
> registers consisting of a FULL bit in MSB position and 31 bits of data.
> The hardware can be configured to trigger interrupts when a mailbox
> is empty or full. Add support for these shared mailboxes to the HSP
> driver.
>=20
> The initial use for the mailboxes is the Tegra Combined UART. For this
> purpose, we use interrupts to receive data, and spinning to wait for
> the transmit mailbox to be emptied to minimize unnecessary overhead.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>=20
> Notes:
>     v3:
>     - Added define HSP_INT0_IE_FULL_SHIFT
>     - Added Jon's Reviewed-by
>    =20
>     v2:
>     - Added defines for some register fields
>     - Simplified bit looping logic in interrupt handler
>     - Changed write done polling to use readl_poll_timeout
>     - Removed unnecessary zero assignments
>     - Fixed two error cases in probe to do proper cleanup
>=20
>  drivers/mailbox/tegra-hsp.c | 211 ++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 191 insertions(+), 20 deletions(-)

Looks good to me:

Acked-by: Thierry Reding <treding@nvidia.com>

--Wtrm9ATX0sn6fFKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6JNwACgkQ3SOs138+
s6GWoRAAjMSzFRnjIqmYTKNAlC3+zWjnHI329p0ETq4v9BEhKuDXsCKv490meKDp
+OFZOvgs7InvdNKX9sUmFYsiHNx7z0AjfyMhbLq2QqFQLJVxLG+h5I1oYdrhIaZ6
PIhOlQNEgrr5b7wYnj/2CvVtANCNB/3uw23gkhQVCvvV0V2SI/SFZzp+JvO4JUT6
KLSvQEGrmialeqaLvDi47nZswcrjh6w28O6YALiJHQWnx66dk3jQFxqS8Ck+4YXk
ihTUSlkG3Qy5PzZQQ/zFESL/S6bh9dLeUkGeFeigsV5B2sBBrcsffP0Sj2Ox3TIQ
LpFHSu9yXAsRRlSxWpeLDVox+AaTrzNNf+earyvItB9tAHKDl1mCLLqAuWrkKyye
AX1hvhLSuT2oXCfvtx/Xiw2XvI19gvXFtuAsMYb1S7fliIcEkuZqruLKT2yeOMLh
3alEYF1QYnVzh7JwInY16Kq7lJ2bHLBOZ01SFVFCAoyZR/Or/yVapoHaHk6LQMwW
vuYBZE7zCWw670+3OS7qRdIwhtt4S1qd5MAoodyu3oA8ZV0C052EhkXASEVG+d0r
QbJCpeNcTfbDnBUnANJ/saLmTe2EAGhmYN4NxR9VKNyH9oKjS9zVr2p42uNvruLq
z+xo5qXKOavNVYhVA93k4MQfEEASqltcqr90nE9/0KeO0u0rdDM=
=30K8
-----END PGP SIGNATURE-----

--Wtrm9ATX0sn6fFKv--
