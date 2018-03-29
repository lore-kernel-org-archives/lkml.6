Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeC2KJ0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 06:09:26 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:39508 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeC2KJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 06:09:24 -0400
X-Google-Smtp-Source: AIpwx48PHcXcQjlG83MEUdBzIb+B2uBIUnZxnbJlR5Jt1hIXRZvkJTJ9CeZm2KJVFkErdcN/zL3YnA==
Subject: Re: [v2,2/2] media: Add a driver for the ov7251 camera sensor
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: jacopo mondi <jacopo@jmondi.org>, mchehab@kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1521778460-8717-3-git-send-email-todor.tomov@linaro.org>
 <20180323134003.GB11499@w540>
 <419f6976-ee6a-f2c1-1097-a51776469ee4@linaro.org>
 <20180329082923.e55pclvlclamnsqz@paasikivi.fi.intel.com>
From: Todor Tomov <todor.tomov@linaro.org>
Message-ID: <6625da39-9f35-f0ae-e40c-8ae508018aae@linaro.org>
Date: Thu, 29 Mar 2018 13:09:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329082923.e55pclvlclamnsqz@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari

On 29.03.2018 11:29, Sakari Ailus wrote:
> Hi Todor and Jacopo,
> 
> On Thu, Mar 29, 2018 at 10:50:10AM +0300, Todor Tomov wrote:
> ...
>>>> +static const struct of_device_id ov7251_of_match[] = {
>>>> +	{ .compatible = "ovti,ov7251" },
>>>> +	{ /* sentinel */ }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, ov7251_of_match);
>>>> +
>>>> +static struct i2c_driver ov7251_i2c_driver = {
>>>> +	.driver = {
>>>> +		.of_match_table = of_match_ptr(ov7251_of_match),
>>>> +		.name  = "ov7251",
>>>> +	},
>>>> +	.probe  = ov7251_probe,
>>>> +	.remove = ov7251_remove,
>>>> +	.id_table = ov7251_id,
>>>
>>> As this driver depends on CONFIG_OF, I've been suggested to use probe_new and
>>> get rid of i2c id_tables.
>>
>> Yes, I'll do that.
> 
> The proposal sounds good to me but rather than adding CONFIG_OF dependency,
> I'd instead suggest changing the of_property_read_u32 to
> fwnode_property_read_u32; then the driver may work on ACPI based systems as
> well. 

Ok.

> There's another change needed, too, which is not using of_match_ptr
> macro, but instead assigning the of_match_table unconditionally.

In that case the MODULE_DEVICE_TABLE(i2c, ...) is again not needed?
And matching will be again via of_match_table?

> 
> Up to you.
> 

Thank you for your help!
 
Best regards,
Todor Tomov
