Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D254C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB33208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uqOET5Gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB33208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756669AbeFOWXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:23:00 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36350 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbeFOWW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:22:58 -0400
Received: by mail-ot0-f193.google.com with SMTP id c15-v6so12642692otl.3;
        Fri, 15 Jun 2018 15:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RyXhgGkt38lDkX8OVW4YkwyaxJ9OfDsIa1zpkPh++Cw=;
        b=uqOET5Ggu8Zn/twK6xVEcxUyt0uNX4NAsjz03HqgWJ7nZ1khwOXY62XuQCZLd1xnsk
         lqg7jaT/sH7VYMTRTjVY3oVJGTmyu4G4+z/EYdUVJJiC9sqzsqweyRH1k7KCV4s3YZMX
         a1c50sJCSYyom1YQmUvGAUpnXCxZsZbtcUmfHpjAlySVpqfZhkWOFDDvmT7NbhJpWm/k
         GrK9GrVNZKGwmzfvmVAGnW+OY5MCpzkIs92pet1tORDEBEFyiBWrgkVqEDgDzShbHy3b
         FETopmY51VuoKR882qZtmdhj0kMcgrmKQKRThOvy+QG5ONWU67O8SRcTipsEpIIEqSqp
         NPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RyXhgGkt38lDkX8OVW4YkwyaxJ9OfDsIa1zpkPh++Cw=;
        b=aQeVNluijgx9QjWjW+UxlCpfVGe9WC9G/n+fnwnktC0SvAB/Ss9O7bWFvcBj39MW+d
         kczf/iDelX/EdR9XNQrGGErmz1dgkmpeQy/o0Q5KJs4l8pf0SgLnLFuI1nZhdEqJF0qV
         35P+xTJB93gDAYjVqElWsoJw+gPhbYKvFa2RhieistRviRTUTQeYq+w0RbLJztQV8ONz
         Klw43bMc9bmhY38Zpd2FAzEufhdx7/UEnZSADsGJqdwNT/Oc+qrl/np9kPM5FC4AcQ+N
         lKMspVZfZqDJ9draqeW3LbwuTI2Sah+2+4AXfkmiA/QF1FMdv9AwCYwOg74q66b9l8P9
         5HEw==
X-Gm-Message-State: APt69E0cTml4QfslPyh5TW0qMlF5gnJpMVtruSeynpXzjj5h2P7vl2dl
        P3AjhgwrRtHnvYpLLYmORDbD5qcP5GMkyyV6g2A=
X-Google-Smtp-Source: ADUXVKK7ZxT/mnNpTqI3xRzW7xf1OOk165z79Qn3k4bulpiApbVXFLP0vHU8F5U/rADEyqGorSiDt1FqaBHfCnUn9y4=
X-Received: by 2002:a9d:2bcd:: with SMTP id u71-v6mr2071806ota.51.1529101377994;
 Fri, 15 Jun 2018 15:22:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 15:22:57
 -0700 (PDT)
In-Reply-To: <638457fd-85da-8fec-d146-517c43f71813@denx.de>
References: <cover.1529091248.git.leonard.crestez@nxp.com> <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
 <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com> <638457fd-85da-8fec-d146-517c43f71813@denx.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 15 Jun 2018 19:22:57 -0300
Message-ID: <CAOMZO5DJju6oBRLakkTx4np7w9nMwPm6TMkGGYjbMLUPDUugYw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
To:     Marek Vasut <marex@denx.de>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 6:36 PM, Marek Vasut <marex@denx.de> wrote:

> Having two drivers in the kernel with different set of bugs is always bad.

Sure, but breaking dtb's is also bad.

Can the mxsfb driver be modified to handle the old style bindings?

The IPU drm driver is capable of handling both the old style where the
display timing is passed in dts and the new drm style.

For example:

arch/arm/boot/dts/imx6qdl-sabresd.dtsi uses the drm style binding
arch/arm/boot/dts/imx6qdl-sabreauto.dtsi uses the old style of passing
the display timings in dts

Both formats are accepted by the ipu drm driver.

Can't mxsfb drm driver support both? Then we don't need to worry about
breaking dtb's and could safely remove the mxs fbdev driver.
