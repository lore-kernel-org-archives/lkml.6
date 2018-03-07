Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsjEFfp750Bm9w7pXV0RH/YFW0dAcovhyU8MmwEgDsFC22YMkSFRzadmEXjS9NhNqFXHymU
ARC-Seal: i=1; a=rsa-sha256; t=1520390289; cv=none;
        d=google.com; s=arc-20160816;
        b=IXlycWdIpk7u7SrF/jbOK+/f5G+SbUkxqC7sgKzPgKw9lagwJlBcMkdwxoc8X1kAHF
         MLwemt7yvrXcq9NYdselKGaWz9jQd9BpM3BW3zz3A7tUa/C2GYrOQAJvpGpGwT1CkQIq
         RH5ebn8VC11muroLUhQ2IDl9NUe+AChmCvYL/7AlN1lWit60b62r2TuylLI5++yM4rMg
         2ZukellXKbrSp66hy2VaApzJITjUzN/gLC7GiNp3o/Xc0UpXn2VaFB7yC/l9GrXemXOG
         tXBFXvYER/FCU6jprhsvoADVZUQ14NaG7p9m/rU4nb3DHCarWgQglKfILAHb48j3oJk6
         bhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=9kfMtxXoyqVMMmkHEqlPG8/CoFmn4hv565xXeSxQF/8=;
        b=ggIMIp2AVp86QC8PaC9aGdb0ve2mjwHYo9K3uzWgYG+PYNlH4wSGvh2IdYdrWhpewM
         bEjPLnBGQtCotuk3+vi+zKdWFm+opkhT4VNg3hixtP7N9vburfMUVmmL4wJsPXhyIpHQ
         plorXppbglrhZ+EIF6aG1EonGuHMARK6cZIeS/OrDJjVPYR0g6Jiwe3G+69EQwjhJORw
         /OnHFhJ4eOHSXC2Us29Hyl4Ne5T01oeEbGxzMQMY+Z1l1AJ22c6ERDvQIP7I1Dp846LK
         mcp09L9hkgFU+DvfY4pwAKQx9MsalN9jHZmR1n0UEFGrzjhsoxsWtvNCG3inrsMIoqny
         fSzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754125AbeCGCiI (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 6 Mar 2018 21:38:08 -0500
Received: from osg.samsung.com ([64.30.133.232]:62137 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753857AbeCGCiG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Mar 2018 21:38:06 -0500
Subject: Re: [PATCH v2] selftests: futex Makefile add top level TAP header
 echo to RUN_TESTS
To: Darren Hart <dvhart@infradead.org>
Cc: shuah@kernel.org, tbird20d@gmail.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah Khan <shuahkh@osg.samsung.com>
References: <20180301201907.17573-1-shuahkh@osg.samsung.com>
 <20180306001820.GF25693@fury>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <dc8c5139-08fc-3a84-d4e2-627a83b41131@osg.samsung.com>
Date: Tue, 6 Mar 2018 19:37:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306001820.GF25693@fury>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593767962911316222?=
X-GMAIL-MSGID: =?utf-8?q?1594244768355334622?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 05:18 PM, Darren Hart wrote:
> On Thu, Mar 01, 2018 at 01:19:07PM -0700, Shuah Khan wrote:
>> Add top level TAP header echo, testname and separator line to make
>> the output consistent with the common run_tests target.
>>
>> This change prevents nested TAP13 headers output from individual tests.
>> Nested TAP13 headers could cause problems for some parsers.
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> 
> 
> Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>
> 
> 

Thanks. Queued this up with the rest for 4.17-rc1

-- Shuah
