Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C172C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D752084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D752084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeJZStg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:49:36 -0400
Received: from mr30.theemaillaundry.net ([78.46.72.43]:38966 "EHLO
        mr30.theemaillaundry.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeJZStf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:49:35 -0400
X-Greylist: delayed 67211 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Oct 2018 14:49:34 EDT
Received: from localhost (localhost [127.0.0.1])
        by mr30.theemaillaundry.net (Postfix) with ESMTP id B841D24190D;
        Fri, 26 Oct 2018 11:13:04 +0100 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mr30.theemaillaundry.net
X-Virus-Scanned: amavisd-new at theemaillaundry.net
Received: from mr30.theemaillaundry.net ([127.0.0.1])
        by localhost (mr30.theemaillaundry.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7gssIuot5ojI; Fri, 26 Oct 2018 11:13:04 +0100 (IST)
Received: from statler.emutex.com (unknown [92.51.199.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mr30.theemaillaundry.net (Postfix) with ESMTPS id 0B9F8241135;
        Fri, 26 Oct 2018 11:13:02 +0100 (IST)
Received: from [10.10.68.81]
        by statler.emutex.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <dan@emutex.com>)
        id 1gFz70-0002Mc-0E; Fri, 26 Oct 2018 11:13:02 +0100
Subject: Re: [PATCH v3 2/3] iio: adc128s052: add ACPI _HID AANT1280
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>,
        Javier Arteaga <javier@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com>
 <1540481742-23596-1-git-send-email-dan@emutex.com>
 <1540481742-23596-3-git-send-email-dan@emutex.com>
 <20181025174638.GB10650@smile.fi.intel.com>
From:   Dan O'Donovan <dan@emutex.com>
Message-ID: <c17cf6de-846b-aed3-7745-4f635495873e@emutex.com>
Date:   Fri, 26 Oct 2018 11:13:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025174638.GB10650@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2018 06:46 PM, Andy Shevchenko wrote:
> On Thu, Oct 25, 2018 at 04:35:41PM +0100, Dan O'Donovan wrote:
>> From: Nicola Lunghi <nicola.lunghi@emutex.com>
>>
>> ACPI _HID AANT1280 matches an ADC124S101 present on E3940 SKUs of the UP
>> Squared board.
>>
>> Add it to the driver.
>>
>> Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
>> [javier@emutex.com: fix up commit message and one checkpatch warning]
>> Signed-off-by: Javier Arteaga <javier@emutex.com>
>> Signed-off-by: Dan O'Donovan <dan@emutex.com>
>> ---
>>  drivers/iio/adc/ti-adc128s052.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
>> index e6716c3..c2d1453 100644
>> --- a/drivers/iio/adc/ti-adc128s052.c
>> +++ b/drivers/iio/adc/ti-adc128s052.c
>> @@ -12,10 +12,12 @@
>>   * published by the Free Software Foundation.
>>   */
>>  
>> +#include <linux/acpi.h>
>>  #include <linux/err.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/module.h>
>>  #include <linux/iio/iio.h>
>> +#include <linux/property.h>
>>  #include <linux/regulator/consumer.h>
>>  
>>  struct adc128_configuration {
>> @@ -135,10 +137,15 @@ static const struct iio_info adc128_info = {
>>  static int adc128_probe(struct spi_device *spi)
>>  {
>>  	struct iio_dev *indio_dev;
>> +	unsigned int config;
>>  	struct adc128 *adc;
>> -	int config = spi_get_device_id(spi)->driver_data;
>>  	int ret;
>>  
>> +	if (dev_fwnode(&spi->dev))
>> +		config = (unsigned long) device_get_match_data(&spi->dev);
>> +	else
>> +		config = spi_get_device_id(spi)->driver_data;
>> +
>>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
>>  	if (!indio_dev)
>>  		return -ENOMEM;
>> @@ -207,10 +214,19 @@ static const struct spi_device_id adc128_id[] = {
>>  };
>>  MODULE_DEVICE_TABLE(spi, adc128_id);
>>  
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id adc128_acpi_match[] = {
> 
>> +	{ "AANT1280", 2 }, /* ADC124S021 compatible ACPI ID */
> 
> Looking how driver is organized and what ACPI can provide I would highly
> recommend to look forward to PTYP field for utilization of the type of the HW.
> 
> Maybe it would not work with published BIOSes, but would be good for the future
> (in that case anybody can utilize that _HID + PTYP pair on their platforms).
> 
Thanks Andy for your review and feedback.  Your _HID + PTYP suggestion sounds
interesting, but I couldn't find any information in the ACPI spec or elsewhere
about how/when/where to use it.  It isn't used in the UP Squared ACPI tables.
Do you have any links or other information you could share about it? Thanks!

>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
>> +#endif
>> +
>>  static struct spi_driver adc128_driver = {
>>  	.driver = {
>>  		.name = "adc128s052",
> 
>>  		.of_match_table = of_match_ptr(adc128_of_match),
>> +		.acpi_match_table = ACPI_PTR(adc128_acpi_match),
>>  	},
>>  	.probe = adc128_probe,
>>  	.remove = adc128_remove,
>> -- 
>> 2.7.4
>>
>>
>> ------
>> This email has been scanned for spam and malware by The Email Laundry.
>>
> 

------
This email has been scanned for spam and malware by The Email Laundry.

