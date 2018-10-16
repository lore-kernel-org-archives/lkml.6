Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579BDC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A55C208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lyBaCzii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A55C208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJPOQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:16:59 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:43944 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeJPOQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1539671286; x=1571207286;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=u4tpebrrl/VBApdlfjTqTVktEETMmv+8uOZOVHOZvLM=;
  b=lyBaCziiuMuWPVWPtlbi88iiBPUIG6N6TjX/Cxw1lC0yR2lU5vmO5PN+
   2BXBlU1W38YnQHe/qgNlh4qj7fE/M6cIVOq3YnqI4wQHlRNv9IUTMncEa
   W6KJteoZbYBO9F+KMzRrokUoH7r6stZMad0OG0NL5zRUaY+JPZOC0fOXv
   0k5vXO/6s9OmQO2TgBi8HnPv6yAZE7KAhnlen5uhhEDLncsgqS6adWTRq
   spDQ/Clc8iRFBrM/Rff3z7luDYWOFLOeR5z5jTTbKIhwIh5XEkaxUzc9R
   RseLpfVur4VaWODv/GkLUAOHbalA8raNMogFeLf8jIey2z+bsT8VNCFFo
   Q==;
X-IronPort-AV: E=Sophos;i="5.54,387,1534780800"; 
   d="scan'208";a="196371778"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2018 14:28:05 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 15 Oct 2018 23:12:40 -0700
Received: from 3k26jc2.ad.shared (HELO [10.86.52.227]) ([10.86.52.227])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Oct 2018 23:28:05 -0700
Subject: Re: [RFC 2/4] pwm: sifive: Add a driver for SiFive SoC PWM
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Wesley Terpstra <wesley@sifive.com>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-3-git-send-email-atish.patra@wdc.com>
 <20181010131128.GA29142@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <39685c1b-46cf-9e78-c9aa-46168627053f@wdc.com>
Date:   Mon, 15 Oct 2018 23:28:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010131128.GA29142@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 6:11 AM, Christoph Hellwig wrote:
> Thanks for getting these drivers submitted upstream!
> 
> I don't really know anything about PWM, so just some random nitpicking
> below..
> 
>> +	iowrite32(frac, pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));
> 
> * already has a higher precedence than +, so no need for the inner
> braces.
> 
>> +	duty = ioread32(pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));
> 
> Same here.

Will remove the braces in both places.
> 
>> +	/* (1 << (16+scale)) * 10^9/rate = real_period */
> 	unsigned long scalePow = (pwm->approx_period * (u64)rate) / 1000000000;
> 
> no camcel case, please.

My bad. I will fix that.

> 
>> +	int scale = ilog2(scalePow) - 16;
>> +
>> +	scale = clamp(scale, 0, 0xf);
> 
> Why not:
> 
> 	int scale = clamp(ilog2(scale_pow) - 16, 0, 0xf);
> 

Sure.

>> +static int sifive_pwm_clock_notifier(struct notifier_block *nb,
>> +				     unsigned long event, void *data)
>> +{
>> +	struct clk_notifier_data *ndata = data;
>> +	struct sifive_pwm_device *pwm = container_of(nb,
>> +						     struct sifive_pwm_device,
>> +						     notifier);
> 
> I don't think there are any guidlines, but I always prefer to just move
> the whole container_of onto a new line:
> 
> 	struct sifive_pwm_device *pwm =
> 		container_of(nb, struct sifive_pwm_device, notifier);

Done.

Regards,
Atish
> 
>> +static struct platform_driver sifive_pwm_driver = {
>> +	.probe = sifive_pwm_probe,
>> +	.remove = sifive_pwm_remove,
>> +	.driver = {
>> +		.name = "pwm-sifivem",
>> +		.of_match_table = of_match_ptr(sifive_pwm_of_match),
>> +	},
>> +};
> 
> What about using tabs to align this a little more nicely?
> 
> static struct platform_driver sifive_pwm_driver = {
> 	.probe			= sifive_pwm_probe,
> 	.remove			= sifive_pwm_remove,
> 	.driver = {
> 		.name		= "pwm-sifivem",
> 		.of_match_table	= of_match_ptr(sifive_pwm_of_match),
> 	},
> };
> 

