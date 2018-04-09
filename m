Return-Path: <phil@raspberrypi.org>
X-Google-Smtp-Source: AIpwx4+1liV2WH35B2jOK0oGEazOG71EGeea+wR7U1xQRaBi0VMNT88Ic9SQ+tyvGRQuPIirkaWa
ARC-Seal: i=1; a=rsa-sha256; t=1523280377; cv=none;
        d=google.com; s=arc-20160816;
        b=nx6nQl3Gv+1wt4Z9SAEXvPE9RYFMNGveHJTxAqlJx7e/8csKI3iTtW+Q1uO8ACz2a2
         1ODlQuxT1hlnHyf/eAAuOVC19fQobfyyr/1zyql13tG/wAkK6zifrjLeOL2ZqImNUFFC
         Ez7W24AtqSahf2NRPvRJo354b+BGRWer6Ry/0t7HWkDB3uNdnYQRRCI/6zxHlLpnaRNH
         lXgzpUSr68L09f2o95gdjYAfxK8VJlRH6btXxK2PcEX2Cw9SS2AkPaJxiqdznicSbbRJ
         dozrTZ3cmuf0kDqocyXdyrixaA0b2z7CUkMbxAiqEAiEzPmb2wNPTxbZszMtNGgvrVLu
         XjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=ovmJNzEcW+FwEl0EEEQ5bOgEs8MyK2ExSZWR8Bq0R2U=;
        b=SaYbm5mT1bFIPjQl0fextAPRZmhLSNlOR1uNXvX4Tli5Dd2Tuw7t6LLH7SZfKfNue2
         S3YjCENeoDhajTsfP3aXGnWg7dK3ZCMhKHM92k6qTZjT1jEx5PzrfPQOQOVtY0IX5htG
         hTQAKRFCgUdw+w4rZEU07YifpFl9SkV9djybMNpQSY2PpiX/y4a0KoV/LY2ajkjX84Xc
         dT7ok6Ou8qlJ4qo/s/YCU0cQvwkMylgUaVtEkTLmOhspS65PW+DwoFm93R3uRTEU1Cqm
         avBg+xDgYj/7kOyRTib7dSxqtCf9j6VKAw4Zs4Y/xHQxsPgkbyRqHWIX1S6QND986K4r
         KDHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@raspberrypi.org header.s=pp header.b=j+cXU8/+;
       dkim=pass header.i=@raspberrypi-org.20150623.gappssmtp.com header.s=20150623 header.b=qSWnX504;
       spf=pass (google.com: domain of phil@raspberrypi.org designates 62.209.51.214 as permitted sender) smtp.mailfrom=phil@raspberrypi.org
Authentication-Results: mx.google.com;
       dkim=fail header.i=@raspberrypi.org header.s=pp header.b=j+cXU8/+;
       dkim=pass header.i=@raspberrypi-org.20150623.gappssmtp.com header.s=20150623 header.b=qSWnX504;
       spf=pass (google.com: domain of phil@raspberrypi.org designates 62.209.51.214 as permitted sender) smtp.mailfrom=phil@raspberrypi.org
Subject: Re: [PATCH/RFC] soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies
 return failure
To: Stefan Wahren <stefan.wahren@i2se.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>, Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1523178315-30562-1-git-send-email-geert@linux-m68k.org>
 <2047337098.98106.1523186884813@email.1und1.de>
From: Phil Elwell <phil@raspberrypi.org>
Message-ID: <6542f11f-35c0-78ae-30f7-510797105c07@raspberrypi.org>
Date: Mon, 9 Apr 2018 14:26:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2047337098.98106.1523186884813@email.1und1.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_06:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597168233130064314?=
X-GMAIL-MSGID: =?utf-8?q?1597275245096821219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 08/04/2018 12:28, Stefan Wahren wrote:
> Hi Geert,
> 
> [add Phil]
> 
>> Geert Uytterhoeven <geert@linux-m68k.org> hat am 8. April 2018 um 11:05 geschrieben:
>>
>>
>> If CONFIG_RASPBERRYPI_FIRMWARE=n:
>>
>>     drivers/gpio/gpio-raspberrypi-exp.c: In function ‘rpi_exp_gpio_get_polarity’:
>>     drivers/gpio/gpio-raspberrypi-exp.c:71: warning: ‘get.polarity’ is used uninitialized in this function
>>     drivers/gpio/gpio-raspberrypi-exp.c: In function ‘rpi_exp_gpio_get_direction’:
>>     drivers/gpio/gpio-raspberrypi-exp.c:150: warning: ‘get.direction’ is used uninitialized in this function
>>
>> The dummy firmware interface functions return 0, which means success,
>> causing subsequent code to make use of the never initialized output
>> parameter.
> 
> i think this is more theoritical, because we need to get rpi_firmware first and in this case it's NULL.
> 
>>
>> Fix this by making the dummy functions return an error code (-ENOSYS)
>> instead.
> 
> Anyway i'm okay with the change.
> 
>>
>> Note that this assumes the firmware always fills in the requested data
>> in the CONFIG_RASPBERRYPI_FIRMWARE=y case.
> 
> Unfortunately i don't know.

The firmware overwrites the request code with an error return value. If this appears
and has an error value of zero (RPI_FIRMWARE_STATUS_SUCCESS) then the firmware has
written any expected fields.

> 
>>
>> Fixes: d45f1a563b92dac7 ("staging: vc04_services: fix up rpi firmware functions")
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>> Should get.polarity resp. get.direction be preinitialized instead,
>> like is done for get.state?
>>
>> static int rpi_exp_gpio_get(struct gpio_chip *gc, unsigned int off)
>> {
>>         ...
>>         get.state = 0;          /* storage for returned value */
>>
>>         ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_GET_GPIO_STATE,
>>                                          &get, sizeof(get));
>>         ...
>> }
>>
>> This would avoid returning uninitialized data if the firmware did not
>> fill in the requested data.
>> ---
>>  include/soc/bcm2835/raspberrypi-firmware.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
>> index 50df5b28d2c9df6e..8ee8991aa099af3a 100644
>> --- a/include/soc/bcm2835/raspberrypi-firmware.h
>> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
>> @@ -143,13 +143,13 @@ struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node);
>>  static inline int rpi_firmware_property(struct rpi_firmware *fw, u32 tag,
>>  					void *data, size_t len)
>>  {
>> -	return 0;
>> +	return -ENOSYS;
>>  }
>>  
>>  static inline int rpi_firmware_property_list(struct rpi_firmware *fw,
>>  					     void *data, size_t tag_size)
>>  {
>> -	return 0;
>> +	return -ENOSYS;
>>  }
>>  
>>  static inline struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
>> -- 
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
