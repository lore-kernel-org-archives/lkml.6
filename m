Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F572C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 19:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347F0217BD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 19:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qli+CwLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347F0217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbeHDV1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 17:27:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37048 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbeHDV1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 17:27:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id b10-v6so3325142eds.4;
        Sat, 04 Aug 2018 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+z0vxxgRQBb6f/keJfTRI0GI96va0Mo78ZYiWDXymtM=;
        b=Qli+CwLjPXaxJktI0Td8ETRtbjgGshCj15xsiicoFkqcQXM9ssehABvyIDC3G0q7Fx
         PehzmDrkyXsxGOlvUXxnlSdUtmkDfOCyojhF5fTilcktNzRmv7nhV9SVVFuIrzGU2Q9y
         pCQr+NSlIsbAyg8MRq51ev2u6lOX0qEtJSuGif4OlxBuziD3ogq/5Et/21/USdLcY1ca
         WltKgI2UWzK0mFL5IyykWqldVM3PJVrQX0lh+OJD7nqpQXlE42o52Zq6j2Hg8jQuSgHp
         PnwW3Zu3CyQdoaGMxRkybJXg9GA1//5dEimV/q89sUmI1r4BVkLE6Gp71E4pRZnnui2t
         pvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+z0vxxgRQBb6f/keJfTRI0GI96va0Mo78ZYiWDXymtM=;
        b=eQQ2VnregiZ3a8I15xg+G138i80VwYiZ4WDdwOE3K2Q0LVtO681ezpYH7lVBw6Ot77
         XF89pQWtZpzJ9uNteGlveH3HM0X8qOLHwF7YLwKRqXb7uJ3Cf/KWXYJgc3lqHnWEIodd
         mZLgEn7lu3BO9jJauLWWwoGMRFMI9S1P8T8d2JEPJxWbEv9ysmNRAt99RlnWPIqRtbc7
         Fb6PjTJtPG0v2M8aDjPzUKLFdQpy1/QJ5N4dWg6KJ1QjMQD6bXh2GesKWkDb6xpItEcl
         Xp5k4mQH91QqEMo0NEyV2q41swjIh0L9E4H2N1MZFCffTEESlP7xpWtXcr5rXCFXoI9i
         +M2Q==
X-Gm-Message-State: AOUpUlHTFx/j0in2mx5yYxVCMxsYzMn4/avFJrvcABtVubRc9lCZ6/eI
        wInVkyJ7+El+P+ogoLxEbJKxsbzK
X-Google-Smtp-Source: AAOMgpfMJwVgig0uzw0qzTtOa6pLDEYoBnpu/ZenxK3Ccvgyk2tLfnzGybXI3qypXjNY0Nuc+dXLLg==
X-Received: by 2002:a50:f5e8:: with SMTP id x37-v6mr11778019edm.132.1533410725013;
        Sat, 04 Aug 2018 12:25:25 -0700 (PDT)
Received: from [192.168.1.54] (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id h34-v6sm4383096eda.58.2018.08.04.12.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 12:25:24 -0700 (PDT)
Subject: Re: [PATCH v3 05/14] gpu: ipu-v3: Allow negative offsets for
 interlaced scanning
To:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        "open list:DRM DRIVERS FOR FREESCALE IMX" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
 <1533150747-30677-6-git-send-email-steve_longerbeam@mentor.com>
 <1533203182.3516.12.camel@pengutronix.de>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <786e7eb0-a81c-a4e8-3ddc-7edd0bc08cd9@gmail.com>
Date:   Sat, 4 Aug 2018 12:25:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533203182.3516.12.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,


On 08/02/2018 02:46 AM, Philipp Zabel wrote:
> On Wed, 2018-08-01 at 12:12 -0700, Steve Longerbeam wrote:
>> From: Philipp Zabel <p.zabel@pengutronix.de>
>>
>> The IPU also supports interlaced buffers that start with the bottom field.
>> To achieve this, the the base address EBA has to be increased by a stride
>> length and the interlace offset ILO has to be set to the negative stride.
>>
>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>> ---
>>   drivers/gpu/ipu-v3/ipu-cpmem.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/ipu-v3/ipu-cpmem.c b/drivers/gpu/ipu-v3/ipu-cpmem.c
>> index e68e473..8cd9e37 100644
>> --- a/drivers/gpu/ipu-v3/ipu-cpmem.c
>> +++ b/drivers/gpu/ipu-v3/ipu-cpmem.c
>> @@ -269,9 +269,20 @@ EXPORT_SYMBOL_GPL(ipu_cpmem_set_uv_offset);
>>   
>>   void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride)
>>   {
>> +	u32 ilo, sly;
>> +
>> +	if (stride < 0) {
>> +		stride = -stride;
>> +		ilo = 0x100000 - (stride / 8);
>> +	} else {
>> +		ilo = stride / 8;
>> +	}
>> +
>> +	sly = (stride * 2) - 1;
>> +
>>   	ipu_ch_param_write_field(ch, IPU_FIELD_SO, 1);
>> -	ipu_ch_param_write_field(ch, IPU_FIELD_ILO, stride / 8);
>> -	ipu_ch_param_write_field(ch, IPU_FIELD_SLY, (stride * 2) - 1);
>> +	ipu_ch_param_write_field(ch, IPU_FIELD_ILO, ilo);
>> +	ipu_ch_param_write_field(ch, IPU_FIELD_SLY, sly);
>>   };
>>   EXPORT_SYMBOL_GPL(ipu_cpmem_interlaced_scan);
> This patch is merged in drm-next: 4e3c5d7e05be ("gpu: ipu-v3: Allow
> negative offsets for interlaced scanning")

I don't see it in drm-next, but I see it in linux-next/master. Thanks.

Steve

