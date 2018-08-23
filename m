Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56484C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0009620C07
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YfN99YxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0009620C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeHWTzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:55:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56364 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeHWTzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:55:47 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7NGOxXY036886;
        Thu, 23 Aug 2018 11:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535041499;
        bh=cjWhkDH8MiBTgJvtOy9Q7hrrgJ2lQq1s6ejXkFumv6E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YfN99YxNs2NiFOV78SJ/qiIiOnAUMNHjbbUPvgP0N6odCUSrJZATgHUKjll5QfW4Y
         XuwHL1XJUTatEX9DlUNVaxR7DdRdMNo5H8wPIhNxZITDYjVyZQ/MwXq9kDBrilxn1x
         aPlgb3UdHFQN6+jCAU/7/Fi/13Y2OTNjJ8MwHf2Q=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7NGOx3U031391;
        Thu, 23 Aug 2018 11:24:59 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 23
 Aug 2018 11:24:59 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 23 Aug 2018 11:24:59 -0500
Received: from [128.247.59.203] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7NGOwO3006470;
        Thu, 23 Aug 2018 11:24:58 -0500
Subject: Re: [PATCH] cpufreq: ti-cpufreq: Only register platform_device when
 supported
To:     Johan Hovold <johan@kernel.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180823024432.7000-1-d-gerlach@ti.com>
 <20180823075058.GR14967@localhost>
From:   Dave Gerlach <d-gerlach@ti.com>
Message-ID: <27e25e06-2721-87dd-3e9b-8d91f6c49449@ti.com>
Date:   Thu, 23 Aug 2018 11:24:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180823075058.GR14967@localhost>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/2018 02:50 AM, Johan Hovold wrote:
> On Wed, Aug 22, 2018 at 09:44:32PM -0500, Dave Gerlach wrote:
>> Currently the ti-cpufreq driver blindly registers a 'ti-cpufreq' to force
>> the driver to probe on any platforms where the driver is built in.
>> However, this should only happen on platforms that actually can make use
>> of the driver. There is already functionality in place to match the
>> SoC compatible so let's factor this out into a separate call and
>> make sure we find a match before creating the ti-cpufreq driver device.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>>  drivers/cpufreq/ti-cpufreq.c | 25 ++++++++++++++++++++-----
>>  1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
>> index 3f0e2a14895a..541fdcf17b57 100644
>> --- a/drivers/cpufreq/ti-cpufreq.c
>> +++ b/drivers/cpufreq/ti-cpufreq.c
>> @@ -201,19 +201,31 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
>>  	{},
>>  };
>>  
>> +static const struct of_device_id *ti_cpufreq_match_node(void)
>> +{
>> +	struct device_node *np;
>> +	const struct of_device_id *match;
>> +
>> +	np = of_find_node_by_path("/");
>> +	match = of_match_node(ti_cpufreq_of_match, np);
>> +	of_node_put(np);
>> +
>> +	if (!match)
>> +		return NULL;
>> +	else
>> +		return match;
> 
> Shouldn't this just be "return match"?

Whoops, yes that's an entirely pointless check I added.

> 
>> +}
>> +
>>  static int ti_cpufreq_probe(struct platform_device *pdev)
>>  {
>>  	u32 version[VERSION_COUNT];
>> -	struct device_node *np;
>>  	const struct of_device_id *match;
>>  	struct opp_table *ti_opp_table;
>>  	struct ti_cpufreq_data *opp_data;
>>  	const char * const reg_names[] = {"vdd", "vbb"};
>>  	int ret;
>>  
>> -	np = of_find_node_by_path("/");
>> -	match = of_match_node(ti_cpufreq_of_match, np);
>> -	of_node_put(np);
>> +	match = ti_cpufreq_match_node();
>>  	if (!match)
>>  		return -ENODEV;
>>  
>> @@ -290,7 +302,10 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>>  
>>  static int ti_cpufreq_init(void)
>>  {
>> -	platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
>> +	/* Check to ensure we are on a compatible platform */
>> +	if (ti_cpufreq_match_node())
>> +		platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
>> +
>>  	return 0;
>>  }
>>  module_init(ti_cpufreq_init);
> 
> With that fixed, feel free to add:
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>

Thanks for the review I will update and resend.

Regards,
Dave

> 
> Johan
> 

