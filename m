Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8FCC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0B4208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3zbrGQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0B4208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756821AbeFOXdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 19:33:00 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42530 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756807AbeFOXc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 19:32:58 -0400
Received: by mail-pf0-f195.google.com with SMTP id w7-v6so5534948pfn.9;
        Fri, 15 Jun 2018 16:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=771TQKyx3HFxkbPiP1OXTSSOKZ4/agX8BAJiOMdFzWg=;
        b=B3zbrGQSc0pfJk8XmCTxOZKN92z0v7qKm2cyfqWab5hgUfXzPz2yYww4Tq9D1BiUF6
         MEjMi8W6JsQ8J/odrST74JUSHgmfM5fo5FOVvQEM1n9NsKogCk3tFKMlFBMWTE8AgraY
         7Z8xIoIPjfrCIZnYjhR3FkSme9nMbYMO5K0Wj9tw10xzJI8OnFRRMQpf13QyjZk+54m/
         xK/fe4LGZWZTbR8mUf2pGEd6n2Bz3ZMtObvoV3qbTO+D7C0JubKtkgNu8qvEmyy9zQVh
         jLzGOjkK4DOHnGPxuXZnQwJSlaJ/nSO1lFBy3s6crItQXnvPuiJuFPFkWBfH/+sbNTh0
         J3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=771TQKyx3HFxkbPiP1OXTSSOKZ4/agX8BAJiOMdFzWg=;
        b=B4DsQ/SpGYT+w5sY1Atm7Hik7XA3KW2Gv8Vz8u2GpTbb3mGzB0MdN/s6kUcyhJ6d18
         u3ZepCS+z1IQ5SW6TESGVhHd1wSFn4JCJKvDniAwGBg3WquBimQD4QyEojCmgsEwkNmM
         sMf3XrhcxZ/yIf+lX1MBIlFzeI73Aop8HVytsP92KRhenadrt09vWX3t9j+ch60tz3/F
         bfAlu59I8BwVXgYoTkZumHET/7GH5wgwoVzovhOojME0tYjBMDlU3bIkjTTuL6OCY7vX
         ZxfBvm98FBTLelcL01CbWkwgW899//iNnAyN1gGWHgU1ubgVMvvtStegeytbW3KokyrQ
         C0jQ==
X-Gm-Message-State: APt69E3wwuzPNJDzViHqfO71omljO4DSM5pGgYPSb6gUC5t2PUC3T8g2
        nC7AIAHjESFIHztxi86MzHc=
X-Google-Smtp-Source: ADUXVKIl4msd6hiLCf5ero03RqM6mCKQu0OTMrWAizXq/H6UD7CuI/+C7v2FVG3U5PkdGwn9uzMymA==
X-Received: by 2002:a65:5143:: with SMTP id g3-v6mr3342121pgq.190.1529105577398;
        Fri, 15 Jun 2018 16:32:57 -0700 (PDT)
Received: from [192.168.43.97] ([1.1.125.127])
        by smtp.gmail.com with ESMTPSA id r2-v6sm16780476pfa.49.2018.06.15.16.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 16:32:56 -0700 (PDT)
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
To:     Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
 <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
 <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
 <638457fd-85da-8fec-d146-517c43f71813@denx.de>
 <CAOMZO5DJju6oBRLakkTx4np7w9nMwPm6TMkGGYjbMLUPDUugYw@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <22e2aecc-3735-8ad6-3f36-75ae2b8f2498@gmail.com>
Date:   Sat, 16 Jun 2018 01:29:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5DJju6oBRLakkTx4np7w9nMwPm6TMkGGYjbMLUPDUugYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/2018 12:22 AM, Fabio Estevam wrote:
> On Fri, Jun 15, 2018 at 6:36 PM, Marek Vasut <marex@denx.de> wrote:
> 
>> Having two drivers in the kernel with different set of bugs is always bad.
> 
> Sure, but breaking dtb's is also bad.

You picked only the first part of my argument, the less important one ;-)

> Can the mxsfb driver be modified to handle the old style bindings?

Maybe, but do we care ? Cfr my comment about the amount of users who
will be affected by this.

> The IPU drm driver is capable of handling both the old style where the
> display timing is passed in dts and the new drm style.
> 
> For example:
> 
> arch/arm/boot/dts/imx6qdl-sabresd.dtsi uses the drm style binding
> arch/arm/boot/dts/imx6qdl-sabreauto.dtsi uses the old style of passing
> the display timings in dts
> 
> Both formats are accepted by the ipu drm driver.
> 
> Can't mxsfb drm driver support both? Then we don't need to worry about
> breaking dtb's and could safely remove the mxs fbdev driver.

This might be a way forward, but again, does it justify the effort ?
We will be adding compatibility code which we will have to maintain for
maybe a handful of users I think.

-- 
Best regards,
Marek Vasut
