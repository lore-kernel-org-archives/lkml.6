Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF93C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB5120821
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392862AbfBMRSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:18:34 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:31572 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfBMRSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:18:34 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id C2D0F13F8CD;
        Wed, 13 Feb 2019 18:18:17 +0100 (CET)
Subject: Re: linux-next: Tree for Feb 13 (drivers/spmi/spmi-pmic-arb.c)
To:     Brian Masney <masneyb@onstation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190213183900.2f68474f@canb.auug.org.au>
 <fb0508f1-131d-ff17-9b5d-123ec75275dd@infradead.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <8f25ce2b-968f-423a-08c3-35c824b369f8@free.fr>
Date:   Wed, 13 Feb 2019 18:18:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <fb0508f1-131d-ff17-9b5d-123ec75275dd@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2019 17:47, Randy Dunlap wrote:

> seen on i386:
> 
> when CONFIG_IRQ_DOMAIN_HIERARCHY is not enabled:
> 
> ../drivers/spmi/spmi-pmic-arb.c:1154:2: error: unknown field ‘activate’ specified in initializer
>   .activate = qpnpint_irq_domain_activate,
>   ^
> ../drivers/spmi/spmi-pmic-arb.c:1154:2: warning: initialization from incompatible pointer type [enabled by default]
> ../drivers/spmi/spmi-pmic-arb.c:1154:2: warning: (near initialization for ‘pmic_arb_irq_domain_ops.match’) [enabled by default]
> ../drivers/spmi/spmi-pmic-arb.c:1155:2: error: unknown field ‘alloc’ specified in initializer
>   .alloc = qpnpint_irq_domain_alloc,
>   ^
> ../drivers/spmi/spmi-pmic-arb.c:1155:2: warning: initialization from incompatible pointer type [enabled by default]
> ../drivers/spmi/spmi-pmic-arb.c:1155:2: warning: (near initialization for ‘pmic_arb_irq_domain_ops.select’) [enabled by default]
> ../drivers/spmi/spmi-pmic-arb.c:1156:2: error: unknown field ‘free’ specified in initializer
>   .free = irq_domain_free_irqs_common,
>   ^
> ../drivers/spmi/spmi-pmic-arb.c:1156:10: error: ‘irq_domain_free_irqs_common’ undeclared here (not in a function)
>   .free = irq_domain_free_irqs_common,
>           ^
> ../drivers/spmi/spmi-pmic-arb.c:1157:2: error: unknown field ‘translate’ specified in initializer
>   .translate = qpnpint_irq_domain_translate,
>   ^
> ../drivers/spmi/spmi-pmic-arb.c:1157:2: warning: initialization from incompatible pointer type [enabled by default]
> ../drivers/spmi/spmi-pmic-arb.c:1157:2: warning: (near initialization for ‘pmic_arb_irq_domain_ops.unmap’) [enabled by default]
