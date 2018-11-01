Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1436DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0FE2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0FE2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeKAJ1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:27:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50080 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbeKAJ1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:27:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E7DB2207BC; Thu,  1 Nov 2018 01:27:07 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id C159920726;
        Thu,  1 Nov 2018 01:27:07 +0100 (CET)
Date:   Thu, 1 Nov 2018 01:27:08 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH AUTOSEL 3.18 22/22] mfd: menelaus: Fix possible race
 condition and leak
Message-ID: <20181101002708.GG24212@piout.net>
References: <20181031231206.29509-1-sashal@kernel.org>
 <20181031231206.29509-22-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031231206.29509-22-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 31/10/2018 19:12:06-0400, Sasha Levin wrote:
> -	m->rtc = rtc_device_register(DRIVER_NAME,
> -			&m->client->dev,
> -			&menelaus_rtc_ops, THIS_MODULE);
> -	if (IS_ERR(m->rtc)) {
> +	err = rtc_register_device(m->rtc);

This appeared in v4.13, this will not compile on v3.18.

> +	if (err) {
>  		if (alarm) {
>  			menelaus_remove_irq_work(MENELAUS_RTCALM_IRQ);
>  			device_init_wakeup(&m->client->dev, 0);
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
