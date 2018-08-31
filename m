Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4C9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B0C20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="O5iFImWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B0C20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeHaSEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:04:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45771 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeHaSEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:04:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id u83-v6so10124058lje.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iSBeLUGP3rflqP/qVxJH8YSSr9RaWxkMjuuRLodonD0=;
        b=O5iFImWF1tuPG+p28/4jz7xuJ1qkeDINe2xy1IYIMlGKGlzgmA4GQRb2MIwZTa0IUT
         l3PlsBzi4+AAtMdmdaXsljKCJdPWCQlquy5JCyyUapo/3dVPcuqpAUK9YqgViEf04LRR
         2QOgbYf+XisOlHDmIN2DAkNqdWgcY+wThhJz3ck1Hdz51qtamy8VhgxlK4awUGnD3Py0
         IuRq7moIuSSxQE4WOqBKmuafSQXBGYmWsb/7IJxhS65+YD5JSjm5VSeQlN47xbC0uxco
         hU4FmZX3h6+LBblwrOK4J5CuDT6gdurgX37NPWYs99rKWP+RIay9wsqOs8A9WFDHlXnT
         9HAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iSBeLUGP3rflqP/qVxJH8YSSr9RaWxkMjuuRLodonD0=;
        b=Veis7W6pLXgNTgMBgQSDBtVsIFi5sbBo23yqk2GAcPvdajOlCq8GbyjvqimL6D8Pk4
         VmPOZ9zRKIDHGQYAhR03qTpHX/44rsJHTvJzpI1d9/EY3IgR31C2j/MyQkbg4xPsRjJz
         yPe1xu24icoD4994JrduCa7sANBS4ilJbLw9+e9I9EjyakNoCt9hi3hLrjpepfSNhQaf
         B+A478/xjdv2IYEc3GvLEKo8ddXnR1z6clB5MxmbSq5VNCljvHKVm/PMk4ijIwKdMad5
         BJmhlRy/3Gx0PaYCu661ICX/lQ/9wb9WRE2f5E8KPmsoNxqGGP0Yy3bWpROLUW9I6VXL
         /V3g==
X-Gm-Message-State: APzg51DXteaeFK2XsxzN5HTPmzJBlVZzjWWWZmYQojbshqUpME+zVKAk
        ssX1qzQcfsnOVjegr8EzZaqo0w==
X-Google-Smtp-Source: ANB0VdaWAXKDkT/unplxvaTmn11n7awsGs1b2YsIZepYOyNPldtsuy3Ae8ZmoaPsWCBbYFI/XGxxHA==
X-Received: by 2002:a2e:3313:: with SMTP id d19-v6mr10117596ljc.25.1535723825509;
        Fri, 31 Aug 2018 06:57:05 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id z10-v6sm1720780ljh.57.2018.08.31.06.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 06:57:04 -0700 (PDT)
Subject: Re: [PATCH 0/4] lightnvm: pblk: add support for chunk metadata on
 erase
To:     javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <71f5f8b3-66d5-a0e0-85ab-cb22e5ac621c@lightnvm.io>
Date:   Fri, 31 Aug 2018 15:57:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 03:34 PM, Javier González wrote:
> Matias,
> 
> This patchset implements support for retrieving chunk metadata when
> submitting a reset/erase command. Patches 0 and 1 are small fixes that
> can be directly merged into your patch:
>    
>    lightnvm: move bad block and chunk state logic to core
> 
> Also, note that these do not apply on top of your for-4.20/core due them
> depending on patches that I sent before that you have not picked up yet.
> You can see them though in for-4.20/pblk. I'll rebase as patches in the
> list appear in your tree.

Thanks. It is really confusing when you guys maintains an implicit order 
and posts the patches separately. I will appreciate that patches that 
are related are posted together, such that I don't have to manually 
track what comes before another. That makes it less of a pain for me to 
keep track of and we can keep the reviews together.

This is the patches that I have in the pipeline (from before the e-mails 
from today):

   - This serie - Pending review
   - Serie: pblk: support variable OOB size - Waiting on review from Igor
   - lightnvm: pblk: recover open lines on 2.0 devices. Which doesn't 
apply due to the fixes to the pad distance patch.

> 
> Thanks,
> Javier
> 
> Javier González (4):
>    lightnvm: use right address format on 1.2 path
>    lightnvm: assign block address before slba
>    lightnvm: pblk: add helper for printing chunk state
>    lightnvm: pblk: retrieve chunk metadata on erase
> 
>   drivers/lightnvm/core.c      | 51 +++++++++++++++++++++++++++++++++++++++-----
>   drivers/lightnvm/pblk-core.c | 47 ++++++++++++++++++++++++++++++----------
>   drivers/lightnvm/pblk.h      |  9 ++++++++
>   3 files changed, 91 insertions(+), 16 deletions(-)
> 

