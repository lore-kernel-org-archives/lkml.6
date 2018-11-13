Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F00EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16278223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dJ7JI4ED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16278223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeKNFOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:14:35 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35808 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNFOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:14:34 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wADJEFNx070232;
        Tue, 13 Nov 2018 13:14:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542136455;
        bh=xxuIJbEBct/MZI5i7pQczZgRzkCtJKgivk1A3FAOzG8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dJ7JI4EDuBZbJU4bwlVig/h2Q62MAKT/PifMrVvYXpZZ8YA+jTH3ut/08KFypCM3F
         RK0H2ZMoJLN+z1HEHlHefDjyjsia15WLBBq0QNi5h86Tt6atRI6p+VpQ8VQ0nz+yGt
         Jl5cusZEpdTjvETzZMxo2ZCoYDEjK6K4DswpBH3Y=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wADJEF53012625
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Nov 2018 13:14:15 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 13
 Nov 2018 13:14:15 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 13 Nov 2018 13:14:15 -0600
Received: from [128.247.59.203] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wADJEF43014970;
        Tue, 13 Nov 2018 13:14:15 -0600
Subject: Re: [PATCH v3] cpufreq: ti-cpufreq: Only register platform_device
 when supported
To:     Johan Hovold <johan@kernel.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Keerthy J <j-keerthy@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <20181113173912.27643-1-d-gerlach@ti.com>
 <20181113175853.GN13311@localhost>
From:   Dave Gerlach <d-gerlach@ti.com>
Message-ID: <c93fb7a9-88ad-d634-18ff-088d146637ce@ti.com>
Date:   Tue, 13 Nov 2018 13:14:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181113175853.GN13311@localhost>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/2018 11:58 AM, Johan Hovold wrote:
> On Tue, Nov 13, 2018 at 11:39:12AM -0600, Dave Gerlach wrote:
>> Currently the ti-cpufreq driver blindly registers a 'ti-cpufreq' to force
>> the driver to probe on any platforms where the driver is built in.
>> However, this should only happen on platforms that actually can make use
>> of the driver. There is already functionality in place to match the
>> SoC compatible so let's factor this out into a separate call and
>> make sure we find a match before creating the ti-cpufreq platform device.
>>
>> Reviewed-by: Johan Hovold <johan@kernel.org>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>> v2->v3: Use platform_device_register_resndata to pass match data to probe to
>> 	to avoid matching again in probe.
>>
>> 	v2: https://patchwork.kernel.org/patch/10574535/
>>
> 
>>  static int ti_cpufreq_init(void)
>>  {
>> -	platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
>> +	const struct of_device_id *match;
>> +
>> +	/* Check to ensure we are on a compatible platform */
>> +	match = ti_cpufreq_match_node();
>> +	if (match)
>> +		platform_device_register_resndata(NULL, "ti-cpufreq", -1, NULL,
>> +						  0, match,
>> +						  sizeof(*match));
> 
> platform_device_register_data()?

Whoops yeah that's a bit more concise, v4 incoming.

Regards,
Dave

> 
>>  	return 0;
>>  }
>>  module_init(ti_cpufreq_init);
> 
> Johan
> 

