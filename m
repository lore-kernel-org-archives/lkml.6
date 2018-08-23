Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2234BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933732150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="F6px5WzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933732150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbeHWQUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:20:17 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:58254 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeHWQUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:20:17 -0400
Date:   Thu, 23 Aug 2018 14:50:36 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] irq: ingenic: Drop dependency on MACH_INGENIC
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, od@zcrc.me,
        linux-kernel@vger.kernel.org
Message-Id: <1535028636.27779.0@crapouillou.net>
In-Reply-To: <201808230923.wfa0xpst%fengguang.wu@intel.com>
References: <20180821134937.3637-1-paul@crapouillou.net>
        <201808230923.wfa0xpst%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535028641; bh=be0J8a2cteKbg7u4vEqL7iBsEkcjD2yhGiDf+0pOaRM=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=F6px5WzBiSrTjcs7NRLGdbtyxRfgEdW3QWT64776j9M85HenwD/r7vbOXMJqwlowu4YvJ6aUGSImwml4xsEY1Eb4ISYQjDS1ob+zKewKxRBxKRVODm5qNAwpf+Kj1gw8H1yLXOPNj06tJx7gDwFUZVO0upMiKIUHNlYPz8TSodg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, forget this patch.

I need to drop the <asm/mach-jz4740/irq.h> include first and
there's a bit of work to do before I can achieve that.

-Paul Cercueil


Le jeu. 23 ao=FBt 2018 =E0 4:30, kbuild test robot <lkp@intel.com> a=20
=E9crit :
> Hi Paul,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on tip/irq/core]
> [also build test WARNING on v4.18 next-20180822]
> [if your patch is applied to the wrong git tree, please drop us a=20
> note to help improve the system]
>=20
> url:   =20
> https://github.com/0day-ci/linux/commits/Paul-Cercueil/irq-ingenic-Drop-d=
ependency-on-MACH_INGENIC/20180822-083429
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget=20
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross=20
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D7.2.0 make.cross ARCH=3Dmips
>=20
> All warnings (new ones prefixed by >>):
>=20
>    In file included from drivers//irqchip/irq-ingenic.c:30:0:
>>>  arch/mips/include/asm/mach-jz4740/irq.h:63:0: warning: "NR_IRQS"=20
>>> redefined
>     #define NR_IRQS (JZ4740_IRQ_ADC_BASE + 6)
>=20
>    In file included from arch/mips/include/asm/irq.h:18:0,
>                     from include/linux/irq.h:23,
>                     from include/asm-generic/hardirq.h:13,
>                     from arch/mips/include/asm/hardirq.h:16,
>                     from include/linux/hardirq.h:9,
>                     from include/linux/interrupt.h:11,
>                     from drivers//irqchip/irq-ingenic.c:19:
>    arch/mips/include/asm/mach-generic/irq.h:12:0: note: this is the=20
> location of the previous definition
>     #define NR_IRQS 128
>=20
>=20
> vim +/NR_IRQS +63 arch/mips/include/asm/mach-jz4740/irq.h
>=20
> 9869848d Lars-Peter Clausen 2010-07-17  62
> 9869848d Lars-Peter Clausen 2010-07-17 @63  #define NR_IRQS=20
> (JZ4740_IRQ_ADC_BASE + 6)
> 9869848d Lars-Peter Clausen 2010-07-17  64
>=20
> :::::: The code at line 63 was first introduced by commit
> :::::: 9869848d12601cdddf097a36aebe0b10dc5d177b MIPS: JZ4740: Add IRQ=20
> handler code
>=20
> :::::: TO: Lars-Peter Clausen <lars@metafoo.de>
> :::::: CC: Ralf Baechle <ralf@linux-mips.org>
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source=20
> Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel=20
> Corporation
=

