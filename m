Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94449C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722962064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722962064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeJVWhN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:37:13 -0400
Received: from mout.web.de ([212.227.15.14]:49249 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbeJVWhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:37:12 -0400
Received: from [192.168.43.108] ([89.15.236.156]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmcRH-1ffXWv3tqd-00aAHc; Mon, 22
 Oct 2018 16:18:15 +0200
Received: from [192.168.43.108] ([89.15.236.156]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmcRH-1ffXWv3tqd-00aAHc; Mon, 22
 Oct 2018 16:18:15 +0200
Subject: Re: [PATCH] rtc: ds1307: fix ds1339 wakealarm support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     stable@vger.kernel.org, Andrea Greco <a.greco@4sigma.it>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181022123812.5782-1-smoch@web.de>
 <20181022135757.GQ17341@piout.net>
From:   Soeren Moch <smoch@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=smoch@web.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3a6041a9-6fef-c113-5962-caa0a24aca49@web.de>
Date:   Mon, 22 Oct 2018 16:18:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181022135757.GQ17341@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-Provags-ID: V03:K1:GqS1Rn1Z5mMU5JEaCgdKYanaZ12XMJUNV2uX0h97Zg98a2QiS6F
 09iIm68kMpGy8U+0RYunprfV9Y9v6fGB+XY9628R1U2/2aldQB3zUCbu0e1uJWqYS+6bbA3
 spkXtCf/gddckL+HlEzrtN0zygUtogKkPIcExqgYS9pZghS2/LfEImXrC0lVXcqakkLSH+3
 +vaJuJ/sJ42wAqmTEeS3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mBwx6qgeD34=:PLNt+GCH1X6igwEs3dQP+O
 K4/uQoMmnVF3OmE3x6p60jV+tlu4OjJoS6XVkeavoOLaL4QAqYIeiz6UTutILPATpKkbSNyrh
 I3ArzNTGOdBCMZMDFdIfWFOJGZS1nzHLcULBf4m2P/Fs0vYNYMKjIRjfuhP91ZRzZ0/Ciupvt
 rfmK8zCnhIJK9mYDvr7yMxU1YiRsLV24beEkmEZbT/bDOqHGYcRiXl2vT4QoF+nUlK3KCjlsH
 7ksoTVgmZNwsO8yJnPem4TFIcaTJFyZ3UXKjbDg23Gn4rIbs3197YcSczSEUw8qFYE1jxPTDe
 uIW+57eAsS9BCdJB3/EDlSZ+f+MtMc0IWNfV492xuLRC7WrhdHVxKemCWCnwAa3G0MF0QvMur
 d91qXB/IMEhhTbHs/ZodhLGxpYC+9E+TgTsue+0yFGVSZ8PPiOVPRB7bJ4xWIxmhQSRRzkhDn
 bvIl0X0tDNdYAkn1urFqSeyOlr4YYPcfkBNhR4Es5tv4+f5r6Hg8EhoyRV7hbsLBiK5A7HyNL
 MPC6UO0uyAVl2YzAoytWb8vKhPmDa0XXKvZnlKtruaJYNb8+GbrrYcLAeaTYrsYE3MXz6c4SV
 acTotNVh2X/Y5vtOw8qqF9sgjd/KG3BPRsB15SQ3qS9EyAgMidndtQgOfVJvSQruk8Q8Ixs2+
 Vc2wD2YN8AT0RKJlRYBiPsz7gQ+OErqfFbzu6b4xS1k3iEULbjveSwhAgWKuSqzTgFxMklJUx
 domk0U17k42nWxvLP1fLzumMN9ontdXZ44yTP8LgpgZ6u4IXEr5nKH+TVuvj6g46EURIh80IH
 6Fv89txNOA5GSd9PSf79MB7rJ2XTOMJj2LpGF+z9q+5+yHaV/c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 22.10.2018 um 15:57 schrieb Alexandre Belloni:
> Hello,
>
> On 22/10/2018 14:38:12+0200, Soeren Moch wrote:
>> Commit 51ed73eb998a1c79a2b0e9bed68f75a8a2c93b9b ("rtc: ds1340: Add support
>> for trickle charger.") breaks ds1339 wakealarm support by limiting
>> accessible registers. Fix this.
>>
>> Fixes: 51ed73eb998a ("rtc: ds1340: Add support for trickle charger.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Soeren Moch <smoch@web.de>
>> --
>> Cc: Andrea Greco <a.greco@4sigma.it>
>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Cc: linux-rtc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  drivers/rtc/rtc-ds1307.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
>> index 4b2b4627daeb..71396b62dc52 100644
>> --- a/drivers/rtc/rtc-ds1307.c
>> +++ b/drivers/rtc/rtc-ds1307.c
>> @@ -1384,7 +1384,6 @@ static void ds1307_clks_register(struct ds1307 *ds1307)
>>  static const struct regmap_config regmap_config = {
>>  	.reg_bits = 8,
>>  	.val_bits = 8,
>> -	.max_register = 0x9,
> I would prefer having a different regmap_config for chips that have more
> registers. I guess you could put a pointer to a regmap_config in chip_desc.
>
What looks strange to me, the original patch (according to its
description) enabled trickle charger functionality for a single chip.
This is something totally different than limiting the register space for
all chips that are supported by this driver. So this seems to be an
accident to me. And this causes an regression for ds1339, which was
supported for years.

Are there any advantages for limiting the address space of i2c devices?
If we really need this, can we apply this partial revert as regression
fix (also for stable) and implement the address space limitation separately?

Thanks,
Soeren

