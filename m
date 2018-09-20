Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C5CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B85C21526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="WCSAUX4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B85C21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbeITPcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:32:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43928 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbeITPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:32:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id x24-v6so7735003lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HqpwcnAl+Xo45jX0KpKmdqRf5UVh/kqIgJH9ilZLAUQ=;
        b=WCSAUX4XG/MCwGudyFuLJ521opbYReSxyNnUn6WUtwnzaAHvw/sH9ioqF4XPXNRjBh
         dkGHNG6x6NyOTRWhtKQiGPwOHwkCufiVUwjRdy5U5mgQSHAcDaK6zlbjjnd3bdHlg1or
         DHyxq9BWVPXkM8bHkMvXzfgZS0Nk+JKr+6B/8bHdWstC14a6IOOC2oEjldNSAsizvh15
         qKXepCkU+h/Q4IcwLLeTv8pjjFF0pl0sKd+af4qx3lMNtRW6W2Xoo6o/55YOxKVR6FnE
         lXhAZe6NFnK5WaHJG96zJc28IxPtFUhPsTbsrsF27TRTiamTA6cUUmbhUdacOCmJpiB/
         8wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HqpwcnAl+Xo45jX0KpKmdqRf5UVh/kqIgJH9ilZLAUQ=;
        b=dgBUrbdujY0KBxiWy77tBFFB2JD/nMjVLrubN88wgjqrtoeu3iNSxktUBm9CdaaAPU
         bY1NFORhBqnPJiFnkYUq8jk+/Fm4lqV9zzeiSr5k05sVKcMoTHs9DAMWBKE8ewMnFys8
         NayuP8GWYMSy9iAIg8clTYUyj9y/QKGwDeed5W/mxswX+ahKgBp1FVhlGW9VbF6cex4d
         cp+cB87N42UT57YtL7ObfPjziNuQJzeexPBX90FHBMz/cC9Owu+dT3tQuRxZGuXK3GsH
         6hTwGuyDl8KnNwUvdbl58L+1Wl6p2dtvDBeT5iXAZZ60ImtBeh9hAJ4s5ZCrqY5yX/lv
         UMnA==
X-Gm-Message-State: APzg51A55qp90Gewpz2JSwrVjZdWrg8YqHs+A/QHU1dHv+rXiIQoFmy8
        7UTcRZEhmzF+o4T/qH0Wsfm8RGBmxUc=
X-Google-Smtp-Source: ANB0VdbW/puIqIzX7wPtVRc1DGDteXAS0azzcsZPWA+0uZpnWdL6E4fa58af4g8ApPopL4nprxt8tg==
X-Received: by 2002:a19:d808:: with SMTP id p8-v6mr25418718lfg.105.1537436973036;
        Thu, 20 Sep 2018 02:49:33 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.87.42])
        by smtp.gmail.com with ESMTPSA id 17-v6sm4412016ljs.32.2018.09.20.02.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 02:49:31 -0700 (PDT)
Subject: Re: [PATCH] net: ibm: remove a redundant local variable 'k'
To:     zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net
Cc:     dougmill@linux.vnet.ibm.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1537366995-59168-1-git-send-email-zhongjiang@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <be705033-2fd3-ba4c-31ae-0183882d1992@cogentembedded.com>
Date:   Thu, 20 Sep 2018 12:49:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537366995-59168-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 9/19/2018 5:23 PM, zhong jiang wrote:

> The local variable 'k' is never used after being assigned.
> hence it should be redundant adn can be removed.

    Can.

> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
[...]

MBR, Sergei

