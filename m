Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03653C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD5220848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vRY7eUMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD5220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbeJYW6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:58:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39790 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbeJYW6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:58:47 -0400
Received: by mail-io1-f68.google.com with SMTP id n11-v6so3523847iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Xz57JowwKP5/9Q063fKUQr/6bFYDR7xJKl6daRN8EE=;
        b=vRY7eUMQSrLhhw1dhi/zyaV8IsCjtzMKeZEDJQcINowe+gZ9hXpJlsueWVyYkUmvuA
         GIvmYXGwP98hrhQLyp+oYvPb24elUIQrxwbZqeIC/XK8OXgEPyuW7BY/R+NbvZ0Hqv4P
         C74f+iKPA3iavhbZr+jtp0inEq7vlMBVMF0j1RnnJdC9Qt4aFnDunOsquGaMaZ5v0QEF
         HReqbSpLT0gLLUy6vZqRf5IgpiHT2p7ipiVi4uKjxGi0s0ofFvGk2K2O574xCAwzX1lu
         5pnigrJ3ax+OVvqps1fugY2Ooho2x7/oLSMdHnynxaSa59tCOuwOWE9H1AyPHtr7yNKB
         kTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Xz57JowwKP5/9Q063fKUQr/6bFYDR7xJKl6daRN8EE=;
        b=oOzf3hISaBvhqglhCluJTXaDMa9igO0DmslI02wnMECgXcuLVeRPqCfkbrpzJfrT1U
         MpDulkRorWzVLGwHrRMuUIJy0GTUd7/+RbitJX++fgtlQm8eD8bLJDa2Aw6StsZhmYNE
         ntAX69+wD3YwVoEF6UB0RiOXHQfQHDYAFPWnj7sb5BNwvqPNBpIK9tRMZ6gJh27Fz9mh
         bYnpystKfwxjiXrO4Cii8JAcAdljXNRxyeiSFCLB/J42byC4gM913GyQ65VQkB5oXIe/
         n93JmKpF7P31klmCK+2+RbVO8OOUubBd/F9EiENwqHA9pzFtfC4UxO2wlEmo2kO1sriZ
         kGIQ==
X-Gm-Message-State: AGRZ1gI2+erMhgBX1Ys7M5XVrd/ccv6JQ24kBNODLutYMeLW6KXf/gUz
        JilQHL3AerYh3hl/AEf8FOOJ2Q==
X-Google-Smtp-Source: AJdET5eOYTTiPbx+AapVjssm2UjP/+ecaMNIiR8SEJIyRpyJsKNb9XUwkaFss+ia49qGlmuOIpeFkg==
X-Received: by 2002:a6b:928a:: with SMTP id u132-v6mr965063iod.97.1540477547037;
        Thu, 25 Oct 2018 07:25:47 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f20-v6sm765084itc.13.2018.10.25.07.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 07:25:45 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix typo in RWH_WRITE_LIFE_NOT_SET constant name
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20181006175114.GA10435@asgard.redhat.com>
 <20181025141927.GB19512@asgard.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8acaf8d7-17c9-e8ec-c60a-18a011b4c34f@kernel.dk>
Date:   Thu, 25 Oct 2018 08:25:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025141927.GB19512@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 8:19 AM, Eugene Syromiatnikov wrote:
> On Sat, Oct 06, 2018 at 07:51:14PM +0200, Eugene Syromiatnikov wrote:
>> Hello.
>>
>> This is a small fix of a typo (or, more specifically, some remnant of
>> the old patch version spelling) in RWH_WRITE_LIFE_NOT_SET constant,
>> which is named as RWF_WRITE_LIFE_NOT_SET currently.  Since the name
>> with "H" is used in man page and everywhere else, it's probably worth
>> to make the name used in the fcntl.h UAPI header in line with it.
>> Second follow-up patch updates (the sole) usage site of this constant
>> in kernel to use the new spelling.
>>
>> The old name is retained as it is part of UAPI now.
> 
> Hello, are there issues with the patches?

I only got the 0/2 patch, none of the two others..

-- 
Jens Axboe

