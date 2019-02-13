Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF2BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63E62086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="JHDiYecu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393755AbfBMSbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:31:42 -0500
Received: from onstation.org ([52.200.56.107]:36190 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387678AbfBMSbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:31:42 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id E678B15F;
        Wed, 13 Feb 2019 18:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1550082701;
        bh=ucMw8eFInA1zowVnTNPmnx8YMwsmQzE8Ehm8DJBVAOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JHDiYecuKeoupulfSHKiITYQCt7yutMnj0xNt8qAnAQFBakv9/mNmJjGWTjXOwM1D
         UQusgX8iIbIQHBe8Q+TaqZt1b7l6meCXZ+oLa5dzx9WnL6n8bUjk9AUYNxkFnfnOUZ
         d7SPBdOXjEnH8HA/6Q43p/0fDff2cSLcwPIIKWEk=
Date:   Wed, 13 Feb 2019 13:31:40 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Feb 13 (drivers/spmi/spmi-pmic-arb.c)
Message-ID: <20190213183140.GA4178@basecamp>
References: <20190213183900.2f68474f@canb.auug.org.au>
 <fb0508f1-131d-ff17-9b5d-123ec75275dd@infradead.org>
 <8f25ce2b-968f-423a-08c3-35c824b369f8@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f25ce2b-968f-423a-08c3-35c824b369f8@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 06:18:17PM +0100, Marc Gonzalez wrote:
> On 13/02/2019 17:47, Randy Dunlap wrote:
> 
> > seen on i386:
> > 
> > when CONFIG_IRQ_DOMAIN_HIERARCHY is not enabled:
> > 
> > ../drivers/spmi/spmi-pmic-arb.c:1154:2: error: unknown field ‘activate’ specified in initializer
> >   .activate = qpnpint_irq_domain_activate,
> >   ^
> > ../drivers/spmi/spmi-pmic-arb.c:1154:2: warning: initialization from incompatible pointer type [enabled by default]
> > ../drivers/spmi/spmi-pmic-arb.c:1154:2: warning: (near initialization for ‘pmic_arb_irq_domain_ops.match’) [enabled by default]
> > ../drivers/spmi/spmi-pmic-arb.c:1155:2: error: unknown field ‘alloc’ specified in initializer
> >   .alloc = qpnpint_irq_domain_alloc,
> >   ^
> > ../drivers/spmi/spmi-pmic-arb.c:1155:2: warning: initialization from incompatible pointer type [enabled by default]
> > ../drivers/spmi/spmi-pmic-arb.c:1155:2: warning: (near initialization for ‘pmic_arb_irq_domain_ops.select’) [enabled by default]
> > ../drivers/spmi/spmi-pmic-arb.c:1156:2: error: unknown field ‘free’ specified in initializer
> >   .free = irq_domain_free_irqs_common,
> >   ^
> > ../drivers/spmi/spmi-pmic-arb.c:1156:10: error: ‘irq_domain_free_irqs_common’ undeclared here (not in a function)
> >   .free = irq_domain_free_irqs_common,
> >           ^
> > ../drivers/spmi/spmi-pmic-arb.c:1157:2: error: unknown field ‘translate’ specified in initializer
> >   .translate = qpnpint_irq_domain_translate,
> >   ^
> > ../drivers/spmi/spmi-pmic-arb.c:1157:2: warning: initialization from incompatible pointer type [enabled by default]
> > ../drivers/spmi/spmi-pmic-arb.c:1157:2: warning: (near initialization for ‘pmic_arb_irq_domain_ops.unmap’) [enabled by default]

drivers/pinctrl/qcom/Kconfig already has this in linux-next:

config PINCTRL_QCOM_SPMI_PMIC
       tristate "Qualcomm SPMI PMIC pin controller driver"
       ...
       select IRQ_DOMAIN_HIERARCHY

Am I missing something else?

Brian
