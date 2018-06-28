Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47276C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB94227989
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HM4aY7yT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB94227989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935118AbeF1Uum (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:50:42 -0400
Received: from mail.efficios.com ([167.114.142.138]:49826 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934361AbeF1Uul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:50:41 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E8A1722E912;
        Thu, 28 Jun 2018 16:50:40 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id v97WlVU6WM9k; Thu, 28 Jun 2018 16:50:40 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5064F22E90B;
        Thu, 28 Jun 2018 16:50:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5064F22E90B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530219040;
        bh=3zsAsHny2giQGZhdDTd8ldXmz5z1G7O0nWQ3afxJcoA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=HM4aY7yTFawgAniToyiWtKlHBbThICrOzRbbADbuVxnCNi7RjJPjnuWvW3KMqRn5Y
         Xz+D1Psuw3y1dxYFzU8DSdOAKJNR6dEvC8tBCS9DPyYNtesK46EnabAZRiWHrYE1iB
         MB1DEA0I9okH57LDrGnsnwuBcY8QM0lXI/3aOM9VLr6xbWrWCRXUw7G8xLdzii4NcT
         vk9N0/IfgP5sCu4OFNTkYXmdjhCUsQ6weg6KLKaIOW27NRHei3tR+d5Ov2TZo8y8r/
         JxhgH7J3oCt056u1bqMeeFx0AgLGyej9iMRYzC2OMfkCtXvnxMpePWuxSSI7O4dv8O
         FvE1HclvNb2cg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id rPaQJRP9cnNn; Thu, 28 Jun 2018 16:50:40 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 3B32C22E902;
        Thu, 28 Jun 2018 16:50:40 -0400 (EDT)
Date:   Thu, 28 Jun 2018 16:50:40 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        peter maydell <peter.maydell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Message-ID: <176714835.9396.1530219040151.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180628164700.GD10751@arm.com>
References: <1529949285-11013-1-git-send-email-will.deacon@arm.com> <1529949285-11013-4-git-send-email-will.deacon@arm.com> <501929863.3051.1529950210436.JavaMail.zimbra@efficios.com> <20180626151427.GF23375@arm.com> <1763491947.3520.1530029512923.JavaMail.zimbra@efficios.com> <20180628164700.GD10751@arm.com>
Subject: Re: [PATCH 3/3] rseq/selftests: Add support for arm64
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq/selftests: Add support for arm64
Thread-Index: pOL0RT8soSezNFWSYW0xKiF2CmhiIw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 28, 2018, at 12:47 PM, Will Deacon will.deacon@arm.com wrote:

> Hi Mathieu,
> 
> On Tue, Jun 26, 2018 at 12:11:52PM -0400, Mathieu Desnoyers wrote:
>> ----- On Jun 26, 2018, at 11:14 AM, Will Deacon will.deacon@arm.com wrote:
>> > On Mon, Jun 25, 2018 at 02:10:10PM -0400, Mathieu Desnoyers wrote:
>> >> I notice you are using the instructions
>> >> 
>> >>   adrp
>> >>   add
>> >>   str
>> >> 
>> >> to implement RSEQ_ASM_STORE_RSEQ_CS(). Did you compare
>> >> performance-wise with an approach using a literal pool
>> >> near the instruction pointer like I did on arm32 ?
>> > 
>> > I didn't, no. Do you have a benchmark to hand so I can give this a go?
>> 
>> see tools/testing/selftests/rseq/param_test_benchmark --help
>> 
>> It's a stripped-down version of param_test, without all the code for
>> delay loops and testing checks.
>> 
>> Example use for counter increment with 4 threads, doing 5G counter
>> increments per thread:
>> 
>> time ./param_test_benchmark -T i -t 4 -r 5000000000
> 
> Thanks. I ran that on a few arm64 systems I have access to, with three
> configurations of the selftest:
> 
> 1. As I posted
> 2. With the abort signature and branch in-lined, so as to avoid the CBNZ
>   address limitations in large codebases
> 3. With both the abort handler and the table inlined (i.e. the same thing
>   as 32-bit).
> 
> There isn't a reliably measurable difference between (1) and (2), but I take
> between 12% and 27% hit between (2) and (3).

Those results puzzle me. Do you have the actual code snippets of each
implementation nearby ?

Thanks,

Mathieu

> 
> So I'll post a v2 based on (2).
> 
> Will

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
