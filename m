Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79A1C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD15218C1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uvifJnHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD15218C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeHFDXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 23:23:37 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:54023 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeHFDXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 23:23:36 -0400
Received: by mail-it0-f41.google.com with SMTP id 72-v6so15303950itw.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 18:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NK4xiPhNoHI0q5zSUuP9TZoGR4GMSiGDEhWlNc6CDes=;
        b=uvifJnHbCM/PRpemsLZJrMuXsASnnVG/fuIYhnai6+ZQitdr6D8yFc8gT9Um0sRtUP
         xfk8rkHc7sy6KxcOutk3eEN06WNnPqkqe4+dMHYzh7k7Jd2CPUFco/tg/5qIRH6MrwDh
         oxdOEeFmMbs/mZt80Mn0UeatkPIBRqlP2d9pxp2ShDKZbXFDEBDWiF4yNRTJMd4k+ZU7
         e58xv47GQAMc2KlwFgS5HSPnX9LGtZgaaqxq8x4OvgMnIVcyZJTNGfbT2r6Coo79P5aQ
         lcz7vNlfZlh0NfVTpiiFX85mWuuLLLE+99yXH24MG47I0Ee7TRLRK9632Tt0x54RMZw5
         GoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NK4xiPhNoHI0q5zSUuP9TZoGR4GMSiGDEhWlNc6CDes=;
        b=fGZzBdq2LCTqPN3z/aHOeMlWdDsLPTqY3dqSC3WSC2es8nmCT26sNzfoa3MJe5t3jZ
         eVCVt6Xri4NlNinAep3PKGyO5AsGm9BXeFGWDcm2VMbF2h2K11sXXTcDY++b4s7OpLmr
         KUj24jgI5KcObeaNTXaYbKQlczxn2CP7mdz+tY1FeMO4umAiXH2ioK5Y/jI1zvHcNfU4
         d/BaDCOHB8kTiGtJ3JT4V7xvDGB3luTfXJa4JQM6anEblP60pdC0U0ncUG8i/rPz3muJ
         yavrMeFPFv348np/F06Oro5+0mSngZx9wGb5pPEc3ewvu72LggK+pZX1o3x2W3FWLS5I
         xVZA==
X-Gm-Message-State: AOUpUlG9bi2B2Sd9RWF/ZbDgDbTWsH/AFw3VMGo75+a6lm8yWfpwRnbD
        JYAHRizOwkPUsdS9QOlOeu7cQIEERbE=
X-Google-Smtp-Source: AAOMgpfH7f0TTMWTzn3RpIgGT/uQESLzUcK3YOMTlY+NyXU4R3Bko95O94Xf/+Y9Ehu1fOV8wzoY/Q==
X-Received: by 2002:a24:7882:: with SMTP id p124-v6mr13546283itc.111.1533518219177;
        Sun, 05 Aug 2018 18:16:59 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id b81-v6sm3003853itg.6.2018.08.05.18.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 18:16:57 -0700 (PDT)
Subject: Re: linux-next: Signed-off-by missing for commit in the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180806075112.6253d2da@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <91bc0348-fbb4-168b-2946-5163a204819b@kernel.dk>
Date:   Sun, 5 Aug 2018 19:16:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180806075112.6253d2da@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/18 3:51 PM, Stephen Rothwell wrote:
> Hi Jens,
> 
> Commit
> 
>   290a40cb336c ("nvme: don't enable AEN if not supported")
> 
> is missing a Signed-off-by from its committer.

It's because I'm an idiot and cherry picked the commit. Not only is
it missing the SOB, but it'll also show up twice if pulled. I'll likely
just have to rebase to get rid of this, and then pull in the right
-rc instead... Will do that tomorrow.

-- 
Jens Axboe

