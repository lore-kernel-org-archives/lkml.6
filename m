Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64B6C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F3F20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfAUSGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:06:42 -0500
Received: from mx1.emlix.com ([46.4.235.150]:55384 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfAUSGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:06:41 -0500
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jan 2019 13:06:40 EST
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 134AA25F0A8;
        Mon, 21 Jan 2019 18:57:52 +0100 (CET)
Subject: Re: [PATCH v2,2/2] usb: chipidea: imx: set power polarity
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Philipp Puschmann <philipp.puschmann@emlix.com>,
        gregkh@linuxfoundation.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, Peter.Chen@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190115123113.20577-1-philipp.puschmann@emlix.com>
 <20190116105103.28842-1-philipp.puschmann@emlix.com>
 <20190116105103.28842-2-philipp.puschmann@emlix.com>
 <22968f8c-0a62-7046-c46f-ce7dc8981499@cogentembedded.com>
From:   Philipp Puschmann <pp@emlix.com>
Openpgp: preference=signencrypt
Message-ID: <b95de83f-b0fe-b31f-22c9-a0dfdc2ff078@emlix.com>
Date:   Mon, 21 Jan 2019 18:57:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <22968f8c-0a62-7046-c46f-ce7dc8981499@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Am 16.01.19 um 17:32 schrieb Sergei Shtylyov:
> Hello!
> 
> On 01/16/2019 01:51 PM, Philipp Puschmann wrote:
> 
>> This patch adds support to set the power line polarity for i.MX6q/dl.
>>
>> To let the USB controller control the power it may be necessary to configure
>> the polarity of the power line. So far the polarity was configured
>> by Bootloader or alternatively the power line was muxed as gpio and
>> driven by a regulator.
>>
>> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
>> ---
>>
>> V2: fixed wrong variable name ...
>>
>> ---
>>  drivers/usb/chipidea/ci_hdrc_imx.c | 3 +++
>>  drivers/usb/chipidea/ci_hdrc_imx.h | 1 +
>>  drivers/usb/chipidea/usbmisc_imx.c | 4 ++++
>>  3 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
>> index e81de9ca8729..32dc120680fa 100644
>> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
>> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
>> @@ -152,6 +152,9 @@ static struct imx_usbmisc_data *usbmisc_get_init_data(struct device *dev)
>>  		dev_warn(dev, "No over current polarity defined\n");
>>  	}
>>  
>> +	if (of_find_property(np, "power-active-high", NULL))
> 
>    How about of_property_read_bool()?

Good idea. I will send a patch v4 in next days.
> 
>> +		data->pwr_pol = 1;
>> +
>>  	if (of_find_property(np, "external-vbus-divider", NULL))
>>  		data->evdo = 1;
>>  
> [...]
> 
> MBR, Sergei
> 
