Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EF2ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774812145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUxYF95M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774812145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbeIYAJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:09:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55562 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeIYAJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:09:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id 206-v6so2793080wmb.5;
        Mon, 24 Sep 2018 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zehZnPhco9VXzlut2NGFLvGXjhHe+Z/VA/YnkOyF56s=;
        b=YUxYF95MVN9FdGhjXczuHCpbZ6syCVFLtSyxN1y1e6Wjt2zX4ieBnOR5JVWT/Venbc
         9rMXHSyijxkAcGHEA7LixeU74CDIHQxj9cMGRStbEXIqGKcHCNAWoiCY1bzRgMSI+TTr
         2L9jAeadUE+wQXVxFbq92bFBwgnxnhMnrXUkt/OTqvy9JMzKJtGbPouMt+o5mmJEP/a6
         yTcduW1RFAOFtgxEB5z4ZiZ7OiQ8g42izmy5W+FFxxV7yMtlo59P+Y0WY7niv10xnvcm
         ErIUpyuePh6d8Y/KrLIEMZF9kTbbTTI1Tn8LpQpx7gclH093tN8G16c7i0lcCBrqCw9L
         Wk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zehZnPhco9VXzlut2NGFLvGXjhHe+Z/VA/YnkOyF56s=;
        b=BhQJD01hk2ghlSKVTB5MK/GeFBiWDHVxG4TOyHvHcj1vOYXfMlWBpDNly6xHHGpqQX
         JBNw/xsipYPpiVezvcaUG3gSQ5bnZEcJUSugXuO1zIMLO1sHYnZRD3Zr/j2CV7+A5oFe
         y0OKsFAj6KZ4+TMLA7VaXfSm6W3cIBubsVJemAgIo/JVNlnu+jk+vj2QUSArobxAKc4w
         JEmS5SsSxFGPuk0ZFFGydagFT+V59MVLgnPVPZfGkMhyhpY87PAZwosOZT5fWdqxpBh4
         11/0xK08Ma9PC1iu32b3rmRS6+AGWWxT0qmNQAfAXnR7/yrQc9oK5pUUEF14WzH4y3Qm
         s+ew==
X-Gm-Message-State: APzg51BZh1lB6fbM5taLvZbeZgy8h6tJFuuPEpTS/JhJGXfm8Tbv0yfy
        ORsW2F/K6lbeCe5O0dbcpfiu1Ym4eeE+SA==
X-Google-Smtp-Source: ACcGV63YbYhd69TDnLDg15y+sirw5KMfIJHyP1s60/qSaNEvIkVs8f3R9p/KwZkpSwAO2gT1HxwjUg==
X-Received: by 2002:a1c:1745:: with SMTP id 66-v6mr8253582wmx.38.1537812380417;
        Mon, 24 Sep 2018 11:06:20 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c19-v6sm39636210wre.86.2018.09.24.11.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 11:06:19 -0700 (PDT)
Date:   Mon, 24 Sep 2018 11:06:17 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/70] 4.4.158-stable review
Message-ID: <20180924180617.GA4232@flashbox>
References: <20180924113058.420454070@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924113058.420454070@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 01:51:59PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.158 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 26 11:30:25 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.158-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel 2 XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
