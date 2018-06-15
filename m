Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEA7C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120EB208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120EB208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966300AbeFOQlv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:41:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966035AbeFOQlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:41:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E82D40122B6;
        Fri, 15 Jun 2018 16:41:48 +0000 (UTC)
Received: from localhost (ovpn-112-7.rdu2.redhat.com [10.10.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0D1A2026DEF;
        Fri, 15 Jun 2018 16:41:46 +0000 (UTC)
Date:   Fri, 15 Jun 2018 09:41:45 -0700 (PDT)
Message-Id: <20180615.094145.334438195653112696.davem@redhat.com>
To:     shuah@kernel.org
Cc:     tom.hromatka@oracle.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com
Subject: Re: [PATCH] selftests: sparc64: Fix to do nothing on non-sparc64
From:   David Miller <davem@redhat.com>
In-Reply-To: <d8ec82b2-a27a-7a7a-9d8a-b3b937e8e959@kernel.org>
References: <20180612232348.27979-1-shuah@kernel.org>
        <d6a1ce6d-4903-ec7a-10aa-d40118fce45c@oracle.com>
        <d8ec82b2-a27a-7a7a-9d8a-b3b937e8e959@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 15 Jun 2018 16:41:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 15 Jun 2018 16:41:48 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'davem@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <shuah@kernel.org>
Date: Fri, 15 Jun 2018 10:33:21 -0600

> On 06/13/2018 11:20 AM, Tom Hromatka wrote:
>> Thanks, Shuah!
>> 
>> Tom
>> 
>> 
>> On 06/12/2018 05:23 PM, Shuah Khan (Samsung OSG) wrote:
>>> sparc64 test fails with the following errors on non-sparc64 systems. Fix
>>> the Makefile to do nothing on non-sparc64 systems to suppress the errors:
>>>
>>> make run_tests
>>> adi-test.c: Assembler messages:
>>> adi-test.c:302: Error: no such instruction: `rd %tick,%r13'
>>> adi-test.c:304: Error: no such instruction: `rd %tick,%rbp'
>>> adi-test.c:190: Error: no such instruction: `rd %tick,%rbp'
>>> adi-test.c:192: Error: no such instruction: `rd %tick,%rdx'
>>> adi-test.c:273: Error: no such instruction: `rd %tick,%rbx'
>>> adi-test.c:276: Error: no such instruction: `rd %tick,%rdx'
>>> adi-test.c:217: Error: no such instruction: `rd %tick,%rbp'
>>> adi-test.c:220: Error: no such instruction: `rd %tick,%rdx'
>>> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
>>> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
>>> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
>>> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
>>> adi-test.c:246: Error: no such instruction: `rd %tick,%rbp'
>>> adi-test.c:248: Error: no such instruction: `rd %tick,%rdx'
>>> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
>>> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
>>> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
>>> <builtin>: recipe for target 'adi-test' failed
>>> make[1]: *** [adi-test] Error 1
>>> adi: [FAIL]
>>> ./drivers_test.sh: 24: ./drivers_test.sh: ./adi-test: not found
>>> ../lib.mk:73: recipe for target 'run_tests' failed
>>> make: *** [run_tests] Error 1
>>>
>>> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
>> 
>> Reviewed-by: Tom Hromatka <tom.hromatka@oracle.com>
>> 
> 
> get_maintainers didn't include your name for this patch. Would you like to
> take this fix through sparc tree? It would be good to get this in for
> 4.18-rc2
> 
> If so, please let me know if you would like me to resend the patch
> with Tom's Reviewed-by tag.

I'm very busy, so this time could you merge this for me?  Thanks!

Acked-by: David S. Miller <davem@davemloft.net>
