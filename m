Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFEEC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66852083B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfA3K2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:28:51 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52286 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728985AbfA3K2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:28:51 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0F1EC318A7FFD68FD2CE;
        Wed, 30 Jan 2019 18:28:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 18:28:47 +0800
Subject: Re: [PATCH -next] tty: ipwireless: Fix potential NULL pointer
 dereference
To:     <dsterba@suse.com>, <gregkh@linuxfoundation.org>, <jslaby@suse.com>
References: <20190130102645.17200-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <jikos@kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <6797e409-2cad-fb22-c430-28c7915a2812@huawei.com>
Date:   Wed, 30 Jan 2019 18:28:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190130102645.17200-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pls ignore this, sorry.

On 2019/1/30 18:26, YueHaibing wrote:
> There is a potential NULL pointer dereference in case
> alloc_ctrl_packet() fails and returns NULL.
> 
> Fixes: 099dc4fb6265 ("ipwireless: driver for PC Card 3G/UMTS modem")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/tty/ipwireless/hardware.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/ipwireless/hardware.c b/drivers/tty/ipwireless/hardware.c
> index b0baa4c..1e21ae3 100644
> --- a/drivers/tty/ipwireless/hardware.c
> +++ b/drivers/tty/ipwireless/hardware.c
> @@ -1516,6 +1516,8 @@ static void ipw_send_setup_packet(struct ipw_hardware *hw)
>  			sizeof(struct ipw_setup_get_version_query_packet),
>  			ADDR_SETUP_PROT, TL_PROTOCOLID_SETUP,
>  			TL_SETUP_SIGNO_GET_VERSION_QRY);
> +	if (!ver_packet)
> +		return -ENOMEM;
>  	ver_packet->header.length = sizeof(struct tl_setup_get_version_qry);
>  
>  	/*
> 

