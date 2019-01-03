Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15FFC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8E820883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hjeN1LTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfACICe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:02:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfACICd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N1HCgu/9K4V4ycQY5lpDdUrvXqrbs6vliV6vgmhMQeo=; b=hjeN1LTitYs39NSSyarC9ltuw
        HFa26YaNUPGl69BWXTqAy1ra1FET2JcwwpFduj/ngNKgTdogVbl8096ZAydzf42oUhUnad9iUGcWK
        fqV6jVhdMtqOsm0e0hYCRGWcexaFL/xwXS7xzfGw3axYGZ1WFiA/SQ/YOzcdjDJR4b5aw27Nfvmcz
        7MlkaqzeKiQXxj8BYt3HexMDUqs7WyGRppJZkX+XMiNgUeyGb5ql1ShALbbW0Slr26EMHCkLdIyav
        /bhD8fu/JihREDIoQ46d2cHnT6js43FqXqJtAjQBYzCsBJkacGWHvT3YC/5KoMLX2JSLhhL6p//9C
        Jo6jshKwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gexxV-00061C-NC; Thu, 03 Jan 2019 08:02:29 +0000
Date:   Thu, 3 Jan 2019 00:02:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 05/25] char/nvram: Adopt arch_nvram_ops
Message-ID: <20190103080229.GB11147@infradead.org>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <66ed571883695314ace53080df8f6dfb132a8b4d.1545784679.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ed571883695314ace53080df8f6dfb132a8b4d.1545784679.git.fthain@telegraphics.com.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +const struct nvram_ops arch_nvram_ops = {
> +	.read_byte      = nvram_read_byte,
> +	.write_byte     = nvram_write_byte,
> +	.get_size       = nvram_get_size,
> +};
> +EXPORT_SYMBOL(arch_nvram_ops);

I think something this internal should always be EXPORT_SYMBOL_GPL.
