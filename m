Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-460432-1526287357-2-4353476300992704343
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526287356; b=DNAzNe7oHeadLEUq6R2F0HD37dgfKyd1iIVJpHuH5Fme4ICdLe
    LtJSDXXKGnmenrffoiUUD9xbipUbbo5Enj6q80BggF1LGty0uwEs9aR2+f8YGkfE
    yWLS+jQNd+A25utcpSUqjzX1Y8h8bLYqtdnJrGpANgagA2GA+zku+sWG00K7egT4
    WwBnqyogyqp8FZPDHO1YhkWp8GI7Nqcy0rShRjn/SzAzsjCqb/UmmFmN/3gui9C3
    wx/e0hnguMFq/LmsTiBv0yJvjA3dQ/DHrRJIQPmurXVn3bv/8X38d90Wqk4iCjBN
    nvklM49R18ww+H1uIuR6a8iF0J0Ag4W84wFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526287356; bh=rCKrwo294y3BSTPZ9uZyGbMdreWZbM
    16zb0m2JWkmic=; b=lu28EqCNhZLsWzUBnFyeF4qbqQvFbPn5OsadhIEvw4tDuC
    Uv59m+eQVs04PQYRmeZ+kTVZp5W9deh15afotTPRxLAUoprzoXqLItep0dBozOHt
    2DEt1UCfxECZvbhZibBNZ/Lu54B4oHvwpSBOQlVTC2jNgVyPTXSCar8z3UYNKBTE
    wtaOcBZAenq8XtAzR9fiqaQy1NNcJbMiXhSvVx83DngYLHz/my5O8F19Aqpfc7go
    K4SdCkxnDMEWVV2ZXZp0R4UZKinlO1Z4aGB5pLIyZAu9KGlnu/IgHDmRIGrkP3oH
    MSX4eFDcj3OFPGZRHjb7wV8elDRPadDj4ER0azow==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfETqFRngCTQ66uBLCKw+PWE0jN8WX+t8+Dckhituj+S/jbQlrasAMv9dD3u+oIbjW4l79WoP/q2e8KuDJuLsB//+lXXsLcg/6K4C91H5aEIdm7WvIONq
    QqrlIUtkNljdgVVGAeOuPj/m7Ru49VpjulyL4du9HjPUd3gRt7D29MjiZ6kPp4BHpAnl39iiRVrWj+Bqr7duQfWzBF3zSF91ookWJwFcu5N3dJTpLeMDUnNU
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=wLmoOJ-oirEA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=Jd-nlFYjHkL37VN1UjcA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbeENIme (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 04:42:34 -0400
Received: from monster.unsafe.ru ([5.9.28.80]:45118 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750810AbeENImd (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 14 May 2018 04:42:33 -0400
Date: Mon, 14 May 2018 10:34:39 +0200
From: Alexey Gladkov <gladkov.alexey@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        Ingo Molnar <mingo@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        aniel Micay <danielmicay@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, bfields@fieldses.org,
        Stephen Rothwell <sfr@canb.auug.org.au>, solar@openwall.com,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Djalal Harouni <tixxdz@gmail.com>
Subject: Re: [PATCH v5 5/7] proc: instantiate only pids that we can ptrace on
 'limit_pids=1' mount option
Message-ID: <20180514083439.GB28179@comp-core-i7-2640m-0182e6>
References: <20180511093613.GA1330@comp-core-i7-2640m-0182e6>
 <7c638a92-8c40-fa15-8c63-777232588137@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c638a92-8c40-fa15-8c63-777232588137@infradead.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 09:09:04AM -0700, Randy Dunlap wrote:
> On 05/11/2018 02:36 AM, Alexey Gladkov wrote:
> > From: Djalal Harouni <tixxdz@gmail.com>
> > 
> > If "limit_pids=1" mount option is set then do not instantiate pids that
> > we can not ptrace. "limit_pids=1" means that procfs should only contain
> > pids that the caller can ptrace.
> 
> Where can I find documentation on these mount options (pidonly, limit_pids)?

The documentation is not ready yet. It will be added in the next version
of the patchset.

-- 
Rgrds, legion

