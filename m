Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDF5C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 12:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C74F21775
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 12:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQFGW3C9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C74F21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754107AbeGGMih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 08:38:37 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41304 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeGGMif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 08:38:35 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so4049188ply.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 05:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qZxRylQae11YeVpp0gIYNgza0FwB/lSPVwmU3koL+iM=;
        b=HQFGW3C9Ybo8gbwXtLxai3rrTnc3SzVa1LFds9XOYmrWSpaCd+NvuowXhbVZs3c0Dd
         p1thbAnNU/1F4tePzNiSlc4uj9+eiPsr5MCUkmAWsjZZUIBcuTbfu+wBgPC9YbtiGarl
         +BYalEsPp5C0puNah322GMzxyXEtLYSUzfJ+c+iuPbYsxPS2V/NtBtuIuzZYdikarsE1
         wOfPSeJHZJ26Ae/OT7JqRPpPwnatY/X79QnIThcf6UePerd+TuaxHzedgoXZrXC6BtFy
         lbK7OqL9rTCqxtLzjfPGGfnQJJq4K0MLWTLLJVenmrnSc4snZ3c0HsdopPQUJcYeNoWk
         B59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qZxRylQae11YeVpp0gIYNgza0FwB/lSPVwmU3koL+iM=;
        b=AcoXt0dVNlpfBPHn32RT41m6lokmHjCC40ajgV8iUz5E0dm0TRA9hm+HaNUsLK1Tat
         N3Lsy6W8/DhDjKIX4TpAaN49XPj9vjL7bzHmxJDVD2oovdMFG00Kc6wdpxA909aXV3JM
         TeysbMcotqtXhaGI7N5kfXJuuCBU8p4jpycGuPLRwsYLvKzUVZEiZNWqvggJo+7orxvb
         hsigtNSVOrymGFCfXBUNrLmHbNTwoBpUh6hPcCIoYOAZN1tPBz/RYSINErkEiDLKJ13G
         YnUhsOLiJiJhQZZIAj5KvfDrPfCp2byMSjSkBV4cZLEGe44xetVAJjqZbowbETopzwbu
         iKzw==
X-Gm-Message-State: APt69E0enyybElVngfW25NQTpL1mAba2zblJWGNO9ftkh47fqn2TiusX
        4cdElppt9sX7RE71/rs+ECU=
X-Google-Smtp-Source: AAOMgpcMUOy4VchULpVfpVPqtZr8+BLWIpYQuJHRe6KaTEfIM9jXua6AkaayT6l35WAeiGMn7T++sw==
X-Received: by 2002:a17:902:342:: with SMTP id 60-v6mr13719880pld.311.1530965390233;
        Sat, 07 Jul 2018 05:09:50 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.250.201? ([2402:f000:1:1501:200:5efe:a66f:fac9])
        by smtp.gmail.com with ESMTPSA id n25-v6sm16621850pff.119.2018.07.07.05.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 05:09:49 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: Add warnings for use of mdelay()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>, Joe Perches <joe@perches.com>,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        apw@canonical.com, Dan Carpenter <error27@gmail.com>,
        linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Israel Schlesinger <israels@codeaurora.org>,
        Stepan Moskovchenko <stepanm@codeaurora.org>
References: <1530728333-31590-1-git-send-email-pheragu@codeaurora.org>
 <173cc189627e0d6618b535fcd1ce6a4c90ce2ad0.camel@perches.com>
 <20180705081953.pmvpmtzm273eb6yk@mwanda>
 <alpine.DEB.2.20.1807060747280.3506@hadrien>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <8149bc56-7523-9c25-67fd-c92480917039@gmail.com>
Date:   Sat, 7 Jul 2018 20:09:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1807060747280.3506@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/6 13:49, Julia Lawall wrote:
>
> On Thu, 5 Jul 2018, Dan Carpenter wrote:
>
>> Neither Smatch nor Coccinelle do a good job tracking when you're in
>> atomic context.  I've wanted to add this to Smatch but even then it
>> would be to warn that "We're holding a spinlock so we can't sleep".
>> It's trickier to say for sure when you're not holding a lock...
> Jia-Ju Bai is working on this.  The tool is available on github.  It's
> still being improved, though, so perhaps it's not yet ready for eg 0-day
> inclusion.  He can give more details.

Thanks for Julia's recommendation :)

I am doing the similar work with Julia, from the beginning of this year.
We develop two new LLVM-based tools to find two problems in the Linux 
kernel:
(1) Sleeping in atomic context. The tool is named DSAC.
(2) Using non-sleep function calls in non-atomic context. The tool is 
named DCNS.

We handle two common examples of atomic context:
(1) Holding a spinlock.
(2) In an interrupt handler.

DSAC and DCNS can basically work now, and some of the defects found by 
them have been confirmed and fixed in the Linux kernel.
But these tools are still being improved.

In fact, I encounter a hard problem when writing the tools, namely how 
to accurately and completely handle function pointer calls.
I have handled the function pointer in form of data structure field, but 
I do not find a good way to handle the function pointer that is used as 
a function argument.
Can someone give me good advice?

We also have made slides introducing DSAC and DCNS tools.
If you are interested in our work, I can send you the slides :)


Best wishes,
Jia-Ju Bai
