Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3BBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF9B20878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nZUTE5uV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e6FaTe+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfAKXeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:34:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40594 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfAKXeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:34:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 18C43608CE; Fri, 11 Jan 2019 23:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547249660;
        bh=zE59Vfxh1F9CXCKP5GImn133C6c/nvYKTLYgyjzhtTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nZUTE5uVB/4BHmuyX9k4a8Zik8y7NNuTKaHB3t1LKsZ9YKsfCruw14UuH4aj4cJjw
         exzBn2Qsf1K/Au9z2rO2ZuLYY8iwpH7EvEhQFdhre+DyQL0Mxw+5PWMqHBRaapUOyM
         Iuv6fnlWePyBY3VSc55bv1OWdDftaG59YLXDwBx0=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E352360397;
        Fri, 11 Jan 2019 23:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547249659;
        bh=zE59Vfxh1F9CXCKP5GImn133C6c/nvYKTLYgyjzhtTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e6FaTe+FJ5Y0W0NRN0IrKUbaFB9i0b+3IpExcWcysVc2mjnKktMTl+4oFQCk55evE
         0JdAxRe+d0xUVqgaf9drQoDkYunj03OoKkHB1yopiqk4+vvQZSTImLfCga6mwbTtgp
         lKeqYFP3OEFZhTFCYoxPscQNqNN+KOqj4yEDRT3s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E352360397
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 11 Jan 2019 16:34:18 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH 3/7] drivers: irqchip: add PDC irqdomain for wakeup
 capable GPIOs
Message-ID: <20190111233418.GA29875@codeaurora.org>
References: <20181219221105.3004-1-ilina@codeaurora.org>
 <20181219221105.3004-4-ilina@codeaurora.org>
 <154533717951.79149.1309452983166815703@swboyd.mtv.corp.google.com>
 <20190107184836.GG14960@codeaurora.org>
 <154724735183.169631.5181161977573120432@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <154724735183.169631.5181161977573120432@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11 2019 at 15:55 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-01-07 10:48:36)
>> On Thu, Dec 20 2018 at 13:19 -0700, Stephen Boyd wrote:
>> >Quoting Lina Iyer (2018-12-19 14:11:01)
>>
>> >> +static const struct pdc_gpio_pin_data sdm845_gpio_data = {
>> >> +       .size = ARRAY_SIZE(sdm845_gpio_pdc_map),
>> >> +       .map = sdm845_gpio_pdc_map,
>> >> +};
>> >> +
>> >> +const struct of_device_id pdc_gpio_match_table[] = {
>> >> +       { .compatible = "qcom,845-pdc", .data = &sdm845_gpio_data },
>> >
>> >Why not qcom,sdm845-pdc?
>> >
>> The compatible matches the compatible specified in the PDC driver. Not
>> sure why the 'sdm' was left out at that time.
>
>Are you going to add sdm?
>
Realized this is a bug. Will fix.
>>
>> >> +       { },
>> >> +};
>> >
>> >I wonder why we wouldn't just put this all into the qcom-pdc.c file at
>> >the bottom and then have that IRQCHIP_DECLARE() macros call small
>> >functions that pass the pdc to gpio mapping table to qcom_pdc_init()
>> >that takes a third argument?
>> >
>> We could. I feel we would be adding tables like this and it just
>> clutters up the driver file. May be in the future we could move to
>> target specific data file like the gpios, but that could be excessive
>> too. Thought this might be a compromise. I am open to change.
>
>Ok. The benefit to my approach is that we don't do the string match
>twice. We do it once and sacrifice a little code space to jump to the
>real init function with the data we want. We can then put those chip
>tables inside some #ifdef to save space and allow configurations to turn
>off everything in EXPERT mode but leave everything default enabled
>otherwise.
>
Sure. I will use this idea.

>>
>> >I really hope that in the future all the gpios can be wakeup capable so
>> >that we don't need to have the table at all!
>> >
>> I doubt there are plans to support that in hardware. We should plan for
>> supporting tables like this for other chipsets based on the PDC
>> architecture.
>>
>
>Uh oh. That's sad.
>
