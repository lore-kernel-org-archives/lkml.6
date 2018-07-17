Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511FBECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0300520C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue0xsx/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0300520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbeGQNA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:00:58 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33532 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbeGQNA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:00:58 -0400
Received: by mail-oi0-f68.google.com with SMTP id l10-v6so1654105oii.0;
        Tue, 17 Jul 2018 05:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8LtrLdl4+rGjYZNiPeI6fm+hRtoSt9K/3MPCMYkAdOc=;
        b=Ue0xsx/e4dpDm27vgD6OZoy4HgRWdcCUw0/uw0sDyWs72xGFI7QoslKJNzOkxtS/YY
         pcjA8dM6puNmIV5XrZtsRl6v8aP6eXEoTFPngipL3gREx7R5ZGEmnvM3OhVmP2I/mlT3
         xpdhr+D+DerbQEyd8tlaZTpdO1uOV6XHBDNbwIJ+LdV+rBpTcXO66jXGYmrzZFOlqiEj
         XYIDm/xgLpoDDOWTj4sZ1jnBsYrGantctGRRFic85KmtQm/rRZ5u+dIHKvlCXBWWRwAl
         pnoCTsu63Bt6SBmEnvJitrpHIQNE8NdesP5xm7yOlmB6ZghPciEqHjgKop4eSljGyW4+
         WPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8LtrLdl4+rGjYZNiPeI6fm+hRtoSt9K/3MPCMYkAdOc=;
        b=jLsGlUEfPXjVPHp76lEduF+IMbnM4hcJftvw0Qy0F4X5wN3leOd8kvZHkzIpeWmvvC
         xMHGPbSr2Dvio3Un5CqREgmU7TnVgrvvOcvbW0TMI129mJ+mkrBKFOHqysc7kuZhTqJ+
         XA5Wpzazz1ObCp7J81ivX0/+axtwTDVEzKBNe3AjsVcOY289/mlKyxqDAd/46syoKFLj
         NF3wtINRfxqbHKLOgtp1bb31VwGbz9FQefDPF9pM29l21eJFbw3UDUfIwsR+BgI8k+oQ
         TfCejTMNLkAhVsNzaqoPwx7bTLK7tLMCujfMnjsBSugB5w8eDG2xAawKmlf9NHv0Iaw2
         gD3Q==
X-Gm-Message-State: AOUpUlHr6Heg5ME6g9pSiuY5uwAsktLRzfDPYcd+9MLmGSHf72z1LoQy
        Dw8ebwAPnyRKMqykdYdN45FGEJYzhkEoUeWYThs=
X-Google-Smtp-Source: AAOMgpclW9zeRnfFatVL7AmTOuIOhKFAhr7M/iR60IBYFYI5bXtVxScNLP+VZUW+VcVq09Sc3OvIo9bY/M1WpbSF+uM=
X-Received: by 2002:aca:e510:: with SMTP id c16-v6mr1550723oih.44.1531830511756;
 Tue, 17 Jul 2018 05:28:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 05:28:31
 -0700 (PDT)
In-Reply-To: <20180717072318.18730-1-sebastien.szymanski@armadeus.com>
References: <20180717072318.18730-1-sebastien.szymanski@armadeus.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 17 Jul 2018 09:28:31 -0300
Message-ID: <CAOMZO5Dr0zqy4Sf3s=L4qoqePRhZAXWpDk1oTOUidy4_TUQ=QA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel: Add support for Armadeus ST0700 Adapt
To:     =?UTF-8?Q?S=C3=A9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi S=C3=A9bastien,

On Tue, Jul 17, 2018 at 4:23 AM, S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
> This patch adds support for the Armadeus ST0700 Adapt. It comes with a
> Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT and an adapter board so
> that it can be connected on the TFT header of Armadeus Dev boards.
>
> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.com=
>
> ---
>  .../display/panel/armadeus,st0700-adapt.txt        |  9 +++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 29 ++++++++++++++++=
++++++
>  2 files changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/armad=
eus,st0700-adapt.txt
>
> diff --git a/Documentation/devicetree/bindings/display/panel/armadeus,st0=
700-adapt.txt b/Documentation/devicetree/bindings/display/panel/armadeus,st=
0700-adapt.txt
> new file mode 100644
> index 000000000000..a30d63db3c8f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/armadeus,st0700-ada=
pt.txt
> @@ -0,0 +1,9 @@
> +Armadeus ST0700 Adapt. A Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT =
with
> +an adapter board.
> +
> +Required properties:
> +- compatible: "armadeus,st0700-adapt"

Shouldn't this be named "santek,st0700i5y" instead?

Santek is the vendor of the panel and st0700i5y is the model.

Then you could add a "santek" entry in
Documentation/devicetree/bindings/vendor-prefixes.txt.

Regards,

Fabio Estevam
