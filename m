Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2005596-1520009659-2-3938483660567751895
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520009658; b=WS4AtNhsSOwUnYN0wkXVzJyrSJ7C79QLbqjUYcvtIpdSLLf
    Z+b2LKDWvhB8Z4Ft3D8D8v5Xu1QyM4pRmtTNIufRa+GY8XuskH4nedqRAOUEpEyX
    zYQsFmIb29unlZsurOMIrMTyxlGkIl1NMhyqZ0qIKsxQgcB+Arc+QPrPPiV3Ddt+
    IiB7NBMiVSIz+LxOkWoLnocpjibqPWnqfx3b7P2IJL1n8BGTytimRWuKD6mH63NL
    ybsf9KQ1/FS2EIe54/CkllJuaYhDOEX+0DBI26yUSruxe+W41v7K3ab703v16ISH
    inlS4ipwMrn5eUGWec67szW6Qho7SwxWiH3Ynvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520009658; bh=Xq79OzpWqP5UkHt0eAmSfaUJzU
    etOuGLJLLkMITrBR0=; b=ostozD0eJLxz7nHFWrMeYHCCHv58ORfpv6rHUUxdH1
    otmUopy0KTeDFZ6IV+BIPD4bnDOtp518wuOA08AXi+V5g+bcAp8iiUcs5b5dVV/2
    TnqvzK/rW9+9Ke10vxDnCC8JNGVEWCI6Pc1gz0KW3CarfvIOETtpwxI1vchiBwtO
    z8+gNsH2v85koMczcccJdFITy4VYX7YCskEVOxvAp/CvKJpEqaaHe2vg/bVLSC+s
    IljK0zO0i6p5Y4JgVr+G/HfNp4m5oACvoQe3LwFbtlzoQy9ravsUp+ZkQRMdNoXO
    iHR9DnGN3K1DSkrhoA2W1WIi5bjZDvsNybIRnXFxGsZg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=T9nu6H/s x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=T9nu6H/s x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424050AbeCBQyP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 11:54:15 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44593 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1423840AbeCBQyO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 11:54:14 -0500
X-ME-Sender: <xms:tYGZWhHY0-LAhvBcui4viAnqfBWy0xJEiRDlidnAttxsrHZ3hlpDzw>
Date: Fri, 2 Mar 2018 17:54:15 +0100
From: Greg KH <greg@kroah.com>
To: Alex Shi <alex.shi@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
Message-ID: <20180302165415.GB8704@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 05:14:50PM +0800, Alex Shi wrote:
> 
> 
> On 03/01/2018 11:24 PM, Greg KH wrote:
> > On Wed, Feb 28, 2018 at 11:56:22AM +0800, Alex Shi wrote:
> >> Hi All,
> >>
> >> This backport patchset fixed the meltdown issue, it's original branch:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
> >> A few dependency or fixingpatches are also picked up, if they are necessary
> >>  and no functional changes.
> >>
> >> The patchset also on repository:
> >> 	git://git.linaro.org/kernel/linux-linaro-stable.git lts-4.9-spectrevv2 
> >>
> >> No bug found yet from kernelci.org and lkft testing.
> > 
> > No bugs is good, but does it actually fix the meltdown problem?  What
> > did you test it on?
> 
> Oh, I have no A73/A75 cpu, so I can not reproduce meltdown bug.

Then why should I trust this backport at all?

Please test on the hardware that is affected, otherwise you do not know
if your patches do anything or not.

> > And why are you making this patchset up?  What is wrong with the patches
> > in the android-common tree for this?
> 
> We believe the LTS is the base kernel for android/lsk, so the fixing
> patches should get it first and then merge to other tree.

But you know that android-common is already fine here, the needed
patches are all integrated into there, so no additional work is needed
for android devices.  So what devices do you expect to use this 4.9
backport?

What is "lsk"?

> >> Any comments are appreciated!
> > 
> > You need to start versioning this changeset, as I have no idea if this
> > is the "latest" one or not, right?>
> > Or have you not sent out this patchset before?  How does this interact
> > with the "spectre" patches?  Or am I totally confused here?
> 
> It is the first patchset for meltdown. Yes, I will resent this patchset
> with versioning after the renesas board booting fixed.
> 
> The meltdown and spectre is 2 different bugs, the fixing patchset are
> isolated each other. So I did the backport as 2 different patchset. And
> merging them together is relative simple. I will comming with a merge
> patch next time, after the meltdown patchset ready.(the kernelci didn't
> works well in recent days)

I don't want a merged patchset, but having one dependant on the other is
just fine.

Again, test this on real hardware properly first.

But really, I don't see this need as all ARM devices that I know of that
are stuck on 4.9.y are already using the android-common tree.  Same for
4.4.y.  Do you know of any that are not, and that can not just use
4.14.y instead?

thanks,

greg k-h
