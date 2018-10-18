Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4561C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659FE2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659FE2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeJRPkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:40:20 -0400
Received: from www381.your-server.de ([78.46.137.84]:56172 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbeJRPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:40:19 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1gD2uy-0001JM-86; Thu, 18 Oct 2018 09:40:28 +0200
Received: from eisbaer.ursus-maritimus.org ([78.47.220.141] helo=[127.0.0.1])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1gD2ux-0005u0-Su; Thu, 18 Oct 2018 09:40:28 +0200
Subject: Re: [PATCH v2] staging: iio: ad7816: Switch to the gpio descriptor
 interface
To:     Phil Reid <preid@electromag.com.au>,
        Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
References: <20181017144716.GA11485@nishad>
 <fdcb085c-cf34-3310-f5ab-5795d5997977@electromag.com.au>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e3d4308c-9608-db52-c51e-5bb5d126284a@metafoo.de>
Date:   Thu, 18 Oct 2018 09:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fdcb085c-cf34-3310-f5ab-5795d5997977@electromag.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.1/25047/Thu Oct 18 06:56:19 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2018 09:28 AM, Phil Reid wrote:
[...]
>> +    chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
>> +    if (IS_ERR(chip->rdwr_pin)) {
>> +        ret = PTR_ERR(chip->rdwr_pin);
>> +        dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
>> +            ret);
>>           return ret;
>>       }
>> -    gpio_direction_input(chip->rdwr_pin);
> 
> The RD/WR pin is an input to the AD78xx. So this doesn't make sense being
> GPIOD_IN.

One thing at a time. This patch is a straight forward conversion to the GPIO
descriptor interface. It keeps the existing semantics of the driver as they are.

Now these semantics are obviously wrong and should be fixed but that should
be a separate patch from changing the interface.
