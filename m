Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DA2C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25498214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIWeKhIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25498214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeIZVJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:09:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54317 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeIZVJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:09:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id c14-v6so2625548wmb.4;
        Wed, 26 Sep 2018 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pvAbw60RfkuxAIxGXNkj555muDFGPzCgZBA0o9zmpFk=;
        b=qIWeKhIGxZukQQiH3cOzpucHI8xtGDwfpxzjlFVIUBEK/Co2JvlwwnSA2wWm/6BMqx
         Uatzm9LBqcYRnnb9QRbwnGx7fH6Ra5hndIZy2DpHfLJQTV9IhKzWcX3tumXGXzf6RjUF
         56e5E73KWkAB2rHOkTrofus8qSYS0VCgiWyyP1SMUbtsQKAZcTSxeTP5ajaC+jM5eiv+
         FrV3A+AhUQxHUjEnWArGZL8qeOUVoDGwReZZ7kp9US/sqMTAv1r2qlOON1XpWr+bcMOH
         cIjk7nK0TKLH4hJr7T6WLNNtoXiM/b5ZCS9VtDqA4QoVsQXZVkLny0ezdoaAPLdXu2Ns
         LWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pvAbw60RfkuxAIxGXNkj555muDFGPzCgZBA0o9zmpFk=;
        b=rjpiqjte9BjB2WHkpSHPED81tSf9d0uOPUQvfpBUddIsAI/kM7dttr2YYaePmZdV4x
         uZwcW9QDbq9xhtDTrQnI1A1XqyqjjNa7MIcZHAQ/UJkV3JjKEBbKv4BkkGCfG7JCOKRK
         L5IAwcgivyyw5tUGBvLfxmeJFuIBkVyldYNwDJV28DIZ6uvwPR0MEz3yET/3BMGtVJox
         kOsnZ19hD4nDEio4mQTLWuKNCg/yQKCdX3j2rIAw/kCve850kQTSR3SDgGzUPaDYaU3H
         XwkHpa5HM0FZ49jMOGObE8Nt9uyDfGOukCu9FWPdxkZ3mR2MOVUc8VXXaKp8DHrF86Da
         dMtA==
X-Gm-Message-State: ABuFfogiGHRxuQ4f6uPq+KM+sTtC/mhEGk+PKVsynv/uItqjtBXg5MFt
        9UeLnd6jk6xIuB/K9a7L5sg=
X-Google-Smtp-Source: ACcGV61Dbhr7jc/+TQXTh24tHOLApWJsvqI1R/kwC7RRSyUBydUhyoI5MtBkfhvWstnHLUfAdvdadg==
X-Received: by 2002:a1c:4887:: with SMTP id v129-v6mr4429000wma.139.1537973763644;
        Wed, 26 Sep 2018 07:56:03 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id z16-v6sm4481393wrq.78.2018.09.26.07.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 07:56:03 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:56:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 00/19] ARM: dts: tegra: apalis-tk1: minor revamp
Message-ID: <20180926145602.GF12980@ulmo>
References: <20180901130504.14318-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Content-Disposition: inline
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 01, 2018 at 03:04:45PM +0200, Marcel Ziswiler wrote:
> This series is a minor overhaul for the Toradex Apalis TK1 system on
> module.
>=20
> Changes in v2:
> - Add Rob's reviewed-by.
> - New patch as suggested by Rob.
> - New patch.
> - Get rid of fake clocks simple bus as suggested by Rob.
> - Change cover-letter subject to indicate minor revamp.
> - Drop "[PATCH 02/15] ARM: tegra: apalis-tk1: reorder pcie properties"
>   as requested by Stefan.
> - Drop "[PATCH 13/15] ARM: tegra: apalis-tk1: fix pcie switch vendor
>   compatible" in favour of the new "[PATCH v2 26/34] dt-bindings: add
>   broadcom (formerly plx technology) vendor prefix" posted earlier as
>   part of the apalis_t30 revamp v2 as suggested by Stefan.
>=20
> Marcel Ziswiler (19):
>   ARM: tegra: apalis-tk1: add local-mac-address property
>   ARM: tegra: apalis-tk1: reorder host1x/hdmi properties
>   ARM: tegra: apalis-tk1: reorder padctl properties
>   ARM: tegra: apalis-tk1: regulator clean-up
>   ARM: tegra: apalis-tk1: add missing regulators
>   ARM: tegra: apalis-tk1: drop unused pinmux label
>   ARM: tegra: apalis-tk1: white-space clean-up
>   ARM: tegra: apalis-tk1: reorder backlight properties
>   ARM: tegra: apalis-tk1: add proper emmc vmmc and vqmmc supplies
>   ARM: tegra: apalis-tk1: enable emmc ddr52 mode
>   ARM: tegra: apalis-tk1: add toradex,apalis-tk1-v1.2 compatible
>   ARM: tegra: apalis-tk1: reorder cpu dfll clock properties
>   ARM: tegra: apalis-tk1: reorder SD card properties
>   ARM: tegra: apalis-tk1: drop module level model and compatible
>   ARM: tegra: apalis-tk1: drop obsolete spidev nodes
>   ARM: tegra: apalis-tk1: replace underscores in node names with dashes
>   ARM: tegra: apalis-tk1: get rid of fake clocks simple bus
>   ARM: tegra: apalis-tk1: shorten temperature-sensor node
>   ARM: tegra: apalis-tk1: drop unused hdmi_ddc label
>=20
>  Documentation/devicetree/bindings/arm/tegra.txt |   2 +
>  arch/arm/boot/dts/tegra124-apalis-eval.dts      |  40 ++-
>  arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts |  43 ++-
>  arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi     | 452 ++++++++++++------=
------
>  arch/arm/boot/dts/tegra124-apalis.dtsi          | 451 +++++++++++-------=
-----
>  5 files changed, 508 insertions(+), 480 deletions(-)

Applied, thanks.

Thierry

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlurngEACgkQ3SOs138+
s6E4YA/+Igpqe3MR/FZa+1S1ez0eA9V8fpZ6QNlHDZQVvgDhFAHiqFFJ2TPORzZU
ORqCWuTaqh+CezOf8UKGh+PHX3U6RuakeSNOauvX2dDo6FfLjJ34XQGrB14zWFwL
EhVvo6huUK0p53ksNPGZ4lDHako5u2T7HSpvxWvgD30B4q4ZIMUrsliC1E6mWsoI
yS4aUuGyH+b5ulI/W8l6GidsTdvJ4xnrmZjk1siJcARaV3v8Bub6J9EgF5kxLzXf
oF1PWDrXKIyq924rZzxFpdHUaBOuJkpNLz2rLLHaG1sYiHqe5vdSrJT4N6OgYQHK
N5KK8wuptP87dUraeE1tnirkz4pqgAlB/VT3PVB9rWKYqxBmkdDffUJgV/JM3OGl
a2LbBQfRhDHHIK5BbP+A4Hqbr9BCX+ocY9RfcrDKAbu8aLjKP5V6J/Vkq7ZycHVi
jYUQJ64md2VF6j+Auu30y5BKZLLxNNCZoK1Y81w0YcHgiqRxYw9CNmln0g7WsfoE
vS0c24BPBTIzOMlLKzv/Fyq85YzzwmACgsmTwCbiC9uqifURH4byywymSPQlHT4k
UJstH3p/J34AdmY0PpVhfjfG2IuWcg1tYJOBu97YR9i2wJHx7+4x9JuOAJaz+PPB
6lf8eQCO3VvrnxCvOhDSspjYGPTQPjs7tCIcYifAPB6vi+B0NWw=
=QMGR
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--
