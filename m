Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F4AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D0C2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeLSGst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:48:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34631 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbeLSGss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 01:48:48 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so14192277lfc.1;
        Tue, 18 Dec 2018 22:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e/CPB4gnLhuGEr+6GLr/ob0SBZJAndsZXG7pGBjhfRk=;
        b=WMS8G9Vi9Vl3JWPKQyb36BZNV+MTYU8VGLtnQekHx9pVLSg3gD+/grNisb7w9nui7w
         R8VoTJLE18h101ercxE7XSwZWgcLPI3D8/I4duJD5fBGli2jhM34pb0j7HmdftafKsWr
         46F9SWScaEVG7MS77XzddMNHSMGgOIO6AAN1RogxHcw4BV9YhbGZZebqd7dyQrUMMhT0
         cgBLUqK5pJp4xqQ8+M3/X54Kv/IHklhglT2vRY8D/bp2vdREjvnZzlaI3iJS+6YgMjUI
         m8FImfrJAe3TwYgoOh+etrRF9NHVmn8CKlXgrZ2wG/r2NfYEGj97KQKPbHH/xD/8bj/N
         uzTQ==
X-Gm-Message-State: AA+aEWaJj2p4V3jpqlGH0gfZRReT2S1dhlCapEKLAm0LbxTgaQ/m4du2
        R+25NRfCYJ6Dt/+iLh7jqEg=
X-Google-Smtp-Source: AFSGD/VpCeHnNQ2fUIOi1uM5d/Z6ytDEUMryDXlRxELP2MAacvlxVPRbjFp4mrPxEJ0eCpyZmMSmRQ==
X-Received: by 2002:a19:641d:: with SMTP id y29mr11487735lfb.14.1545202126374;
        Tue, 18 Dec 2018 22:48:46 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q6sm3546848lfh.52.2018.12.18.22.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 22:48:45 -0800 (PST)
Date:   Wed, 19 Dec 2018 08:48:42 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, mazziesaccount@gmail.com,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, vladimir_zapolskiy@mentor.com
Subject: Re: [PATCH v3] regmap: regmap-irq/gpio-max77620: add level-irq
 support
Message-ID: <20181219064842.GG2477@localhost.localdomain>
References: <20181218115931.GA21253@localhost.localdomain>
 <201812182306.X3vcHVlL%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201812182306.X3vcHVlL%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:36:22PM +0800, kbuild test robot wrote:
> Hi Matti,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on regmap/for-next]
> [also build test ERROR on next-20181218]
> [cannot apply to v4.20-rc7]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Matti-Vaittinen/regmap-regmap-irq-gpio-max77620-add-level-irq-support/20181218-225844
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next
> config: x86_64-randconfig-x006-201850 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/base/regmap/regmap-irq.c: In function 'regmap_add_irq_chip':
> >> drivers/base/regmap/regmap-irq.c:644:24: error: 'const struct regmap_irq' has no member named 'type_reg_offset'; did you mean 'reg_offset'?
>        reg = chip->irqs[i].type_reg_offset / map->reg_stride;
>                            ^~~~~~~~~~~~~~~
>                            reg_offset
> >> drivers/base/regmap/regmap-irq.c:645:41: error: 'const struct regmap_irq' has no member named 'type_rising_mask'
>        d->type_buf_def[reg] |= chip->irqs[i].type_rising_mask |
>                                             ^
> >> drivers/base/regmap/regmap-irq.c:646:19: error: 'const struct regmap_irq' has no member named 'type_falling_mask'
>          chip->irqs[i].type_falling_mask;
---

> > Version 3 of this patch is intended to be functionally identical to v2.
> > This patch is rebased on top of a tree which contains changes:
> > "regmap: irq: handle HW using separate rising/falling edge interrupts"
> > from Bartosz Golaszewski and the change
> > "regmap: regmap-irq: Remove default irq type setting from core"
> > (proposed here):
> > https://lore.kernel.org/lkml/20181218105813.GA6957@localhost.localdomain/
> > 
> > There should not be direct dependency to "regmap: regmap-irq: Remove
> > default irq type setting from core" though. Patch was also tested to
> > apply cleany on regmap-tree.

I forgot that the block of code the commit "regmap: regmap-irq: Remove
default irq type setting from core" removes do use the old type specifiers
whcih this patch changes. So even though this patch applies cleanly on tree
which does not include "regmap: regmap-irq: Remove default irq type setting
from core" - it does not mean there is no dependency. This was my brain fart.
There is dependency. "regmap: regmap-irq: Remove default irq type setting
from core" should be applied prior this patch.

Should I combine these two patches as a series (and resend them) or what is
the correct way to note the dependency?

Br,
	Matti Vaittinen

