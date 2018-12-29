Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6116FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 15:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C472087F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 15:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WEfYxN5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeL2PWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 10:22:05 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36934 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeL2PWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 10:22:04 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so19330397oia.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 07:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mwm/K69egRq1SanlOLInVAwrbURpDfe7CtVqhOl1rEg=;
        b=WEfYxN5Pc1kFSqhckMCw186LN9K3or8EErFktbigZUavR3ByVm+eM9EyRV+7+4ywkK
         iNyk7rftk6ipLIUFPqOzdqDZXorlqdEAw7fiJHwwB4g7L6MTYQ6Tb75LkMZTelwzrTt2
         /+kRj8xf8/rNthaG4+Th9p9YZBdU76Q0vASdR7UPKnsonbkLg8FWi6lgNUsJxNuUzwc7
         /WnyFK7QgbBlhOjrjDm1laU6K+lIaoNvisDCKUeLi6XPIy2mxdChvj2b9zFJkqOy8oUr
         T7DS5sH+Vi7V6K1t8YJjVhhnA/nn7Fw6fKp9oemRKmBbxgX7IkuLexdToPf8zRaooPbf
         eDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mwm/K69egRq1SanlOLInVAwrbURpDfe7CtVqhOl1rEg=;
        b=I6YTwG4wwkgRPmr1QpOdttHQ3BVDtkrmoL0XU83FLBhzBlRSx0HMxFmSrjW5tUTEGF
         CE7ZC3riIGS6RrYwOuaJ67dp747yhMpluXHSpcgcQI6QS3Om3QYVS20jHWOuNdmSfXxd
         WxYCdVdExXVyQ+fwCTlVtYTvnurCAirTny+KjXxiFCRJyfR1bdW3KffUPnIa2YVRGHKs
         3McqhyIl8I0gTJcvEZ4zy6AUEqmyqgTx+EsmrNNZiQoPyjRvjnj5KIeuoMiRGbEVVEOz
         sjMkSO/lAeo0++CHVuEEpnPeBuqhhVlXttZJLnz/oJ7LpJsw/5IwMDyIUWIZxRN0PwMy
         YMhg==
X-Gm-Message-State: AJcUukcyUNkWP6XrCbWWxd95MZGaY/qOkKawuzP+eFFTwjXv5fVGKjTj
        9dTbvCUQM8SAqlRub7Ojr7x87PweHdkyzw==
X-Google-Smtp-Source: AFSGD/VttJGtWFI5421lnZQkIrHWtI5lypT3KQIypGw/9FFB1NEHs7+SDQoHILaUaj6en2UhKLtZ5w==
X-Received: by 2002:aca:da02:: with SMTP id r2mr19528717oig.66.1546096923036;
        Sat, 29 Dec 2018 07:22:03 -0800 (PST)
Received: from [172.16.42.23] (24-32-25-180.com.dyn.suddenlink.net. [24.32.25.180])
        by smtp.gmail.com with ESMTPSA id x9sm19368896otq.73.2018.12.29.07.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 07:22:01 -0800 (PST)
Subject: Re: [PATCH] gdrom: fix a memory leak bug
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Maurizio Lombardi <mlombard@redhat.com>,
        zhong jiang <zhongjiang@huawei.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1545876914-11283-1-git-send-email-wang6495@umn.edu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f0ef28cb-7f4e-e346-7b88-aaf85ae0b5f5@kernel.dk>
Date:   Sat, 29 Dec 2018 08:21:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545876914-11283-1-git-send-email-wang6495@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/18 7:15 PM, Wenwen Wang wrote:
> In probe_gdrom(), the buffer pointed by 'gd.cd_info' is allocated through
> kzalloc() and is used to hold the information of the gdrom device. To
> register and unregister the device, the pointer 'gd.cd_info' is passed to
> the functions register_cdrom() and unregister_cdrom(), respectively.
> However, this buffer is not freed after it is used, which can cause a
> memory leak bug.
> 
> This patch simply frees the buffer 'gd.cd_info' in exit_gdrom() to fix the
> above issue.

Applied, thanks.

-- 
Jens Axboe

