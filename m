Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C0BC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9CB20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QVs9RZqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9CB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933824AbeFTWgw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:36:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933555AbeFTWgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dRKbFl2LYWJbXvt+Skk6o6oKbyqiJEAC2vudTvQv09g=; b=QVs9RZqe8irJkY1c8lPa6jIKr
        d55/71p/fxPOsdQl8c3brfkq34Eo7WifezavF0tJxWLAFdrbyhIgowcD6GeTxktpOaZR4CmwicOkE
        hVKHoxkkHqMOfjpAfas2up3WaVCveQjUCtacW1r/FOO+QoCzD+ssV4zu6cu68elSJle8hM6JH4IfV
        BdZsiJHvOvoXtjzbqRz86dcEpPgXWchyo82PZovd5EZQYWic8VSXNnSZ3MT+MMPVvwfVohQxSDvuQ
        qW58nRsBX2ZZ1WA9ZtLbkWK4UZD9t6x6OU9HJCSSE7iB/0tkua9EmqomInrHlYg6uwRXOuoeQXYv4
        8/JL1ki7Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVliZ-0005Vj-EI; Wed, 20 Jun 2018 22:36:47 +0000
Subject: Re: [PATCH v8 4/4] vsprintf: Add command line option
 debug_boot_weak_hash
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180620042046.30806-1-me@tobin.cc>
 <20180620042046.30806-5-me@tobin.cc>
 <e4f6bfb3-68c7-9f57-0d90-d68d0913234a@infradead.org>
 <20180620223014.GE11671@eros>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b472dca0-9bd0-caf3-efab-586b6ff32765@infradead.org>
Date:   Wed, 20 Jun 2018 15:36:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620223014.GE11671@eros>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 03:30 PM, Tobin C. Harding wrote:
> On Wed, Jun 20, 2018 at 09:09:49AM -0700, Randy Dunlap wrote:
>> On 06/19/2018 09:20 PM, Tobin C. Harding wrote:
>>> Currently printing [hashed] pointers requires enough entropy to be
>>> available.  Early in the boot sequence this may not be the case
>>> resulting in a dummy string '(____ptrval____)' being printed.  This
>>> makes debugging the early boot sequence difficult.  We can relax the
>>> requirement to use cryptographically secure hashing during debugging.
>>> This enables debugging while keeping development/production kernel
>>> behaviour the same.
>>>
>>> If new command line option debug_boot_weak_hash is enabled use
>>> cryptographically insecure hashing and hash pointer value immediately.
>>>
>>> Signed-off-by: Tobin C. Harding <me@tobin.cc>
>>> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>> ---
>>>  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
>>>  lib/vsprintf.c                                  | 17 +++++++++++++++++
>>>  2 files changed, 26 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 638342d0a095..a116fc0366b0 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -748,6 +748,15 @@
>>>  
>>>  	debug		[KNL] Enable kernel debugging (events log level).
>>>  
>>> +	debug_boot_weak_hash
>>> +			[KNL] Enable printing pointers early in the boot
>>> +			sequence.  If enabled, we use a weak hash instead of
>>> +			siphash to hash pointers.  Use this option if you need
>>> +			to see pointer values during early boot (i.e you are
>>
>> maybe:
>> 			to see hashed pointer values
>> i.e., not raw pointers.
> 
> You cannot see 'raw pointers' anyways?

only if using %px ?

Maybe it's just terminology.  I don't consider a hashed value as a pointer value.
It's just a key or handle or some other number, but it's not a pointer.

>>
>>> +			seeing instances of '(___ptrval___)').
>>> +			Cryptographically insecure, please do not use on
>>> +			production kernels.
> 
> thanks for the review, I don't quiet see how to use your suggestion to
> make the text clearer.  If you still feel this change is needed perhaps
> you could write so I understand i.e 'Use this option if ...'


OK, if you are good with it, I am too.  :)

thanks,
-- 
~Randy
