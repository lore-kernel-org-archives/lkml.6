Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224oNLo7gP3auKf66mK+JUUfkdAqfjvuDEFPeLJgGHYlZn7djJAXXpPLhsaPKH+IQEb4B4CK
ARC-Seal: i=1; a=rsa-sha256; t=1518572760; cv=none;
        d=google.com; s=arc-20160816;
        b=KbY+qMUf9BDHE0KJ5FX1/Hq2M5nbSCgw2Gy2lOMwJ9CoQvlWD8xLW0aGt1N8hS9YYX
         WpBobCWbesF7h1j2Uay/4ctAt7BHDwZL/R2saS1mhdCN6xJ/TkyuhKovYZmRfLVOl3Js
         ORpH6KmrkHq9LdKLqSKGvV+m18IfFPzdnuLD8bcOnoN8T/wSfbB0J8ZRs01MuJr8OypA
         k02nocXQHp/+9OdfyohhAzRBjc1N8ISQFR5jEG0a+bbikbwh7sJdyed+GnwWnvON5c4X
         xmGCS/1kLe69SYenWY4UWB7RNKA8+Oxz8IvxAGJIYxhK5zGLLHd8CKx0zYTgzCWnG6cU
         2w1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=XHbLi9jEIsip4ySgHrDP1Xx3pkiMUpmRcg3OnvBsiQk=;
        b=bBCXtA03YSSwRRQbTa/VDPueLREeXJpNNC3hbAWeLPbz4hPvU0OKtH8UZ/oQ7P+7Cn
         XmNwQh+yCkyAT+7wURPn8VpBrftKZsnKusEpExZXW2y1Y2N0KZ+nYRieywG2bsLabiSn
         aC3cAWMXQhUUQtlQIqzBJE4+g+HEpqol7mOKFFy/8jJAJfwqp7EFkGhpYYeHO3+gd8B+
         lNR2z9yoIQ/OnzTlvv4elg+0/dx1FvHiMxmjMNmqt04g21R87QGPFcQNKxHvyQQFjNbT
         mfIXlf46aXK9Pv6APpT3RpQzK7kp3nxVJPZJMbYNwUYvQBgPL3+L2pKC/McBjw2gC9cl
         pRAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966372AbeBNBp7 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 13 Feb 2018 20:45:59 -0500
Received: from osg.samsung.com ([64.30.133.232]:61110 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966364AbeBNBp7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Feb 2018 20:45:59 -0500
Subject: Re: [PATCH] selftests/futex: Fix line continuation in Makefile
To: Darren Hart <dvhart@infradead.org>,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Cc: linux-kselftest@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:FUTEX SUBSYSTEM" <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>
References: <1518024271-12467-1-git-send-email-daniel.diaz@linaro.org>
 <dbf5a78f-4178-2210-9a6c-bf71de7b939d@osg.samsung.com>
 <20180214013347.GA5786@fury>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <6d498007-de71-2071-646c-05eeb81b2b08@osg.samsung.com>
Date: Tue, 13 Feb 2018 18:45:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214013347.GA5786@fury>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591763894080699218?=
X-GMAIL-MSGID: =?utf-8?q?1592338950867040730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/13/2018 06:33 PM, Darren Hart wrote:
> On Tue, Feb 13, 2018 at 02:26:46PM -0700, Shuah Khan wrote:
>> On 02/07/2018 10:24 AM, Daniel Díaz wrote:
>>> The Makefile lacks a couple of line continuation backslashes
>>> in an `if' clause, which produces an error while make'ing:
>>>
>>>   $ make
>>>   make[1]: Entering directory `/[...]/linux/tools/testing/selftests/futex'
>>>   /bin/sh: -c: line 5: syntax error: unexpected end of file
>>>   make[1]: *** [all] Error 1
>>>   make[1]: Leaving directory `/[...]/linux/tools/testing/selftests/futex'
>>>   make: *** [all] Error 2
>>>
> 
> What is the failure scenario here? Is this shell specific? What does /bin/sh
> point to for you?

My understanding is that this problem is seen with make versions prior to 4.x.
This specific problem is seen with make version 3.81

I will let Daniel Díaz share details on his environment.

thanks,
-- Shuah
