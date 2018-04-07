Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-505030-1523131731-2-3713529282989480200
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
    1523131731; b=WIokIrWzpaHuQTeUCod6yqklJ+3N2TwgyvLzUKAcNpGy5gcv2q
    datFcBmmdluvmhAYgjLN57pa4Ws+56+vf3qDM1SHY5Nho0bqrNogwJFRlcJi8fwu
    CYe7BInLSb1KpS85E9ij8erq5powWeSItWrr40P7Rzw3oauXvENpJDBhaZaOc0Ms
    Nv3nAs+Fu0nFh15USRw0xkiuNe1Gb0j5qY6KHGoUDaabLttrU8rVaKSGR4zWA2yS
    eehBh7otqCSWQ4PTYSK3DBwC/P5KU50tYYSKYvFbC2m1ATrHs9bCGN583GxEpYVW
    8zYY6Exh7CK0vzxnnEG2LkDnbxJw/wkQjuEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523131731; bh=iJ2RT08B2NcQTYBWMT1XTLQGVQIibOgVykFYVFgaDy
    4=; b=vRY67LmptvxLCwtYrIiu0XKtwCwQmBjqeo6P5kK0FuKI2wov1Mgh9bnSls
    IDQwNfxzOP6o3S07GS5nx/PhNZSaG0yveQDmVIf6Xnqch7CSWgNcLcJ268E58FI2
    E7WV49+p3IsD893P2wbY3UdodkPbW+ZkMC9CEU94xHLGcZ7zyMKKKVkURZnrNSiR
    YEfhRUOHwtanA65Bz0j8G4YFOO63Wv7uXMRWGFWP9vQdZMbKBbvFJWrZQjCuxCBU
    9Np0A6Cfh+CpmRi+IikLz18d5DSpkb4OI5B7MKWfdr9j15Uw/5j/8BmMtghXGlL4
    hmvnPzzpq6EupfQDZfObinPnQrMg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VaWgUqg9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bU+hR/mi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=l8qhSnrE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VaWgUqg9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bU+hR/mi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=l8qhSnrE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI1asLnpmAmGx5EDYYIt68l/yuebGvYcdwLMkfTiOwSDjZwxMS+na0/Z5odkKAwvT/3Dgh+58Wlihgm3yXBZ50mD8f54QlybOXqzx4ZR1E1B1vUYqC4f
    g+THj1wORakGXEBcCaZt+tprb7hXx36euutk+HAQcZF8RKBJvpr1I9fQFVGOv1nYWAtbJklp+lpjAa0JLSNHomVx0n32HBAK6pXmAkE8I4mZwR1pY/fHmz+w
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=UiPhJQK3R-UMlHEniRUA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeDGUIq (ORCPT <rfc822;greg@kroah.com>);
        Sat, 7 Apr 2018 16:08:46 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:51622 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbeDGUIp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Apr 2018 16:08:45 -0400
X-Google-Smtp-Source: AIpwx4/77fmLpF3HM3WzoTaQuXpYVB1zgR3VuEEtlrr0FmYooyy+r54iX24jH7QOHiqf9zVIF92axuFyPYEvEXb8lWU=
MIME-Version: 1.0
In-Reply-To: <1522962072-182137-3-git-send-email-mst@redhat.com>
References: <1522962072-182137-1-git-send-email-mst@redhat.com> <1522962072-182137-3-git-send-email-mst@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Apr 2018 13:08:43 -0700
X-Google-Sender-Auth: 5Zoh6Ny7J_P3lgewqDlSXQHfudY
Message-ID: <CA+55aFywfktB83dERzYaC1NCYxD+Lg+NRft5ypjmbbcM_qdxpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm/gup_benchmark: handle gup failures
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        stable <stable@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 2:03 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>
>                 nr = get_user_pages_fast(addr, nr, gup->flags & 1, pages + i);
> -               i += nr;
> +               if (nr > 0)
> +                       i += nr;

Can we just make this robust while at it, and just make it

        if (nr <= 0)
                break;

instead? Then it doesn't care about zero vs negative error, and
wouldn't get stuck in an endless loop if it got zero.

             Linus
