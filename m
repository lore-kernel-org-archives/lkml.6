Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A21FC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AFB240BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AFB240BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbeGETFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 15:05:44 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42544 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753931AbeGETFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 15:05:42 -0400
Received: by mail-qt0-f195.google.com with SMTP id y31-v6so8003967qty.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 12:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sslrhwr7phJIYYt/gFhVwD6/b7a0KcJliBFtR8ZJNsQ=;
        b=mzB3JMGs80ID+ygyJ9Zw/U+P0a87gSpc8N+GVv+1o265FM3nPYPNpSo5rpL9TGL3Dt
         jnNRdunq/7BUgrhZzad6jXFLtmwl4VM1+biHlxnNym3xZI4BhsJ6AZVY0aoBh/QXWR2C
         xlS0V06ZifFHpi+ZlTf+eqpTQTsYD8gXaXQvCN4jcWvukTSJFjVuUXaMLyMT8BCoCL3y
         kIlOI/J6V0Z/0u1LZK5otAY+gmsD9a+4/Znf2KVqW1Le3OiHXABsFBL4tZXkM2mTDw8y
         ak36Dc+77T5T2X4q85DV3XcSimyzrrzd3LwCJW9ieFNz/sOkHH9SC5/iI2Lpkcc4iWA8
         SpSg==
X-Gm-Message-State: APt69E0dcz6qKkmoB/2nPZNFBhWr4Uz3wM2zUtTegdD8VOFPkW2wxBIT
        Z8McdJJ1FmGYXyBQimXkNxX3wA==
X-Google-Smtp-Source: AAOMgpegII9RveCS2muyz+/u0P3a63CmLXUQ2oyjfKzgmbq74OIIAMjS3lY3EFG25Un5baiO34r4Gw==
X-Received: by 2002:ac8:2853:: with SMTP id 19-v6mr6605328qtr.61.1530817541886;
        Thu, 05 Jul 2018 12:05:41 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::f0c1? ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id l7-v6sm4782334qtc.27.2018.07.05.12.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 12:05:40 -0700 (PDT)
Subject: Re: [PATCHv5 4/4] arm64: Add build salt to the vDSO
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Mark Wielaard <mjw@fedoraproject.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20180703233430.14416-1-labbott@redhat.com>
 <20180703233430.14416-5-labbott@redhat.com>
 <CAK7LNARxwNkzkUif9dj1oVFGYP4J41C+t=W4YFVxM+J94siGvA@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <33c28c0a-e429-51ea-0428-26fcfafa61bb@redhat.com>
Date:   Thu, 5 Jul 2018 12:05:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNARxwNkzkUif9dj1oVFGYP4J41C+t=W4YFVxM+J94siGvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 08:55 PM, Masahiro Yamada wrote:
> Hi.
> 
> 2018-07-04 8:34 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>>
>> The vDSO needs to have a unique build id in a similar manner
>> to the kernel and modules. Use the build salt macro.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> v5: I was previously focused on x86 only but since powerpc gave a patch,
>> I figured I would do arm64 since the changes were also fairly simple.
>> ---
>>   arch/arm64/kernel/vdso/note.S | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/vdso/note.S b/arch/arm64/kernel/vdso/note.S
>> index b82c85e5d972..2c429dfd3f45 100644
>> --- a/arch/arm64/kernel/vdso/note.S
>> +++ b/arch/arm64/kernel/vdso/note.S
>> @@ -22,7 +22,10 @@
>>   #include <linux/uts.h>
>>   #include <linux/version.h>
>>   #include <linux/elfnote.h>
>> +#include <linux/build-salt.h>
>>
>>   ELFNOTE_START(Linux, 0, "a")
>>          .long LINUX_VERSION_CODE
>>   ELFNOTE_END
>> +
>> +BUILD_SALT;
> 
> 
> 
> I think this works, but
> I prefer no-semicolon in assembly files.
> 
> For coding consistency,
> I want ';' as statement delimiter in .c files.
> But, only new line after each statement in .S files.
> 
> For example, in arch/x86/xen/xen-head.S
> I see no semicolon after ELFNOTE().
> 
> I found this:
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0473k/dom1359731141352.html
> It says ';' starts a comment line
> although it is not the case of GAS.
> 
> 
> Same for 3/4.
> 
> 
> 

Yes, that was a typo out of habit. Will fix.
