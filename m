Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4624AC6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 00:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61FE27D69
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 00:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BBEWZGmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61FE27D69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937006AbeF3AR6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 20:17:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40178 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935547AbeF3ARz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 20:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H6Q6VHQS6J9JhxR3v2C/k7BvARgy0MINFw/ehuGQFFU=; b=BBEWZGmJDIUGD6GXpSfjcEeLW
        gygpy9JQP4moc09mfWT7KHAljceAg6X41RjNgnBFtjZg/GvUu/cXLR1ypdWIr800mMIZiRy3cgNAQ
        LEBK4jdXnZCnzJi19dzZGneyht8vuZw3OGkzVFQl2LpI6ixYh2KjCNTOBy07ZCL+Dj287TEI4AL/3
        9M9+asZK4L4KyaVySqf4xDGgVcgBYxKOpdW1V8Trw0WG1AcOQ8C2RgkoAtYRtPKR2A9G2wpHzvkv3
        wQfdlxdz1iEX+jRcIzS8/+u/E5ILmz/ISoCbkDYyNJ1CQuXl0VyHYtp8RP3Tt0c+Gll3Z23yMquAN
        6oh4E/bVw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZ3aI-0005BW-IA; Sat, 30 Jun 2018 00:17:50 +0000
Subject: Re: [PATCH v6] drivers/staging: Gasket driver framework + Apex driver
To:     Simon Que <sque@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Chan <benchan@chromium.org>,
        Chun-Ta Lin <itspeter@chromium.org>,
        Zhongze Hu <frankhu@chromium.org>,
        Joe Perches <joe@perches.com>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>
References: <20180630000253.70103-1-sque@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d46ff130-45b5-d971-94f2-1650de891682@infradead.org>
Date:   Fri, 29 Jun 2018 17:17:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180630000253.70103-1-sque@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/18 17:02, Simon Que wrote:
> diff --git a/drivers/staging/gasket/Kconfig b/drivers/staging/gasket/Kconfig
> new file mode 100644
> index 000000000000..3465e8510fc2
> --- /dev/null
> +++ b/drivers/staging/gasket/Kconfig
> @@ -0,0 +1,23 @@
> +menu "Gasket devices"
> +
> +config STAGING_GASKET_FRAMEWORK
> +	tristate "Gasket framework"
> +	depends on PCI
> +	help
> +		This framework supports Gasket-compatible devices, such as Apex.
> +		It is required for either of those modules.

Either of what modules?
Maybe "for any of those modules." ?


Also, Kconfig help text indentation is (from Documentation/process/coding-style.rst):

Lines under a ``config`` definition are indented with one tab, while help text
is indented an additional two spaces.

so one tab + 2 spaces, please, above and below here.

> +
> +		To compile this driver as a module, choose M here.  The module
> +		will be called "gasket".
> +
> +config STAGING_APEX_DRIVER
> +	tristate "Apex Driver"
> +	depends on STAGING_GASKET_FRAMEWORK
> +	help
> +		This driver supports the Apex device.  Say Y if you want to
> +		include this driver in the kernel.
> +
> +		To compile this driver as a module, choose M here.  The module
> +		will be called "apex".
> +
> +endmenu


-- 
~Randy
