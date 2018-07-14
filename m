Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF15BECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D2B20897
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D2B20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeGNOWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 10:22:13 -0400
Received: from www381.your-server.de ([78.46.137.84]:42178 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeGNOWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 10:22:12 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <lars@metafoo.de>)
        id 1feL8P-0001hb-0g; Sat, 14 Jul 2018 16:02:53 +0200
Received: from [188.174.124.159] (helo=[192.168.178.33])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1feL8O-0000Z5-IV; Sat, 14 Jul 2018 16:02:52 +0200
Subject: =?UTF-8?Q?Re:_[PATCH_1/2]_mux:adgs1408/1409:_New_driver_for_Analog_?=
 =?UTF-8?Q?Devices_ADGS1408/1409_mux_=e2=80=a6?=
To:     Peter Rosin <peda@axentia.se>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     davem@davemloft.net, mchehab+samsung@kernel.org,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
References: <20180713122738.5888-1-mircea.caprioru@analog.com>
 <b3540119-73e1-38d5-1dc9-ce9f8bdad9e8@axentia.se>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <059d9750-8715-bc4e-185f-d52b48ad9b59@metafoo.de>
Date:   Sat, 14 Jul 2018 16:02:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b3540119-73e1-38d5-1dc9-ce9f8bdad9e8@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.0/24752/Sat Jul 14 14:53:17 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/14/2018 02:04 PM, Peter Rosin wrote:
[...]
>> +static int adgs140x_spi_reg_write(struct spi_device *spi,
>> +				u8 reg_addr, u8 reg_data)
>> +{
>> +	u8 tx_buf[2];
>> +
>> +	tx_buf[0] = reg_addr;
>> +	tx_buf[1] = reg_data;
>> +
>> +	return spi_write_then_read(spi, tx_buf, sizeof(tx_buf), NULL, 0);
> 
> 	return spi_write(spi, tx_buf, sizeof(tx_buf));

Be aware spi_write_then_read() can handle on stack buffers, spi_write() can't.
