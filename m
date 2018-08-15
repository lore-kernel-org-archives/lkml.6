Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C0AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447A6208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="j/Yo8ckL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447A6208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeHOWBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:01:32 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:34950 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbeHOWBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=r+r1HdYBwOeS/aO3se0BfJZVfFBqnVsnXnRNMjI8apo=;
        b=j/Yo8ckL+Q41RSmuggh/KffTd/fS1m2FzzGSbP71unScrk84iAkox/vQ7g/CSrMHT4eJtA7KVZEYvhsntTxUlnzpglcQYROTfj2XV2AErnG7adUM5CjpNdE4/tEwz1eNzlAnL3x5McgCPb9ebytq6ZkrzRWPzd9L9QL5zLvg1nA=;
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sven Joachim <svenjoac@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180814171520.883143803@linuxfoundation.org>
 <6272e062-6cfc-0669-bebf-ebb039da051a@dd-wrt.com>
 <87k1orms9i.fsf@turtle.gmx.de>
 <55df6754-ce8c-520a-13f9-c610ac498173@dd-wrt.com>
 <20180815185553.GA18219@roeck-us.net>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <69700876-f31a-ea0a-bdea-2e82b7a5d308@dd-wrt.com>
Date:   Wed, 15 Aug 2018 21:08:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180815185553.GA18219@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [79.251.189.74] (helo=[10.88.193.131])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1fq19L-000704-6k; Wed, 15 Aug 2018 21:08:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 15.08.2018 um 20:55 schrieb Guenter Roeck:
> On Wed, Aug 15, 2018 at 08:27:00PM +0200, Sebastian Gottschall wrote:
>> if i fix the other error (can be reproduced with disable smp on standard
>> i386 build)
>>
>> another raises up again related to smp. to be serious. this patchset of x86
>> patches is absolutelly broken and put together without any care. not a
>> simple compile test has been done
>>
>> sorry for beeing a little bit upset. i'm sure i will find other bugs if i go
>> deeper
>>
> It might possibly help if you would consider to publish your configuration(s).
>
> As for "not a simple compile test has been done", please have a look
> at http://kerneltests.org/builders. I guess those compile (and boot)
> tests don't count as "simple". I assume the same applies to all the
> builds done by 0day and all the other test builders.
>
> Guenter

it was nothing special. just a standard x86 build with smp disabled. 
that triggers all of them. so this should be a common build 
configuration for testing
these issues are covered by the rc3 patch of 4.9 right now

the issue reported by sven can be triggered by just compiling rtc-cmos.c 
which is caused by the change in dmi.h  (asm/io.h was replaced by 
linux/io.h)
so this driver should be included in all x86 and x64 builds and must be 
uncovered in any simple compile test

btw. this issue is still unresolved but simple to fix

--- arch/x86/include/asm/i8259.h        (revision 36620)
+++ arch/x86/include/asm/i8259.h        (working copy)
@@ -2,6 +2,7 @@
  #define _ASM_X86_I8259_H

  #include <linux/delay.h>
+#include <asm/io.h>

  extern unsigned int cached_irq_mask;


Sebastian

>
