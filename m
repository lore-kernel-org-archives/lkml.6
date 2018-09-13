Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E99FC618E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327DD217A6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dxt/QZTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327DD217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeIMWYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:24:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeIMWYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cg+oraMLuOFlFGPtICaBKWuy4PhgA+/ILPYQ5VNUbig=; b=dxt/QZTGY6ELie5ybRfQaHGwp
        ceTtupBt9NRWKwZPjDMyudvO/xG3xtnYIJbOzTeD3uWD07lAS/jwDh5mNBceRaexkLhfVjq3KSflJ
        WOtl6y85LzubgAmIHGoA9CMW+Afc21lYTricgfI5FwUPBKFv/ltTLI7ZfxuOgCGP7Xvx/JWZK2fyv
        XcUQ+I/L31xYw472u0HNayJHis7xUoC7Xaj7vuJCQm7eLtosa5h6wAkGn+QW9WUYw717RSM2s3Gdw
        OkTCJ3gBcHuE0zBHQh7UyA4EsUKYWMWrLEpfPnieQLJSnoRKxlon7dWVgYKzleOR05EHs/x4zIGGs
        vB19tFyvw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0VC6-00083u-L9; Thu, 13 Sep 2018 17:14:18 +0000
Subject: Re: linux-next: Tree for Sep 13 (drivers/media/platform/imx-pxp)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media <linux-media@vger.kernel.org>
References: <20180913152753.60866288@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d0604bdf-b8a5-a828-f28e-023e05c767be@infradead.org>
Date:   Thu, 13 Sep 2018 10:14:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180913152753.60866288@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/18 10:27 PM, Stephen Rothwell wrote:
> Hi all,
> 
> News: there will be no linux-next releases on Friday or Monday.
> 
> Changes since 20180912:
> 

on i386 or x86_64:

../drivers/media/platform/imx-pxp.c:988:1: error: unknown type name 'irqreturn_t'
 static irqreturn_t pxp_irq_handler(int irq, void *dev_id)
 ^
../drivers/media/platform/imx-pxp.c: In function 'pxp_irq_handler':
../drivers/media/platform/imx-pxp.c:1012:9: error: 'IRQ_HANDLED' undeclared (first use in this function)
  return IRQ_HANDLED;
         ^
../drivers/media/platform/imx-pxp.c:1012:9: note: each undeclared identifier is reported only once for each function it appears in
../drivers/media/platform/imx-pxp.c: In function 'pxp_probe':
../drivers/media/platform/imx-pxp.c:1660:2: error: implicit declaration of function 'devm_request_threaded_irq' [-Werror=implicit-function-declaration]
  ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, pxp_irq_handler,
  ^
../drivers/media/platform/imx-pxp.c:1661:4: error: 'IRQF_ONESHOT' undeclared (first use in this function)
    IRQF_ONESHOT, dev_name(&pdev->dev), dev);
    ^


Reported-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
