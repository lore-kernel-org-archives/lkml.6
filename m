Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CABC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57CB20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfGZg3zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfBHL5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:57:19 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36377 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfBHL5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:57:17 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so5408468otk.3;
        Fri, 08 Feb 2019 03:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HL/XCMxPlEHXXfHLSzwnwpsgbinlGn1v9qRYoVOtbxs=;
        b=ZfGZg3zifHIYZlN4Bw2a1Zyh8USlrOYaF4SkaaHP7Vq6VBprjlpjmcEBsLNhEnfHcY
         zJtFWAyYFAt2CxSR0s0hq6C8/I+FW/pVxZhmFTM7+kLz+PPwSQi+QBPVDwaHpVO/vGuv
         kJkTKZpvqduxcRYvaU4PGbMWxzlbypZszENA6CrYdyyCRJONsbs0E+Ku1ZfWjK89bHgp
         3dV7E85lVAC3AbHbiOh0dLCL2kkAJSgZIQpZXT4Xy7JO1BqoMiflF6X6phZF2zCWIYPs
         mircBVmCYJ9j9UWISGzMS9ookfu1tzKa1RnRAq2nTfU1IHL1meQ/sOc90KeIxMnEbczR
         Z2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HL/XCMxPlEHXXfHLSzwnwpsgbinlGn1v9qRYoVOtbxs=;
        b=SLJ8+pBYehrrnQoXDVoz7Zi3ZpZtS9zGEkY00Z5TSxBo9H44/lm893V+1JVg0dVK8K
         IEuSSS6ZJWR2RJAkIGEgWJ8Gr3E51d2QCb7qi/XY5rZrPnljeSffJSNH8VgAE3pkSAVi
         3J3nyrdCIVT3yP+CGgUJYbiWze9nm9AEpYZSPatnBqtvd5DQeN2X3AMHA0pVaG/Ro0g5
         JhnYf1shspimCmeETBfR3BV6850TSMRL/x9egM8cCHFZAosgvz+17msY7EetwKcQyEkl
         4Pmj3uT/07UbMYoXCq26BdLR4YaRlZjxLiboBr+mmnf9zWm+h66dYlHuDVIXxC7X54NM
         CSQg==
X-Gm-Message-State: AHQUAuZFiac8ahp3ke60bQY6P0HAC5kMM8dWGIIvrXCVKaQ2o8F1Tu2/
        YlTz+XbklB0UcSrFRtXvVNUgBFEVNenKSJyv7xQ=
X-Google-Smtp-Source: AHgI3Ibi2LLUPEBFEfLl1xJee040zEsQO+5A1UvNTVglvua0OVbnRh88vtwNYiL9jhPqmtfcI2FEyYZPKKpOq+izKW4=
X-Received: by 2002:a9d:72c6:: with SMTP id d6mr9578069otk.78.1549627036253;
 Fri, 08 Feb 2019 03:57:16 -0800 (PST)
MIME-Version: 1.0
References: <20190129165530.7606-1-j.neuschaefer@gmx.net>
In-Reply-To: <20190129165530.7606-1-j.neuschaefer@gmx.net>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 8 Feb 2019 09:57:04 -0200
Message-ID: <CAOMZO5ABy+uDXMhQy95vuY8Yz2a8Wr0Q0+fUq=2Xkm2NSCdQGQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Document the i.MX50 IOMUXC binding
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Dong Aisheng <dong.aisheng@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Tue, Jan 29, 2019 at 2:55 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> AFAICS from the i.MX50 Reference Manual, the i.MX50 IOMUXC works the
> same as the one in i.MX51, so I copied fsl,imx51-pinctrl.txt and changed
> the text to imx50.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Cc: Dong Aisheng <dong.aisheng@linaro.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

> +Required properties:
> +- compatible: "fsl,imx50-iomuxc"
> +- fsl,pins: two integers array, represents a group of pins mux and confi=
g
> +  setting. The format is fsl,pins =3D <PIN_FUNC_ID CONFIG>, PIN_FUNC_ID =
is a
> +  pin working on a specific function, CONFIG is the pad setting value li=
ke
> +  pull-up for this pin. Please refer to imx50 datasheet for the valid pa=
d

Nit: It is the i.MX50 Reference Manual, not its datasheet that
describes the pad settings values.

I noticed that all the bindings say datasheet though, so I will send a
patch to fix this.
