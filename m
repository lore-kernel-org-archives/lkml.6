Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3161771-1520947526-2-8732372426914764218
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
    t=1520947526; b=p9xHbVIW3reEqwA2jDR/tjKNIm3okB7L9qiN/cYkGySkVZ7
    Pq5VY1/JjdxAMpe0NS2iOlHSpVT+YZQ76UoY6cal0C5ZQW3qC88QWJqGb6LuChZo
    LdoQfOPi9s/vQjh3jFYsgDd6wermVa4ohOp/txiqprLV1OSyXkYx4C5uzMSy2Qlb
    1FoSI3k3VSNNsCTSs6SBtMFEqra71XC3zYTBa4ezdolNZI0eBSGTPL0EUyVDUpJ3
    b5s7DZUnCvyS2R0mdC50E2td2fFDSJ9VHShjWWv3AGfqwLKm7qXmXbagRgq3Hjyx
    BMlxassCog9aBQzekjeQal6HdYoratrS1/L/kew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520947526; bh=1oOMD+IPXw58dOYOyIjBLVzKFy
    le6cm3xYISX41Rn5w=; b=eMRbmXt7j73IuboZNH5USzBKTsaWcTU5vfaQl/HR35
    vPC7KRdUfM2jD6YzbdhJMQBgbh4FaJn1uMwFUhQFrWI8e4uwrMlNJCV5JNy2Uxku
    CwRwEkQK2Ybj4mTp3vtnr+tmSrvRHA+aVKTeVyerHi40RANOEcvwr1/cv2fG6jLF
    P4kfkKO6MQzSjF2NmrbGfYLZsfgt/zGpVfN47NS4EvFkRbwItiHJG5bfQv7EvDFf
    L10OeJrkwuA7zZGXgi/HcJ5GTFZrJGqpbZnGAmhnY80Zf4ixGq5xnoQKUmJ+Xegx
    1FfMfKN/R7//F5x6U/l6nanaIA/FWUG5k9ss32k18dqA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=LAAEzRoo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=LAAEzRoo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeCMNZL (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 09:25:11 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39103 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752084AbeCMNZI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 09:25:08 -0400
X-ME-Sender: <xms:NNGnWq1qDx2TqAQCrZ_fVx9qhG7vbBZ724Jx2SCz0KT48dj3shrhEQ>
Date: Tue, 13 Mar 2018 14:25:10 +0100
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
Message-ID: <20180313132510.GA3629@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com>
 <CAKv+Gu-HdLkjYeNBQOW=JuWt3GjdZJFjyXCHCbGU01hkO81BNg@mail.gmail.com>
 <20180313100442.GB1999@kroah.com>
 <CAKv+Gu-v6U49_OZyt6HHmCJ7srYnNw040LpVkFnzx+BGKVC0aA@mail.gmail.com>
 <20180313103843.GA29908@kroah.com>
 <CAKv+Gu8ratRYnGzNm5qppUetEFt4Dief_3_Dj6yaW==DJemeHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8ratRYnGzNm5qppUetEFt4Dief_3_Dj6yaW==DJemeHQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 01:01:43PM +0000, Ard Biesheuvel wrote:
> On 13 March 2018 at 10:38, Greg KH <greg@kroah.com> wrote:
> > On Tue, Mar 13, 2018 at 10:13:26AM +0000, Ard Biesheuvel wrote:
> >> On 13 March 2018 at 10:04, Greg KH <greg@kroah.com> wrote:
> >> > On Wed, Mar 07, 2018 at 06:24:09PM +0000, Ard Biesheuvel wrote:
> >> >> On 2 March 2018 at 16:54, Greg KH <greg@kroah.com> wrote:
> ...
> >> >> > Please test on the hardware that is affected, otherwise you do not know
> >> >> > if your patches do anything or not.
> >> >> >
> >> >>
> >> >> I don't think it is feasible to test these backports by confirming
> >> >> that they make the fundamental issue go away. We simply don't have the
> >> >> code to reproduce all the variants, and we have to rely on the
> >> >> information provided by ARM Ltd. regarding which cores are affected
> >> >> and which aren't.
> >> >
> >> > You really don't have the reproducers?  Please work with ARM to resolve
> >> > that, this should not be a non-tested set of patches.  That's really
> >> > worse than no patches at all, as if they were applied, that would
> >> > provide a false-sense of "all is fixed".
> >> >
> >>
> >> I know that on x86, the line between architecture and platform is
> >> blurry. That is not the case on ARM, though.
> >>
> >> Unlike platform firmware, the OS is built on top of an abstracted
> >> platform which is described by ARM's Architecture Reference Manual. If
> >> ARM Ltd. issues recommendations regarding what firmware PSCI methods
> >> to call when doing a context switch, or which barrier instruction to
> >> issue in certain circumstances, they do so because a certain class of
> >> hardware may require it in some cases. It is really not up to me to go
> >> find some exploit code on GitHub, run it before and after applying the
> >> patch and conclude that the problem is fixed. Instead, what I should
> >> do is confirm that the changes result in the recommended actions to be
> >> taken at the appropriate times.
> >
> > To _not_ take that exploit code and run it to _verify_ that your patches
> > work, would be foolish, right?
> >
> 
> Oh, absolutely. But that presupposes access to both the affected
> hardware and the exploit code.

If you all don't have access to both, then someone is doing something
seriously wrong.  Go complain to ARM please, we all know they have both.

I just got done yelling at a whole bunch of vendors last week about this
whole mess at a very large meeting of a lot of different Linux-based
companies.  It's crazy that the disfunction is still happening.

greg k-h
