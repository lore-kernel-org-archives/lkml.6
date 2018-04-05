Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3484267-1522953826-2-17359819047622747633
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522953826; b=lcPiP55F1Q9GKhnptaaEOZJEDkXbvv+TnmH3h5NMc4/9C5MQPq
    Fac28Hqznh2PsMXkrHPw/JBumTwN9/7J0+bVkRu7jd5WkxhvxwW77Ge+cpvqEzCG
    U4BWJZSbmAzZTf7/Ma4+oDH80/iapTzGAZb4zSryKtvdGykLN0PtGi8eiZaOiqGQ
    ft2pStHqPaXyoD0NvRPlVwmLA6SdT0w+6kqsLQ6/ZaP90+V+6LBohrcnk5mbaRvE
    mYoiA3ac/kJ11by1MMtYsKISEO6STI7X+X5N1AGT6m3IFk18mAc8983znFHpvRuh
    H7aYWpXzzrABlVkKAOEO7LmqKIIWkGfLDhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522953826; bh=DZqcsvjdGu8ok9xB3iUUclQrt0sAULOePRuvdEXd+F
    8=; b=ZQ5lv8JcW2n252HI5w9jWMZqeuU/fx0gDONpo4jyaDyZQVVzlg/2I0EW63
    DL/CX1jfSCfuyS+/omE/wEzIMIMNj40hnQlRNc8HfLUD84SZOchLvYCILzT0oaZN
    J6DvixgmZE2IWo1ukWu+XZ78BtZt+uhBkPAYwSF1Z6KDkqyRFhnAo9z83LOd0cA5
    rahvPXQLrOqU9voTh/gJvxZ0JQO8IC/dZFJUpPGVIb9wYcHIiz8Tq7Hb5+A8NcKr
    rC4YFEqJak34C6qpNCsnYtV/EFFBaSsLIBq9b1/APBlmW3ajUxzBRF/5cmR8Pw4m
    s1TW9/XBDkPJezj1zswJMBAMNV6g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U8NXEjdg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jNYc+qIw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZKdArE69;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U8NXEjdg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jNYc+qIw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZKdArE69;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIXxbHO4XSTno/QxxJvmpGL8gAKHhwYm9+fIt14Menj4Z1Vbv4Q1qekDvPFEqeA7KbfPsbrkKV0j46diW8Wj/JxV/p0ofNiqKAckPdm+53WvG7YOPFaE
    4hFRFVC2/bVYmPndrv09ca72gGYUOZkBvFQI+mqbIIRPDZ8hKM5crCucd+pbi1qFQadYPrwJLsMFX5EEyHpLVcm82DqU8yJJY+H7BV13ywUa/QqHv+sS13xL
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=rtfPk9mxSI2hQe7otmoA:9 a=aCecns5c_e8ZTv5y:21
    a=YQRc56bDYpsOld-C:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeDESnc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 14:43:32 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:41618 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbeDESn3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Apr 2018 14:43:29 -0400
X-Google-Smtp-Source: AIpwx483wBSyvhimilGuRrx1HY3NeBM4y4DjUoKb23/hJgRqvMAqkU/Fo1gmN45pYqS6LYNs+ARxuyBEIsP436mkaOI=
MIME-Version: 1.0
In-Reply-To: <20180405211945-mutt-send-email-mst@kernel.org>
References: <1522431382-4232-1-git-send-email-mst@redhat.com>
 <20180405045231-mutt-send-email-mst@kernel.org> <CA+55aFwpe92MzEX2qRHO-MQsa1CP-iz6AmanFqXCV6_EaNKyMg@mail.gmail.com>
 <20180405171009-mutt-send-email-mst@kernel.org> <CA+55aFz_mCZQPV6ownt+pYnLFf9O+LUK_J6y4t1GUyWL1NJ2Lg@mail.gmail.com>
 <20180405211945-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Apr 2018 11:43:27 -0700
X-Google-Sender-Auth: 3qYC2e4XU2TscrglRHB_xmJDn-4
Message-ID: <CA+55aFwEqnY_Z5T-5UUwbxNJfV5MmfV=-8r73xvBnA1tnU_d_w@mail.gmail.com>
Subject: Re: [PATCH] gup: return -EFAULT on access_ok failure
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
        linux-mm <linux-mm@kvack.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 11:28 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> to repeat what you are saying IIUC __get_user_pages_fast returns 0 if it can't
> pin any pages and that is by design.  Returning 0 on error isn't usual I think
> so I guess this behaviour should we well documented.

Arguably it happens elsewhere too, and not just in the kernel.
"read()" at past the end of a file is not an error, you'll just get 0
for EOF.

So it's not really "returning 0 on error".

It really is simply returning the number of pages it got. End of
story. That number of pages can be smaller than the requested number
of pages, and _that_ is due to some error, but note how it can return
"5" on error too - you asked for 10 pages, but the error happened in
the middle!

So the right way to check for error is to bverify that you get the
number of pages that you asked for. If you don't, something bad
happened.

Of course, many users don't actually care about "I didn't get
everything". They only care about "did I get _something_". Then that 0
ends up being the error case, but note how it depends on the caller.

> What about get_user_pages_fast though?

We do seem to special-case the first page there. I'm not sure it's a
good idea. But like the __get_user_pages_fast(), we seem to have users
that know about the particular semantics and depend on it.

It's all ugly, I agree.

End result: we can't just change semantics of either of them.

At least not without going through every single user and checking that
they are ok with it.

Which I guess I could be ok with. Maybe changing the semantics of
__get_user_pages_fast() is acceptable, if you just change it
*everywhere* (which includes not just he users, but also the couple of
architecture-specific versions of that same function that we have.

                    Linus
