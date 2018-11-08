Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F53ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407D6206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjDfJgyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407D6206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeKIGYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:24:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44821 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeKIGYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:24:49 -0500
Received: by mail-lf1-f66.google.com with SMTP id z13so5211962lfe.11;
        Thu, 08 Nov 2018 12:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MA56BvtxTlfmH3WtBnkY185CT8lQ8eWzs2om9OJ69CI=;
        b=hjDfJgybBvIDXzlJeUoF7zOM4FyD4YAB8+nNWoq3IurlaLZAvgOFmuBYbegbCYAES3
         slv2Rea1gt0whGbXPA4BwYVG8QUrtBdaWWRNDE0k/2iG5sbpGXdtB0is3siANz9JfF1q
         l3nqF6qVkR0Nd9oPlo8NaLv0++3Ds4Z3EWU217ROWq5t+fGTLtNUEME4ho9qT3bhEKLL
         y4k+Lk9BxwlYqJuVsTOPoZXlGRryflkIQUjMVH7y7LN3JmUAh+PPoXTHWaJTthlP/fDE
         OQOYsDX4Uttn5Eqnj9l10YV69dEh5a1rizJPXsKH3Z/jC9339+UceOmTakggqxMd4jL9
         6qGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MA56BvtxTlfmH3WtBnkY185CT8lQ8eWzs2om9OJ69CI=;
        b=aJ53fg9AX7Q1a336tAaCskKAOi2J0W89KS7jMjMZ+7mEjbs6zK7s0dNwaW+uJvo9wP
         WNN2HSmZu+6CM/vLLw9PoKXi25lvtuajaYKUtrPl7OjP90Aro2guooNxZ/ZlXJDuRoC7
         UYTyAq3AfjVoAZ6o9kMaFxic0lJ5lTsNF9OD//C6F8zXFeSjlq9jYDRRmRvEky9NP1UK
         +t0OJXztm5NbgZN+ob9tWdpg/ysuAQ+LO3opfb073P62CkAs+cKsxkBoqoWjzgKegXH/
         9+h6fSxehOveACJe9PerG0mVrumrSTbxfiRSGDhdXO2Kz5G3HOnTEnNZm9aGwGO0ALlG
         zM5Q==
X-Gm-Message-State: AGRZ1gLTzdU4PrCv/qJTMucLC3CKwdAlgd59eOgLQmrJRMM/LvNTmKJq
        ONxJLITEQCRBVkyKZjCXIb4=
X-Google-Smtp-Source: AJdET5cOfeNzNxee0IepvQcV8/a+m5G9KYeXYgAAOKYWTz+ZhjTyXcsaE/shnis4AMJun4I0LN86pg==
X-Received: by 2002:a19:8fce:: with SMTP id s75mr3631686lfk.151.1541710053855;
        Thu, 08 Nov 2018 12:47:33 -0800 (PST)
Received: from [192.168.1.18] (dkl219.neoplus.adsl.tpnet.pl. [83.24.15.219])
        by smtp.gmail.com with ESMTPSA id j12-v6sm855709lja.8.2018.11.08.12.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 12:47:33 -0800 (PST)
Subject: Re: [PATCH 02/24] leds: core: Add support for composing LED class
 device names
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
 <CAMz4ku+K=Jw56C2YczFMcVGRPUHMpSw4_iWEsNmKDBQgWjmEqQ@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <3a5ca343-5c48-b257-4ba4-5a7e223efbf8@gmail.com>
Date:   Thu, 8 Nov 2018 21:47:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMz4ku+K=Jw56C2YczFMcVGRPUHMpSw4_iWEsNmKDBQgWjmEqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

Thanks for the review.

On 11/07/2018 08:20 AM, Baolin Wang wrote:
> Hi Jacek,
> 
> On 7 November 2018 at 06:07, Jacek Anaszewski
> <jacek.anaszewski@gmail.com> wrote:
>> Add public led_compose_name() API for composing LED class device
>> name basing on fwnode_handle data. The function composes device name
>> according to either a new <color:function> pattern or the legacy
>> <devicename:color:function> pattern. The decision on using the
>> particular pattern is made basing on whether fwnode contains new
>> "function" and "color" properties, or the legacy "label" proeprty.
>>
>> Backwards compatibility with in-driver hard-coded LED class device
>> names is assured thanks to the default_desc argument.
>>
>> In case none of the aformentioned properties was found, then, for OF
>> nodes, the node name is adopted for LED class device name.
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linaro.org>
>> Cc: Daniel Mack <daniel@zonque.org>
>> Cc: Dan Murphy <dmurphy@ti.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Cc: Simon Shields <simon@lineageos.org>
>> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>> ---
>>  Documentation/leds/leds-class.txt |  2 +-
>>  drivers/leds/led-core.c           | 71 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/leds.h              | 32 ++++++++++++++++++
>>  3 files changed, 104 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/leds/leds-class.txt b/Documentation/leds/leds-class.txt
>> index 836cb16..e9009c4 100644
>> --- a/Documentation/leds/leds-class.txt
>> +++ b/Documentation/leds/leds-class.txt
>> @@ -43,7 +43,7 @@ LED Device Naming
>>
>>  Is currently of the form:
>>
>> -"devicename:colour:function"
>> +"colour:function"
>>
>>  There have been calls for LED properties such as colour to be exported as
>>  individual led class attributes. As a solution which doesn't incur as much
>> diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
>> index ede4fa0..f7371fc 100644
>> --- a/drivers/leds/led-core.c
>> +++ b/drivers/leds/led-core.c
>> @@ -16,6 +16,8 @@
>>  #include <linux/list.h>
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/property.h>
>>  #include <linux/rwsem.h>
>>  #include "leds.h"
>>
>> @@ -327,3 +329,72 @@ void led_sysfs_enable(struct led_classdev *led_cdev)
>>         led_cdev->flags &= ~LED_SYSFS_DISABLE;
>>  }
>>  EXPORT_SYMBOL_GPL(led_sysfs_enable);
>> +
>> +static void led_parse_properties(struct fwnode_handle *fwnode,
>> +                                struct led_properties *props)
>> +{
>> +       int ret;
>> +
>> +       if (!fwnode)
>> +               return;
>> +
>> +       ret = fwnode_property_read_string(fwnode, "label", &props->label);
>> +       if (!ret)
>> +               return;
>> +
>> +       ret = fwnode_property_read_string(fwnode, "function", &props->function);
>> +       if (ret)
>> +               pr_info("Failed to parse function property\n");
>> +
>> +       ret = fwnode_property_read_string(fwnode, "color", &props->color);
>> +       if (ret)
>> +               pr_info("Failed to parse color property\n");
> 
> Now the color and function properties can be optional, so we should
> deal with different return errors.
> -EINVAL means we have not set color or function property, which means
> we should not give failure message for users (maybe "not supply color
> property\n") and return 0 as success.

The lack of any of these properties is not critical, therefore this
function does not return the error code, but only prints the status.
Please note that I'm not using pr_error(), but pr_info().
Related to the message text - I agree, I will change it to e.g.
"color property not found"

> For other errors, we should not ignore them, instead we should give
> failure messages and return errors.

I've skimmed through other kernel drivers and vast majority of
them don't check exact failure code in case of non-zero return,
but assume that property is missing, and eventually report
error code. I'd do the same here.

> Tested-by: Baolin Wang <baolin.wang@linaro.org>
> 
>> +}
>> +
>> +int led_compose_name(struct fwnode_handle *fwnode, const char *led_hw_name,
>> +                    const char *default_desc, char *led_classdev_name)
>> +{
>> +       struct led_properties props = {};
>> +
>> +       if (!led_classdev_name)
>> +               return -EINVAL;
>> +
>> +       led_parse_properties(fwnode, &props);
>> +
>> +       if (props.label) {
>> +               /*
>> +                * Presence of 'label' DT property implies legacy LED name,
>> +                * formatted as <devicename:color:function>, with possible
>> +                * section omission if doesn't apply to given device.
>> +                *
>> +                * If no led_hw_name has been passed, then it indicates that
>> +                * DT label should be used as-is for LED class device name.
>> +                * Otherwise the label is prepended with led_hw_name to compose
>> +                * the final LED class device name.
>> +                */
>> +               if (!led_hw_name) {
>> +                       strncpy(led_classdev_name, props.label,
>> +                               LED_MAX_NAME_SIZE);
>> +               } else {
>> +                       snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
>> +                                led_hw_name, props.label);
>> +               }
>> +       } else if (props.function || props.color) {
>> +               snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
>> +                        props.color ?: "", props.function ?: "");
>> +       } else if (default_desc) {
>> +               if (!led_hw_name) {
>> +                       pr_err("Legacy LED naming requires devicename segment");
>> +                       return -EINVAL;
>> +               }
>> +               snprintf(led_classdev_name, LED_MAX_NAME_SIZE, "%s:%s",
>> +                        led_hw_name, default_desc);
>> +       } else if (is_of_node(fwnode)) {
>> +               strncpy(led_classdev_name, to_of_node(fwnode)->name,
>> +                       LED_MAX_NAME_SIZE);
>> +       } else
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(led_compose_name);
>> diff --git a/include/linux/leds.h b/include/linux/leds.h
>> index 646c49a..ddb4001 100644
>> --- a/include/linux/leds.h
>> +++ b/include/linux/leds.h
>> @@ -238,6 +238,32 @@ extern void led_sysfs_disable(struct led_classdev *led_cdev);
>>  extern void led_sysfs_enable(struct led_classdev *led_cdev);
>>
>>  /**
>> + * led_compose_name - compose LED class device name
>> + * @child: child fwnode_handle describing a LED,
>> + *        or a group of synchronized LEDs.
>> + * @led_hw_name: name of the LED controller, used when falling back to legacy
>> + *              LED naming; it should be set to NULL in new LED class drivers
>> + * @default_desc: default <color:function> tuple, for backwards compatibility
>> + *               with in-driver hard-coded LED names used as a fallback when
>> + *               "label" DT property was absent; it should be set to NULL
>> + *               in new LED class drivers
>> + * @led_classdev_name: composed LED class device name
>> + *
>> + * Create LED class device name basing on the configuration provided by the
>> + * board firmware. The name can have a legacy form <devicename:color:function>,
>> + * or a new form <color:function>. The latter is chosen if at least one of
>> + * "color" or "function" properties is present in the fwnode, leaving the
>> + * section blank if the related property is absent. The former is applied
>> + * when legacy "label" property is present in the fwnode. In case none of the
>> + * aformentioned properties was found, then, for OF nodes, the node name
>> + * is adopted for LED class device name.
>> + *
>> + * Returns: 0 on success or negative error value on failure
>> + */
>> +extern int led_compose_name(struct fwnode_handle *child, const char *led_hw_name,
>> +                           const char *default_desc, char *led_classdev_name);
>> +
>> +/**
>>   * led_sysfs_is_disabled - check if LED sysfs interface is disabled
>>   * @led_cdev: the LED to query
>>   *
>> @@ -414,6 +440,12 @@ struct led_platform_data {
>>         struct led_info *leds;
>>  };
>>
>> +struct led_properties {
>> +       const char *color;
>> +       const char *function;
>> +       const char *label;
>> +};
>> +
>>  struct gpio_desc;
>>  typedef int (*gpio_blink_set_t)(struct gpio_desc *desc, int state,
>>                                 unsigned long *delay_on,
>> --
>> 2.1.4
>>
> 
> 
> 

-- 
Best regards,
Jacek Anaszewski
