Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34088C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025C321901
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8eFJcUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbfAaL2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:28:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39027 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaL2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:28:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so2861018wra.6;
        Thu, 31 Jan 2019 03:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B4/zVGtrRPOnpsW0f5QeDrVYx1vlzJE6Isl8tADkSTM=;
        b=r8eFJcUnkwxI3BsTUzgFEHufsAxe+ppzmhU9XKSk6DKp18ejrU8d1DjqQrw4WzHD+8
         7IW93kMaXwsvbP7CdAGGso4R+cDHliPwArW304PiOSthwbWcTgsPqmD7d6tdzyU6ho4I
         QUXTT05NFWuOy7/BfSr0Nk8Or5atrBAR/9rK3f8iO67IWJUgqsEh2WKyw3pN9kMsw0qJ
         1MO2xNdomsFIANrdrzD+oBnDTK+paxhSn/wC5bICRPdwKDapvoVe8iU3rgWWAC7pN8+M
         Np+EuyAcotnm43X0XeWQ7S4vGQW5L02K+Fohtw3w3+V6B2KoqZFK5YW9Dyb/yUQ9TMJy
         KOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B4/zVGtrRPOnpsW0f5QeDrVYx1vlzJE6Isl8tADkSTM=;
        b=ndEHla8CZUclzv4ukqLEPUgzfdJGhlDFXQLsbJcsouoL63GGfFqbytHlUEs59lM8Zv
         Ixx682PE/7d33Nv+oYpljPs4udYOVbYdDCYdfVshCKBT+xNmq5W5HcBAfpomAUyVmEVK
         hKXFgh9NXBpqYiE7nNWsaovFKaLhUbdkBiulMWHar/wAVLQRnOgCDnO/auqvcfxrwyWb
         TE20K8oN7h6C7h4OpLJeVYGT0rXGs/yJXhDSLRLlMApvAqW3Zlmh+t2dVLmsSKxB/H8j
         KQC3qp15JGGpZ8CC5s8k/wYvUk1GdExoSXkV0nJwY5JSr/8l836zeTQTd2MXHn48+p3K
         7CZw==
X-Gm-Message-State: AJcUukecZQT9gTiAmpwGRmJsyLktW7zrzZHfToDa9BiBLarOgjCTFU1m
        RODdcK3DMKwvntmL//v3xAITQ7t5EIw=
X-Google-Smtp-Source: ALg8bN75wGvt7ztsCT0T3sTSMIaORkJz+3nIuKuJCGkgflf2O7OeFONHasdP9SZPQZWHBQqhonWgRg==
X-Received: by 2002:a5d:5182:: with SMTP id k2mr34080075wrv.121.1548934119908;
        Thu, 31 Jan 2019 03:28:39 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id w12sm4372724wrr.23.2019.01.31.03.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 03:28:39 -0800 (PST)
Date:   Thu, 31 Jan 2019 12:28:38 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V7 1/5] i2c: tegra: Sort all the include headers
 alphabetically
Message-ID: <20190131112838.GD23438@ulmo>
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 30, 2019 at 08:01:32AM -0800, Sowjanya Komatineni wrote:
> This patch sorts all the include headers alphabetically for the
> I2C tegra driver

Nit: s/tegra/Tegra/ and place the full stop at the end of the sentence.
Otherwise:

Acked-by: Thierry Reding <treding@nvidia.com>

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxS2+YACgkQ3SOs138+
s6GYaxAAo7z2iwhxy3O8IZeSG8BcE/Zsz7juFrLpYF/p9GIerRYhHsJLMsN0KJlH
NmXiXGhBw0w8gNkZcKI2Ntk6ZYtLRDRtg003y5G4CabB02+XNLjreDHwlfJtAV+d
8v8xOKgpGqURiJ0rAMrZL/+eT2+SI2D8j+I05COndc6OTU0oaaPf3U4rKJyQRRwQ
Kq063zGUGhL0Bv55o84MOys9xQQX5DrZNtvr3shkA6410iDkekvdZndBWOVnnKKR
bc4/30eCzQzwzzq6JDakYiiGKnA4QnMlI3CWZAmePyBPNxO7Or4D0g/39gqHSalx
BzjUFsl0XkuRl5r6IQilCICmhy6R1eZhc2NnOlIDPXbl8vfKwjuxRUqcW4UCOJH9
JbCW2It2/fXWocCj2HyhWAeVTihm9Tzz70WjokBRfQPZtK+Cr+dAxmGqP7W2fpLK
jvXJ7LEpEstjuSS1Y7hRaNiKJwCxxkGrzhyBDgwaUzHmDKwqxXM+tsa251XOEBL4
EEkz9bv6TpXc0kzCSJM8Veg/gVaXzgE6P2p98rMlxaqE4Yk8g9LmCMRPCaNq4J4s
fdnAqbaiTA+OuTOxo2/sHFQEXspfm4xNAsolDFlVCFQeGBCOmyo1f3tEDwkyODHl
rO/jixiMncvAP+HBPkge1dryOYi5ZkWiOpKUxuri24YU4XPptUA=
=ZQhK
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
