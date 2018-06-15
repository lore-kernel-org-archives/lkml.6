Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8B7C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C760D208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C760D208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966196AbeFOQdd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:33:33 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38322 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966002AbeFOQda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:33:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id F17052169A;
        Fri, 15 Jun 2018 16:33:29 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Tk8ji6LtKRay; Fri, 15 Jun 2018 16:33:29 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 4EE74215A8;
        Fri, 15 Jun 2018 16:33:21 +0000 (UTC)
Subject: Re: [PATCH] selftests: sparc64: Fix to do nothing on non-sparc64
To:     Tom Hromatka <tom.hromatka@oracle.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180612232348.27979-1-shuah@kernel.org>
 <d6a1ce6d-4903-ec7a-10aa-d40118fce45c@oracle.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <d8ec82b2-a27a-7a7a-9d8a-b3b937e8e959@kernel.org>
Date:   Fri, 15 Jun 2018 10:33:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d6a1ce6d-4903-ec7a-10aa-d40118fce45c@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 11:20 AM, Tom Hromatka wrote:
> Thanks, Shuah!
> 
> Tom
> 
> 
> On 06/12/2018 05:23 PM, Shuah Khan (Samsung OSG) wrote:
>> sparc64 test fails with the following errors on non-sparc64 systems. Fix
>> the Makefile to do nothing on non-sparc64 systems to suppress the errors:
>>
>> make run_tests
>> adi-test.c: Assembler messages:
>> adi-test.c:302: Error: no such instruction: `rd %tick,%r13'
>> adi-test.c:304: Error: no such instruction: `rd %tick,%rbp'
>> adi-test.c:190: Error: no such instruction: `rd %tick,%rbp'
>> adi-test.c:192: Error: no such instruction: `rd %tick,%rdx'
>> adi-test.c:273: Error: no such instruction: `rd %tick,%rbx'
>> adi-test.c:276: Error: no such instruction: `rd %tick,%rdx'
>> adi-test.c:217: Error: no such instruction: `rd %tick,%rbp'
>> adi-test.c:220: Error: no such instruction: `rd %tick,%rdx'
>> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
>> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
>> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
>> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
>> adi-test.c:246: Error: no such instruction: `rd %tick,%rbp'
>> adi-test.c:248: Error: no such instruction: `rd %tick,%rdx'
>> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
>> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
>> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
>> <builtin>: recipe for target 'adi-test' failed
>> make[1]: *** [adi-test] Error 1
>> adi: [FAIL]
>> ./drivers_test.sh: 24: ./drivers_test.sh: ./adi-test: not found
>> ../lib.mk:73: recipe for target 'run_tests' failed
>> make: *** [run_tests] Error 1
>>
>> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> 
> Reviewed-by: Tom Hromatka <tom.hromatka@oracle.com>
> 

Hi Dave,

get_maintainers didn't include your name for this patch. Would you like to
take this fix through sparc tree? It would be good to get this in for
4.18-rc2

If so, please let me know if you would like me to resend the patch
with Tom's Reviewed-by tag.

thanks,
-- Shuah
