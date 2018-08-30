Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25590C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20B520658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BcNJezh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20B520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeH3VSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:18:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41038 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeH3VSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+xa5Dhb70YcwJAZdPES/RuEEFJy18ffurdXijKdpREw=; b=BcNJezh2JbyLD0fK++DkuaBlI
        87TCRQQpSIncevbiNpza+RccOnvUf13sspgbsUyQSTJ9MefygIPSAop9UA4kcuGs2fGn3iDg5w+l5
        Kr8N0RO9u8Rvpx+0WLauwIgFzeE04C9vFsxIhmdHVZtN7v2qLLH6gw4arKZhCj6Pd3LQv6RBpS06m
        +zxQwCkTk0kiyZ0KjPSL9mGlgsYXaJAVlIENJ4yPBxuvSanVqDCfTEvAi4OA+6HsHHx8p8alhsZm4
        wPI62BJDn/kVxO9C2YTAboONdnVWDHr2Jce9R8GyLLZYQsMl6eqlW62C1BWu0bb6IcDwUfuYcj2fJ
        2pcOyqubw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvQXB-000206-Fj; Thu, 30 Aug 2018 17:15:05 +0000
Subject: Re: [PATCH V1] add huawei ibma driver modules The driver is used for
 communication between in-band management agent(iBMA) and out-of-band
 management controller(iBMC) via pcie bus in Huawei V3 server. The driver
 provides character device,VNIC and black box interface for application layer.
To:     xiongsujuan <xiongsujuan.xiongsujuan@huawei.com>,
        davem@davemloft.net, zhaochen6@huawei.com,
        aviad.krawczyk@huawei.com, romain.perier@collabora.com,
        bhelgaas@google.com, keescook@chromium.org,
        colin.king@canonical.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535591472-44997-1-git-send-email-xiongsujuan.xiongsujuan@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dc265e3c-3836-d954-5de3-d7b8701ce986@infradead.org>
Date:   Thu, 30 Aug 2018 10:15:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535591472-44997-1-git-send-email-xiongsujuan.xiongsujuan@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please fix the Subject: and patch description.

(more below)

On 08/29/2018 06:11 PM, xiongsujuan wrote:
> diff --git a/drivers/net/ethernet/huawei/Kconfig b/drivers/net/ethernet/huawei/Kconfig
> index c1a95ae..68748e9 100644
> --- a/drivers/net/ethernet/huawei/Kconfig
> +++ b/drivers/net/ethernet/huawei/Kconfig
> @@ -4,7 +4,7 @@
>  
>  config NET_VENDOR_HUAWEI
>  	bool "Huawei devices"
> -	default y
> +	default y 

Don't add a space after the 'y'.

>  	---help---
>  	  If you have a network (Ethernet) card belonging to this class, say Y.
>  	  Note that the answer to this question doesn't directly affect the
> @@ -16,4 +16,7 @@ if NET_VENDOR_HUAWEI
>  
>  source "drivers/net/ethernet/huawei/hinic/Kconfig"
>  
> +source "drivers/net/ethernet/huawei/ibma/Kconfig"
> +
> +
>  endif # NET_VENDOR_HUAWEI

> diff --git a/drivers/net/ethernet/huawei/ibma/Kconfig b/drivers/net/ethernet/huawei/ibma/Kconfig
> new file mode 100644
> index 0000000..810cc60
> --- /dev/null
> +++ b/drivers/net/ethernet/huawei/ibma/Kconfig
> @@ -0,0 +1,17 @@
> +#
> +# Huawei driver configuration
> +#
> +
> +config IBMANIC
> +	tristate "Huawei IBMA PCIE Network Interface Card"
> +	depends on (PCI_MSI && X86)
> +	---help---
> +	  This driver supports IBMANIC PCIE Ethernet cards.
> +	  To compile this driver as part of the kernel, choose Y here.
> +	  If unsure, choose N.
> +	  The default is compiled as module.
> +
> +
> +
> +
> +

Drop those trailing blank lines.

What makes the default be compiled as module?

thanks,
-- 
~Randy
