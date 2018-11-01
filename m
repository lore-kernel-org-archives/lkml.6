Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA512C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA9920823
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rs8NNUbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA9920823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeKAKaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbeKAKaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:30:22 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B3920821;
        Thu,  1 Nov 2018 01:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541035777;
        bh=itOGhcqFnLrlDs0mvAOwihnvYp5vyu5r7rS5R6tAX4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rs8NNUbDtaGuEUqh3qMtnxHKJHvsUfYAm+IStyW5TUL9RLQlpHnYc/omq+iucfPfL
         8drMTFh4kcW2ZoYxvFzi/OOBrKO2jb9sxrY3boRQrBslh4StDACyyopxo3NXwjDptj
         SgeswZQjBrRVCYZtsQXMkiTDApDqh4iLH4SFs0To=
Date:   Wed, 31 Oct 2018 21:29:36 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH AUTOSEL 3.18 22/22] mfd: menelaus: Fix possible race
 condition and leak
Message-ID: <20181101012936.GY194472@sasha-vm>
References: <20181031231206.29509-1-sashal@kernel.org>
 <20181031231206.29509-22-sashal@kernel.org>
 <20181101002708.GG24212@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181101002708.GG24212@piout.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 01:27:08AM +0100, Alexandre Belloni wrote:
>Hello,
>
>On 31/10/2018 19:12:06-0400, Sasha Levin wrote:
>> -	m->rtc = rtc_device_register(DRIVER_NAME,
>> -			&m->client->dev,
>> -			&menelaus_rtc_ops, THIS_MODULE);
>> -	if (IS_ERR(m->rtc)) {
>> +	err = rtc_register_device(m->rtc);
>
>This appeared in v4.13, this will not compile on v3.18.

Indeed, I guess I need more cross-compilers here. Thanks!

--
Thanks,
Sasha
