Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B3F5AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C582086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ilWRFtAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C582086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934448AbeFLP1Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:27:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52776 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933845AbeFLP1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=K7QWjCLzyUpUNATe0WXJicNygYPxbkC9Lqgf/l3Bh94=; b=ilWRFtAoaj9C02/sDNWpzN1qCG
        9P8SZDrYL06vF7hfpcjgTyt414x+1DvHqPGgzG87TNBK7yXGBhjjpeROmoO0D2O4H1qrTJOHU8bh8
        ECyTUY+ZaguRXMF5lXkRiy+y2um3Rex0Yps7hCZKl0bN0STEQnj1x92rS5ywI1SSm5Ra2UvZRf2o9
        psGPY+UYzRzfK6+FVNHJ1Z0Z2hWcttLi6EH8X2zGZdz7WdfaC0Nqb8Tl3/0qmBCF29rPRJRnUlB1K
        gw4FYBAd6Z382W6dz6Myvi1YZAPhB4ta8fUYmGSl6FW7blL/SB1p2IUB6gFWh8gl5Yq4PIucDeiJM
        jwakAdUw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSlCW-0004T1-Sf; Tue, 12 Jun 2018 15:27:17 +0000
Subject: Re: [PATCH v6 06/29] fpga: add device feature list support
To:     Wu Hao <hao.wu@intel.com>, atull@kernel.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
 <1528798243-2029-7-git-send-email-hao.wu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e4e6c6b4-bf85-64e0-5d4b-f0816c2f941c@infradead.org>
Date:   Tue, 12 Jun 2018 08:27:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528798243-2029-7-git-send-email-hao.wu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/12/2018 03:10 AM, Wu Hao wrote:

> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index ee9c542..4052532 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -130,4 +130,20 @@ config OF_FPGA_REGION
>  	  Support for loading FPGA images by applying a Device Tree
>  	  overlay.
>  
> +config FPGA_DFL
> +	tristate "FPGA Device Feature List (DFL) support"
> +	select FPGA_BRIDGE
> +	select FPGA_REGION
> +	help
> +	  Device Feature List (DFL) defines a feature list structure that
> +	  creates a link list of feature headers within the MMIO space

	          a linked list

> +	  to provide an extensible way of adding features for FPGA.
> +	  Driver can walk through the feature headers to enumerate feature
> +	  devices (e.g FPGA Management Engine, Port and Accelerator

	          (e.g.

> +	  Function Unit) and their private features for target FPGA devices.
> +
> +	  Select this option to enable common support for Field-Programmable
> +	  Gate Array (FPGA) solutions which implement Device Feature List.
> +	  It provides enumeration APIs, and feature device infrastructure.

	                              ^no comma

> +
>  endif # FPGA


-- 
~Randy
