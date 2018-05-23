Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-406271-1527093575-2-15178500984009486620
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527093574; b=KWqPp5ozUlYj2XCX4YnntGKtNGU4sHKgb5pm+nBmwqmeJBwKci
    uD0YveUSuF24WTnRR7Z6w+i9XT5RL2V+U1SkqHxPLgarVVSqN2U61hAbKrQ7Bk7U
    3GAwimt2zDbFyZ2lFBoh045HJ22BZraMiUFV05J0gsyoC6Zvmnte8oHqDqypHBM1
    qz2LJDz1eCKzf50t4Njeea0dqX4/5NXsNimY/qz4NKOL5ccYmHGjQnpXUYDn0r9L
    E9RDcW2lEW+k168Pj3tNoNu2GVpiXL7xSlo/+TrGk29CJrw5IHWPUFVabGSUiTFO
    Ov1cH3C69rTx1TNDvSq6AXQ8dzlrBrey0yIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:content-type:sender:list-id; s=fm2;
    t=1527093574; bh=YjMxBTesU3v1ciKTlVsptRrOaHbzc+x0q1K21A3kk5Q=; b=
    klQdDldnhNh7eae3JHNVrUDR5eQJRDkjk0rwlb07WL+jGj5XE8GRJkvsTk0dbeve
    5f3XHmUo5AzjxTJu2e9taJQxi7nnmwLBMty+8WvNr8ACBvblDqE/1DCd+x/fLZd3
    jsGTNx23qHHQfrUiMVUXNI2Zcd6C+7bW8smggCyVwBx39FFj9QMhFfZLJFCX38ph
    EuxCfBsev2fZxbFo2iodGlLABNodi1UxhyrQYrFc+KuLQnYULfjVp5MkKbBEk6dm
    doC72uea6h9abxkJkQgTQZjgWKaZRRrBt0ky2t9Ymca+naY/oQIMT1pAJ3bKn4E9
    xaon58yYkUH8LYemoBzxrg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=intel-com.20150623.gappssmtp.com
    header.i=@intel-com.20150623.gappssmtp.com header.b=coWFmTMo
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=g6u9AXGh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=intel-com.20150623.gappssmtp.com
      header.i=@intel-com.20150623.gappssmtp.com header.b=coWFmTMo
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=g6u9AXGh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJonac3O4H39qNa6cZOhP0Ea49UuSKdxrZwb/l4wcGAruyjiKw4im3TsThp4/X7eLhOt/7ueKslQs0S26spNv1o63jtZwCmsfjZv4V0CTDejEtWJuLwU
    4tyLlouGeEL7Snirft/BbgdTAaI+jprUgwj5YPzx9p+ouH/mjjN/I/E4juFWMGizGtgt0FLs6tFEqkYjVVq8KEtRE9Cvihq5e2IeJ7NRoQ3sgwx2WWWYlWhm
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=drOt6m5kAAAA:8
    a=SOq6UgPBAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8 a=4M5GA-KHht2A57MGKDkA:9
    a=WXXFO0rH0vm7dGIa:21 a=0dskIXEud0ZV9LmY:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=RMMjzBEyIzXRtoq5n5K6:22 a=3hv5r9HjGAh9o5iR9qwG:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933740AbeEWQj3 (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 12:39:29 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34217 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933683AbeEWQjF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 May 2018 12:39:05 -0400
X-Google-Smtp-Source: AB8JxZrH3ToK5hGtwmQU0ZVxK4bYh5wScU1+V9PCvA9RvOnLzMmbzvPSCU3Tj7DDWLJxifNco80aiulkfrYrqvTwldM=
MIME-Version: 1.0
In-Reply-To: <20180523163442.GB29519@linux.intel.com>
References: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152539240242.31796.4162676712193177396.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180523163442.GB29519@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 23 May 2018 09:39:04 -0700
Message-ID: <CAPcyv4gaM+vMLQKzfQ3J0LBhN2L6uNUzqwH_m39pFN-TeQHavA@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] dax: report bytes remaining in dax_iomap_actor()
To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 9:34 AM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> On Thu, May 03, 2018 at 05:06:42PM -0700, Dan Williams wrote:
>> In preparation for protecting the dax read(2) path from media errors
>> with copy_to_iter_mcsafe() (via dax_copy_to_iter()), convert the
>> implementation to report the bytes successfully transferred.
>>
>> Cc: <x86@kernel.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  fs/dax.c |   20 +++++++++++---------
>>  1 file changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/dax.c b/fs/dax.c
>> index a64afdf7ec0d..34a2d435ae4b 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -991,6 +991,7 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>>       struct iov_iter *iter = data;
>>       loff_t end = pos + length, done = 0;
>>       ssize_t ret = 0;
>> +     size_t xfer;
>>       int id;
>>
>>       if (iov_iter_rw(iter) == READ) {
>> @@ -1054,19 +1055,20 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>>                * vfs_write(), depending on which operation we are doing.
>>                */
>>               if (iov_iter_rw(iter) == WRITE)
>> -                     map_len = dax_copy_from_iter(dax_dev, pgoff, kaddr,
>> +                     xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
>>                                       map_len, iter);
>>               else
>> -                     map_len = dax_copy_to_iter(dax_dev, pgoff, kaddr,
>> +                     xfer = dax_copy_to_iter(dax_dev, pgoff, kaddr,
>>                                       map_len, iter);
>> -             if (map_len <= 0) {
>> -                     ret = map_len ? map_len : -EFAULT;
>> -                     break;
>> -             }
>>
>> -             pos += map_len;
>> -             length -= map_len;
>> -             done += map_len;
>> +             pos += xfer;
>> +             length -= xfer;
>> +             done += xfer;
>> +
>> +             if (xfer == 0)
>> +                     ret = -EFAULT;
>> +             if (xfer < map_len)
>> +                     break;
>
> I'm confused by this error handling.  So if we hit an error on a given iov and
> we don't transfer the expected number of bytes, we have two cases:
>
> 1) We transferred *something* on this iov but not everything - return success.
> 2) We didn't transfer anything on this iov - return -EFAULT.
>
> Both of these are true regardless of data transferred on previous iovs.
>
> Why the distinction?  If a given iov is interrupted, regardless of whether it
> transferred 0 bytes or 1, shouldn't the error path be the same?

This is is the semantics of read(2) / write(2). Quoting the pwrite man page:

       Note that is not an error for  a  successful  call  to
transfer  fewer  bytes  than
       requested (see read(2) and write(2)).
