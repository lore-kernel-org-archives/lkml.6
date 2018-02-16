Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-684122-1518802981-2-17949778006687286225
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518802981; b=fd1phW3lp9hRlothc59VwHjlcZOawKtVG4xxJrOUoOQCaXa
    us7BikR8/G2qcgG0pKsuo4RckpVqo4X1vtCNko3QuJhNGRfN1EviVT1RKNC4gXuR
    gCd72rag6dQfq+Rbtsvo/R0tV55R6XiDwSQD5N6FtAJgcdPVcH6HxKsigxZ9+8nv
    25xawJSroKttZ0BQJJAqmRMqZ2jNjs9Yo+VO8OzHHq7QIB86S7UckyCtTz52x/QQ
    FMYjYB5vSJXwuxFYg9hCVUOnRagV/2aV7nI+OuC0QIorF1USF5ap+GkiMudtkW1G
    RgO/uq2SaPdsAoR58F1uikWD72E3Mdws0IkfpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518802981; bh=s9ETC304pYBEJFWED6otLPzzvrq8uxwTDdn2GA
    sfJW0=; b=eA2HUVHy9XgaY8sJzTbrtP7qVvKqen2dLIwEaviaU5h//r1fL7SJH7
    kqbQNcoRuN+XK4szFlrK6IKgfyU4sWAgcajT7+Mhtchf+5xTBf+aDQ03/Q89OQBL
    9uM7byWssU3z1uCYray4lqsNtxVUQ5SZ1zGb8xqbJXgQnFw928F6Eot/LfnqRajf
    HldauM8nfSWWjYR+IyIPmDntDoYZQUw5VW62P7wdbFbOVSAOAtFs69nIx6hK5MPe
    Dzu9Mj1+w+Wko1N2bh33XfDL3kZqh5fIQ+fwFJpohybP8zuyyI9VIVpoxY7jfl8G
    AdJs4Qdt3QnoYuGnRHks7snLJEo2B15g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=f0Fqjk9E x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jq8BgZKL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=f0Fqjk9E x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jq8BgZKL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758870AbeBPRmq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 12:42:46 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:54602 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756035AbeBPRmn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 12:42:43 -0500
X-Google-Smtp-Source: AH8x227Rikc6d7sQQE4gsEgIqvaj63CTUd3GYYKNKOfGUGNq20+lCkvH0nV5rhgGTvmIjMBaGTA427tI+m7MhEcfVW8=
MIME-Version: 1.0
In-Reply-To: <20180216152608.1626885-1-arnd@arndb.de>
References: <20180216152608.1626885-1-arnd@arndb.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Feb 2018 09:42:42 -0800
X-Google-Sender-Auth: n8249BJqoAima_NRZOxNXfZBJNc
Message-ID: <CA+55aFxRo=X3_fb5JC55JjWt8KOWAdaMaBt5k5VPZhosT25WpQ@mail.gmail.com>
Subject: Re: [PATCH] mm: hide a #warning for COMPILE_TEST
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Jan Kara <jack@suse.cz>,
        Ingo Molnar <mingo@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Matthew Wilcox <willy@linux.intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, Tobin C Harding <me@tobin.cc>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 7:25 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> The warning is reasonable by itself, but gets in the way of
> randconfig build testing, so I'm hiding it whenever CONFIG_COMPILE_TEST
> is set.

Ack, looks sane, so I just applied it directly to my tree instead of
waiting for this to get back to me from Andrew ;)

                 Linus
