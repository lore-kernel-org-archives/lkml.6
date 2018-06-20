Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE5FC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCEE20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fuiNxW92";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fuiNxW92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCEE20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754272AbeFTLDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:03:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49284 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754235AbeFTLDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:03:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E3F3860B18; Wed, 20 Jun 2018 11:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529492585;
        bh=0/yEzv6nHNUmDqj5u7jFGVQDYtpFVTb/FF40b8YthPU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fuiNxW92dZfQcetGOdK9NzfhiSkoL/em10I0HPuF5n+N8KdolgzeGjhy7o7pc4uWk
         EqwpoRAXMM5eX1ivrPRnM2IGwT5uyPIrM/F0J7ZCgWUcdEyD+rlVNZFwwZxOKVG9SZ
         ojnslvVEetPLdyLddAhszzdJeFEA7T/h9T2M0DyI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3DE3F604A6;
        Wed, 20 Jun 2018 11:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529492585;
        bh=0/yEzv6nHNUmDqj5u7jFGVQDYtpFVTb/FF40b8YthPU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fuiNxW92dZfQcetGOdK9NzfhiSkoL/em10I0HPuF5n+N8KdolgzeGjhy7o7pc4uWk
         EqwpoRAXMM5eX1ivrPRnM2IGwT5uyPIrM/F0J7ZCgWUcdEyD+rlVNZFwwZxOKVG9SZ
         ojnslvVEetPLdyLddAhszzdJeFEA7T/h9T2M0DyI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Jun 2018 16:33:05 +0530
From:   kgunda@codeaurora.org
To:     Vinod <vkoul@kernel.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V3 6/7] backlight: qcom-wled: add support for short
 circuit handling
In-Reply-To: <20180620054722.GH13316@vkoul-mobl>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-7-git-send-email-kgunda@codeaurora.org>
 <20180620054722.GH13316@vkoul-mobl>
Message-ID: <830ec51a6ea0cb9bcf8981cda86975cc@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-20 11:17, Vinod wrote:
> On 19-06-18, 16:43, Kiran Gunda wrote:
> 
>>  struct wled {
>>  	const char *name;
>>  	struct device *dev;
>>  	struct regmap *regmap;
>> +	struct mutex lock;	/* Lock to avoid race from ISR */
> 
> the comment is wrong as you avoid race with thread handler and not the
> main ISR. The ISR runs in atomic context so you cant use a mutex but 
> you
> may do so with a thread handler
> 
Will fix the comment in the next series.
>> +#define WLED_SHORT_DLY_MS			20
>> +#define WLED_SHORT_CNT_MAX			5
>> +#define WLED_SHORT_RESET_CNT_DLY_US		USEC_PER_SEC
> 
> an empty line after defines would be better
> 
Will add it in the next series.
>> +static int wled_configure_short_irq(struct wled *wled,
>> +				    struct platform_device *pdev)
>> +{
>> +	int rc = 0, short_irq;
> 
> superfluous initialization of rc
Will remove the initialization in next series.
