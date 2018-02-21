Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1161423-1519205787-2-14107959582753616560
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
    t=1519205787; b=QlWhAK4p6QIUK2yoPmj+vSw539ESVCtt7J5Zo3blO1Da7eQ
    LYOPljWhgHII0ysyCYeTfmAcbxKEvQrolY0YZLMDGdBlo+SuM6EBqFu5vp1SJSs9
    vz1oM0+LsZ8rlxkQhZJHhHjk7wkhFHIHGxvPggQvMaG3phA4jmWpvOqm1Z036FOG
    CbDvu2IshlGl1LEH3bGiOG+X+s+ZWxmMkI52Us4IAJTgTqkEfyk1Sf5DA7eA4hD8
    mjiw//j3RKWH95RwpewH/BWl5WnZh9n+eGCyKiRzn1eUF/P4OUGZcf8TyITVqQ23
    DJ8H7KzPrTyaSw/udxM76VewxdzQ9Sv6jg6QBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519205787; bh=Sw9uhFWIiq2GrNKlr7uvrptC7r
    u/mb6rMgYqOS1NK3Q=; b=V1ls9NHYjE9pBk6IX3S1s8W8yGqdcYLfPzsOJOni1u
    h27ZNA0ck0eDyuqJ33FchV3bwbuyxRNdvtoNqyxApqBVO1YeYIGOloIF6tjTW7mr
    bH/Z/iDAJygy8BGnForsAg1ogTJFbF0hP+YYfe5A7S0z+aUpxIHasG2U00Jhr+mT
    V2/lPRSm0nCIjyobcC+hh57ogkcmvZONNq2jHad5zBTq5lvVOABoq+ux+FeEjiR3
    ZJ0pv15A94n0U1mDAYIuAhW+MBaL2ExOUJaEVI+BWjmcg2A+j54Uj4DPEMcPQdGM
    he89vOp3PqeZaZfr58qGyDh7i15XiR0pAx3T0H6mKDUQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbeBUJgY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 04:36:24 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50360 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753230AbeBUJgY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 04:36:24 -0500
Date: Wed, 21 Feb 2018 10:36:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [stable-4.9] x86: fix build without
 CONFIG_X86_VSYSCALL_EMULATION
Message-ID: <20180221093623.GD16575@kroah.com>
References: <20180215151710.1473117-1-arnd@arndb.de>
 <20180215164922.GB6699@kroah.com>
 <alpine.LSU.2.11.1802151104240.1652@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1802151104240.1652@eggly.anvils>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 11:18:21AM -0800, Hugh Dickins wrote:
> On Thu, 15 Feb 2018, Greg Kroah-Hartman wrote:
> > On Thu, Feb 15, 2018 at 04:16:56PM +0100, Arnd Bergmann wrote:
> > > I ran into a 4.9 build regression in randconfig testing, starting with the
> > > KAISER patches:
> > > 
> > > arch/x86/mm/kaiser.c: In function 'kaiser_init':
> > > arch/x86/mm/kaiser.c:347:8: error: 'vsyscall_pgprot' undeclared (first use in this function); did you mean 'massage_pgprot'?
> > > 
> > > This is easy enough to fix, we just need to make the declaration visible
> > > outside of the #ifdef. This works because the code using it is optimized
> > > away when vsyscall_enabled() returns false at compile time.
> > > 
> > > Fixes: 9a0be5afbfbb ("vsyscall: Fix permissions for emulate mode with KAISER/PTI")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  arch/x86/include/asm/vsyscall.h | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Thanks for these, I'll queue them up in the next round after these
> > kernels get released in a few days.
> 
> Thanks to Arnd, but please drop this vsyscall one Greg: it duplicates
> my/Tobias's "kaiser: fix compile error without vsyscall" that you just
> sent out for 4.4 and 4.9 review.
> 
> Arnd's PAE one looks good for 4.4 and 4.9 (well, in another context I'd
> object to using a different prototype in the stub, but I'm pretty sure
> Arnd feels the same way, but has made the appropriate choice for our
> Kaiser backports context): so please do take his 2/2 "x86: fix build
> warnign with 32-bit PAE" for both 4.4 and 4.9.

I've now taken the 2/2 patch here, thanks for the review.  Arnd, thanks
for the patch.

greg k-h
