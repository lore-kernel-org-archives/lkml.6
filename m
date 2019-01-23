Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E16C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA492217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfAWSJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:09:10 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.234]:21000 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726281AbfAWSJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:09:09 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id B80E4816B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:09:08 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mMxYg9eicYTGMmMxYgs8vA; Wed, 23 Jan 2019 12:09:08 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=50044 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmMxY-000i3W-C2; Wed, 23 Jan 2019 12:09:08 -0600
Subject: Re: [PATCH net-next] net/mlx4: Mark expected switch fall-through
To:     David Miller <davem@davemloft.net>
Cc:     tariqt@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190123080511.GA32528@embeddedor>
 <20190123.090803.438719975498577995.davem@davemloft.net>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Message-ID: <e27972ea-dc6a-569d-638f-293067c95059@embeddedor.com>
Date:   Wed, 23 Jan 2019 12:09:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123.090803.438719975498577995.davem@davemloft.net>
Content-Type: text/plain; charset=iso-8859-7
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmMxY-000i3W-C2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.130.205]:50044
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/19 11:08 AM, David Miller wrote:
> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> Date: Wed, 23 Jan 2019 02:05:11 -0600
> 
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> This patch fixes the following warning:
>>
>> drivers/net/ethernet/mellanox/mlx4/eq.c: In function ¡mlx4_eq_int¢:
>> drivers/net/ethernet/mellanox/mlx4/mlx4.h:219:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>   if (mlx4_debug_level)      \
>>      ^
>> drivers/net/ethernet/mellanox/mlx4/eq.c:558:4: note: in expansion of macro ¡mlx4_dbg¢
>>     mlx4_dbg(dev, "%s: MLX4_EVENT_TYPE_SRQ_LIMIT. srq_no=0x%x, eq 0x%x\n",
>>     ^~~~~~~~
>> drivers/net/ethernet/mellanox/mlx4/eq.c:561:3: note: here
>>    case MLX4_EVENT_TYPE_SRQ_CATAS_ERROR:
>>    ^~~~
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enabling
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied.
> 

Thank you both, Tariq and David.

--
Gustavo
