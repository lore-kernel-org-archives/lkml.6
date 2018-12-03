Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC059C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECCB20834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMBo67uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECCB20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbeLCLOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:14:25 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36388 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeLCLOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:14:25 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so10532183oix.3;
        Mon, 03 Dec 2018 03:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lJhPkqbemsu/Gscn14MFiWsyxw5AFHX4bvaLNq9tY5Y=;
        b=bMBo67ujcxYh8rHzNNSFgA2dhRfx3DEvK8aiidLX2tNueGfKyJprxTrRv4PyGQ0nvD
         oltMjXrWsjX3wQNpseQCFrhO3/9oxqfrngvesjA0BvlmXZw8rx9Vom7zWkUSjmCWNMYh
         Ua/cDQdp/hhiWExHSH2X5t6wSo5DDhePv1eGv70HUxj7S1mEFM7o+DRWnRj0vREsts3z
         k/oT3rD0IlEO5dz0XnUUASL4lIIG0MhiFNIDvipJpuNlBvkumPSzKvfgHf8ALwvfU9cw
         ejSv7EsLZ7CEzb++/XX5/8hf9zbtADg+vBOhmSfQCF2GFeDskeVvyqmPa68XEU/R4oNk
         o6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJhPkqbemsu/Gscn14MFiWsyxw5AFHX4bvaLNq9tY5Y=;
        b=NDjlAJQke4etoJ/e78mQnfWTDHpKWR9tKkraflt2DMMWbVpaTjBcLo/nOq3p7GtyJI
         Z6FgiqNYlk0R6ATXNYFerFV0ji9AKCx6sUjXofnTthvHaSEDmeIU68o+iiBCQShnNNQt
         I7r0VzeQOMTNVst70gggiI00II1PxDZ/dMJrV74OfO4r6lL7kWLzu2Tq+n/LY/iqYg51
         rv/hevvu0iWOsHm4cxj1OlBR7vEx/5yUxkCJkf0vKaiPW9dh1VaDz7HUIxsq+z8nlj47
         +v3ZchtvBI7oxiRy1Nws4QZPlUzO598l0tX9S8DDkGgJ+i+8QQrCoVLcIrmxedMhy4ZS
         8hgQ==
X-Gm-Message-State: AA+aEWY/eQJa84aiktBlI7jYe7wUg8aDEhlxi9lRnZgemQk0URlHT35H
        udJCC9i1/hbtVTTLU08ivyPF3ZEFaQNuXAtlna0=
X-Google-Smtp-Source: AFSGD/UDAK/GF+/q/fi9nzGAkqJYykL0Whiy0kgcATEBA2m6bXDDkTYnOTdtXpPtx2TxXUUeors0/lOhpjCmIiSgzxA=
X-Received: by 2002:aca:6155:: with SMTP id v82mr683718oib.259.1543835628797;
 Mon, 03 Dec 2018 03:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20181113121213.14296-1-lukma@denx.de> <20181126143619.GB31334@dragon>
 <20181203103333.111c2463@jawa>
In-Reply-To: <20181203103333.111c2463@jawa>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 3 Dec 2018 09:13:50 -0200
Message-ID: <CAOMZO5AJPiexbvHUq+vsz5zz6gNwL3O1KJ9ka_XPFotac2Sb=A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: Provide support for reading ID code from MVB
 device (BK4)
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Mon, Dec 3, 2018 at 7:33 AM Lukasz Majewski <lukma@denx.de> wrote:

> > > +           72xx165@0 {
> >
> > Please use a generic name for the node.
>
> This is a bit tricky.

What about using 'gpio@0' like described in
Documentation/devicetree/bindings/gpio/gpio-pisosr.txt ?
