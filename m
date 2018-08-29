Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA0CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7391220844
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eTynB6Hb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IOh6agEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7391220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeH2LI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:08:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41450 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeH2LI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:08:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D63B260540; Wed, 29 Aug 2018 07:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535526809;
        bh=dzPkriEpsu0jPqhoR24QNFhQBeJecYxGuFn1tIk0wIU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eTynB6HbMF3iESOOm7pUHCVJzTEg1kLEL2qdR3c0vQ0+x1wCEOn0Vj8oNW6xiw0ZF
         gl/H49At8Fc2YDTA1i2g0cIYCLaXm+Bq8tfLsZbl+jCipNITKELRkJmIGWELJA23IU
         n9vwHado7XCXRNCnjJNv7eVNsIgtDu8z9wnJHPyE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D91E160227;
        Wed, 29 Aug 2018 07:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535526808;
        bh=dzPkriEpsu0jPqhoR24QNFhQBeJecYxGuFn1tIk0wIU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IOh6agEb1m/45+6CdGBQcgUBuC6KgwBgBUgVWswWCDGJGrgDW1RJ0XuxhJrBNc/Tj
         HhTHJqhfROToOdn90wFXN5enPwP9QUl36Xsms+DZE5DALr9Y3VXRXPkqjwBZXHrpFH
         UHlVaemX1ca215mubXCDxD6sLFq56SnHjWf8dvGc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Aug 2018 12:43:28 +0530
From:   kgunda@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V5 8/8] backlight: qcom-wled: Add auto string detection
 logic
In-Reply-To: <20180827145420.GL3048@tuxbook-pro>
References: <1535106467-17843-1-git-send-email-kgunda@codeaurora.org>
 <1535106467-17843-9-git-send-email-kgunda@codeaurora.org>
 <20180827145420.GL3048@tuxbook-pro>
Message-ID: <f6e6baa748d73b68c1cbcc5d955df471@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-27 20:24, Bjorn Andersson wrote:
> On Fri 24 Aug 03:27 PDT 2018, Kiran Gunda wrote:
>> diff --git a/drivers/video/backlight/qcom-wled.c 
>> b/drivers/video/backlight/qcom-wled.c
> [..]
>>  struct wled {
>> @@ -135,16 +146,22 @@ struct wled {
>>  	struct regmap *regmap;
>>  	struct mutex lock;	/* Lock to avoid race from thread irq handler */
>>  	ktime_t last_short_event;
>> +	ktime_t start_ovp_fault_time;
>>  	u16 ctrl_addr;
>>  	u16 sink_addr;
>>  	u16 max_string_count;
>> +	u16 auto_detection_ovp_count;
>>  	u32 brightness;
>>  	u32 max_brightness;
>>  	u32 short_count;
>> +	u32 auto_detect_count;
>>  	bool disabled_by_short;
>>  	bool has_short_detect;
>> +	int ovp_irq;
>> +	bool ovp_irq_disabled;
> 
> ovp_irq_disabled is now only assigned, never read. So you should be 
> able
> to drop it.
> 
Ok. will address in next series.
> [..]
>> @@ -200,7 +226,18 @@ static int wled_module_enable(struct wled *wled, 
>> int val)
>>  				WLED_CTRL_REG_MOD_EN,
>>  				WLED_CTRL_REG_MOD_EN_MASK,
>>  				val << WLED_CTRL_REG_MOD_EN_SHIFT);
>> -	return rc;
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	if (val) {
>> +		schedule_delayed_work(&wled->ovp_work, HZ / 100);
> 
> wled_ovp_work() is a nop when ovp_irq == 0, so wrap the entire if/else
> in a check for ovp_irq > 0 (rather than include it in the else) and 
> drop
> it from the worker.
> 
Will address in next series.
>> +	} else {
>> +		if (!cancel_delayed_work_sync(&wled->ovp_work) &&
>> +		    wled->ovp_irq > 0)
>> +			disable_irq(wled->ovp_irq);
>> +	}
>> +
>> +	return 0;
> 
> Also, if a user calls rmmod within 10ms of enabling module we will
> schedule work of code that's no longer available in the kernel. So you
> need to also cancel_delayed_work_sync() in the remove function of the
> driver.
> 
> 
Will address in next series.
> Apart from this I think this patch looks good now!
> 
Thank you
> Regards,
> Bjorn
