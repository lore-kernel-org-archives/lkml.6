Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2595178-1520534257-2-13760329397036101126
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520534256; b=s09g3PHrzgP6t+B4GcX5XDlPMPHe3ZxWcWFCNCo6ey+g9bK
    s95ReHhPahCXXY3oItrX3UmFTqQ7NIIxnQXKxZSzvvkORVB9ZPGbnFmPd85yLJap
    fMyYsj0M53Mb20tVivmPqRQIPlajS6S95K2+wA8zDAvhfxmziIrORZmg1ho2EwCN
    52Hej3R0mup7M7Dg2/I7K8SXcoAY3824kVZMK3DjEkBe9O7Te4ZW3vPB9qiWrESY
    FtsxsBzTW6imc5anqzEKv5k9n6sF8GR/479ePgL3OdBH4303KbcdRI1T3PF+0Vwp
    JMtrT3BgIQ+5LFBgXHGl9tt0qKdG/imJo0TUPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520534256; bh=j4q7rwCOSAfF4HTmvHmTzSdtpa
    BAXIIykTGESgfNmV8=; b=p3q/0N/2p8v8rXZANwQ++gxBYo78ZYwfG/oDtHjShU
    ExHlW+CmWac1boKEP/onYGBL5nF8tTngYExqAzcMPreQzermpfsuF1RoqiCeJFH6
    TWDQTvgc2JxqT2G53EQOSG4X3ZbvEdbMWneeE2ZCs8mzy4l4AdDSExhVziuui4Cl
    YD38ipsRjc8uRipAFyYkDGBD5DhynmRv2RdyKCFMyKjVpuAkAjjkUs+OPiAoOGV0
    6odpqCVy8Oc/d8KBDv9Te1i6B9CbUb0rTC8YVxz7qXXbEmekz511arx2fP6sjLV8
    jfUr0P0d7ElWZPsDToluGu161JIEKMDudDAauhSL1eMw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=eUZyZymk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=eUZyZymk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755905AbeCHShd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 13:37:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755624AbeCHShb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 13:37:31 -0500
Date: Thu, 8 Mar 2018 10:37:21 -0800
From: Darren Hart <dvhart@infradead.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Santeri Toivonen <santeri.toivonen@vatsul.com>
Subject: Re: [PATCH AUTOSEL for 4.9 025/190] platform/x86: asus-nb-wmi: Add
 wapf4 quirk for the X302UA
Message-ID: <20180308183721.GD11045@localhost.localdomain>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
 <20180308045810.8041-25-alexander.levin@microsoft.com>
 <20180308173914.GC11045@localhost.localdomain>
 <20180308174754.GA28545@kroah.com>
 <20180308181526.glcmj32nmu6c2hqk@sasha-lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308181526.glcmj32nmu6c2hqk@sasha-lappy>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 06:15:27PM +0000, Sasha Levin wrote:
> On Thu, Mar 08, 2018 at 09:47:54AM -0800, Greg KH wrote:
> >On Thu, Mar 08, 2018 at 09:39:14AM -0800, Darren Hart wrote:
> >> On Thu, Mar 08, 2018 at 04:59:01AM +0000, Sasha Levin wrote:
> >> > From: Santeri Toivonen <santeri.toivonen@vatsul.com>
> >> >
> >> > [ Upstream commit f35823619db8bbaa2afea8705f239c3cecb9d22f ]
> >> >
> >> > Asus laptop X302UA starts up with Wi-Fi disabled,
> >> > without a way to enable it. Set wapf=4 to fix the problem.
> >> >
> >> > Signed-off-by: Santeri Toivonen <santeri.toivonen@vatsul.com>
> >> > Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
> >> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> >>
> >> Hi Sasha,
> >>
> >> I'm curious about this AUTOSEL tag, and what about this patch triggered
> >> its selection?
> >
> >It's "magic"!  :)
> >
> >Seriously, it's close to magic, there's a tool that Sasha is using that
> >takes "machine learning" to match patches that we have not applied in
> >stable kernels to ones that we have, and try to catch those that we
> >forgot to tag for the stable tree.  Not all subsystems mark stable
> >patches, so this is an attempt to catch those fixes that should be
> >getting backported but are not either because the developer/maintainer
> >forgot to mark it as such, or because they just never mark those types
> >of patches.
> >
> >Sasha has a better write up about how this all works somewhere, and
> >given that this type of question keeps coming up every other week or so,
> >I think I need to add it to a FAQ somewhere to point people at to make
> >it more obvious what is happening.
> 
> It's pretty much a neural network that knows how to classify a "bug
> fixing patch" based on things such as:
> 
>  - Code metrics
>  - Words in the commit message (the NN knows about the 10,000 most used
>    words, and their likehood to appear in a bug fixing patch).
>  - Which files were modified.
>  - Authors of the commit, and persons who got Cc'ed/Signed-off/etc.
> 
> So in this case, there are a few things that "helped" this patch get
> selected:
> 
>  - The word "quirk" in the subject line.
>  - "fix" + "problem" in the commit log.
>  - Modifies drivers/platform/x86/asus-nb-wmi.c which contains mostly
>    quirks.
>  - The patch has minimal changes in code metrics. I don't have exact
>    numbers for this, but it seems that in general patches that do very
> little have more odds of fixing bugs.
> 
> And I also manually review all the stuff that get sent out, and to my
> human brain it looks like something that should be in stable :)

This is really cool to see, thanks for the effort here. Good place for the
application of AI/ML.

Have you considered having this work on patches submitted? If the machine could
respond to patches that don't have stable or fixes tags that it thinks should,
we could address this a bit earlier in the process, and perhaps get a more
consistent labeling, as well as get the maintainer eyes on this, reducing the
amount of manual auditing you have to do.

> 
> -- 
> 
> Thanks,
> Sasha

-- 
Darren Hart
VMware Open Source Technology Center
