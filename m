Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B14AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A6B20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="a7uzzRoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A6B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeLERYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:24:43 -0500
Received: from mail.efficios.com ([167.114.142.138]:34514 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbeLERYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:24:42 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 265509FE7D;
        Wed,  5 Dec 2018 12:24:41 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id e-wNZEF1XMty; Wed,  5 Dec 2018 12:24:40 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8D25A9FE75;
        Wed,  5 Dec 2018 12:24:40 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8D25A9FE75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1544030680;
        bh=tAO7DXb3rVFPA4jINYxWvYHi+QXJ6YxyFgAnD3Q+47k=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=a7uzzRoJe033C61VJfDOpQuFq7ns0U7TSpWG0CRJLPqE5wwD5toClSSvhHuSUFRcc
         VeTaGzInbUA4KPjR4vPwIDBc89wZ8h3xuMT53gefMld29Xm7sDi0nd1/IKFWwpCcrr
         cfEdheHy/yJlmZm4juL/f0E7J1U9xJxKpgeFL2pJ0AuTf/L/uEFvLZxHEeFhFNAJN3
         uIfQ8H6kqEtQVpLOlKjDH7zwqXbmtmlN/8G9ThezRIqrF5WUL3bL0dC+W+K0lAHDg7
         s90iSf3PGJRXZl0K5I1f8zZNBsENd+L9WIIhnhEEBWlqbQ7kaoGuvEYfWc7+JhU16G
         d++YACtJGWW+A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id sbMC47hApzJb; Wed,  5 Dec 2018 12:24:40 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 6DA619FE6E;
        Wed,  5 Dec 2018 12:24:40 -0500 (EST)
Date:   Wed, 5 Dec 2018 12:24:40 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Rich Felker <dalias@libc.org>
Cc:     Florian Weimer <fweimer@redhat.com>, carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <210288020.19588.1544030680384.JavaMail.zimbra@efficios.com>
In-Reply-To: <20181126170758.GP23599@brightrain.aerifal.cx>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com> <865273158.11687.1542995541389.JavaMail.zimbra@efficios.com> <20181123183558.GM23599@brightrain.aerifal.cx> <1758017676.12041.1543007347347.JavaMail.zimbra@efficios.com> <87bm6cqm31.fsf@oldenburg.str.redhat.com> <688718071.12798.1543247469553.JavaMail.zimbra@efficios.com> <1284855405.12857.1543249851299.JavaMail.zimbra@efficios.com> <20181126170758.GP23599@brightrain.aerifal.cx>
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation
Thread-Index: 5b1Qx0E+myfJ6lch14/JRVcvr2UF6g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Nov 26, 2018, at 12:07 PM, Rich Felker dalias@libc.org wrote:

> On Mon, Nov 26, 2018 at 11:30:51AM -0500, Mathieu Desnoyers wrote:
>> ----- On Nov 26, 2018, at 10:51 AM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>> 
>> > ----- On Nov 26, 2018, at 3:28 AM, Florian Weimer fweimer@redhat.com wrote:
>> > 
>> >> * Mathieu Desnoyers:
>> >> 
>> >>> Using a "weak" symbol in early adopter libraries is important, so they
>> >>> can be loaded together into the same process without causing loader
>> >>> errors due to many definitions of the same strong symbol.
>> >> 
>> >> This is not how ELF dynamic linking works.  If the symbol name is the
>> >> same, one definition interposes the others.
>> >> 
>> >> You need to ensure that the symbol has the same size everywhere, though.
>> >> There are some tricky interactions with symbol versions, too.  (The
>> >> interposing libraries must not use symbol versioning.)
>> > 
>> > I was under the impression that loading the same strong symbol into an
>> > application multiple times would cause some kind of warning if non-weak. I did
>> > some testing to figure out which case I remembered would cause this.
>> > 
>> > When compiling with "-fno-common", dynamic and static linking work fine, but
>> > trying to add multiple instances of a given symbol into a single object fails
>> > with:
>> > 
>> > /tmp/ccSakXZV.o:(.bss+0x0): multiple definition of `a'
>> > /tmp/ccQBJBOo.o:(.bss+0x0): first defined here
>> > 
>> > Even if the symbol has the same size.
>> > 
>> > So considering that we don't care about compiling into a single object here,
>> > and only care about static and dynamic linking of libraries, indeed the "weak"
>> > symbol is not useful.
>> > 
>> > So let's make __rseq_abi and __rseq_refcount strong symbols then ?
>> 
>> Actually, looking into ld(1) --warn-common, it looks like "weak" would be
>> cleaner
>> after all, especially for __rseq_abi which we needs to be initialized to a
>> specific
>> value, which is therefore not a common symbol.
>> 
>> "      --warn-common
>>            Warn when a common symbol is combined with another common symbol or with a
>>            symbol definition.  Unix
>>            linkers allow this somewhat sloppy practice, but linkers on some other operating
>>            systems do not.
>>            This option allows you to find potential problems from combining global symbols.
>>            Unfortunately,
>>            some C libraries use this practice, so you may get some warnings about symbols
>>            in the libraries as
>>            well as in your programs."
>> 
>> Thoughts ?
> 
> AFAIK this has nothing to do with dynamic linking.

Reading through the ELF specification, it seems to imply that "weak" only affects the link
editor behavior when combining relocatable objects, not the behavior of the dynamic linker.
Is that what you refer to when you say "weak" has nothing to do with dynamic linking ?

If that interpretation is correct, then indeed I should remove the "weak" from the __rseq_abi
and __rseq_refcount.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
