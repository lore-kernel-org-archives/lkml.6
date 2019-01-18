Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B141C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DED72086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDEhlsb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfAROUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:20:45 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35025 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfAROUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:20:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so6689530pfi.2;
        Fri, 18 Jan 2019 06:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m3JSc6RrjJ1uHXAaN23Q8gzSjIqIxEi378aoJMYIEqo=;
        b=dDEhlsb/p4kl97t4/9G2i30QdDCl23tgEPUhXz7xIKFjSS/J++QckC8cQT3oUlKYFG
         V74cbu+epuSeDBJN4BtiNbPnHOIZfqClS5C8kOw5UcGOz5zWSopNkH0QcTDjCidOEuZZ
         tzifwX6JE0eQJxJfCZjsA8i+hjVsFDJGywYSmD3bGe4JOxRMwxdz5ql1IucBYb0TGLQj
         sc2D1n0Z0OXKbkTMKXcDbx5V72dMhSi6qxwKWXCAeTq7eqDTaRQh/sLGWE8UHDqK9HJz
         YcIgfSKSBxEXd12CD6TH8eyE9fsB5KbOv2WCoaa0dzsDFr7lcOXwUjrhzvhihQwL/Sut
         Qfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=m3JSc6RrjJ1uHXAaN23Q8gzSjIqIxEi378aoJMYIEqo=;
        b=R5byb4F03dG31gEnpyXZ4oXwsEtg7gC/EA2I23Na+NBk+a6Zhv7kIppdktrvXqwkQg
         BKLmvGGDeuXfILmE0gzYnPtaVDnC+ucpWgZEFLUXh7bLECKvfCb2ZP2IsUwcibgyxScY
         fP//w9nmktPSb9EcrWgYb643UMs6u1nAoqeDarj+70RSBykqUrM52cK6VLLUUDrFGTH2
         J1OlHn+lF7D2jgS9vAzYbIIxgoDow+xjmM8EfIe1FnVPF0Rj7GihubsqQhWsVA2Hk0B4
         uFlwiVusJlT4vC//lKwmvrXY7H8/dpVLBAO2dUpGecszMM/kvuj1kH6ngaQEj2HeunyX
         vjuw==
X-Gm-Message-State: AJcUukfooXZynJ0xslqCmxYJ0o25mTz9kR3Gc7+DAkjxuLAZW/POHIoL
        JkM50lAv0TGpBVEEgRM3A+8=
X-Google-Smtp-Source: ALg8bN48UJ4pBK+m8DxsEwA3XxPD4vXDkQhBgF/0NSrO1y4OebFJ0s3U7+uQitaPfhYyvEXtIf80+Q==
X-Received: by 2002:a62:6ec8:: with SMTP id j191mr19552669pfc.198.1547821243544;
        Fri, 18 Jan 2019 06:20:43 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m9sm8709240pgd.32.2019.01.18.06.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:20:42 -0800 (PST)
Date:   Fri, 18 Jan 2019 06:20:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] hwmon: adm1029: Fix most style problem
Message-ID: <20190118142040.GA16507@roeck-us.net>
References: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 03:03:22PM +0100, Corentin Labbe wrote:
> Hello
> 
> Thirteen years later, coding style have change a bit.
> This patch series fixes the gap.
> 
> This patch serie was tested on my precious so rare real hardware.
> 
Series applied to hwmon-next.

Thanks,
Guenter

> Regards
> 
> Corentin Labbe (7):
>   hwmon: adm1029: Remove write to FFF paragraph
>   hwmon: adm1029: Add SPDX header
>   hwmon: adm1029: replace S_IXXX macros by their numeric values
>   hwmon: adm1029: Add blank line after declarations
>   hwmon: adm1029: Fix Logical continuations should be on the previous
>     line checkpatch warning
>   hwmon: adm1029: Fix function alignment
>   hwmon: adm1029: Add a comment for locking mutex
> 
>  drivers/hwmon/adm1029.c | 67 +++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 36 deletions(-)
> 
> -- 
> 2.19.2
> 
