Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8767C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6BA20833
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CQcn5NBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6BA20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeIZVpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:45:00 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39222 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeIZVo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:44:59 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8QFVJct050770;
        Wed, 26 Sep 2018 10:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537975879;
        bh=VN9raH1xpjNwA8Cj4SNFjkkLdpshBijCH0k5lOufgMw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CQcn5NBowDR8WsnukkRqnOsGcODyqkEOnplISfj/VwlyC03KcCttepM+3vOKnDJLS
         o/oLBeoxiz3gXRXaRFk1atw0tMYloN4Jai2Qw4QKlDosuawOj3JV4ZW9CRknWCw1x6
         UkeTHEpPRz20Iooy13h3UWoaEpkVBsQkMgupispU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QFVJ27021256;
        Wed, 26 Sep 2018 10:31:19 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 10:31:18 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 10:31:19 -0500
Received: from [128.247.58.174] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QFVJcQ026346;
        Wed, 26 Sep 2018 10:31:19 -0500
Subject: Re: [RFC PATCH 1/9] leds: add TI LMU backlight driver
To:     Tony Lindgren <tony@atomide.com>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
References: <20180926130921.12329-1-dmurphy@ti.com>
 <20180926130921.12329-2-dmurphy@ti.com> <20180926150145.GS5662@atomide.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <ee0185f0-1fc9-9176-2236-836ca0ac6f41@ti.com>
Date:   Wed, 26 Sep 2018 10:30:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926150145.GS5662@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony

On 09/26/2018 10:01 AM, Tony Lindgren wrote:
> * Dan Murphy <dmurphy@ti.com> [180926 13:14]:
>> --- /dev/null
>> +++ b/drivers/leds/ti-lmu-led-common.c
>> +static int ti_lmu_common_enable(struct ti_lmu_bank *lmu_bank, bool enable)
>> +{
>> +	struct regmap *regmap = lmu_bank->regmap;
>> +	unsigned long enable_time = lmu_bank->enable_usec;
>> +	u8 reg = lmu_bank->enable_reg;
>> +	u8 mask = BIT(lmu_bank->bank_id);
>> +	u8 val = (enable == true) ? mask : 0;
>> +	int ret;
>> +
>> +	return 0;
> 
> Hmm this early return probably needs to be left out on real hardawre?
> 

Yes it does.  I have not debugged or completed this function yet.

>> +	if (!reg)
>> +		return -EINVAL;
>> +
>> +	ret = regmap_update_bits(regmap, reg, mask, val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (enable_time > 0)
>> +		usleep_range(enable_time, enable_time + 100);
>> +
>> +	return 0;
>> +}
> 
> Regards,
> 
> Tony
> 


-- 
------------------
Dan Murphy
