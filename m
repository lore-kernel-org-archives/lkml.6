Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0D9C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C4D20870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfBAKjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:39:03 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:52111 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbfBAKjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:39:03 -0500
Received: from [192.168.178.52] ([109.104.54.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MTznO-1ghJ2329Lu-00Qzyb; Fri, 01 Feb 2019 11:38:09 +0100
Subject: Re: [PATCH 2/2] hwmon: pwm-fan: Add optional regulator support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1548781631-5736-1-git-send-email-stefan.wahren@i2se.com>
 <1548781631-5736-2-git-send-email-stefan.wahren@i2se.com>
 <20190131175651.GA16231@roeck-us.net>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <2c05a0dc-6e5a-97a7-bc79-f01275fe956c@i2se.com>
Date:   Fri, 1 Feb 2019 11:38:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131175651.GA16231@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:FQhik6GlkG+GRHwI71D6o38ToirX14WEn7lWHN+O921h12g2SM4
 QXrTSwWbaJW+XufOW6C2jT2pA6LfJ2zy3UJyxOMPZwFxOrSUuL7z71Zi4P7X8DuY7r8Fyx3
 zGBKmCb8xdTgKNn9zmTzfbfRaDFeU+oOsXY/3orGhCEhGOhgYsZ6sInzmFDabDe0A03RFMh
 hWErOFgxUYgdBrK5tOsZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ApUoyVgIt/s=:U9HybeiVYat0tmxGIawnBy
 YbIAHQwnImgYCFNJvKgdfrIjFcxYoVnidAbuSP1Jdk7wb+Swl3Z/yHJahRBlQQ2LD0Bf2P+X9
 3zVvl6WY58FVKa9Uj1CZX85s2SKbFw3BQP5MSCjkkwrQPRw1h4pRRw980TY+BVXkWO1SjI2fd
 YkaMNlR4f4y+4cR5iHAIVyMS9GYIfjK+OwJ5OYxTFg27+F6MfeKLO12HVaBIt06kLkPgzc9QA
 OeKtgDbq/Krise3eqzggpvrf8+R6TNtUsMPm2NS0dchopzFfJPDYvCUwHrCFIjram4RhoP+jb
 gNdVDGf1pDx/50TUZ7viYeFSXuZCwhb4ahuylbKfiSnVNKH1v1hX8cl20Vk6YihzqZ8k038zM
 sHC+2GfpoEvfKL6l5sAU9NiiYzQSn9kh57kzs6VusBgVi/dcKjGmbrCXyPRVq+Fxf0A9/07zb
 bkSXbLlEj9FdhKyfAlpAXlgM6GaBUzsB9fLZh5upiUk2nnpOrz/Izykkaq4gM7zDYltSdAuUB
 rfVgiR2uN5SjPDpkoajhYDOgRzhC0uVjGhTErbbrg6WX3Yhh3cSaOGCVJNae5FGkR8I6dxCBl
 mx9evL+o4WGlUz6/WkZc4pGfJXxZ3Sza/4AEQSQ7eZ2OvZ1p54ij/nkkWMph/sSTT2BEomgeo
 8mPTVM2zKCFKnAiREN2zrRGeCZvsTNrFN9QI6WR9FQ99n6mSXEPK1JwOxrOvtLm8cD+vR2u7s
 0Sb/A/q46rY6qyF9Wdu3MuaMJCnm4yBK11hWiyENr3uFBiMC3C4OWZQyhXc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Am 31.01.19 um 18:56 schrieb Guenter Roeck:
> On Tue, Jan 29, 2019 at 06:07:11PM +0100, Stefan Wahren wrote:
>> This adds optional regulator support to the pwm-fan driver. This is
>> necessary for pwm fans which are powered by a switchable supply.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>  drivers/hwmon/pwm-fan.c | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
>> index 2c94482..9e0591e 100644
>> --- a/drivers/hwmon/pwm-fan.c
>> +++ b/drivers/hwmon/pwm-fan.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/of.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pwm.h>
>> +#include <linux/regulator/consumer.h>
>>  #include <linux/sysfs.h>
>>  #include <linux/thermal.h>
>>  
>> @@ -31,6 +32,7 @@
>>  struct pwm_fan_ctx {
>>  	struct mutex lock;
>>  	struct pwm_device *pwm;
>> +	struct regulator *reg_en;
>>  	unsigned int pwm_value;
>>  	unsigned int pwm_fan_state;
>>  	unsigned int pwm_fan_max_state;
>> @@ -244,6 +246,23 @@ static int pwm_fan_probe(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>  
>> +	ctx->reg_en = devm_regulator_get_optional(&pdev->dev, "fan");
>> +	if (!IS_ERR(ctx->reg_en)) {
> It is customary to handle the error case first.
>
>> +		ret = regulator_enable(ctx->reg_en);
>> +		if (ret)
>> +			dev_err(&pdev->dev,
>> +				"Failed to enable fan supply: %d\n", ret);
>> +	} else {
>> +		switch (PTR_ERR(ctx->reg_en)) {
>> +		case -ENODEV:
>> +		case -ENOSYS:
> Does devm_regulator_get_optional() ever return -ENOSYS ?
> I glanced through other calls to devm_regulator_get_optional(),
> but I don't see that check anywhere.

sorry, i mixed this up with. In case CONFIG_REGULATOR=n we are getting
-ENODEV.

Thanks Stefan

