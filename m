Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1185227-1520621071-2-14074385501789148849
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520621070; b=wvDq9v06taZ7Ivu+vObaLB60kR1zS/OtTUr7Dk+377RFI0q
    OBteNnRxYp3KQHYOIo+jF9r7wOFxqcRoeQys0j7+Nz12HaCy7o/WX5v3UWgfgezs
    s6xNJBld6NQ+99sP3IcKgq53j6nZCzQDevFLiTrn/0DA4b2c4WS16UWicg6wZY1J
    UtSNy5nz8/h8wyIPvPizZ3YhPsD5709fjPVGmZMmg3RHySmUxX6RJzCKrSuvQxdc
    i4M23jukPrHIjwRZ2Iiay0ztFz0hD9XKv8Z9tcPsYCFAa6mP4ZyJPxjkIfJR3ygh
    fUjx7wRXaIRpfmno8vLGHacKVd7COt0UehNiWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520621070; bh=9
    fMFaLH4/6+TFEhRGXNFkBJynRt9K2s7M35AIMBqDko=; b=QGdH4n19hfl/suZyl
    WW0hTsgcbiB0/o7KQvKCWia+mChJkL6uLYXPZoYNiNP8DuIh7juIjRpr308BLMkC
    d1zd7i0hnzYn7mbpa1pBOegG5VNlZ7SI0HOtnB6TQv7yATBURlqS8HenPPkaQVMN
    dslnAEQQigb3sdiE4y1xqhfJw8ExKOblD9a506+/3azbUnTjAjMf+8pZpzJVREjD
    Q5R8aUBZUIXu2RPcnWzfzXI41zmVxbD3Kt7PtP93AgUU204PkfPxsHtLpZPm/ul7
    Uhwmp+V0KkU9QGvC4bHo0em8zJYssx+aPahRRTXNbLopiXn87cF2CNWefbNuLcQZ
    RdAuA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UbC0silc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rmrOCol9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B6qEx0Z6;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UbC0silc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rmrOCol9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B6qEx0Z6;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELs4CA1A130fK//l+pTUIqGgRtyIe/42ZInxA4ahhdkGmztwkXMRlg5Cyxh+NSs4npJfU6TKtRoyIn8XuEXJkYg=
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+k6SkGP19EYxOAvwy+uzvkJ664_Lj_Rz5t8a6Fi60+JQ@mail.gmail.com>
References: <1520576470-20628-1-git-send-email-me@tobin.cc>
 <877eqli0f0.fsf@anholt.net>
 <CAGXu5j+k6SkGP19EYxOAvwy+uzvkJ664_Lj_Rz5t8a6Fi60+JQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Mar 2018 10:44:21 -0800
X-Google-Sender-Auth: PQePd1KGlVnHUZlY3RzwJea4dkQ
Message-ID: <CA+55aFzTa25jMx7B-NZ-nSbVV9Ee-UNpFungZNu8P=eKjJU=+A@mail.gmail.com>
Subject: Re: [PATCH] staging: vchiq_arm: Clear VLA warning
To: Kees Cook <keescook@chromium.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Tycho Andersen <tycho@tycho.ws>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 driverdev-devel@linuxdriverproject.org, LKML <linux-kernel@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 10:35 AM, Kees Cook <keescook@chromium.org> wrote:
>
> I think you mean ARRAY_SIZE(service_data) ? In that case, yeah, it
> seems like a raw "64" for the array size can be used instead.

I think 64 is much too big anyway. That's 768 bytes of stack data that
is used to check stuff deep in some transfer call chain.

So that code is broken from a stack usage model anyway. If it's just a
"random big number", then cut it down in size.

I don't know. The code was imported in 2013, and has seen very little
change since. I'm not sure how many users it has. But while changing
this, just do the stack size limitation at the same time.

              Linus
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
