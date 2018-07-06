Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC11C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24A722BD2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWmxHIhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24A722BD2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934524AbeGFUuY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:50:24 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38155 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbeGFUuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:50:20 -0400
Received: by mail-pl0-f67.google.com with SMTP id b1-v6so3363852pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 13:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0hK463Syvi116bLE+c6qWeGCts0HFAcJb08CcJ615oc=;
        b=FWmxHIhV3YDTprqrPAkRSVRxypR9Yabya2bpgkiBAlBAPbtiKPMBYmy0ufk0XNkX7z
         E3+bNaTtBIhEWYTL66JZ00f/DULkUdz3Oxgv5db044DBp/dy7nQanqqX0NHPm2RAlj/P
         7d6rH79M4Yp5lWt0LLDvbQRKPkNGSthmBB30cMxdyi0DPVcI5L1jNRQtmlgloQVllGHT
         k//swYOolkx344o6ObbhkoTlogQQCtuIDivIadvLeJS1/gl66w+v4rdu7l2f83/zUhC9
         CUY2a9CaaxBp/fp81LgQrv4krCIeLjcBtlGgtaUeT9QGJRKn56ZCLOKYIK/8W1CO6KKO
         5kOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=0hK463Syvi116bLE+c6qWeGCts0HFAcJb08CcJ615oc=;
        b=lew6lbLDPmb4qbRDmBEYnlRbu83+J/YyzDVd+4BSUybasmvJPRrJEECgIh4GYuJGNp
         LnzOxF5aiOjR/ZscrOzE8/Krqvyv5qUqM37JrRBwhY5iABC6n9sS8asOHMqVEtLk3L+3
         CP+FpFjvJcffpsfOmQOOwvOR72SThyKk8SFUv8/bGTA8Qn7yu4MjeaCL7yMhP4ppJel/
         Q8TWJ518wRu8d5rKnGCnEPBMKxvBUDSgTnM4d1WZI9VT0RKNfJ7+Ydt3YgyNDBagMMvh
         tM3LHL5pkpsC9hWimoqzV2+Td1QB6gO3IcF7VTBUoxHrB2yGC39VEWkBjXoheneGZj6p
         rdBg==
X-Gm-Message-State: APt69E0dwf7aflvdEkWZYFg2453sxCVZE3Ly43mZjN+x7QF/FiVuto2y
        lspcOL+dJ6QxNyGqtQMX5g==
X-Google-Smtp-Source: AAOMgpevmjeCfw8lcQ3Q+ZxO6B/JmDKnhjdBmDzW2O2mxAwHhdULbTsuV3Q1pG2McPyqp+ox47j5Mw==
X-Received: by 2002:a17:902:d24:: with SMTP id 33-v6mr11811707plu.22.1530910219562;
        Fri, 06 Jul 2018 13:50:19 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.59])
        by smtp.gmail.com with ESMTPSA id d65-v6sm18752618pfj.20.2018.07.06.13.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 13:50:18 -0700 (PDT)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id 40A078F8;
        Fri,  6 Jul 2018 15:50:17 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH 2/6] device: Add #define dev_fmt similar to #define pr_fmt
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1525878372.git.joe@perches.com>
 <3f213f4f9ee604c1797af67360d8da1836b34271.1525878372.git.joe@perches.com>
 <20180706153028.GA6838@kroah.com>
 <6aad533106ce750ee7a7ce3e507d7de37d132dc0.camel@perches.com>
 <20180706155003.GA30093@kroah.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <54432c2a-a956-b721-0b2b-762a61898ae1@acm.org>
Date:   Fri, 6 Jul 2018 15:50:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706155003.GA30093@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 10:50 AM, Greg Kroah-Hartman wrote:
> On Fri, Jul 06, 2018 at 08:41:34AM -0700, Joe Perches wrote:
>> On Fri, 2018-07-06 at 17:30 +0200, Greg Kroah-Hartman wrote:
>>> On Wed, May 09, 2018 at 08:15:46AM -0700, Joe Perches wrote:
>>>> Add a prefixing macro to dev_<level> uses similar to the pr_fmt
>>>> prefixing macro used in pr_<level> calls.
>>>>
>>>> This can help avoid some string duplication in dev_<level> uses.
>>>>
>>>> The default, like pr_fmt, is an empty #define dev_fmt(fmt) fmt
>>>>
>>>> Rename the existing dev_<level> functions to _dev_<level> and
>>>> introduce #define dev_<level> _dev_<level> macros that use the
>>>> new #define dev_fmt
>>>>
>>>> Miscellanea:
>>>>
>>>> o Consistently use #defines with fmt, ... and ##__VA_ARGS__
>>>> o Remove unnecessary externs
>>> SHouldn't these be separate patches please?
>> Multiple patches touching the same lines are unnecessary work.
>>
>> So I don't think so as it's just touching bits that need change
>> anyway.
>>
>>>> Signed-off-by: Joe Perches <joe@perches.com>
>>>> ---
>>>>   drivers/base/core.c    |  12 +++---
>>>>   include/linux/device.h | 103 ++++++++++++++++++++++++++++---------------------
>>>>   2 files changed, 64 insertions(+), 51 deletions(-)
>>> Ok this seems like a lot of churn for no real apparent gain.  What is
>>> all of this getting us?
>>>
>>> What is the benifit, you have more code now,
>>> why is that good?
>> IPMI and a few other subsystems prefix all their output
>> dev_<level> with specific duplicated content.
> That's crazy and strange as the whole idea was that dev_* would uniquely
> identify the driver/device such that "prefixes" would not be needed.
>
> Ugh.
>
>> This centralizes those prefixes just like pr_fmt.
>>
>> The IPMI changes are already in mainline and now
>> need this mechanism to maintain their output content.
>>
>> IPMI and a few other subsystems prefix all their output
>> dev_<level> with specific duplicated content.
>>
>> This centralizes those prefixes just like pr_fmt.
>>
>> commit a2d70dfdda6f ("ipmi: msghandler: Add and use pr_fmt and dev_fmt,
>> remove PFX")
> Ok, I'll take this.  I don't like it, as drivers should really not need
> this at all.  But ipmi is known for doing "odd" things anyway...

I've been trying to make things less odd as time has gone by.  And I'm 
happy to
pull out this change.  I've been slowly working on the logging in the 
ipmi driver
to clean this kind of stuff up.

-corey

>
> greg k-h


