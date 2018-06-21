Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE80C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1862120875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzpB8S//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1862120875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754460AbeFUDvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:51:25 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43934 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754240AbeFUDvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:51:23 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so809406pfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 20:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eZZo8XnwiwOggc+MhbarNhZq08M9HzBUjT+22K9F8nk=;
        b=XzpB8S//QxNeOiVILu+GIDoOQJibYFz2jlV916nueSCSLqznxl92Dii0PSwgyvMr0Z
         xhfA7AlGxGMGZHrMK4EPNJasf5fdJ5NSlPbub/l3k5tpq0pq4ICjZ+VAXWKEdej0dyuf
         2X9gmak9HSIJ8nbIZxNPmMiifUSCMXYxrIyFaEnljl+iVw2DPue6765CsbGsM0bt+ap8
         TQi72rEZbqfqIkiVOy82rVEolC1hCHkaoU3wil1gUALC2JY+P0UDiUBV6y+TpPICtLk9
         4JSDSzDnz3t0H0eujaoGOIXGjlxXpBPt8lHcLzhC5NkZlTaykZT1FSgbHRWhgB+ucJQ2
         lijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eZZo8XnwiwOggc+MhbarNhZq08M9HzBUjT+22K9F8nk=;
        b=V10k5ZG1lyfMUytUo19xsjZ2Wgs3VJ43fK9guejhFrweQKThaS8Sc2kXHmdVIabQb4
         isruqJ8jKQsTExC9XD2c5NKpZnrZS1/GjVKMIyI0/Y00he97hP9TJBFLDWXp1oJgDNLo
         mdxW68D5bu/WKWwi6648z16AWT6EmvZnf847aCeL9/f0mfAqk0BctgDStGfnOEJUnDkL
         4v2jjxsY2liKbgT7R9SP5Uh3f4RBw7sLTGSH9M3s8hQuDax69qIGCjrRIHVBvoBfy001
         f48av7Aidll29BTGul6+O4OCmNtpi892AmdQcuiF2TtIS5wRRHlswzmsH0aHrl5bKtIz
         iOYg==
X-Gm-Message-State: APt69E2HZgUdXsB4v6K+arlxYs46zUr5qW5NFtWgN4JGL18pas07T1Ut
        C+oxDPI/MxMz6YKZ4gJcvZnsGHC0
X-Google-Smtp-Source: ADUXVKK1w36C7zdFSDRKmaKYKwpj+41FoKSKl7dtdorUUu6apWGZ4Dbh0HBWUt+dOXZ8sbfLuFh7fg==
X-Received: by 2002:a63:7f1b:: with SMTP id a27-v6mr21480231pgd.410.1529553083395;
        Wed, 20 Jun 2018 20:51:23 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.70.11? ([2402:f000:1:1501:200:5efe:a66f:460b])
        by smtp.gmail.com with ESMTPSA id x19-v6sm7004624pfi.5.2018.06.20.20.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 20:51:22 -0700 (PDT)
Subject: Re: [BUG] kernel: kcov: a possible sleep-in-atomic-context bug in
 kcov_ioctl()
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     akpm@linux-foundation.org, dvyukov@google.com,
        Greg KH <gregkh@linuxfoundation.org>, tchibo@google.com,
        aryabinin@virtuozzo.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ca2e4f0b-dd08-8d66-51e3-05cc69e15d65@gmail.com>
 <20180621034335.GT30522@ZenIV.linux.org.uk>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <3dc2431d-e474-a3b6-c6c9-9f7079a9cb9b@gmail.com>
Date:   Thu, 21 Jun 2018 11:50:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180621034335.GT30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/6/21 11:43, Al Viro wrote:
> On Thu, Jun 21, 2018 at 11:20:59AM +0800, Jia-Ju Bai wrote:
>> The kernel may sleep with holding a spinlock.
>> The function call path (from bottom to top) in Linux-4.16.7 is:
>>
>> [FUNC] vfree --> can sleep
>> kernel/kcov.c, 237: vfree in kcov_put
>> kernel/kcov.c, 396: kcov_put in kcov_ioctl_locked
>> kernel/kcov.c, 410: kcov_ioctl_locked in kcov_ioctl
>> kernel/kcov.c, 409: spin_lock in kcov_ioctl
>>
>> This bug is found by my static analysis tool (DSAC-2) and checked by my
>> code review.
>>
>> I do not know how to correctly fix this bug, so I just report them.
> Assuming it's a bug in the first place, that is.  Note that
> 	* we never modify task->kcov for task != current
> 	* task->kcov contributes to refcount
> 	* opened file contributes to refcount
> 	* that kcov_put() of yours happens from ->ioctl() and removes
> current->kcov reference; it *can't* be the last reference - the one
> held by struct file used to call ->ioctl() is also there.
>
> IOW, it's a false positive.

Okay, thanks for your reply and explanation.
I agree that my report is false.


Best wishes,
Jia-Ju Bai
