Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D841AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E8D222CF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SCeoAlFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392717AbfBMQrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:47:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391852AbfBMQrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KPUGRMyaRFr6TTJIbDoVRY383RX5bnKeXNiWj5o2h9I=; b=SCeoAlFY6MUKxEp+n7DjNiAK4
        ezYQzJCAfjVSKki4PDxILJJFidfXoSssPYzIsDnrv2w5CKIdzra+EHNj3aHfLeGfrz0YIKSN0tdso
        1GdwNbUJ21ioGShcsQgBqTy/QRMZPxgtGXdrmZoYj5DmKM4NBUVRYcMjaNmejLreJITrDIofDsPWb
        9XLJK85i5q4kkrZOVK1gWX62A5lWkuN69X7W9hfrectBU3uF4pSpwgp/pDqle+QVtb8RLcIDkYZ95
        PYdgJhT0srcl73XERg2t4+MOTOrrFJybcvC5ajcBNx3fqQ+amb/IVh56emCgoes5pTOCncTT340PZ
        dSLD2Entw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtxgh-0008MO-SH; Wed, 13 Feb 2019 16:47:07 +0000
Subject: Re: linux-next: Tree for Feb 13 (drivers/spmi/spmi-pmic-arb.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org
References: <20190213183900.2f68474f@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fb0508f1-131d-ff17-9b5d-123ec75275dd@infradead.org>
Date:   Wed, 13 Feb 2019 08:47:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190213183900.2f68474f@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 11:39 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190212:
> 

seen on i386:

when CONFIG_IRQ_DOMAIN_HIERARCHY is not enabled:

../drivers/spmi/spmi-pmic-arb.c:1154:2: error: unknown field ‘activate’ specified in initializer
  .activate = qpnpint_irq_domain_activate,
  ^
../drivers/spmi/spmi-pmic-arb.c:1154:2: warning: initialization from incompatible pointer type [enabled by default]
../drivers/spmi/spmi-pmic-arb.c:1154:2: warning: (near initialization for ‘pmic_arb_irq_domain_ops.match’) [enabled by default]
../drivers/spmi/spmi-pmic-arb.c:1155:2: error: unknown field ‘alloc’ specified in initializer
  .alloc = qpnpint_irq_domain_alloc,
  ^
../drivers/spmi/spmi-pmic-arb.c:1155:2: warning: initialization from incompatible pointer type [enabled by default]
../drivers/spmi/spmi-pmic-arb.c:1155:2: warning: (near initialization for ‘pmic_arb_irq_domain_ops.select’) [enabled by default]
../drivers/spmi/spmi-pmic-arb.c:1156:2: error: unknown field ‘free’ specified in initializer
  .free = irq_domain_free_irqs_common,
  ^
../drivers/spmi/spmi-pmic-arb.c:1156:10: error: ‘irq_domain_free_irqs_common’ undeclared here (not in a function)
  .free = irq_domain_free_irqs_common,
          ^
../drivers/spmi/spmi-pmic-arb.c:1157:2: error: unknown field ‘translate’ specified in initializer
  .translate = qpnpint_irq_domain_translate,
  ^
../drivers/spmi/spmi-pmic-arb.c:1157:2: warning: initialization from incompatible pointer type [enabled by default]
../drivers/spmi/spmi-pmic-arb.c:1157:2: warning: (near initialization for ‘pmic_arb_irq_domain_ops.unmap’) [enabled by default]



-- 
~Randy
