Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892C4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455EB24687
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5gfex7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455EB24687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934501AbeGCSLl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:11:41 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42878 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934141AbeGCSLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:11:39 -0400
Received: by mail-oi0-f66.google.com with SMTP id n84-v6so5651679oib.9;
        Tue, 03 Jul 2018 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kLiRGUkNZZyv46T9YISHgYl2pq9Orl33xT/dCTiZiSw=;
        b=s5gfex7E6ig+w8gJlY/yv+NhuhuTuZfpY+dI0NC6qVq+6AqNhB+MVZf6HQHirsf+cf
         sKy3cJSH7XvA/NjiMSTVVTLcoge72LvCVs9OpF/ECvLS13GayQhUkYgBO73iIP0MScRE
         +wHD0UoGgC9GFnBM3nCwm2qakGTCMcjIAf0BzEusKtqdNc2UXZn0k03dL/ns20QhX2i8
         0k+po8SHjAL/U3Jyx6KX69un2RBxXNful7N78pzdu1inB1xqBEQw7o7/JC6azCl08L9J
         Gn8ZL7j9/QFiNWRUsn1HBksn7j+pxpZgeTfsG/dsZB5vgeHmQgpSpUzAdYZvORHcNbeu
         XPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kLiRGUkNZZyv46T9YISHgYl2pq9Orl33xT/dCTiZiSw=;
        b=oAcvR3WYaBuSxiQ0FoID0c/o2L2q1tpxgNrweEpNS2LSNU2cTNYrPC/Vl0YFkngJ8o
         9K5fTxF7oUbkAnWYCkpwuOgZfx4oEvOy7T6eNa7wIkM4ErUCJcwLrhs1ISg2O6RduWpI
         QraCdOhIYH0D/ABZEnc5+I2+9LODQyRWWoGOgb8EZkDNk6QYn0wm8YqFrkIOXcCc5Uxo
         9lPbf3wEInjiBj69lbVctvDVWB6TEOUnaCIXFkREoRdHXmJxsJIBaMvYYMYzSVjN3h+P
         LK1/hlppVf1D2+3XTLbJXq/LjZnfvrWcw8NSmRafCasFzqIbknnrO7nWETins7chce+G
         INyA==
X-Gm-Message-State: APt69E2b9bor3aTM1UY3ksfRwH3kQojQcEqcwAqvya5Y/5x+OJgnqzY1
        KUhfTr6bE+TT5KH0DWNoAe8Nbez6+uYN/gpI4+8=
X-Google-Smtp-Source: AAOMgpf2J4Cxo7NyU37z/HsIXg3Ipad73c4Vy9+MwHbRgADUyjUBqTJFAaN08B9Jj5t+hePmt3EgnBDn7G58JCUklkI=
X-Received: by 2002:aca:b3c5:: with SMTP id c188-v6mr23314493oif.9.1530641498599;
 Tue, 03 Jul 2018 11:11:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 11:11:38 -0700 (PDT)
In-Reply-To: <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
References: <20180622194752.11221-1-logang@deltatee.com> <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com> <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Jul 2018 15:11:38 -0300
Message-ID: <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-ntb@googlegroups.com,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 3:09 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Btw, what is the environment did you use to build it?
> and what is the environment / make variable you supply (like ARCH,
> CROSS_COMPILE, etc)?

I build it on a Dell laptop running Ubuntu 16.04 with the following
variables exported:

export ARCH=arm
export CROSS_COMPILE=/usr/bin/arm-linux-gnueabi-
