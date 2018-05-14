Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-519562-1526288955-2-12690581838804503523
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
    1526288955; b=SJs3rQ0Swa90zm3HXG34s0ky4hQ4hm4yFL6Jon6GbktVEm6cIh
    jcI0jBPcUCY2ScgU810q6oceHG4NWyX4L3ZZ00JLCuNuWZMSiozWGdeArgEwY2tb
    0VvUit1BbRQI3FO3YEkH9Scf75JvHXdKXWifumOSfyjssgygnMeTAKFuys6gYqy0
    CgjCgeEkAyrOJjOxaVuQ2jBIBOsnHbv5o3Ibg4OS3E3V85UvYA9ggoXZMM53/chq
    t+XmgOBs+VTl4jb9MVb3SYWsmxybKAfX3Vq6LHhRnduJRBB/HumYNqtki9cHj/EN
    V2Bzer0f/b7L/AiA/eaC7iGqnhBeYKfOVfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526288955; bh=oehUTNBJezJty/aoaXYwloClC+6ZJ8
    /SJOgatT0E4Xs=; b=GoPTGecSQofrlxTsjWtyvqXS9JASbbTxGoXFELadx7+HZo
    00HbK3FaAjbbzeQNbDyWUz0srPZCumMk5c9I4gUPnyaoYFARDuidpq3NfzAfznMI
    qugIudrpi2e29WxAYImAl7GmnrTwz/s7izuakdUp4R4XP1ToYsKDEgPJp9XQq7jn
    lspyyeKskiMZSaBh1VQHlYCkXCFuq0YkvqzVYZ6YMgWAtV9jEZMEU9u/9UNaYae7
    DIawMER5PA4JInJs9ctm9FFlNJ8py/Hsp5aAGydh09QG4vefyvwkLfsr4LZb3wy5
    aoqveMDxF9DPuMeHjlYG52fWmRI/nTR0S8oAXKDA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfAiDSF6H4nBv5FvO1NbvyyaivXQIbkWnM6TNRYswu0qTD85gGy4KXvsOeadaJtUVoZBW1UBZbaBo0FMFHXTCw1K5UoK8XAkPc1EECdApsyEeiMeh6IkC
    sh5pzvuhb2cNME9WjH9+7HqUQDJeYLwvT41gpnMbY2ECpPyKkL8xrf8zfJniHo0HuWweyV496tooCTnePdQWvsJXcroiV6QP/ournaQ5nKuK8acFJubYO3to
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=wLmoOJ-oirEA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=hTd73hWayHQc-imAXzoA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeENJJM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 05:09:12 -0400
Received: from monster.unsafe.ru ([5.9.28.80]:54410 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751617AbeENJJL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 14 May 2018 05:09:11 -0400
Date: Mon, 14 May 2018 11:01:17 +0200
From: Alexey Gladkov <gladkov.alexey@gmail.com>
To: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
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
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Solar Designer <solar@openwall.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Djalal Harouni <tixxdz@gmail.com>
Subject: Re: [PATCH v5 7/7] proc: add option to mount only a pids subset
Message-ID: <20180514090117.GC28179@comp-core-i7-2640m-0182e6>
References: <20180511093707.GA1403@comp-core-i7-2640m-0182e6>
 <CAG48ez0bXvp1iF=HqyhEP1p5B6PRR07_j0qRoypJqs8x3Z+=mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0bXvp1iF=HqyhEP1p5B6PRR07_j0qRoypJqs8x3Z+=mw@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 03:58:39PM +0200, Jann Horn wrote:
> On Fri, May 11, 2018 at 11:37 AM, Alexey Gladkov
> <gladkov.alexey@gmail.com> wrote:
> > This allows to hide all files and directories in the procfs that are not
> > related to tasks.
> 
> /proc/$pid/net and /proc/$pid/task/$tid/net aren't in scope for this
> protection, even though they contain information about the whole
> network namespace of the task, right?

Yes. The pidonly makes visible only pids subset. You can still access the
process namespaces via /proc/$pid/ns.

We can think of additional constraints since the parameters are not
stored in the pid namespace anymore.

-- 
Rgrds, legion

