Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D098C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8772229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NKEbOPXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfBNEIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:08:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBNEIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 23:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gRrf5RxuXHNYSMfXoXc/hIs/Gm7aSHJoMlb4pTjQPwg=; b=NKEbOPXteTuAAi3UsUqQC3MJB
        B3BAcxVf7Bu8Y0fGyVjCsGYYqXIbIspAoyD7Er+jN3p2kYAxEKXPiY/rgeTpiZlYgcIQ1CfEC+riQ
        bHulgiSt4Q3zREmFvp/mKFAINEZmqBHiUubV0k/6tLydshtKZUEg3/19FHZldYtUx9VxDn/7YYYsp
        JuS35E65KB57HwgXx/0AS8gl+/UqwsRzYatjPPtXB9GCgA/5JedgPqjycSAyQdhYey84LXAXFENTR
        9BNBtGjxKOxSK/8d2BhuJzmvwYeK2hVmO0ATCWKg6f/t7cC355W6oxm2PKo0NUaZK20KAiDrtIVV+
        1y/Ajowjw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gu8K5-0000xR-FU; Thu, 14 Feb 2019 04:08:29 +0000
Subject: Re: [PATCH 2/2] rpmsg: add syslog redirection driver
To:     Xiang Xiao <xiaoxiang781216@gmail.com>, gregkh@linuxfoundation.org,
        alexander.shishkin@linux.intel.com,
        andriy.shevchenko@linux.intel.com, ohad@wizery.com,
        bjorn.andersson@linaro.org, wendy.liang@xilinx.com,
        arnaud.pouliquen@st.com, kumar.gala@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guiding Li <liguiding@pinecone.net>
References: <1550116097-29710-1-git-send-email-xiaoxiang@xiaomi.com>
 <1550116097-29710-2-git-send-email-xiaoxiang@xiaomi.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <242f03bc-ce43-7827-3621-57e052672dfe@infradead.org>
Date:   Wed, 13 Feb 2019 20:08:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1550116097-29710-2-git-send-email-xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 7:48 PM, Xiang Xiao wrote:
> From: Guiding Li <liguiding@pinecone.net>
> 
> This driver allows the remote processor redirect the output of

                                processor to redirect

> syslog/printf into the kernel log, which is very useful to see
> what happen in the remote side.
> 
> Signed-off-by: Guiding Li <liguiding@pinecone.net>
> ---
>  drivers/rpmsg/Kconfig        |  12 ++++
>  drivers/rpmsg/Makefile       |   1 +
>  drivers/rpmsg/rpmsg_syslog.c | 163 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 176 insertions(+)
>  create mode 100644 drivers/rpmsg/rpmsg_syslog.c
> 
> diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
> index d0322b4..d701614 100644
> --- a/drivers/rpmsg/Kconfig
> +++ b/drivers/rpmsg/Kconfig
> @@ -15,6 +15,18 @@ config RPMSG_CHAR
>  	  in /dev. They make it possible for user-space programs to send and
>  	  receive rpmsg packets.
>  
> +config RPMSG_SYSLOG
> +	tristate "RPMSG syslog redirection"
> +	depends on RPMSG
> +	help
> +	  Say Y here to redirect the syslog/printf from remote processor into
> +	  the kernel log which is very useful to see what happen in the remote

	                                         see what happens
	or                                       see what happened

> +	  side.
> +
> +	  If the remote processor hang during bootup or panic at the runtime,

	                          hangs during bootup or panics during runtime,


> +	  We can even cat /sys/kernel/debug/remoteproc/remoteprocX/trace0 to

	  we

> +	  get the last log which doesn't output yet.

	  get the last log which hasn't been output yet.

> +
>  config RPMSG_QCOM_GLINK_NATIVE
>  	tristate
>  	select RPMSG

-- 
~Randy
