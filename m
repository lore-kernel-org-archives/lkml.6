Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76030C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2770821582
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tQX00zST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2770821582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbeHBXYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:24:53 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46712 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeHBXYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:24:53 -0400
Received: by mail-pl0-f67.google.com with SMTP id t17-v6so1582182ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 14:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+oy7xt4EOZxLna0GRNMFqVzAPZjfYwD9K7nS7F5dpqk=;
        b=tQX00zSTzD48AX8CXKkiFdulNAa0YbcxDhXBABV8e9jzhiOLm3TrSnpuUsC39bz2Ue
         jK2K0s8hLi25AIN6i8ii5J0Lnk88mRSvQkdpWJns9wAUfPRJLjFrP9w3zkJs/Gu3pPYf
         2+8ohmVQZXKgEKXv/hH04QpQitxq7wXdnLqAQchxeT0WLFBBaUNDP/htnB8X4zX62vMH
         FH+MA15lWq+50acBsn17glnqecdSzd7SJdbFE4VxQPz+KqLqJ+MKizNCNZDQn0o9etmD
         0YJUwl92BMdEuaALBIx5zieqYY+dFJCrkxlb50nEh4jI73H3UMfNaXFit3GkJXDSMcm+
         +9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+oy7xt4EOZxLna0GRNMFqVzAPZjfYwD9K7nS7F5dpqk=;
        b=Rc1B8rAQRc+zJp14CrF+W+Mg/zmItZtMJ8/mXuZMg1fIBBFKC6fppgc7Vv10ihOdSG
         onUQXlG0iKzDvJo5lYYPLr40tXTMYe2FchqLF6eEYqh6sGRD0caNkxd8HNkxG6wwEHdO
         ID2jbbRc+LT9VW9sopP8GlTG6GZZJdp1F6oUy/FXJ/p4Cn5OvXbtvG+fDBbSZS7W8VuI
         4kScZjnCGfMTP4k/Db3FUFtSnGoVg7IbjL2ZPbRmcW2Kde/HrHg1cGpkqEKohQqUTC5A
         fqWTwnM6Kbj2pyGfLtR9PdPHYtOK3shGHphSaD951EenpdY2yZMBlbOXly0jX+zITK6R
         U79A==
X-Gm-Message-State: AOUpUlE/wxRdY8knH2wkvhXaFHUNAyBbJHw684h4xT0oYAKudB/O2iQB
        RkPlOrzBc6lV1/4I9w7Xi2uiB2aOyOY=
X-Google-Smtp-Source: AAOMgpcavrb9eZ4IoiOiGn4nR1dwU8awLoFNpc/RnjCVIAF/uKIqYgtf9LaDAAf0YCXwKkIN2DP0tQ==
X-Received: by 2002:a17:902:8481:: with SMTP id c1-v6mr966817plo.177.1533245514619;
        Thu, 02 Aug 2018 14:31:54 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id k64-v6sm6065219pfc.160.2018.08.02.14.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 14:31:53 -0700 (PDT)
Subject: Re: [PATCH] block/compat_ioctl: fix range check in BLKGETSIZE
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180406222350.174104-1-khazhy@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e40fc93d-ddb1-23a5-725c-e8ab613168cb@kernel.dk>
Date:   Thu, 2 Aug 2018 15:31:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180406222350.174104-1-khazhy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/18 4:23 PM, Khazhismel Kumykov wrote:
> kernel ulong and compat_ulong_t may not be same width. Use type directly
> to eliminate mismatches.
> 
> This would result in truncation rather than EFBIG for 32bit mode for
> large disks.

Sorry for not getting to this. Applied, thanks.

-- 
Jens Axboe

