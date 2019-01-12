Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C50C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A932084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="CSLV4Xa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfALVfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:35:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38785 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfALVfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 16:35:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so8356619plb.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 13:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tkQYo6uZkGOWLy7pkU5/K/+5sEyO9Ddm3yZMv66QBjw=;
        b=CSLV4Xa+XxRR2wHRIFVesX7cSIVV7PNXddDNWDSmyIoDdrWgF04rYUAkmUqKT0KCFr
         I4b+GaekdYqVUGYBvDKy6kmg2Vi+5G6V5nEJkJk3YrYtproSMYO1KSh/gsB/dzTAef/Y
         Zf6FcjbO4zeOcFSmOIzxc5KPRIn3yXop5ebM4s8XlmEzWdDctuS/PA5V6mYF45gWPAYv
         OUocWidKAzxyHgVUw4wS1eUh7wAnoK7Mhuqa5+/obyTwNElMC00so11plTUsSrV9jZht
         4ysqVPqB/YziLwsq682m2DTSdeKLp7eXiSEBN4c/Z5S31JXFZTRFHzXvX/Y84nevFLRv
         ARTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tkQYo6uZkGOWLy7pkU5/K/+5sEyO9Ddm3yZMv66QBjw=;
        b=O67F0sJKRSVsBUyO4cSk7cNMNWCI4P/eRDwyW1x47q49tizYCVIKYaBYuQWZdDf6WK
         H39/k/CV4lSMDORsL3sBWRl8i6jBAtxXdyUPi0HMhPcx5BmjftHpJ+x2ydAveMF2D4l9
         8hnfn533AyTS6savvDlY/B0Opyp/Hp9oOaXJ0oERS5NC1EC/XPSG0gYRzPz2wMKfYGPu
         vBVQWnsqzN7lpWoB7+MWUgc4fw5sml+ywrqDBDJC9PdIQ13iU32tN0lGYzWSedd1ejmy
         CKDjfQ+oggcRZ/ulNPoPTgH2vujV0uwb1tBqvxMA5LeW7mpGwvlnUYFfMmbSJUPRdBeA
         3qEw==
X-Gm-Message-State: AJcUukeRuqmdnd5HrsAI2+G3AR3okkdVqus0cjcaNrGFRokvU3w+08CM
        M0DN8VyChOjQbFB4Ly2053f7fw==
X-Google-Smtp-Source: ALg8bN4MtnAj2BQB5yphCIL8YHc6NDZgRFzRBLHzhm/Evr8HguKYW2l4t8qZFTiL+vQp0fHc3AQegA==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr19286795ply.143.1547328937523;
        Sat, 12 Jan 2019 13:35:37 -0800 (PST)
Received: from [192.168.0.8] (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id a18sm107871006pgj.30.2019.01.12.13.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 13:35:36 -0800 (PST)
Subject: Re: [PATCH 4.14 058/105] tools: fix cross-compile var clobbering
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Pali Rohar <pali.rohar@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ignat Korchagin <ignat@cloudflare.com>
References: <20190111131102.899065735@linuxfoundation.org>
 <20190111131107.880515108@linuxfoundation.org>
 <CADVatmMALKGQc3M3vyuHekDiR6zNhFzCiJCLrg00_9N0nDSChg@mail.gmail.com>
From:   Martin Kelly <martin@martingkelly.com>
Message-ID: <76359b4d-94e1-f88b-7ca6-e99555c2910a@martingkelly.com>
Date:   Sat, 12 Jan 2019 13:35:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CADVatmMALKGQc3M3vyuHekDiR6zNhFzCiJCLrg00_9N0nDSChg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/19 1:18 PM, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Fri, Jan 11, 2019 at 2:34 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> 4.14-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Martin Kelly <martin@martingkelly.com>
>>
>> commit 7ed1c1901fe52e6c5828deb155920b44b0adabb1 upstream.
> 
> This was fixed upstream by 755396163148 ("tools: power/acpi, revert to
> LD = gcc")
> 
> 

Yes, both patches should be applied. This patch fixed a bunch of 
Makefiles but caused a regression in power/acpi, which is fixed by
755396163148.
