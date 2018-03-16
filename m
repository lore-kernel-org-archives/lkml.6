Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4051070-1521238438-2-1687286738065112047
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521238437; b=KwL//uyuID8Llh7FUQj9sagGqWHEymsmn8E1R9tPLWfVUQc
    NYbBsRi2iTdQG92G4Sm9L92q5rrHCeN4ln9/h+4Wr88n6x2oc8gg4u7llP7RNJNG
    GbOc3RSoKFAvXiOUfqrE1O6eR/VG4ahk8fM+LilcjiTEDDmh+xUs8rDM7nZu5wek
    e40YRbVzOcmdEdW7ziv3huiqGsSQV3Vh4Hd+D+zoEyaNoaOyYNsn2pCLYNtDjGH8
    21aLdOYcltpwY88K5MZEgeGOZu1Wn1ribT0foyEps9RGg5YE0pgO9NwM0uaA95sA
    r7wqG2LwFUq0pa3wEI0qnRMbSdLI1jgV2UpLtmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521238437; bh=y2ic19K+zmp8GQuxrD/ZNZ2Pnj0814LgVVN/xuZkHmc=; b=I
    eNnqUMJP1iJ9hoBnKTbQN/nTqBnu7M9dr6G1VSYzMnuqNhzRXGOKzSCk1SP385ba
    kkYA7vDLgff/wMEvulPromxTwMROdpvfrbtYoYjjrfKtt/76S7zKIJ20h0/84u3k
    5tQCnhMp0bJ6+6OQJ0qWej9/NZ/1necwlSwcm7wzbw71WrBS2b7nndql+dsvTmBA
    u3OrGEQ9L8xXsTD+P00ftxvshEeF0GVDWNWtfg29ashiQBJJPFNAsci3lDqrTKB5
    ur9MYKfXpw3IkZfgK/x0haUSnyWPFFf6hj0LXe2OPF9APiR40qfKcRjY2Xy5aPja
    f91mjTFPjODesOZrLL6IQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeCPWNl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 18:13:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752446AbeCPWNj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 18:13:39 -0400
Date: Fri, 16 Mar 2018 15:13:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Huacai Chen <chenhc@lemote.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
Message-Id: <20180316151337.f277e3a734326672d41cec61@linux-foundation.org>
In-Reply-To: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
References: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Mar 2018 15:55:16 +0800 Huacai Chen <chenhc@lemote.com> wrote:

> Call __stack_chk_guard_setup() in decompress_kernel() is too late that
> stack checking always fails for decompress_kernel() itself. So remove
> __stack_chk_guard_setup() and initialize __stack_chk_guard before we
> call decompress_kernel().
> 
> Original code comes from ARM but also used for MIPS and SH, so fix them
> together. If without this fix, compressed booting of these archs will
> fail because stack checking is enabled by default (>=4.16).
> 
> ...
>
>  arch/arm/boot/compressed/head.S        | 4 ++++
>  arch/arm/boot/compressed/misc.c        | 7 -------
>  arch/mips/boot/compressed/decompress.c | 7 -------
>  arch/mips/boot/compressed/head.S       | 4 ++++
>  arch/sh/boot/compressed/head_32.S      | 8 ++++++++
>  arch/sh/boot/compressed/head_64.S      | 4 ++++
>  arch/sh/boot/compressed/misc.c         | 7 -------
>  7 files changed, 20 insertions(+), 21 deletions(-)

Perhaps this should be split into three patches and each one routed via
the appropriate arch tree maintainer (for sh, that might be me).

But we can do it this way if the arm and mips teams can send an ack,
please?
