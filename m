Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1161423-1519205810-2-5988177430493613450
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519205809; b=bq2ZfWNcdmzOcL6uNdCBxFOvya1cWw83Iy4Ga+Q7FgEurmt
    lHHEtMmKZGP3IAvsEi70hvABsruOKwWBkUTtlIIZgUntDOqJcK/aaahsGtKNh+lX
    SWzHkqnNUS4Vmho3SJBbJobudD0k+QdzyB4Dt27FxO930WAgdfqbCG4v4L0niKLv
    53cwkJPr4Pmp4m8KQegV39Yb5YvZGOSaOLmYdTbxk7zdQqBrB0BQU2J7ZkAhJ5uL
    ERZV8od3zhyUorpdJZ5HPYabORoOoISE3bSROY6gjoNCAC8iBCPCb17J9/e4yqmv
    G6TE4ykmLNN75at0mTLwOmOpQT72Ph5W+X9r6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519205809; bh=CpNR2Sb92kDsTV7ElLH5pYppFq
    LIlmCw2uGS06LeHjg=; b=aDXIjrLKp+rF9pYmB0XLUrZwKR84iU6wlZZ9P8BXXK
    GLPQNdY5MWW+jKin7SugJcumXzLcjU73QxAGc3DzVYu9ni/Rq4VTX43GDhWk3dqJ
    eVxVUfOt2Bx5RI3hTYj5qAuCQaaJiKZqVk/Kbx6eKr9aNz3cA7S4asDzo6MAEMCB
    0r9CZvJLNVAqH6r271xAQyXXxmzYskO/59nSu3JH3kwZybC7olQJNwufw3VU/mW8
    sYbFheIaj7jtiZ9iV8ykuXmPQ1DfSUvw9cMUi86lOr2lSlr3iRK3ljd/cfGMwO0r
    DZoxtfkw6sK2A43LgUCCHdLcV197lQ5+bnS4TbLNMjjg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbeBUJge (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 04:36:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50656 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbeBUJgd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 04:36:33 -0500
Date: Wed, 21 Feb 2018 10:36:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "# 3.4.x" <stable@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] [stable-4.9] x86: fix build warnign with 32-bit PAE
Message-ID: <20180221093632.GE16575@kroah.com>
References: <20180215151710.1473117-1-arnd@arndb.de>
 <20180215151710.1473117-2-arnd@arndb.de>
 <CAGXu5jKH1N3nqmRLnRiieGS-YpXj+dptDAB65ZgBWx+Ey3mCdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKH1N3nqmRLnRiieGS-YpXj+dptDAB65ZgBWx+Ey3mCdQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 09:58:00AM -0800, Kees Cook wrote:
> On Thu, Feb 15, 2018 at 7:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > I ran into a 4.9 build warning in randconfig testing, starting with the
> > KAISER patches:
> >
> > arch/x86/kernel/ldt.c: In function 'alloc_ldt_struct':
> > arch/x86/include/asm/pgtable_types.h:208:24: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
> >  #define __PAGE_KERNEL  (__PAGE_KERNEL_EXEC | _PAGE_NX)
> >                         ^
> > arch/x86/kernel/ldt.c:81:6: note: in expansion of macro '__PAGE_KERNEL'
> >       __PAGE_KERNEL);
> >       ^~~~~~~~~~~~~
> >
> > I originally ran into this last year when the patches were part of linux-next,
> > and tried to work around it by using the proper 'pteval_t' types consistently,
> > but that caused additional problems.
> >
> > This takes a much simpler approach, and makes the argument type of the dummy
> > helper always 64-bit, which is wide enough for any page table layout and
> > won't hurt since this call is just an empty stub anyway.
> >
> > Fixes: 8f0baadf2bea ("kaiser: merged update")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  include/linux/kaiser.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/kaiser.h b/include/linux/kaiser.h
> > index 58c55b1589d0..b56c19010480 100644
> > --- a/include/linux/kaiser.h
> > +++ b/include/linux/kaiser.h
> > @@ -32,7 +32,7 @@ static inline void kaiser_init(void)
> >  {
> >  }
> >  static inline int kaiser_add_mapping(unsigned long addr,
> > -                                    unsigned long size, unsigned long flags)
> > +                                    unsigned long size, u64 flags)
> >  {
> >         return 0;
> >  }
> > --
> > 2.9.0
> >
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> I assume this is needed for 4.4 as well...

Yes, I've added it there too.

greg k-h
