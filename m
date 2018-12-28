Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50501C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1331A20879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4IrFHJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbeL1SUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:20:32 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34189 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731921AbeL1SUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 13:20:31 -0500
Received: by mail-oi1-f195.google.com with SMTP id r62so17940400oie.1;
        Fri, 28 Dec 2018 10:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o2YXIoyu6bSMKbOxxf+CV2nKYwO4K74uKrdD9f4+e0E=;
        b=q4IrFHJKtGP0RM4MxQTuLvHmJyqKET+5BojWDQHiqrdz2ssf1pIxhDluLaFACnYzlP
         fM9VHZECe8lSg5KF1tYT0OtqhNBC1WB+uBduaJqcellmXMm9kikqqkp5b21SimFSK8Vk
         GpPTWjpm8GnEevvjelGVhvBMPS+kVjU6gi8G4T+J5R4yInUd62N3891qMIggPU+Yc2Rp
         fner+zF/SrjKYIW0uC7xAqqpB40p2TcyEFBoikscH0RADzYNafWN8yfAh8dk/6kxfOQ9
         3frlKqDJ70om14+PNgHBNYmEhgzTLTUk70W3fZfx2bJjXcEI9QaEcykPL22IxycfI2qN
         ObkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o2YXIoyu6bSMKbOxxf+CV2nKYwO4K74uKrdD9f4+e0E=;
        b=Vok4OoBt8vdNH2KasEIdZwipDLSum8iZBfF90y3GwAbH06+EfpG5lrlNS/mGFDGLu2
         wH8CJ2XfMse7DTqAeY61HQZj7adHPCzTU4+bW9LAiuMxCytD5Jjlw3hat560sJEskuVq
         pAZfOpXD588Ycy5t8O18yPBOUqPYrbbhXmkGgeWmTXFupIEmc3YWWVr6jFAEMQTp1gWF
         Q1Qo8tz08u18VhK5ZJaXHiARE3qKWkFc20tuYutmZ5pO+j855CVkhErba2nzbiL1ueYj
         SloakXDtwZjUMnivWA868eKtTNFhGDxAjzXR0Cvt6fZA0lTNdKufbP2iJ12v3tkZ6enO
         uT9A==
X-Gm-Message-State: AA+aEWY0fd0Q65JZ2ucLTxm+XL2yATWfNqmyi4HddUVv6zB53BwBcMmh
        9HYaX84gOu+blsgPPg9QqAQAQb2I3X9/ldnqfWk=
X-Google-Smtp-Source: AFSGD/Wkie2QMUosQmCIyvZWZnqyOc+ein4UvUeNMqz9+cg9KRobn2FA7dREwy8KmU2GhlKV1hZ/WVqsPuPUSkaYl/Y=
X-Received: by 2002:aca:3011:: with SMTP id w17mr19048334oiw.342.1546021230223;
 Fri, 28 Dec 2018 10:20:30 -0800 (PST)
MIME-Version: 1.0
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 28 Dec 2018 16:20:37 -0200
Message-ID: <CAOMZO5CuPr_BxMP_wjPuZNTCinHQ-cb08wPHr=Od_Qw_aafPTw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa boards
To:     =?UTF-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vok=C3=A1=C4=8D,

On Tue, Dec 18, 2018 at 12:42 PM Vok=C3=A1=C4=8D Michal <Michal.Vokac@ysoft=
.com> wrote:

> +&fec {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_enet>;
> +       phy-mode =3D "rgmii-id";
> +       phy-reset-gpios =3D <&gpio1 25 GPIO_ACTIVE_HIGH>;

Are you sure this is active high?

The FEC driver ignores the polarity of phy-reset-gpios and it assumes
the GPIO reset as active low.

If it really is active high, then you would need to pass the
"phy-reset-active-high" property.

> +/ {
> +       model =3D "Y Soft IOTA Draco i.MX6Solo board";
> +       compatible =3D "ysoft,imx6dl-yapp4-draco", "fsl,imx6dl";
> +
> +       cpus {
> +               /delete-node/ cpu@1;

Is this really needed? We don't usually do this on imx6solo dts board files=
.

Only one CPU will be brought up online on imx6solo anyway.

> +       };
> +
> +       memory@10000000 {

Need to pass "device_type =3D "memory";"

> +/ {
> +       model =3D "Y Soft IOTA Hydra i.MX6DualLite board";
> +       compatible =3D "ysoft,imx6dl-yapp4-hydra", "fsl,imx6dl";
> +
> +       memory@10000000 {

Need to pass "device_type =3D "memory";"

> +       memory@10000000 {

Need to pass "device_type =3D "memory";"
