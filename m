Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFDCC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479982148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfA1Kof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:44:35 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46452 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfA1Kod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:44:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so12540546edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 02:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WzMEudxlxCKfwTRDhlUpX2KaPI1Bf5kgoRFzOHZaBF0=;
        b=HfeoiCZIUcyschRl0AWYtH5gsYlGcmC/7biFR2rvWvtL1Tar3LnwoPB0VSgl/FZhiX
         p8XiTwsNEMXiN+8j3DnV7hKp7Z4zwTM/mwmxrrJxqdHpcTcUp6kBQYuCffsUzsJRcynE
         /atPJc3dlpM0LO1qVh3QitkxcwbZW85oKyPlrO0dcrXvP36ezwwsR20WmEQ6wEql0OxY
         LW6fsvaNMOATb+IeBb3awGyoL0p3fon44jr1hzLSeVRLwr2qGmhkwjJcBYiYi7bZP9yn
         eYcN7Gg7J/Xi1X1mHTuOb1I0KfCWXtbXuCLHGSOTj5N/MsJmwIEatpjvpsUeWX/V4gna
         8rSQ==
X-Gm-Message-State: AJcUukcQipNn2gbzBGuKIt+lTVqhqf2FWzs6OyhJZF6csxf4gJGYNccS
        XaKsczbZ2Ip+3/CuSVAYjIbR4H22Eds=
X-Google-Smtp-Source: ALg8bN5uHJQGjbSzQNBC4/vuC9w5oN5go6tvy6GSYLY+gEtFDzP/QuIL4d5EV1m8jLqAXmIZpOG+dA==
X-Received: by 2002:a17:906:6201:: with SMTP id s1mr19097387ejk.66.1548672271236;
        Mon, 28 Jan 2019 02:44:31 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id v18sm1990138ejw.14.2019.01.28.02.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 02:44:30 -0800 (PST)
Subject: Re: [PATCH 1/8] platform/x86: intel_cht_int33fe: Remove connection
 for the alt mode mux
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
 <20190125131519.88416-2-heikki.krogerus@linux.intel.com>
 <CAHp75Vf1w6fOUp968S=5=-3jsG6x6JAcwR=uxzk9eMjXc7H_ZQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5642f1df-44b5-8293-3ce6-b244f95498ba@redhat.com>
Date:   Mon, 28 Jan 2019 11:44:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf1w6fOUp968S=5=-3jsG6x6JAcwR=uxzk9eMjXc7H_ZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28-01-19 10:45, Andy Shevchenko wrote:
> On Fri, Jan 25, 2019 at 3:17 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
>>
>> Driver for fusb302 does not support alternate modes, so the
>> connection is not really needed for now. Removing that
>> connection description allows us to improve the USB Type-C
>> mux API.
>>
> 
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> supposed to go via USB tree.

I missed the original posting of this, so let me reply here:

Nack to this change, I've a patch-set in the works to
make display-port over type-c work with 2 devices with a fusb302
mux and that needs this connection.

Regards,

Hans



> 
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel_cht_int33fe.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
>> index 02bc74608cf3..fbd24daa7f8d 100644
>> --- a/drivers/platform/x86/intel_cht_int33fe.c
>> +++ b/drivers/platform/x86/intel_cht_int33fe.c
>> @@ -32,7 +32,7 @@ struct cht_int33fe_data {
>>          struct i2c_client *fusb302;
>>          struct i2c_client *pi3usb30532;
>>          /* Contain a list-head must be per device */
>> -       struct device_connection connections[5];
>> +       struct device_connection connections[4];
>>   };
>>
>>   /*
>> @@ -178,12 +178,9 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>>          data->connections[1].endpoint[0] = "port0";
>>          data->connections[1].endpoint[1] = "i2c-pi3usb30532";
>>          data->connections[1].id = "typec-mux";
>> -       data->connections[2].endpoint[0] = "port0";
>> -       data->connections[2].endpoint[1] = "i2c-pi3usb30532";
>> -       data->connections[2].id = "idff01m01";
>> -       data->connections[3].endpoint[0] = "i2c-fusb302";
>> -       data->connections[3].endpoint[1] = "intel_xhci_usb_sw-role-switch";
>> -       data->connections[3].id = "usb-role-switch";
>> +       data->connections[2].endpoint[0] = "i2c-fusb302";
>> +       data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";
>> +       data->connections[2].id = "usb-role-switch";
>>
>>          device_connections_add(data->connections);
>>
>> --
>> 2.20.1
>>
> 
> 
