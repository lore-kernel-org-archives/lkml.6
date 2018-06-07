Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MzHAGzvsGFtzXAAAmS7hNA
	; Thu, 07 Jun 2018 08:26:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 50FB6607F7; Thu,  7 Jun 2018 08:26:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4AE0660115;
	Thu,  7 Jun 2018 08:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4AE0660115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932747AbeFGI0a (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:26:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35422 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752570AbeFGI00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:26:26 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fQqFU-0005OU-9W; Thu, 07 Jun 2018 08:26:24 +0000
Subject: Re: [PATCH][next] pinctrl: pinctrl-single: add allocation failure
 checking of saved_vals
To: Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20180606134338.4645-1-colin.king@canonical.com>
 <CAHp75Vd0Djw+nDN7u=-CLEfdDGA5QTsMueOb9EZLNnCDgso5fA@mail.gmail.com>
 <20180607073543.GP13775@localhost>
From: Colin Ian King <colin.king@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a197ff75-627a-b0b1-1683-ef1b3ff4ebfd@canonical.com>
Date: Thu, 7 Jun 2018 09:26:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180607073543.GP13775@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/18 08:35, Johan Hovold wrote:
> On Wed, Jun 06, 2018 at 07:02:03PM +0300, Andy Shevchenko wrote:
>> On Wed, Jun 6, 2018 at 4:43 PM, Colin King <colin.king@canonical.com> wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Currently saved_vals is being allocated and there is no check for
>>> failed allocation (which is more likely than normal when using
>>> GFP_ATOMIC).  Fix this by checking for a failed allocation and
>>> propagating this error return down the the caller chain.
>>>
>>> Detected by CoverityScan, CID#1469841 ("Dereference null return value")
>>>
>>> Fixes: 88a1dbdec682 ("pinctrl: pinctrl-single: Add functions to save and restore pinctrl context")
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>  drivers/pinctrl/pinctrl-single.c | 14 +++++++++++---
>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
>>> index 9c3c00515aa0..0905ee002041 100644
>>> --- a/drivers/pinctrl/pinctrl-single.c
>>> +++ b/drivers/pinctrl/pinctrl-single.c
>>> @@ -1588,8 +1588,11 @@ static int pcs_save_context(struct pcs_device *pcs)
>>>
>>>         mux_bytes = pcs->width / BITS_PER_BYTE;
>>>
>>> -       if (!pcs->saved_vals)
>>> +       if (!pcs->saved_vals) {
>>>                 pcs->saved_vals = devm_kzalloc(pcs->dev, pcs->size, GFP_ATOMIC);
>>
>>> +               if (!pcs->saved_vals)
>>> +                       return -ENOMEM;
>>
>> Wouldn't make sense to move it out of the first condition?
>>
>> Something like
>>
>> if (!foo)
>>  foo = ...malloc(...);
>> if (!foo)
>>  return ...
> 
> No, checking for NULL immediately after the allocation is more obvious
> and easier to parse.

+1 on that
> 
> Johan
> 
