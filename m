Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0876C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44F22086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMkOFMri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44F22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeLJNT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:19:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38366 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLJNT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:19:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so11242060wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A14+cpGICZmkMKX5exos1oEbeGXA8qhcpaKcy1nQco8=;
        b=QMkOFMri09y5suUJygM4n4A8Djupz/dZGWUePOMbwewPKwFanhwUo6+TAn83Ej4RoD
         yGmkx+M0up4TslDKh0vlirD0zaC5oUlQe+gIbHgPk5LGjvnRj/Fg4w16iaJjGvb9D8R4
         tWPrx2l7niMGxSlYQIJYhxu2HBWx0Vm9AHXRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A14+cpGICZmkMKX5exos1oEbeGXA8qhcpaKcy1nQco8=;
        b=fCM5CoUle365zc/k/G+MyfQ6zfVnHQYrnCJ5wp1cDfhAzyxOOwkkszgkZ52ZOhAbde
         SCAp5yyGIjpV5kZl/dAJ/9eKXQGgz8OAIoade7fNxRbKpLed6Qp6sfaEl0XDsjSepFfq
         mEpdPV+k6ouoZmlOFtKMIuarmMtpOK1RQSIEC8BfG97LLfyZNkuRn4dQsf2PqyaaN76j
         K11KkfJClcoKx6hdItGqcqn8xepoxHvEmdLWft0SYV7TSPz1K2EyfS641xMkWG4jLMkO
         0edl1hbJYA+uR2+PFBf9Kek8wB56qRehXdmY3ZQ2HURfpLf/ytKRS8GIoIXO07xDWqqh
         W4VQ==
X-Gm-Message-State: AA+aEWYu6z3kS9w0un080E8DKNXSZto8GnsRFSMxU+KvO4Up4m5Py92a
        Cf1W6ow34J/xz4n6UewrvBDR6lAoQ/0=
X-Google-Smtp-Source: AFSGD/UfopOwtzjNW6Z5QiMIMkNEY9VUc8LTintGnJamIW2V+0AmfoHwemmgiH6uq/Egm0vN5uwdgA==
X-Received: by 2002:a1c:9183:: with SMTP id t125mr10211485wmd.79.1544447994875;
        Mon, 10 Dec 2018 05:19:54 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id x8sm36540626wmd.45.2018.12.10.05.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 05:19:53 -0800 (PST)
Subject: Re: [PATCH v4 2/4] irqchip/gic: common: add support to device tree
 based quirks
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
References: <20181210102309.8207-1-srinivas.kandagatla@linaro.org>
 <20181210102309.8207-3-srinivas.kandagatla@linaro.org>
 <da39d3af-b8e4-1b5e-cdf4-54dd9e955a0b@arm.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <50b81a24-ecf1-b36f-86e5-1ec4a476cbfd@linaro.org>
Date:   Mon, 10 Dec 2018 13:19:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <da39d3af-b8e4-1b5e-cdf4-54dd9e955a0b@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/18 10:55, Marc Zyngier wrote:
>>   
>> +void gic_enable_of_quirks(const struct device_node *np,
>> +			  const struct gic_quirk *quirks, void *data)
>> +{
>> +	for (; quirks->desc; quirks++) {
> So you expect quirks->desc to be NULL at some point, just like for any
> other quirk table we have.
> 
>> +		if (!of_device_is_compatible(np, quirks->compatible))
>> +			continue;
>> +		if (quirks->init(data))
>> +			pr_info("GIC: enabling workaround for %s\n",
>> +				quirks->desc);
>> +	}
>> +}
>> +
>>   void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
>>   		void *data)
>>   {
>> diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
>> index 3919cd7c5285..97e58fb6c232 100644
>> --- a/drivers/irqchip/irq-gic-common.h
>> +++ b/drivers/irqchip/irq-gic-common.h
>> @@ -23,6 +23,7 @@
>>   
>>   struct gic_quirk {
>>   	const char *desc;
>> +	const char *compatible;
>>   	bool (*init)(void *data);
>>   	u32 iidr;
>>   	u32 mask;
>> @@ -35,6 +36,8 @@ void gic_dist_config(void __iomem *base, int gic_irqs,
>>   void gic_cpu_config(void __iomem *base, void (*sync_access)(void));
>>   void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
>>   		void *data);
>> +void gic_enable_of_quirks(const struct device_node *np,
>> +			  const struct gic_quirk *quirks, void *data);
>>   
>>   void gic_set_kvm_info(const struct gic_kvm_info *info);
>>   
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 29e9d47be97d..c95796fa4de6 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -1271,6 +1271,9 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
>>   	gic_set_kvm_info(&gic_v3_kvm_info);
>>   }
>>   
>> +static const struct gic_quirk gic_quirks[] = {
>> +};
> ... and yet here you provide an empty table. That's not going to work
> very well. You definitely need to have an empty entry at the end of the
> array, always.
> 
> I guess you want to test your code on a non affected platform, and I'm
> pretty sure you'll see it exploding.

Yes, Should have carefully looked at this!!
We need an empty entry at the end!
I will fix it and send a new version!

Thanks,
srini
> 
