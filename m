Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343E4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E299120851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGWBM1E1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E299120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeK1Jdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:33:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43856 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeK1Jdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:33:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so8504969pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O1hRDnFus3AskxuyLrZZFXXttLY4R/TTtN7XJV4WRaE=;
        b=YGWBM1E18f46QM8deE463piSaf8BvJgNnD1JXp/Q5s1hlIFVValvew748gr2dpEwf/
         yzmyrhcuTCIp3hKuk0lTCFK5YcdFgtQ0xeOCndhn+s5oV7XcnLDUv10p7hRX/EkdFs6c
         XviiXjOqaOF62RHflUKYxOPOQMzEwoiMwdQFZMIkoilcxUaxKhJSvtqDyDLJhd2mNbLT
         hTEElxXOdgFuj6OPDC+j/WTFMnxcwq85CX6mRKeaIcQDxUNJbXUEr5xTB7kmlitvVFML
         AYzvCq6UXLP+L04bqKTNmVYczrXYNnjuHfBu7g5ZPzS5fTASBfHiFvr0Le1XoU7dtDT2
         uAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O1hRDnFus3AskxuyLrZZFXXttLY4R/TTtN7XJV4WRaE=;
        b=Hzh1EJQJhbVXXUCcZIBddyO3X/6UMQSTO55x1Vb6XV8fe5HybRkSihHKn0AVXB4FSh
         16oAZel0heNwQjUXfh6vC6vMgUPfz/zaMnmT5WJisOz1F/+PEWOX2PIDd+WoWu+npV1g
         HYoKiV4oMK5w4cSeeYUPLdZJniQfPgC6NYdn3Y8mGSZwOkdi1MBHrEQmVUiXIHzoPXsU
         ldS0hONcm553HJMbEE88TVtI3grzYTlrSHY0o5WXnwRnyATAWG1C5h3qCn2SicQaLYlv
         AB3jj/lq34IXrjxn2Am/cnF0oy8MJilVkeK/tYrCxU6WYgav0p0KO3YjSH6tb4zuNg7z
         9ERg==
X-Gm-Message-State: AA+aEWaSIFRovF5CAX/8nuK+O1siRrkD2bWsFXbMN+HX9P5mEftcH0Z4
        boR+mC53iYDrE4YCTaONXWg=
X-Google-Smtp-Source: AFSGD/VSlgzMBRBIGc168CrEV6ZReDJj4pHJvv4UT0Zfes/Kq68k0gw/qKUJrK1bQrXt3XEpAh5qjw==
X-Received: by 2002:a63:8d44:: with SMTP id z65mr31342472pgd.57.1543358059214;
        Tue, 27 Nov 2018 14:34:19 -0800 (PST)
Received: from [192.168.11.4] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id p6sm5826677pfn.53.2018.11.27.14.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 14:34:18 -0800 (PST)
Subject: Re: [PATCH 0/3] tools/memory-model: Add SRCU support
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <Pine.LNX.4.44L0.1811151101310.1308-100000@iolanthe.rowland.org>
 <20181119120120.GA5092@andrea> <20181126223509.GM4170@linux.ibm.com>
 <20181127002642.GA4087@andrea> <20181127171746.GP4170@linux.ibm.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <04d15c18-d210-e3da-01e2-483eff135cb7@gmail.com>
Date:   Wed, 28 Nov 2018 07:34:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181127171746.GP4170@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/27 09:17:46 -0800, Paul E. McKenney wrote:
> On Tue, Nov 27, 2018 at 01:26:42AM +0100, Andrea Parri wrote:
>>> commit 72f61917f12236514a70017d1ebafb9b8d34a9b6
>>> Author: Paul E. McKenney <paulmck@linux.ibm.com>
>>> Date:   Mon Nov 26 14:26:43 2018 -0800
>>>
>>>     tools/memory-model: Update README for addition of SRCU
>>>     
>>>     This commit updates the section on LKMM limitations to no longer say
>>>     that SRCU is not modeled, but instead describe how LKMM's modeling of
>>>     SRCU departs from the Linux-kernel implementation.
>>>     
>>>     TL;DR:  There is no known valid use case that cares about the Linux
>>>     kernel's ability to have partially overlapping SRCU read-side critical
>>>     sections.
>>>     
>>>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
>>
>> Indeed!,
>>
>> Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> 
> Thank you, applied!
> 
> I moved this commit and Alan's three SRCU commits to the branch destined
> for the upcoming merge window.

We need to bump the version of herdtools7 in "REQUIREMENTS". Would it be
7.52?

Removing the explicit version number might be a better idea. Just
say "The latest version of ...".

Thoughts?

        Thanks, Akira
> 
> 							Thanx, Paul
> 
>>   Andrea
>>
>>
>>>
>>> diff --git a/tools/memory-model/README b/tools/memory-model/README
>>> index 0f2c366518c6..9d7d4f23503f 100644
>>> --- a/tools/memory-model/README
>>> +++ b/tools/memory-model/README
>>> @@ -221,8 +221,29 @@ The Linux-kernel memory model has the following limitations:
>>>  		additional call_rcu() process to the site of the
>>>  		emulated rcu-barrier().
>>>  
>>> -	e.	Sleepable RCU (SRCU) is not modeled.  It can be
>>> -		emulated, but perhaps not simply.
>>> +	e.	Although sleepable RCU (SRCU) is now modeled, there
>>> +		are some subtle differences between its semantics and
>>> +		those in the Linux kernel.  For example, the kernel
>>> +		might interpret the following sequence as two partially
>>> +		overlapping SRCU read-side critical sections:
>>> +
>>> +			 1  r1 = srcu_read_lock(&my_srcu);
>>> +			 2  do_something_1();
>>> +			 3  r2 = srcu_read_lock(&my_srcu);
>>> +			 4  do_something_2();
>>> +			 5  srcu_read_unlock(&my_srcu, r1);
>>> +			 6  do_something_3();
>>> +			 7  srcu_read_unlock(&my_srcu, r2);
>>> +
>>> +		In contrast, LKMM will interpret this as a nested pair of
>>> +		SRCU read-side critical sections, with the outer critical
>>> +		section spanning lines 1-7 and the inner critical section
>>> +		spanning lines 3-5.
>>> +
>>> +		This difference would be more of a concern had anyone
>>> +		identified a reasonable use case for partially overlapping
>>> +		SRCU read-side critical sections.  For more information,
>>> +		please see: https://paulmck.livejournal.com/40593.html
>>>  
>>>  	f.	Reader-writer locking is not modeled.  It can be
>>>  		emulated in litmus tests using atomic read-modify-write
>>>
>>
> 

