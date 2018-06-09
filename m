Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1o3QNZ4kHFsXQQAAmS7hNA
	; Sat, 09 Jun 2018 19:03:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CCAF5602FC; Sat,  9 Jun 2018 19:03:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3D8FF602FC;
	Sat,  9 Jun 2018 19:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D8FF602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbeFITD4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 15:03:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50153 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753227AbeFITDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 15:03:54 -0400
Received: from mail-pf0-f197.google.com ([209.85.192.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fRj9V-0001NX-9k
        for linux-kernel@vger.kernel.org; Sat, 09 Jun 2018 19:03:53 +0000
Received: by mail-pf0-f197.google.com with SMTP id g15-v6so7978710pfh.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 12:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cMF+a2zBMCbUm/J4RLrxjAyo4y80On+cFqP3HU+CYuc=;
        b=PBLvHTMbAG6z88m5gMmThVPa5p5P242xPza0+vUywRyphgitZHRQ5k/GOFtsv+KvYM
         dAACOh4hgw4V6rSQibh9NndV7xsUWeVCpv8yWjAaD5PV/5FObq7OGFW8q4H8HcllAvr6
         Pmim/vWPKiO4teTS2bk92KsXY9t0hXJDhrTbO9MHJrq3DClmvb53qL5bAkl+5L7slOUG
         L9Ol4XwWbFHNo6QjNlA4axitwnDtqPfwxDv3otqHvKneDNluzg04EgLySosGAerX882H
         jvlUw6Jhu82MxMW6TuBmZr++f1/wjczsKmWShPW7pj1nf5NdANAB5qoIZgpEI7WVxQJV
         eBmA==
X-Gm-Message-State: APt69E1vZmsKh/eKGcrlXtmJXm5ff2ox393ACaLU1cZWwAcz7H+JYLcC
        IuElnhm8nsdYGA3rprdnxV3mIjrlm7zWkOsa5V7AZdxOf3dD9IFxqAZJNxO1wvwSZjUxKVHSogN
        0sKrAouuQfB5C7MQkqQS/2oNCnhS4o/5ZSBRLGaXZYA==
X-Received: by 2002:a63:b609:: with SMTP id j9-v6mr9604010pgf.335.1528571031895;
        Sat, 09 Jun 2018 12:03:51 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKLaD/eYFbOE+8qRzw7WDYYToZBtkJJCkgqebJIs+G//6XOWjs7U+DlLMAEv9nATmxqhYK6mvQ==
X-Received: by 2002:a63:b609:: with SMTP id j9-v6mr9604002pgf.335.1528571031602;
        Sat, 09 Jun 2018 12:03:51 -0700 (PDT)
Received: from [192.168.1.206] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id z28-v6sm70903031pfl.169.2018.06.09.12.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 12:03:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: Ryzen 2700 Temperature offset?
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180607154915.GA7061@roeck-us.net>
Date: Sun, 10 Jun 2018 03:03:47 +0800
Cc: Chris Ouellet <rabbit.of.war@gmail.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <54EAD835-C48D-4751-9BFF-71536241129A@canonical.com>
References: <C85830A6-BCC7-4137-84E5-38503873F278@canonical.com>
 <20180607154915.GA7061@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 23:49, Guenter Roeck <linux@roeck-us.net> wrote:

> On Thu, Jun 07, 2018 at 11:03:13AM +0800, Kai Heng Feng wrote:
>> Hi Guenter,
>>
>> A user thinks the Ryzen 2700 temperature may not be correct [1].
>> Can you take a look when you have time? Thanks.
>>
>> Also, where can I find all these temperature offsets? I googled but with  
>> no
>> result.
> Problem is that the offsets are not documented in public, making it
> difficult to find out. For Ryzen 2700, there is currently no offset
> configured; I was told that there is none. For Ryzen 2700X, the offset
> is 10 degrees C.

I am still quite interesting where you get this information...

>
>> [1] https://bugs.launchpad.net/bugs/1774817
>
> The key here is the commit mentioned in the log (1b59788979acd). It does
> not only adjust the per-CPU offset, but also takes a configurable offset
> of 49 degrees C into account. You'll need to apply that patch in your
> kernel, or the temperature may be off by 49 degrees C.

So unless AMD shares these offsets value, we can never know what correct  
offsets are?

Kai-Heng

>
> Hope this helps. If not, please let me know. Note that I am travelling;
> responses may be delayed.
>
> Guenter
