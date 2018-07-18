Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB7CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845832075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFifDTc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845832075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbeGRSf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:35:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45823 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731596AbeGRSf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:35:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16-v6so4964487edq.12;
        Wed, 18 Jul 2018 10:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=84wAhKUCA4qSmRANSQEF/7RgRZ8h1XHJvFBP1ZhXg20=;
        b=gFifDTc05OkcMqw0LXrlXUIVbZW+uAdewNDVpTPlIaDyayOYnECX3SsTA9C5/LxqDr
         cW4x9rYneNYbzXdE8NOSAC17KochhA0c7tO/GC671s3J3jIUTLT+1f5n7sSVY/OzQ5bp
         T7YHipmlEHcoYw/8ZM3HzYfzB8fxVXlgWGR8jjZF5UNG8+fN2Hu9/IKYgUsRMF3kIQSv
         6EMKBCTfdnYl5mnyuOV2SlR9tWRAAogoIbeyUsaehgG9Xkt2Y7BC0G4EafIJRxwWj63h
         yIhmqaqjt1dTS/lG82cuSDOxZ6F/b06DM/5rcbn5tRk+1Eq9JALyTF3BgqzYCRMGbV8p
         H1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=84wAhKUCA4qSmRANSQEF/7RgRZ8h1XHJvFBP1ZhXg20=;
        b=g/DjZHjFR/Pmbab9xqU4UQf0AlftYQosgGOF73INBO5lfzvNIXLWH3ELDGpkTapN1C
         uegh/2s2GGnun0Y+e0VkYsCWY94YWabsgqdNwqxZhrjqaYABZj4fWR4pk7t2fnitI3wq
         Fk+SusblS+oUT/DmxIrYO7GH4Alcmz1YraJ/lepgd9g1p9/1h1c4iKqerbKC9nlHQGM0
         TOMzfHroYAwtet78I8WmAZ6r9j28yrMOurHTQfXH9DnH4FUMSqMy81n+IZ09qQxG8NQR
         m+zym9vtCmGIRFWRf0+1xVACXfdsG9Wu6+KjTsd6ewNNsxv4s4vWqK63TjMU6BTWSYQS
         dI0g==
X-Gm-Message-State: AOUpUlGiJIw6cKtGiAXHEFeZm5pJv3k/cAeXhzCPLTeaPcPU7U7YDYQ7
        SW/qZgA1zD6TXn9amjbHOsI=
X-Google-Smtp-Source: AAOMgpcqdZJ5sg5kqbE5o6xy3sXY1tMwNyCyHPtDGHmb6i1FQGZ2zHPO6yBtNQipsVf4TfEgSvSE8A==
X-Received: by 2002:aa7:d40a:: with SMTP id z10-v6mr7887555edq.203.1531936615888;
        Wed, 18 Jul 2018 10:56:55 -0700 (PDT)
Received: from [192.168.1.54] (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id 8-v6sm1611024edv.77.2018.07.18.10.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 10:56:55 -0700 (PDT)
Subject: Re: [PATCH] clk: vc5: Avoid divide by zero when rounding or setting
 rates
To:     Stephen Boyd <sboyd@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve Longerbeam <steve_longerbeam@mentor.com>
References: <1527818357-8154-1-git-send-email-steve_longerbeam@mentor.com>
 <153090140728.143105.7720351459587498082@swboyd.mtv.corp.google.com>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <9b8f68f6-dd88-cc1a-6f13-b4d2fedadead@gmail.com>
Date:   Wed, 18 Jul 2018 10:56:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153090140728.143105.7720351459587498082@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/06/2018 11:23 AM, Stephen Boyd wrote:
> Quoting Steve Longerbeam (2018-05-31 18:59:17)
>> Add checks in the .round_rate and .set_rate ops for zero requested
>> rate or zero parent rate. If either are zero in .round_rate, just
>> return zero. If either are zero in .set_rate, return -EINVAL.
> Are you seeing problems when the clk is unparented and we're trying to
> recalculate the rate or change rates, and thus the parent frequency
> looks like 0?

The problem appeared when suspending the rcar-du driver.
The kernel tested is a Renesas BSP release (3.6.2), and in the
version of the rcar-du driver from that release, the driver calls
clk_set_rate() with a rate of zero in its suspend PM op. This is
fixed in mainline kernel. So the divide-by-zero in vc5 clock driver
probably will not show up in mainline.

>   Should this get a Fixes: tag so that it goes back to
> stable kernels?
>

Zero rates are not checked beginning with the initial commit
3e1aec4e2c ("clk: vc5: Add support for IDT VersaClock 5P49V5923 and 
5P49V5933").
so that would have to be the Fixes: tag.

Steve

