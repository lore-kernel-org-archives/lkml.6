Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeCPUvb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:51:31 -0400
Received: from [195.159.176.226] ([195.159.176.226]:39817 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeCPUva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:51:30 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] net: ethernet: arc: Fix a potential memory leak if an
 optional regulator is deferred
Date: Fri, 16 Mar 2018 21:51:21 +0100
Message-ID: <89a63178-a08a-5023-a045-018b4d7b11bc@wanadoo.fr>
References: <7fd57a4e7f7a41dccf55430cbc43de3b0a7f7826.1521061530.git.christophe.jaillet@wanadoo.fr>
 <20180316.152712.1584177628223195375.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
In-Reply-To: <20180316.152712.1584177628223195375.davem@davemloft.net>
Content-Language: fr
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/03/2018 à 20:27, David Miller a écrit :
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Date: Wed, 14 Mar 2018 22:09:34 +0100
>
>> diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
>> index 16f9bee992fe..8ee9dfd0e363 100644
>> --- a/drivers/net/ethernet/arc/emac_rockchip.c
>> +++ b/drivers/net/ethernet/arc/emac_rockchip.c
>> @@ -169,8 +169,10 @@ static int emac_rockchip_probe(struct platform_device *pdev)
>>   	/* Optional regulator for PHY */
>>   	priv->regulator = devm_regulator_get_optional(dev, "phy");
>>   	if (IS_ERR(priv->regulator)) {
>> -		if (PTR_ERR(priv->regulator) == -EPROBE_DEFER)
>> -			return -EPROBE_DEFER;
>> +		if (PTR_ERR(priv->regulator) == -EPROBE_DEFER) {
>> +			ret = -EPROBE_DEFER;
>> +			goto out_clk_disable;
>> +		}
> Please build test your changes.
>
> There is no 'ret' variable in this function, perhaps you meant 'err'.
>
Yes, obviously, this is 'err'.

I apologize. I usually build-test all my patches before submission.
This one seems to have gone out of my normal process.

Can you fix it yourself or do you want me to re-submit?

CJ
