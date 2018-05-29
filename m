Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2618787-1527626095-2-17272996077583340074
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527626094; b=MgvQXA2SkaPeRjiOKK+zcSVqxnZrh6q/pPP4jkJelYsXLJVdLi
    J789VnJlQ9LOrbnoJsTGCm0oH6YYivrmWJng1M2A7phPOIq75l4prEr/etZ/G5wC
    dAK272mFq7SYp7YZrcbW1Yg2C5Z0evBgWiSQb3PB1IPcv00RJnf1pamLur7YyVzG
    CUTnm+MHVXw6/zlX6LfJN9JN9W05FHx57q7uh4wqE5SkJfYfTf2rn5XKxqYOds5A
    0knNU/sM8+65DhSYAJB4LG4cfmVoWrkh0lTfbyMmyAeJ4O/KeQKofv/XUy3iyv9c
    u0HzmukwtOIEEXzXyaL9xhCCAjMH7EpU9iPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527626094; bh=66toWwYLFCyIMkh7TDYV1GTJTm1w7wp6a2r0sifr/b
    I=; b=i45dR8Fo1jqbiEMI+x1+UIA3IQGAvgCtZsAQDnjAhHq/MTq6yXQDmXM9Tb
    O3+U4QH4wXrWN9+xCVCLVhIPPMYbf8MzZ12SwUHdkL238e9APjB66c1LEPzILUSe
    T2R+EvngA72kw26r5krRspNNnHTwDyK/F997h0TEud3d3MtTPpyu+wjAX90a+cZV
    jRM7iv3fL4X5AiME7mGUAoNP7ASAxlntfemvT2aqpPO9niWa9jwyMGsUrpGWIN40
    r251vymYDamR/4B8yRBLVQsJ8nEtujlotLJIkK/GFC5moSTwV2U8bb8faXens5PH
    FohvtCwiKmxYFIbyBuOMIIUNlD6A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linux-foundation.org
    header.i=@linux-foundation.org header.b=CZweSAp4 header.a=rsa-sha256
    header.s=google x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=PkhArTjs;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linux-foundation.org
      header.i=@linux-foundation.org header.b=CZweSAp4 header.a=rsa-sha256
      header.s=google x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=PkhArTjs;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIpsoBxCoi2RFAQTysGEouiBbkMB1LJpojdPnuktM51sZCw039J2QZKXm+9SSbBjQEwznvNnbR6WlDuFe6+P4tMWDQXBX+nPUcW1mPwh3TUpOdKGST/l
    RYSD7fNi+QPl9fWXnCXF3oIIShztDRc41LEY5yCUaJnZgBzF6IxaBUsUhDl0VNh6jEjZQEqKkPAcHqJiNMGLGdnBpCJArrpugY2AFylJ2ylT1TJvsx2JZmw4
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=bw_HkS2fvF9Ary8DDH8A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966524AbeE2Ueu (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 16:34:50 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54097 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966480AbeE2Uet (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 16:34:49 -0400
X-Google-Smtp-Source: ADUXVKJc++6j0rBZMcixmKuogilzgtN9SOLULdLUYpywYUn37x3wtN+Z1WPZgi9fUaO75WSCbqhfB3xHX0O9Hk2LPJY=
MIME-Version: 1.0
References: <31071.1527602145@warthog.procyon.org.uk>
In-Reply-To: <31071.1527602145@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 29 May 2018 15:34:37 -0500
Message-ID: <CA+55aFxJXptHn4ddadqz2v_WqJHgf1vrVR6U9a31priYV1F+zg@mail.gmail.com>
Subject: Re: [GIT PULL] afs: A couple of fixes
To: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 8:55 AM David Howells <dhowells@redhat.com> wrote:

>    git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
tags/afs-fixes-20180529

Hmm. That _was_ a tag, but it wasn't signed.

I don't require signed tags from kernel.org, so I took it.

But since you *have* been sending me signed tags (with RSA key
FBB7576BA7CB0B6B), I thought I'd mention it and double check that it was
just an oversight.

              Linus
