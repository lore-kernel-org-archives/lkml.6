Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A38BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAED21479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2a0kxrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbeLSMnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:43:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43051 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbeLSMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:43:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so6135725lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 04:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nOy5hdgeY1EU0zxvCJwl+fixHxllutk8WZ/cFjaINYE=;
        b=r2a0kxrXm07Ijdu2otZNPoOHhmKNlnMFQ/acrYr9MaLHQT4ONePYNaWeHTDB51TPjp
         6y4RcW+DDPKS9cNOYccM3uzeudOW3Dce+83LWphFsebCqrGfZs6P9veAf/4xTdBKpWIa
         M24Xq7zVwiLfUZwgDdbKdHKyec3ivq+/2I0ryQ1yxEVZ/XgNKOWnyWPq7C0s2mkFtCey
         Af6k+7daRG6zS8rdZgaUh7Kdf665CMli4k0JkVEUXDUI5G35+FEc42fFu3H9TXgmZIlO
         pVxBWNEDnpXAhCDOibidTkOd+TRgnnsQpcVHZMgr3kTVPVssCT1abVEEQ+8UtX427s9L
         D1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nOy5hdgeY1EU0zxvCJwl+fixHxllutk8WZ/cFjaINYE=;
        b=XXD/LNkdzwpuPycBb72xgBTK5mqYBgvApvRb8bYdZXWCv0rx2SQP1oKvYi/jzUUu22
         1/WNYxQTITv2b1jziOIpGQjq831LsQf6MuppllRk9uqfXflIjIkBCLHnUUQSVL/KbtO7
         UHn0s/SreHPcilWmUUp7ONLFo+HH6LygOtYfdyfkt7ykIqP7PKwszy0EoUp/mDZIxv0H
         KGGoS3vGREyZHpwPyI/56nXJix2LscijjAWu4HYTkJnhpnr4Hwa2oSCsRVnatV+LxSWQ
         7Uy08Gha4h2XmbfVbJIK50UCdghk7PI1jGK2hHQyXhJIw+ylLbvRMXGqTJTwW2NsTG4f
         SsfA==
X-Gm-Message-State: AA+aEWZZxh7WZHtNfr6DxQPXBqFVZ63/SnlSv1LqaucO1F31nuZPnq/E
        zH4BRW0IYT8P+lqhKdtbBfOAHZgb
X-Google-Smtp-Source: AFSGD/U83N84EKoZVQwJmUNO4+48MANHcgRwSlmdZjzRr7h50+GdBoGMj8rnBj9/2vWfAStKIAhMTw==
X-Received: by 2002:a2e:5654:: with SMTP id k81-v6mr12234570ljb.48.1545223388313;
        Wed, 19 Dec 2018 04:43:08 -0800 (PST)
Received: from [192.168.10.160] (91-156-179-147.elisa-laajakaista.fi. [91.156.179.147])
        by smtp.gmail.com with ESMTPSA id t144sm3733061lff.53.2018.12.19.04.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 04:43:07 -0800 (PST)
Subject: Re: [PATCH] checkpatch.pl: Improve WARNING on Kconfig help
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     igor.stoppa@huawei.com, linux-kernel@vger.kernel.org
References: <20181219083559.30985-1-igor.stoppa@huawei.com>
 <af04860002d4b0f4607bd4ce6d767f5705430ace.camel@perches.com>
 <20181219115914.GA24359@brain>
 <0fcf870749cae85490aa17cd637e2c933a792c90.camel@perches.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <f05d1e5f-7514-07f1-dfc9-a4b95d7ff385@gmail.com>
Date:   Wed, 19 Dec 2018 14:43:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0fcf870749cae85490aa17cd637e2c933a792c90.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/2018 14:29, Joe Perches wrote:
> On Wed, 2018-12-19 at 11:59 +0000, Andy Whitcroft wrote:
>> On Wed, Dec 19, 2018 at 02:44:36AM -0800, Joe Perches wrote:

>> To cover both cases perhaps:
>>
>> 	"please ensure that this config symbols is described fully (less than
>> 	 $min_conf_desc_length lines is quite brief)"
> 
> This is one of those checkpatch bleats I never
> really thought was appropriate as some or many
> Kconfig symbols are fully descriptive in even
> with only a single line.
> 
> Also, it seems you are arguing for a checkpatch
> --verbose-help output style rather than the
> intentionally terse single line output that the
> script produces today.

If I have to use --verbose, to understand that the warning is about me 
writing 3 lines when the script expects 4, I don't think it's 
particularly user friendly.

Let's write "Expected 4+ lines" or something equally clear.
It will fit in a row and get the job done.

> That is something Al Viro once suggested in this thread:
> https://lore.kernel.org/patchwork/patch/775901/
> 
> On Sat, 2017-04-01 at 05:08 +0100, Al Viro wrote:
>> On Fri, Mar 31, 2017 at 08:52:50PM -0700, Joe Perches wrote:
>>> checkpatch messages are single line.
>>
>> Too bad... Incidentally, being able to get more detailed explanation of
>> a warning might be a serious improvement, especially if it contains
>> the rationale.  Hell, something like TeX handling of errors might be
>> a good idea - warning printed, offered actions include 'give more help',
>> 'continue', 'exit', 'from now on suppress this kind of warning', 'from
>> now on just dump this kind of warning into log and keep going', 'from
>> now on dump all warnings into log and keep going'.

It's all good in general, but here the word "paragraph" is being abused, 
in the sense that it has been given an arbitrary meaning of "4 lines".
And the warning is even worse because it doesn't even acknowledge that I 
wrote something, even if it's a meager 1 or 2 lines.
Which is even more confusing.

As user, if I'm running checkpatch.pl and I get a warning, I should 
spend my time trying to decide if/how to fix it, not re-invoking it with 
extra options or reading its sources.

--
igor



