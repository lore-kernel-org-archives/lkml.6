Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AA2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3A5214DE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RLNOhbw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3A5214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeLDTu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:50:57 -0500
Received: from mail.efficios.com ([167.114.142.138]:46262 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeLDTu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:50:56 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7CE979EDB0;
        Tue,  4 Dec 2018 14:50:55 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id iyU9d0poIRNX; Tue,  4 Dec 2018 14:50:55 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DCC5A9EDAB;
        Tue,  4 Dec 2018 14:50:54 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DCC5A9EDAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1543953054;
        bh=+zVGABJb4waJEo0jE0aHRjh6BYIKymGmDY6lWxHg7fA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=RLNOhbw/ZbfHsnwKT8Whsk+HTRQiz0d9XHbQjOMXXt7Xp2q3N+Y5Nltyy6aMYBdyv
         VwkvqQ2qaQofzfYy6/dv4aX+AU6tv7Uvx5rdwbjnTXUUu35acNSSiHi8kJ0T0/OyT7
         6Dh7qXy2BsOJWOJsL0QdqFbgkfns/XbT/U67vZLAFa159ZVxOjPh44doZmtdsCLoiO
         yDO6ZjEanbAzyqc/qQl4HHyeHdhNDUiZoziijC5xToS5ElgGa/JY3/CUmIDOCCGuUS
         NjJH97Se5hEcefSTujhPkcgz84vRRUkUAbLUQwo93nQyZI9lOIjINGfQR54uIEPHfW
         Fjjv+pLoO/fMg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id e3LvpFVWiUgo; Tue,  4 Dec 2018 14:50:54 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id BF7F89ED9B;
        Tue,  4 Dec 2018 14:50:54 -0500 (EST)
Date:   Tue, 4 Dec 2018 14:50:54 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <2002498237.18908.1543953054629.JavaMail.zimbra@efficios.com>
In-Reply-To: <8736rd13i7.fsf@oldenburg2.str.redhat.com>
References: <20181204192141.4684-1-mathieu.desnoyers@efficios.com> <8736rd13i7.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH glibc 1/4] glibc: Perform rseq(2) registration at
 nptl init and thread creation (v4)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation (v4)
Thread-Index: vbBiugdrML49y0rh0l25/HG+rBfz5A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Dec 4, 2018, at 2:44 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> diff --git a/sysdeps/unix/sysv/linux/riscv/rv64/libpthread.abilist
>> b/sysdeps/unix/sysv/linux/riscv/rv64/libpthread.abilist
>> index c370fda73d..9da78d59d2 100644
>> --- a/sysdeps/unix/sysv/linux/riscv/rv64/libpthread.abilist
>> +++ b/sysdeps/unix/sysv/linux/riscv/rv64/libpthread.abilist
>> @@ -235,3 +235,4 @@ GLIBC_2.28 tss_create F
>>  GLIBC_2.28 tss_delete F
>>  GLIBC_2.28 tss_get F
>>  GLIBC_2.28 tss_set F
>> +GLIBC_2.29 __rseq_refcount T 0x4
> 
> This part looks buggy.
> 
> It's unclear based on this patch whether you actually want to get rid of
> the __rseq_refcount symbol.

I want to keep the __rseq_refcount symbol so out-of-libc users can
register rseq if they are linked against a pre-2.29 libc.

Why does it look buggy ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
