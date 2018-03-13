Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2795102-1520935483-2-9225350245094118324
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520935482; b=aSQ0URY33tQiCQzwhVnlBxbq408FlWgN+16Us+1hk/Iw7Yk
    73Gcq41tKJlhKdBs3nSGTimulSCKgJRvn6jfnoWe/cPYH0C1rf36XSu9qNZiu7me
    p8tML3EJe7eCdc+LIhA4iEeGZml4EEdVvTb/uErDDF0yQH2D09eHOAAGKoSWxK3r
    ztaQLQ2KHEmKYZ9WlzzhetgXld/WXvirrvCr8W9OGEZrSfTv940H/Pm3STRcm1Y4
    vne/OOMH8/jci2UEkAUo2b2T1LUchM26MEzY0FF+C1kYXDHeCYh7bMZ8cT56j6FR
    dEStNwszKCHHJsTgyeg/H6Qmeff+MzWp/z7kcyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520935482; bh=mnlBd+VcBVT3Duuu8tlWj0leam
    RyYssq/cOtdbrZxrE=; b=Qm4QV4VIgjT7UwDVHSl0si5TA+7NbNbHRNnEbJfls1
    z7ajdBzOA6J6ZABKjzW98clwnMvxl8ZTkMBGwGMk+50I5JcQGLDdGXHS3jUTVTqS
    YsGCiREzxXY/5QVi4stx1VzL2i2wswWZmr3CXgnuun1gTI42t7/BjPZbNh+L27+C
    hi9b8S83GIbCUcnyg3rlRFLYiFjl4Oj5Khmbd5HHkxA+8dapL4OHMl6cWj9IoyPI
    DzyGlQI8B8LTMYTj7jVrsfD9WedZVhQhaJaDtuoBYJOlpqK1/JtxvBhcaZi/lgiL
    9Jo9O4/HTAEDNs7XEujUrsbGY0EA779FId7NQB8OmD3w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=DMYIvCN+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=DMYIvCN+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeCMKEl (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 06:04:41 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47921 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752181AbeCMKEk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 06:04:40 -0400
X-ME-Sender: <xms:OKKnWqKZjGsrmg4JQ952dp3ZCLxHCzZZ4Br7cNpoXpujg1xroltjUA>
Date: Tue, 13 Mar 2018 11:04:42 +0100
From: Greg KH <greg@kroah.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Alex Shi <alex.shi@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
Message-ID: <20180313100442.GB1999@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com>
 <CAKv+Gu-HdLkjYeNBQOW=JuWt3GjdZJFjyXCHCbGU01hkO81BNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-HdLkjYeNBQOW=JuWt3GjdZJFjyXCHCbGU01hkO81BNg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 06:24:09PM +0000, Ard Biesheuvel wrote:
> On 2 March 2018 at 16:54, Greg KH <greg@kroah.com> wrote:
> > On Fri, Mar 02, 2018 at 05:14:50PM +0800, Alex Shi wrote:
> >>
> >>
> >> On 03/01/2018 11:24 PM, Greg KH wrote:
> >> > On Wed, Feb 28, 2018 at 11:56:22AM +0800, Alex Shi wrote:
> >> >> Hi All,
> >> >>
> >> >> This backport patchset fixed the meltdown issue, it's original branch:
> >> >> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
> >> >> A few dependency or fixingpatches are also picked up, if they are necessary
> >> >>  and no functional changes.
> >> >>
> >> >> The patchset also on repository:
> >> >>    git://git.linaro.org/kernel/linux-linaro-stable.git lts-4.9-spectrevv2
> >> >>
> >> >> No bug found yet from kernelci.org and lkft testing.
> >> >
> >> > No bugs is good, but does it actually fix the meltdown problem?  What
> >> > did you test it on?
> >>
> >> Oh, I have no A73/A75 cpu, so I can not reproduce meltdown bug.
> >
> > Then why should I trust this backport at all?
> >
> > Please test on the hardware that is affected, otherwise you do not know
> > if your patches do anything or not.
> >
> 
> I don't think it is feasible to test these backports by confirming
> that they make the fundamental issue go away. We simply don't have the
> code to reproduce all the variants, and we have to rely on the
> information provided by ARM Ltd. regarding which cores are affected
> and which aren't.

You really don't have the reproducers?  Please work with ARM to resolve
that, this should not be a non-tested set of patches.  That's really
worse than no patches at all, as if they were applied, that would
provide a false-sense of "all is fixed".

thanks,

greg k-h
