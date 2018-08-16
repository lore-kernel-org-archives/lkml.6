Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474A2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C9D21480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y9yO4rZM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="blE0Vi/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C9D21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388334AbeHPI3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 04:29:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbeHPI3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 04:29:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8607B61867; Thu, 16 Aug 2018 05:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534397599;
        bh=PiMMRwGH7UG9rbb4u+TB2yd6TuMGkQu2hpBzkSeuuhk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y9yO4rZMayPulGddukco8XYM/1DW+K6ldxZd0wKNhjlF7UHLkf+/o+S0xym6P11Or
         rbFwbl7DyPnSdixmtSQxTFcecWf97lQYFOoO4LT6sCJ/dG4dmGBJb4qrY6kqQsfK8j
         l4heiajeCxftQEYMvVflHjoPRc9AeJpfnE6tjV18=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B323B618EB;
        Thu, 16 Aug 2018 05:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534397598;
        bh=PiMMRwGH7UG9rbb4u+TB2yd6TuMGkQu2hpBzkSeuuhk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=blE0Vi/pBzdjl/A+ttf/fp1nKRSTTwk0PDtUL4FV5tJKTJdN9Mb4FB6WFKt9FSn8F
         KjE075k773H1PJWd18GfGvlBPkBovtJNHepLnZqigZ3vmeyVZFakxnAgqIRMIPJLNp
         1OLC0AcGonH1oejVlCKP1wgKDHqvLn0gWTo5+bUI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Aug 2018 11:03:18 +0530
From:   kgunda@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V4 8/8] backlight: qcom-wled: Add auto string detection
 logic
In-Reply-To: <20180807063229.GE23866@tuxbook-pro>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-9-git-send-email-kgunda@codeaurora.org>
 <20180807063229.GE23866@tuxbook-pro>
Message-ID: <bfc20fc54fcb3bc91ce13b353f73039e@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-07 12:02, Bjorn Andersson wrote:
> On Mon 09 Jul 03:22 PDT 2018, Kiran Gunda wrote:
>> diff --git a/drivers/video/backlight/qcom-wled.c 
>> b/drivers/video/backlight/qcom-wled.c
> [..]
>> @@ -189,6 +206,15 @@ static int wled4_set_brightness(struct wled 
>> *wled, u16 brightness)
>>  	return 0;
>>  }
>> 
>> +static void wled_ovp_work(struct work_struct *work)
>> +{
>> +	struct wled *wled = container_of(work,
>> +					 struct wled, ovp_work.work);
>> +
>> +	if (wled->ovp_irq > 0)
>> +		enable_irq(wled->ovp_irq);
>> +}
>> +
>>  static int wled_module_enable(struct wled *wled, int val)
>>  {
>>  	int rc;
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
>> +		schedule_delayed_work(&wled->ovp_work, WLED_SOFT_START_DLY_US);
> 
> schedule_delayed_work() takes a delay in jiffies, not micro seconds.
> 
I will address it in the next series.
>> +	} else {
>> +		cancel_delayed_work_sync(&wled->ovp_work);
> 
> If we get here within WLED_SOFT_START_DLY_US of a module enable we have
> yet to execute the enable_irq() in the delayed worker, which should 
> mean
> that the irq is unbalanced from then on.
> 
> I believe you can check the return value of cancel_delayed_work_sync()
> being true to know if wled_ovp_work() was yet to execute.
> 
Ok. I will address it in next series.
>> +		if (wled->ovp_irq > 0)
>> +			disable_irq(wled->ovp_irq);
>> +	}
>> +
>> +	return 0;
>>  }
>> 
> 
> Regards,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
