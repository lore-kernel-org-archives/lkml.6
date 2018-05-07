Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1122852-1525703169-2-3671541778474451794
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525703168; b=FJJ8qDl7YtopVDJnYN1ztwGxKxiUArZEuxdG4tbGUeZwReeSde
    Lsu76Nz3egmkqg4JoeUcajnc3sbEx9i9xa934/V293z9EksYEBAa/fcemk+kpd06
    E1wtugkcEn88mgzNUvm0QK25JGW0AqOHwQ/XX+2l6xzT7JyG4WxWtMryy6i2fZh3
    /XeZYOGbtiqifRdhpqGcEXQEeq3+SWNANHnTGtBU8C3bCVOlp1l2ZXSL+8VVFvGt
    L3PE8dyUYNYKvqKDssLhVUun98QS+cezOE8stM2+XdO5XnG52p2su6gwRYlfRuOy
    gb74CPn4TeBVMVyVx2sesEUEoFBdXUA1ux8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525703168; bh=h9N9V5tDi4QRZCEvuSXbSbtVMbvfLzmxwIFRiW8iLm
    0=; b=FM+ujksvGE0m4tUrpL6H2B0MgGW3stPlks08Dd0cBO3yLynaCu4p3WV9Gw
    oOoJyUw8HQCbAT7iUc9yZXMhmoKUvxDxZtq8wQu8uMjLedfC3+PQJVuByn6xpSDs
    oh+FYb5QAojFViFiarnolTXA8GMXtxtqjMEn/kylui/dlFQA0PtwBccXZPYiZfE8
    CdSMyYquYxk/E2FHUEQHeA9zcn8IrFo6M/X5RZMo/08nbDdRhiHv1uYdL/V5jMpo
    r2kFcsxIAFJZW2R2Harx6baI5kAYUYilkvZTGCJyaF3QIkOoP4+KzcQJiKFTgfdB
    mEZ7AaQ3zeHIvUAT175gMBhi0Khw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=r4ZaXps7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=r4ZaXps7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMBETcv+3fN2ZrK98NiyCngH2BLq97qXxrySAVoubeLDYkcRVoNgLY7BWd8G1X4AdOyZaVlVL9tB1fiMYryLvd14tHcIsiLSv97Q5myGgh+d0mBYWaff
    kYFQ6qvP2LSbtHKeqdtFwAWZLwl3ILBoYuordtfY1Y+K6qA1QAWCQs+zg/AG8ZhxrscKgufQaz2OiwB3AFugF/YDkyTUJnPtuXu/mr6auPtaJCJ1bdkKaYcj
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=VpgxCxnqr4Dva7mWsnYA:9 a=Rmr751hKHAYA2ybz:21
    a=16NWyFWt-zcrLnB-:21 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeEGO0H (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 10:26:07 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:38390 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbeEGO0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 10:26:06 -0400
X-Google-Smtp-Source: AB8JxZpmJWooRn3CDUyIx4ME+2GeUEZ1n5Z0tJOpyss5dlKA+M4Tj1CX6BpuPQ+g++x7mXopHpWV/9qFfcain1U6bDc=
MIME-Version: 1.0
In-Reply-To: <20180507121758.GD18116@bombadil.infradead.org>
References: <20180507082108.28186-1-mszeredi@redhat.com> <20180507082108.28186-2-mszeredi@redhat.com>
 <20180507111142.GA18116@bombadil.infradead.org> <CAOssrKebppZhRbvM-3qk=S0aY57skYCEn2axknOtF9LcJcu8yA@mail.gmail.com>
 <20180507121758.GD18116@bombadil.infradead.org>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Mon, 7 May 2018 16:26:05 +0200
Message-ID: <CAOssrKds6zYpoN88ns2W3c+uqSJ_iWFRjsuMM-iAv3MqU15GDA@mail.gmail.com>
Subject: Re: [PATCH 1/3] vfs: dedpue: return s64
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 7, 2018 at 2:17 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, May 07, 2018 at 01:32:09PM +0200, Miklos Szeredi wrote:
>> On Mon, May 7, 2018 at 1:11 PM, Matthew Wilcox <willy@infradead.org> wrote:
>> > On Mon, May 07, 2018 at 10:21:06AM +0200, Miklos Szeredi wrote:
>> >> f_op->dedupe_file_range() gets a u64 length to dedup and returns an ssize_t
>> >> actual length deduped.  This breaks badly on 32bit archs since the returned
>> >> length will be truncated and possibly overflow into the sign bit (xfs and
>> >> ocfs2 are affected, btrfs limits actual length to 16MiB).
>> >>
>> >> Returning s64 should be good, since clone_verify_area() makes sure that the
>> >> supplied length doesn't overflow.
>> >
>> > Why s64 rather than loff_t?  Particularly since the next patch turns
>> > the paramters into loff_t.
>>
>> Next patch turns the offsets into loff_t and leaves "len" as u64.  A
>> size is definitely not an offset, I'd consider changing the type of
>> "len" to loff_t a misuse.
>
> Usually a size is the size of something in memory.  The length of
> something on storage is definitely an loff_t.  Look at fallocate()
> for an example.  You could also argue that lseek where whence is set to
> anything other than SEEK_SET is also being used as a length rather than
> an absolute offset.  We also already use 'loff_t len' as an argument to
> vfs_dedupe_file_range_compare().

Fair enough.  Will fix.

Thanks,
Miklos
