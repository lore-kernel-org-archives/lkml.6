Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2537649-1527619258-2-6596629610722400466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527619258; b=GnUd8lGPI84c0o2cPRyMDpxJxE6XjnvVED2MBiLEw6u1+U7XjN
    7mx0ornDqHK3id4rUElOGjN7dmSpTMCkqbqwIQMrq3bUd07cYPgOM4uA3xf+10DQ
    U6mHaZFfQvIT/4MpusXBQci1Hc7StIg1ilWZTI4roqOkOGZgWj551COUBixoHqG4
    tV0yIftVuDUagTln244LMhZi4drmD8FkNRtLgWwi+jOyALlN4CzfX54VqKNfqg/Z
    BuCgKXl8yOP9t1yNkEUw1dht4AsReK31OSKYOskDm01Y054KVkQO8tApXl2iKhoD
    AdK4B0Jk5iOK1YXhXLvYv1AW6Zd4DKMjycfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527619258; bh=Mfgl5PlFhea7ewUnigFnZGWZfPDYaSiyA3zh4m0oRf
    4=; b=YKDb9wUSxbqEKD93MUVWg73ykfyVTzrpkNDkVckmi0GL1++ZBQ4e9uuxF7
    qGf8nykwc+C3BrRAO3waDvl5aotaMFZpsfCnut2xJE/worI8kDcWIzH6ey4OMynX
    R12ZCdja9KzLMQ59m3CbrZDbE1wT107c7Gg/XXHL1hLteQw6oHBHBeDUOP0IlZ0q
    xWeJnEhhEZIW2RXB1ujlL23VprLKLksYTvlmF/ID+ADeEuUlIjjWdE2YqXvMufq1
    47VSvKMjQimOGi5hTmEZu7bvCbHW5+m+X++lC6LbjUa7WmERvJMR0IOAAGm8raY2
    DA7UAfcs7yOwpLi0jJ2QAekK2zVA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=intel-com.20150623.gappssmtp.com
    header.i=@intel-com.20150623.gappssmtp.com header.b=JLSCBy5o
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=rbjk8Z0K;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=intel-com.20150623.gappssmtp.com
      header.i=@intel-com.20150623.gappssmtp.com header.b=JLSCBy5o
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=rbjk8Z0K;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFgPKO4SOmMMn0BVhiG88/1CFS7P3EzBrwAPn7hmh9eOm6QcX0+Fk6BRXGd/zq1zhJ8zphmapXOgY2BcGmPgyHUCfq2ctEoIGOBJ15/hHuTMBnp4PQKr
    +xuOEPcJNHvUB1QslQncBl+y6L71tpjv9YP6wW78z/QsypuI5QEehgrUvjeKTtrlxmmi93cXjL/7Ek6d2DhBrLG60SBpMlK4Uyjs2QRhr2AuI1hUFJUhSoIj
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=D19gQVrFAAAA:8 a=w_4FuvkSi0pOwJ2HCcEA:9
    a=QEXdDO2ut3YA:10 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965954AbeE2Sky (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 14:40:54 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40556 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937016AbeE2Skw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 14:40:52 -0400
X-Google-Smtp-Source: ADUXVKKg2SK72TpgaTI7gkBTIfBvxGVlIPx7M9CFsryst45Jn5fGZP3f5dVB/Yau27xcGLZHhC63djcOJv9xIo/QBYg=
MIME-Version: 1.0
In-Reply-To: <20180529180823.GA32763@redhat.com>
References: <20180528153834.2268557-1-arnd@arndb.de> <20180529175216.24937-1-ross.zwisler@linux.intel.com>
 <20180529180823.GA32763@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 29 May 2018 11:40:50 -0700
Message-ID: <CAPcyv4iF8oAGDKcWP++-bw5OcfmkSTPHCAw1XZvVRTz4evJvGw@mail.gmail.com>
Subject: Re: dm-writecache: fix compilation issue with !DAX
To: Mike Snitzer <snitzer@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Shaohua Li <shli@kernel.org>, Alasdair Kergon <agk@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 11:08 AM, Mike Snitzer <snitzer@redhat.com> wrote:
> On Tue, May 29 2018 at  1:52pm -0400,
> Ross Zwisler <ross.zwisler@linux.intel.com> wrote:
>
>> As reported by Arnd (https://lkml.org/lkml/2018/5/28/1697), dm-writecache
>> will fail with link errors in configs where DAX isn't present:
>>
>> drivers/md/dm-writecache.o: In function `writecache_ctr':
>> dm-writecache.c:(.text+0x1fdc): undefined reference to `dax_read_lock'
>> dm-writecache.c:(.text+0x2004): undefined reference to `dax_direct_access'
>> dm-writecache.c:(.text+0x21cc): undefined reference to `dax_read_unlock'
>>
>> Fix this by following the lead of the other DM modules and wrapping calls
>> to the generic DAX code in #if IS_ENABLED(CONFIG_DAX_DRIVER) blocks.
>>
>> We also expand the failure case for the 'p' (persistent memory) flag so
>> that fails on both architectures that don't support persistent memory and
>> on kernels that don't have DAX support configured.  This prevents us from
>> ever hitting the BUG() in the persistent_memory_claim() stub.
>>
>> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks, I've picked this up.

...I assume you're also going to let the 'pmem api' discussion resolve
before this all goes upstream?
