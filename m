Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1873391-1528136887-2-2907016105186471381
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528136887; b=dctKcp9qv6VXAII1ykdqlUnG/LpoObjHnOPNnZ6JV7hr2WpmEs
    PqSSl2TH0opx7mzRvLZGVFdCqY8+K/FlPj3hsiOT4F1OJ/1pRFipnkcLS+zpnT4K
    aiGs4lvuDQPG+qoyZrN9pilrj4F+xOyB7P/AXdcCTU0Q0U96iWzP39QbeslE4r4X
    vqglx10ef7Q0268BJ05uI4hRzcXJgCjpQ7Dv6C4gbfM2Fs0R62BG6rf4knXJDd6I
    1ltifiImOC/EwWUfwm0OdE4s854uzcci+nu4FdIbWGlpJHuZcHv83Jefdn0eT9PC
    6hqfc777h9bSL6iJYTSqDziyJEJLF5iODP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528136887;
    bh=dWb2h3goa/RPYqg5DaUTlI2pq2oB8Kmn9DcbOZ2AsUc=; b=ZwNEjW9DdG9H
    FfZYyVO64PZLNNaGNuefznIGSLvHf0uOIoqJV4hI2ta6+aFNouQitJ9lheHmIKys
    0eYcN5GmArgRlpQuC+Z6j5TDocf8mo1uUE6o1FuJAC4ZxnufHQz8h3vi6FxU7thx
    dXcqyKBXoGSFz/9Z4moDi2f/GQMxoN7j0NJK9eQJUulzNYZF9KCDYU1Lbr3/mtKC
    9FbR/EBVU0WBkwEParFRNjK3I+ecJ3heIuOMCDkdb9fqDX+yM0ElX36UCFVPpclB
    HJRV5xXe+dN4ncbKkNAF3CSH5MU+R8Xb9XbBHFbgnS5GIQ/k/X82CMyzXBLvDRho
    acx/mrqPkQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=Njh2Z+Hm
    header.a=rsa-sha256 header.s=merlin.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=Njh2Z+Hm
      header.a=rsa-sha256 header.s=merlin.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFTAAjUzS2iWEnXk7I+ECy2IkOIP/BnO/7a+meTVY7IYzY+fUaZmuP0EqSaLjDhwGUM+ObErE2sgx45mqZixL81RugQX8dvbzhiKoAbsY0z6RZaTVcOf
    Y7YMf9eQEJiAWx3RaoWB0ph0C1JPAhYcug6H6rviTHbNfWagh5TaxNobW2HGYzecAq9LQNLiSx1Xs9gJqPMY29hCBONln7O5ZSSaqg2Q7UWt88U47NNS6GNB
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=iTKq39Npzpd0vVdMzygA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbeFDS2F (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 14:28:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48116 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeFDS2E (ORCPT
        <rfc822;linux-next@vger.kernel.org>); Mon, 4 Jun 2018 14:28:04 -0400
Subject: Re: linux-next: Tree for Jun 4 (md/dm-writecache.c)
To: Mike Snitzer <snitzer@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180604215911.75399f6e@canb.auug.org.au>
 <0e3fa62d-727e-ccb8-53ae-a6aaa6c506e2@infradead.org>
 <20180604182259.GA5440@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7b566935-a03d-ecab-be2a-10e25e4554f6@infradead.org>
Date: Mon, 4 Jun 2018 11:27:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604182259.GA5440@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06/04/2018 11:22 AM, Mike Snitzer wrote:
> On Mon, Jun 04 2018 at 12:06pm -0400,
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 06/04/2018 04:59 AM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20180601:
>>>
>>
>> on x86_64:
>>
>> In file included from ../drivers/md/dm-writecache.c:8:0:
>> ../drivers/md/dm-writecache.c: In function ‘writecache_status’:
>> ../include/linux/compiler.h:61:17: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 4 has type ‘int’ [-Wformat=]
>>    static struct ftrace_branch_data   \
>>                  ^
>> ../include/linux/device-mapper.h:550:46: note: in definition of macro ‘DMEMIT’
>>       0 : scnprintf(result + sz, maxlen - sz, x))
>>                                               ^
>> ../include/linux/compiler.h:48:24: note: in expansion of macro ‘__branch_check__’
>>  #  define unlikely(x) (__branch_check__(x, 0, __builtin_constant_p(x)))
>>                         ^
>> ../drivers/md/dm-writecache.c:414:35: note: in expansion of macro ‘unlikely’
>>  #define writecache_has_error(wc) (unlikely(READ_ONCE((wc)->error)))
>>                                    ^
>> ../include/linux/compiler.h:56:23: note: in expansion of macro ‘__trace_if’
>>  #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
>>                        ^
>> ../include/linux/compiler.h:251:2: note: in expansion of macro ‘if’
>>   if (check)       \
>>   ^
>> ../include/linux/compiler.h:258:22: note: in expansion of macro ‘__READ_ONCE’
>>  #define READ_ONCE(x) __READ_ONCE(x, 1)
>>                       ^
>> ../drivers/md/dm-writecache.c:414:44: note: in expansion of macro ‘READ_ONCE’
>>  #define writecache_has_error(wc) (unlikely(READ_ONCE((wc)->error)))
>>                                             ^
>> ../drivers/md/dm-writecache.c:2196:32: note: in expansion of macro ‘writecache_has_error’
>>    DMEMIT("%ld %llu %llu %llu", writecache_has_error(wc),
>>                                 ^
>>
>> s/%ld/%d/
> 
> AFAICT, this is the correct fix:
> https://patchwork.kernel.org/patch/10438865/
> 
> Not seen any response to it (Steven and Ingo were emailed, Arnd and LKML
> were cc'd).

Yes, thanks.  That looks good.

-- 
~Randy
