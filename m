Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF96C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D6A21480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gM7ycBu1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hV74MeR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D6A21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbeHPIYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 04:24:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57190 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbeHPIYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 04:24:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F2771619BF; Thu, 16 Aug 2018 05:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534397332;
        bh=GRH46pZgiTd4RLtgMiEgZhWG+0Mfa6M+BN2ZHBXpmOw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gM7ycBu1y2gAoDNnNMxzBLlg1ykQeJPyVBo5n9VnH5YhLSw27jht307p7516JrZ8D
         sdeQETgF54SdRy8ZHdhhnptMzJKJ78GYXpwedbe7XKw02SzENdKBEoZ7pFS29y3O7J
         7t7XjMPhX98MOsHNie20TEkqQxOGxHSI6CSAxncg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1420A619BF;
        Thu, 16 Aug 2018 05:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534397331;
        bh=GRH46pZgiTd4RLtgMiEgZhWG+0Mfa6M+BN2ZHBXpmOw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hV74MeR+VVDZGAMIod/kBI/1w7iiPBSpE4yH/OqW1OX9Y5PDCwTJqQm4Gkj7H4EPZ
         Nj9tq43j5kJJi9j/QzsTNc5kNxVnGC7tv5+AIP27Qts4J7kUXjLjHnmH3WJMr1XvzO
         jxGANATaZ/hqB7sHcAWCCe31u+/wE8dhfw+6sdsU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Aug 2018 10:58:51 +0530
From:   kgunda@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V4 5/8] backlight: qcom-wled: Restructure the driver for
 WLED3
In-Reply-To: <20180807053705.GB23866@tuxbook-pro>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-6-git-send-email-kgunda@codeaurora.org>
 <20180807053705.GB23866@tuxbook-pro>
Message-ID: <53030a892f6cd69a8e58188ff1a60f36@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-07 11:07, Bjorn Andersson wrote:
> On Mon 09 Jul 03:22 PDT 2018, Kiran Gunda wrote:
>> diff --git a/drivers/video/backlight/qcom-wled.c 
>> b/drivers/video/backlight/qcom-wled.c
> [..]
>> @@ -365,6 +434,15 @@ static int wled_configure(struct wled *wled, 
>> struct device *dev)
>> 
>>  	cfg->num_strings = cfg->num_strings + 1;
>> 
>> +	string_len = of_property_count_elems_of_size(dev->of_node,
>> +						     "qcom,enabled-strings",
>> +						     sizeof(u32));
>> +	if (string_len > 0)
>> +		rc = of_property_read_u32_array(dev->of_node,
>> +						"qcom,enabled-strings",
>> +						wled->cfg.enabled_strings,
> 
> qcom,enabled-strings is listed as optional, but without it we will end
> up with qcom,num-strings zeros in an array.  Initialize
> wled->cfg.enabled_strings to 0,1,2,3 and the driver will be backwards
> compatible.
> 
Correct. I will initialize the array in the next series.
> I also think that if you do qcom,enabled-strings = <0, 1, 2>; there's 
> no
> need to also specify qcom,num-strings = <3>; and we can just use
> string_len for num_strings.
Correct. But I have kept this property to have the backward 
compatibility with the
old driver (WLED3).
> 
>> +						sizeof(u32));
>> +
>>  	return 0;
>>  }
> 
> Regards,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
