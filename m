Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67227C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368C020870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfHD9qfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfBAEKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 23:10:54 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40620 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfBAEKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 23:10:54 -0500
Received: by mail-yw1-f66.google.com with SMTP id g194so2325915ywe.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 20:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7cAZcqrjPXXFh+0czRZgkohiQNUN7HEiDF7AJe9qNZA=;
        b=YfHD9qfkkZyQgeGZ0lfW0D/B14nHqL3RKAFFWia8oE7qrzRDd+zYmmrllihej/e9HE
         760wyK8cL2kZ48dr9O5LoIorT5K8NQzuPHHr4KL86Kujy1UoQgPsRNPxR4hVSETT5aHb
         riXtOl14ixHxUr2KQ7e4/PwLOPVJTk2E6Gz3fvxtgmq41AKz2RKqfvAsa+23+IpuDuQR
         r83qshMTuU1mSBm7fE2YbSOXjLDFMObtEfpP5SoSYx/Sxy/s9mXnM+1ZwiGSRowQyWGK
         BXVcyvcB+nMfYje3/fRKfEvdr7Bgm4XM/w/2TRoOq1SZnAR1RoHDs6gxe6x8YO5gkR3J
         3M3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7cAZcqrjPXXFh+0czRZgkohiQNUN7HEiDF7AJe9qNZA=;
        b=fjDrWCLB+HwdBK/x5uVFYaAH7BDzVuEf6uYv5lMJ1gKa2NxEy17Iiopk+umCHRxqwv
         lEjEdjHuGHeYoT+ULTL7b+kbPYSKchoGkTKVo5VqJ2TqiTulo92Wapgg2iYQWsQFztNO
         YaOnNkHZuGYl9xBpi8OUASjKMHsIvbdQ6CFbWsSFaIrnBkbB/vSccCOgiZtkpiB04pj3
         Wc/yID0DS8fyi2pH/nWX4ep86yvTInXo/yuQ2l9HR6G8uzgHYJf48vEEFLWjMYUx7Gt9
         3x9fTNqfvrEJ//ZcAk+bsEwpKx+1ThmmBHY7bVsrJiGbpAY3uJ3yUUbjst7K27X9VjZN
         M0WA==
X-Gm-Message-State: AJcUukfQfDJd147LEWLxw2SWkWtPzeuySEWIp1uKgUXZsUGz5+/OzJcv
        w2c3gDRyeK1UaLZgEviN4gReRtkw
X-Google-Smtp-Source: ALg8bN5s3/Xc8ZbeIaeY0wqq3iIvrJZU7HQgV9YMIWDdayBJkmVsVkvAvT73/l2P9+pMbIlLC4HBTA==
X-Received: by 2002:a81:bd6:: with SMTP id 205mr36362511ywl.304.1548994253305;
        Thu, 31 Jan 2019 20:10:53 -0800 (PST)
Received: from [10.10.115.198] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id i7sm2499034ywd.7.2019.01.31.20.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 20:10:52 -0800 (PST)
Subject: Re: [GIT PULL 2/3] bcm2835-dt-64-next-2019-01-29
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
 <1548788008-4733-2-git-send-email-stefan.wahren@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e9a43bc2-32cd-84d8-afbd-a9c8780d8f50@gmail.com>
Date:   Thu, 31 Jan 2019 20:10:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548788008-4733-2-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/19 10:53 AM, Stefan Wahren wrote:
> Hi Florian,
> 
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-dt-64-next-2019-01-29
> 
> for you to fetch changes up to 3688325a4acac981e95e25478d3703e3ab05d4c9:
> 
>   arm64: dts: broadcom: Add reference to RPi 3 A+ (2019-01-09 19:24:04 +0100)
> 
> ----------------------------------------------------------------
> This pull request brings in the arm64 reference for Raspberry Pi 3 A+.
> 
> ----------------------------------------------------------------

Merged into devicetree-arm64/next, thanks Stefan!
-- 
Florian
