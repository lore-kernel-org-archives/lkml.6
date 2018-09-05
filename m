Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD795C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766BE20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="km/yPEPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766BE20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeIESJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:09:29 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35868 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIESJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:09:28 -0400
Received: by mail-it0-f66.google.com with SMTP id u13-v6so9486445iti.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=beehM+0Rh6OfeZ2Y47c3+eKqPiv1RKMXzjjGePj3hJg=;
        b=km/yPEPPrXhda+va5po8YzBBodQbGFUuvGGBz+biC6JQWq8SAg1/lVbFY0sUgc/Fq0
         ynVbbJxcvDmDNEL7KmCTQkasC9sDXHJR8+9d78xV0Jy6Bjs5as7N4F45MErYw8Q/Bl4X
         5xPMzhnCGj5n9KuJ2MUFNY931sxirQNWNubaPPlqPIc5Fn7vqPC6ODqNi8EqbA1FJFvx
         TMntOKK0F7x3Sp81Sd0SANfugPiVj8lSxvgoRwoHTOWlNlxR9ixzUaxZEZfkbvun7UKS
         ZcVAZFgByYGEmYWrynOIG/Q7mKvSZBzAj6WhgfaiDH4IIYnPCwvFFd0Wnm1h50HIr+Ct
         n9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=beehM+0Rh6OfeZ2Y47c3+eKqPiv1RKMXzjjGePj3hJg=;
        b=SkN+UtJ9FrjepN4YQBsKlBXraEJmBOK7vrNM89KAiYRmRUXtocU3vF1xDU44wEwrQ1
         dbPwt+t7sToE5jrng+vpH+RMYC8MCnWBAf1W4reXIPDis3U7pae5pF07gqEfW4xBGtf0
         R8DlfnA5210/8s7Z0Zv7GGhqHGLzf1nCC9HNJ03SdoeBq8ok1fVaM9T5Hgi3k9d9K7gy
         MlLeBAPFAJylpLpGtTjd1W2Ix9esC0I0ezc7Ah1ryiqEpY1Rf/wVHH7A+sQltBBIdiO9
         w1+KKw4E0rrPnrqjBz/tIaejaeP2NeL3bemldBxxfQf5PpbW3ZhKZY7gynr7kJmVMC8a
         1Xug==
X-Gm-Message-State: APzg51AC2l7dJkqeDVnghqvREPFQAo9wIvHqqvZh50ra2hoH4bUcGWrW
        +k5zFC51whOO4LYI3jwcYdWFqw==
X-Google-Smtp-Source: ANB0VdYA5b1AozOWbaNZssgGg07wER2taaOF8xcapHbG/4O3JdO0oyTeOQfORBaNWe1UJlc+M5t7uQ==
X-Received: by 2002:a02:4add:: with SMTP id s90-v6mr26366030jad.21.1536154750946;
        Wed, 05 Sep 2018 06:39:10 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id a11-v6sm561845ioc.63.2018.09.05.06.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 06:39:09 -0700 (PDT)
Subject: Re: [regression/bisected] 4.19 cycle boot time IO stalls
To:     Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1536137722.4813.66.camel@gmx.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <178d6adc-2a79-99dc-daa8-fb0ed9f0afd1@kernel.dk>
Date:   Wed, 5 Sep 2018 07:39:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1536137722.4813.66.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/18 2:55 AM, Mike Galbraith wrote:
> Greetings,
> 
> I've been seeing $subject, decided to take the time to try to bisect
> the little bugger.  The hangs are not 100% repeatable, and while
> bisection with a 5 boot go/nogo threshold seemed to go smoothly, it
> ended up fingering a merge commit (sigh).
> 
> Box has an SSD (unused only by windows 10 box came with) and 3 spinning
> rust buckets that I normally use with BFQ via a udev rule, but CFQ does
> the same, so scheduler is seemingly irrelevant.  However, in 7 crash
> dumps, all of which look about like the data below the bisect log,
> there is something relevant, namely the hung 'tlp' task (powersaving
> script of some sort for laptops according to the package description). 
> That knob twiddling script is present/hung in all, making me a tad
> suspicious, and indeed, testing with the final (bad) kernel, all I have
> to do to eliminate hangs is to remove the 'tlp' package.  Verified via
> remove, 5 boots work fine, reinstall, 2 of 5 hang, remove again, 10 of
> 10 work fine, reinstall, 2 in a row hang.
> 
> Seems pretty certain that tlp script is what inspires bug to raise its
> ugly head.  WRT bisection result itself, munged merge seems far less
> likely than a false negative having knocked bisection off course.
> 
> 72f02ba66bd83b54054da20eae550123de84da6f is the first bad commit

I bet it's the host busy change from Ming, which I already
reported as being the culprit for another test failure I had. For
some reason it's not merged yet, nudge nudge Martin. You can test
by reverting:

commit 328728630d9f2bf14b82ca30b5e47489beefe361
Author: Ming Lei <ming.lei@redhat.com>
Date:   Sun Jun 24 22:03:27 2018 +0800

    scsi: core: avoid host-wide host_busy counter for scsi_mq

which was slightly modified by 265d59aacbce, so you'll want to
yank that one first.

BTW, that suse email for me hasn't worked in 12 years :-)

-- 
Jens Axboe

