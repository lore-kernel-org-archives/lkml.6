Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C8AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED032086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aAqpwmfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfARJUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:20:19 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1999 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbfARJUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:20:19 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c419a330000>; Fri, 18 Jan 2019 01:19:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 18 Jan 2019 01:20:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 18 Jan 2019 01:20:18 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 18 Jan
 2019 09:20:16 +0000
Subject: Re: [PATCH V1] i2c: tegra: increase transfer timeout
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        <thierry.reding@gmail.com>, <mkarthik@nvidia.com>,
        <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>
References: <1547757572-29075-1-git-send-email-skomatineni@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c6ba237c-d271-c9d7-1c30-9901ba6bb1a0@nvidia.com>
Date:   Fri, 18 Jan 2019 09:20:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547757572-29075-1-git-send-email-skomatineni@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547803187; bh=2NQfxEXC3F9l3nh7cvxnkwctaWGqGIMJdOMr1SOUalw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=aAqpwmfQN9Yq1vFiGyxfJGfen077u8wpz072QopSNjJir8u7Qz1Ug+xILo6lt9/OD
         cTtjzaFDQhmwdPpTJSOvLRlQ2rDo8iehN4TYrGtHtmoLJnvWp5QAlrFf8NmdsCAIGk
         HkGK4OAQtvQwjfn75MITuzJ8EfkpZpW9N5WSeLSEGAYviBosb0NRcqHWXtI3qvXRSZ
         F7Imnejxf9wnL7X1u0tVL4gIsAwldvVReV5TzG6A7P6olQeZxexWoFJ9fU6vkMi2Ae
         zx2zxe5QgYrsuVhzcItDKR2z1ehUdmxIr5knZI4ytZhdYm6zdnLOFBwCzl71u7PjxL
         GBDfkfCe0gnQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/01/2019 20:39, Sowjanya Komatineni wrote:
> increase transfer timeout to 10s to allow enough time during max
> transfer size.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/i2c/busses/i2c-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index e417ebf7628c..ca7c581fb4c0 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -25,7 +25,7 @@
>  
>  #include <asm/unaligned.h>
>  
> -#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
> +#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(10000))
>  #define BYTES_PER_FIFO_WORD 4
>  
>  #define I2C_CNFG				0x000

Should the timeout be set depending on the max transfer size? 10s seems
an age if the max transfer size is 4KB. In other words, we should this
only be applied for T194+?

Furthermore, in tegra_i2c_xfer_msg() we know the len of the message and
so maybe it would be better to dynamically set the timeout depending on
length?

Cheers
Jon

-- 
nvpublic
