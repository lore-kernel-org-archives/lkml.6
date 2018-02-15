Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-561476-1518673447-2-17805522580401914085
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518673447; b=PBEVXPIEnBuiKSHCa3xYLx9lmCh54DNpKRJuKzgojffkJ1W
    C0jF3tola2lIS2TLjLXmiw41S0YSmHETMCXpajJyaY8FsJZoBNAIvfFHNmSir9ZT
    PZ2+zZb1IzI3tYnO0VriOGZio7/M8yz6OnvNNs8PPGh241jJn6SoM0AxGVRG97/E
    4JS2pqdiQyp4rg73BZsGLUTbaRqyz4ltYt2RLiCjKTcF3TcW9CWwn5bCIuAnR34c
    eofvOb9e5JdcSZ1NUQqU9J2LbxvXis5VR7nAU3PPnggYuld3U2kAaVTfCbmYiL3b
    3OzubH6A1lx6bBPsN/VV67A1jwk2+BVYEtN622w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518673447; bh=DHeRc330dsqrFMNHyW1CFdprRy
    oh4A+UJZ9nMbLEEFU=; b=XTIGmEOn8wY2P3KQawgHjNSf9knTIvwb8f1jOTUrX9
    ZQ5Y4ku89Olp+fU09kxt/7Tv1ozZQBmS7F7jY3KVW9OMaSou9G+yG71+PviQMcX0
    wNpYHQod6YPVBiPe10skqFw3XXDm9Q498L6Ai2u3dqaNig44bMfZk2A3bcsQy+mf
    mKlAkRz4Crszn/YbCbrRmfxe0CPxCBtRbr9NUlaUKAmlHY0ZU8Go97XE+K3F6fXH
    HNEVep06mujzfVpq1JYW6VSWZRz1QplVgM9YCLq1U843bU0v4bf9Quo3lZ38dOKp
    hUTiDySnlH7J9z1iuU83VPsN2btIS+PqWVzTNUPFB19Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbeBOFoG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 00:44:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56122 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbeBOFoF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 00:44:05 -0500
Date: Thu, 15 Feb 2018 06:43:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/mm/kaiser: avoid 32-bit/PAE build warning
Message-ID: <20180215054357.GC7377@kroah.com>
References: <20171206141627.688219-1-arnd@arndb.de>
 <CAK8P3a0ZN2ALu1tj9sm8-Lt9SsRgpbQtz91zR4MhY-Np7TQNyg@mail.gmail.com>
 <af5124d4-b2cc-7d3c-5b8e-f7381859efd6@linux.intel.com>
 <CAK8P3a3pyM2FwHcAvFQckvbfqt7WvgRYSWE97pwLAtdvd77ToQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3pyM2FwHcAvFQckvbfqt7WvgRYSWE97pwLAtdvd77ToQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 11:12:24PM +0100, Arnd Bergmann wrote:
> On Wed, Dec 6, 2017 at 4:08 PM, Dave Hansen <dave.hansen@linux.intel.com> wrote:
> > On 12/06/2017 07:03 AM, Arnd Bergmann wrote:
> >> On Wed, Dec 6, 2017 at 3:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >>> This changes the type to u64 in the architecture-independent dummy,
> >>> and to pteval_t in the x86 specific portion that is used when KAISER
> >>> is enabled, ensuring that the flags can always fit. Unfortunately,
> >>> pteval_t is not provided by most other architectures, so we are
> >>> a little bit inconsistent here.
> >>
> >> I ran into a new regression with my patch applied, after doing more randconfig
> >> builds:
> >>
> >> In file included from /git/arm-soc/include/linux/kaiser.h:5,
> >>                  from /git/arm-soc/arch/x86/events/intel/ds.c:4:
> >> arch/x86/include/asm/kaiser.h:34:10: error: unknown type name
> >> 'pteval_t'; did you mean 'dev_t'?
> >>
> >> Maybe it's better to just to the last one-line change in include/linux/kaiser.h.
> >
> > Hi Arnd,
> >
> > Are you hitting this in -next?
> >
> > The newest version of this code has a single kpti_init() function that
> > shouldn't have any of these problems.
> 
> Coming back to an old thread...
> 
> I did some randconfig testing on 4.9.80, and now I see the same problem there,
> since that version uses the KAISER patches rather than PTI:
> 
> /git/arm-soc/arch/x86/kernel/ldt.c: In function 'alloc_ldt_struct':
> /git/arm-soc/arch/x86/include/asm/pgtable_types.h:208:24: error: large
> integer implicitly truncated to unsigned type [-Werror=overflow]
>  #define __PAGE_KERNEL  (__PAGE_KERNEL_EXEC | _PAGE_NX)
>                         ^
> /git/arm-soc/arch/x86/kernel/ldt.c:81:6: note: in expansion of macro
> '__PAGE_KERNEL'
>       __PAGE_KERNEL);
>       ^~~~~~~~~~~~~
> 
> I also saw another warning:
> 
> /git/arm-soc/arch/x86/mm/kaiser.c: In function 'kaiser_init':
> /git/arm-soc/arch/x86/mm/kaiser.c:347:8: error: 'vsyscall_pgprot'
> undeclared (first use in this function); did you mean
> 'massage_pgprot'?
> 
> I can send this as proper patches for inclusion in 4.9-stable, unless
> someone has a better idea or finds a problem

proper patches would be good :)

thanks,

greg k-h
