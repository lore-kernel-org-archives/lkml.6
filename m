Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BD0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3AA217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbeLQHYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:24:05 -0500
Received: from mail.ispras.ru ([83.149.199.45]:59614 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbeLQHYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:24:05 -0500
Received: from [10.10.2.219] (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id 5BF8154006B;
        Mon, 17 Dec 2018 10:24:01 +0300 (MSK)
Subject: Re: [PATCH] mailbox: imx: Fix clk handling in imx_mu_probe()
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
References: <1544914904-3809-1-git-send-email-khoroshilov@ispras.ru>
 <20181217060111.hsay6vhqpxyfdbiu@pengutronix.de>
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=khoroshilov@ispras.ru; prefer-encrypt=mutual; keydata=
 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
 kK2E04Fb+Zk1eJvHYRc=
Message-ID: <3ccce5b6-75a5-da94-08e3-985880382d00@ispras.ru>
Date:   Mon, 17 Dec 2018 10:24:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217060111.hsay6vhqpxyfdbiu@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

By chance I took a look at another implementations:

arch/arm/mach-ep93xx/clock.c#L266

int clk_enable(struct clk *clk)
{
	unsigned long flags;

	if (!clk)
		return -EINVAL;
...

arch/c6x/platforms/pll.c#L48

int clk_enable(struct clk *clk)
{
	unsigned long flags;

	if (clk == NULL || IS_ERR(clk))
		return -EINVAL;

So, I am not sure the NULL resistance is a part of the clk_enable()
contract?

--
Alexey


On 17.12.2018 9:01, Oleksij Rempel wrote:
> Hi Alexey,
> 
> On Sun, Dec 16, 2018 at 02:01:44AM +0300, Alexey Khoroshilov wrote:
>> Handling of devm_clk_get() suggests that the driver should support
>> lack of priv->clk. But imx_mu_probe() fails on clk_prepare_enable(NULL)
>> in that case.
>>
>> The patch removes the try to enable absent clk and adds error handling
>> for mbox_controller_register().
>>
>> Found by Linux Driver Verification project (linuxtesting.org).
>>
>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>> ---
>>  drivers/mailbox/imx-mailbox.c | 18 +++++++++++++-----
>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
>> index 363d35d5e49d..ddde398f576e 100644
>> --- a/drivers/mailbox/imx-mailbox.c
>> +++ b/drivers/mailbox/imx-mailbox.c
>> @@ -292,10 +292,12 @@ static int imx_mu_probe(struct platform_device *pdev)
>>  		priv->clk = NULL;
>>  	}
>>  
>> -	ret = clk_prepare_enable(priv->clk);
>> -	if (ret) {
>> -		dev_err(dev, "Failed to enable clock\n");
>> -		return ret;
>> +	if (priv->clk) {
>> +		ret = clk_prepare_enable(priv->clk);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to enable clock\n");
>> +			return ret;
>> +		}
>>  	}
>>  
>>  	for (i = 0; i < IMX_MU_CHANS; i++) {
>> @@ -324,7 +326,13 @@ static int imx_mu_probe(struct platform_device *pdev)
>>  
>>  	imx_mu_init_generic(priv);
>>  
>> -	return mbox_controller_register(&priv->mbox);
>> +	ret = mbox_controller_register(&priv->mbox);
>> +	if (ret) {
>> +		clk_disable_unprepare(priv->clk);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>>  }
>>  
>>  static int imx_mu_remove(struct platform_device *pdev)
>> -- 
>> 2.7.4
>>
>>
> 
> NACK for this patch.
> 
> Here are code snippets from clk framework:
> ============================================================================
> /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
> static inline int clk_prepare_enable(struct clk *clk)
> {
> 	int ret;
> 
> 	ret = clk_prepare(clk);
> 	if (ret)
> 		return ret;
> 	ret = clk_enable(clk);
> 	if (ret)
> 		clk_unprepare(clk);
> 
> 	return ret;
> }
> 
> int clk_prepare(struct clk *clk)
> {
> 	if (!clk)
> 		return 0;
> 
> 	return clk_core_prepare_lock(clk->core);
> }
> 
> int clk_enable(struct clk *clk)
> {
> 	if (!clk)
> 		return 0;
> 
> 	return clk_core_enable_lock(clk->core);
> }
> ============================================================================
> 
> As you can see, complete code path is NULL resistant. Are you trying to
> fix some real issue, or it is a theoretical work?
> 

