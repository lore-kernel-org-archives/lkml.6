Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-995127-1526313126-2-14786833103967176285
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526313126; b=khwOfoHVjnsOyuvO7yJPDjEKtDboS+jMRe368Gog+e5tEKpYsQ
    xjQqHdh/WBK+wUTLvm5aa0eCgPcXi4j1lB+nPDgttBlTEhk7QdUo5CkxH3rPlehV
    8L1vSk6S0MmK2tD44ao7E18l/w/eTbLvxfrnhnAv821MjS9wG6cr7/He9K7+7/4G
    nRd691LQz7/dR5+JaCAykXBewJ/QRKVpUcGiHb/Zn3UR6N6krN18YEYGdHt0rqmF
    WiUGKBkY54nJ6Cu3bEbupsMSXwh6mg/0cL7TTg/cLYQlhcqF5e7LtS7RbmEt/kQQ
    fCIlDgtdLxtypWG7KalkxqjCqHjn4c/ncz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526313126; bh=anAKFmZNfeHi3xHfJ4ejWlebwrKxCrxgc2LqYe9oTk
    c=; b=VOeyn0PPtanjYikYACxNRo6pZJs55viRvZDpGTrv/73Xt6oAWpyrUXT20t
    j4U/m6/KsuTvimwkcDf1/h4B7/r9ecNXHz34wVM8iUxUvIl6p3oW7p6HNQVpo8dv
    +aK0xUlGkV7eVk58h+lGnGA0P2NaE92eOH39dM4J2OgVYxpp0CAB++SfslPUwQXZ
    K6vbSFrx2n+gdiMpW3hNm0HfSDLZF/rPFt5amESjxfm2ES7gHgQcG90LSpA6M5HW
    UcVUMXukIddDxMU7sALFAyjN22SJFNxLdWRAzH5S9RMuPKwvlIEknY7I5gMbmx/D
    MdL3kwT7v8AfyBIuAgW6oOTuWDKw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=intel-com.20150623.gappssmtp.com
    header.i=@intel-com.20150623.gappssmtp.com header.b=k1UoZKgD
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=n0YedSXu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=intel-com.20150623.gappssmtp.com
      header.i=@intel-com.20150623.gappssmtp.com header.b=k1UoZKgD
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=n0YedSXu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH3SJuZItPdgpGpZX/Tl88J8lwAbOV47939Y6LiiyIzYpWppaFm58cwEDSXeXT+KF/Ny4LaMwtIf9EwjNChzcmqYXaSSa1KiyYPQH1FUSYAVpFy3tMrR
    b7BUARryoaPI3/qXIctdL5XpEzYhidtnmeYBmmvjnPQzSSU3C77COwP+iXeag49PNz+Xsd7vrCm5qEBH2/NyPAsK7Wy9bfsGEActMwjlkboZ9WaHRAL7+5tE
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pC25yzH5R2KbY8HCt64A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeENPwE (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 11:52:04 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45976 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeENPwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 May 2018 11:52:03 -0400
X-Google-Smtp-Source: AB8JxZpGqQyFiLr9ZFu/gySYaio9OwqZ0dC8IPZwv2uHeZC+MbJDDtfNR6NyYsWdYKY974Ca01mKqa4XuBkmsAAxjU8=
MIME-Version: 1.0
In-Reply-To: <20180514072603.GA14099@gmail.com>
References: <CAPcyv4g5p72aiXYh8Tf03tvZq8HNYmTFU95PJGG1iQ4JHcr9PA@mail.gmail.com>
 <20180514072603.GA14099@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 14 May 2018 08:52:02 -0700
Message-ID: <CAPcyv4j2HQH1wdsGGWUAiXEKXeoMUWN_HeUEMmkv8PG7RUTtfw@mail.gmail.com>
Subject: Re: use memcpy_mcsafe() for copy_to_iter() (was: Re: [PATCH v3 0/9]
 Series short description)
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 12:26 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Dan Williams <dan.j.williams@intel.com> wrote:
>
>> Ingo, Thomas, Al, any concerns with this series?
>
> Yeah, so:
>
>    "[PATCH v3 0/9] Series short description"
>
> ... isn't the catchiest of titles to capture my [all too easily distracted]
> attention! ;-)

My bad! After that mistake it became a toss-up between more spam and
hoping the distraction would not throw you off.

> I have marked it now for -tip processing. Linus was happy with this and acked the
> approach, right?

I think "happy" is a strong word when it comes to x86 machine check
handling. My interpretation is that he and Andy acquiesced that this
is about the best we can do with dax+mce as things stand today.
