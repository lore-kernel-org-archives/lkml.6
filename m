Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37797C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022C82146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkKQm86I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfBHQSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:18:24 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42918 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfBHQSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:18:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id y140so2398919qkb.9;
        Fri, 08 Feb 2019 08:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QQu/QWLDPHuMshPc5YAAA4F5+cJPSYk22RGUb+HqXs=;
        b=VkKQm86IHbd/8V/TQvY2r5xoj6DiMxfuslEU6zPDLfCfmanYcpaM7N7Fh7pHxF9iBl
         ndyPV95G0bS5m1jhYeRm8G5ZbT8inYNAtAbype4CtAOndrauCyhQrvtEZWaGl74+Paly
         /RVWCwtqn6rV7or05c+SoE5GufUZjnbuZqRR47Xibxue0gBdSiKFVuQAewxGsaHgNkSw
         n7uuDVKy6igzPG2avHubLCCNTNwiv/Y+CNlYjUXLS96VHs0Xj4EkYLV1olHSSRvieb4Z
         IjkToyNwa54cOfhhT5QgzFXlLwgMOFtM2jxe5AcRa6WUkN6EyzySjNhQy3sG42XMk626
         UW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QQu/QWLDPHuMshPc5YAAA4F5+cJPSYk22RGUb+HqXs=;
        b=m210QvGFS/6lCbyvb0XJnng4NH/4NUz6iHMSJsQx4ILSfXFCIAnfW4W4OjFka8U8uS
         Lq0pGbfoRuBHOz47ifjQZDayIgkSqsbL18/Z9N9dAFXbiLwbbl3Lb3/cmbX4tFu0LoxT
         TU7y9KKI1BqlY5+28a3XRvfpnyPscvWVFjc1ue8ylRwwzWDcOHYZ/xO48bXNkDc8mBTc
         CzVFZ0bCrhLH2jlx/K7dtSEPXgGfoPcksQ86ANliNo/iRjzvvKyzWp6DBUqSfJwSD53m
         qx5BnSXyypgOqZtEorkoxn1LaMhS579heWx+HMhnIHNZpdLaYelY5RSkQb0bvEkUFxra
         S1Xg==
X-Gm-Message-State: AHQUAubDha1tLtaa4/6uGnqFpryr13P6VkvW+rWv90lLI8EujwSHQv7R
        7PUgGjb1yh26U54ojpvr3OSEJtMa1xvFzrswy8WOr2r5
X-Google-Smtp-Source: AHgI3IY+6xAn2uTQVuMayP8kZIF54RfcrCOMd/G0mbLpUD41caul0PEanxdWrtP35n8aeNsWZGvYjSL0L4KMhgukwcQ=
X-Received: by 2002:a37:3008:: with SMTP id w8mr16424798qkw.75.1549642702528;
 Fri, 08 Feb 2019 08:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20190207201455.25071-1-mdf@kernel.org> <20190207.181530.1190821370151974734.davem@davemloft.net>
In-Reply-To: <20190207.181530.1190821370151974734.davem@davemloft.net>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Fri, 8 Feb 2019 08:18:11 -0800
Message-ID: <CAJYdmeN5Q53_Sm_9MPC29OfpcWmVH1S6cvf2MMWNOEf8eDoUkg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net: fixed-phy: Add fixed_phy_register_with_gpiod()
 API
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>, hkallweit1@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, Feb 7, 2019 at 6:15 PM David Miller <davem@davemloft.net> wrote:
>
> From: Moritz Fischer <mdf@kernel.org>
> Date: Thu,  7 Feb 2019 12:14:55 -0800
>
> > Add fixed_phy_register_with_gpiod() API. It lets users create a
> > fixed_phy instance that uses a GPIO descriptor which was obtained
> > externally e.g. through platform data.
> > This enables platform devices (non-DT based) to use GPIOs for link
> > status.
> >
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
>
> This doesn't apply cleanly to net-next, please respin.

I think 5468e82f7034f ("net: phy: fixed-phy: Drop GPIO from
fixed_phy_add()") might've been
missing when you tried. I just tried with net-next and next, and it
applied fine.

It also seems to be in net next as 71bd106d25676 ("net: fixed-phy: Add
fixed_phy_register_with_gpiod() API"),
do you still want me to resend?

Sorry for the confusion,

Moritz
