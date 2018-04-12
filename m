Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-461662-1523520532-2-6163784483517688978
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 2.361, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523520531; b=WGMLStW/2VGvQ+GI114Po0k/skYK35OZMvz27X4wV396grCwx9
    3FTn9d+InnchP3XDdyiP3mM+0FzyHvEmRdCSu6Y5ld27FTG7T2HUqD+IFYf2Rt+M
    cjYYsZgXiq8/eTa8W9TDrxi0Yy5iQye/dCPQUpDeKkyE9C0f6HGuM/mpTLn5MkyH
    Rt8QXZu62nl5ta9BEFaeu5qFp+T/5xBxu1zao4WWICrs+q0jeTVF6Cgq+0rmfN4V
    ZoPZC4Gp8r9fSwNc23iHoAKVy33bjiMeIveKCLvAIWwrJiMilpdiwaYt4ggo62j1
    HAWDl9FBlMDXinAHuiiUN8XLLaj1zbXIMn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1523520531; bh=EAy4s2/PiGT
    wUAEqBJlTC+F59YeuEJ4L89vmuzLRzrU=; b=CrH6zajeJKgZFAjv4GtqZ2U/foo
    4ydLcsd2xA1Y3XSEYWSDKPnEFmhYAmXQjZIRon3T0V18i6p9qM51h4kDKKQ3PZcV
    FXmd3iulrRqQQQ1TtYPNR5iPWRxn5vriDc4MoDyx1RsKP+DIr69H9+u43H5xf7AD
    JXl9CezzBCVCNEZL9oSrUXr0FFnD1CKMALgYE+QtuFiuZ95G6+vd4i54M/tr/3KW
    1M+hHwExh/0IikbpxzpjUxVT+5Dzb0yn/VyDMBquSNZq8ri7eIO8cc11PxB2eage
    lqhx5wxC/eppaHNsxLcjbhLKXTM73dPNbI2HllGtLzmM+c3G/OKZIMuFmNg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fCUbHYHL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DQiI1s9b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fCUbHYHL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DQiI1s9b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBxgymrjVB2Q12x06CIPDT0d1CxdFUUuXO9kTN2oKTV4DB/ozxnyoJ0AkWkqfNEE0sjzaVCEPHvVH74FAcZrcMJzncDWRwvt6eNJlOvYgfx4zE/6hohf
    hh7N3+8+4iWVPWNEQoToulxYKf3je1J8Nb/v3VsTE7smRK+l246Au69JVVopEgAjE9WIE38QNH6Mw82IcYr5tDwdyMYm7/0u9X8dMeYx9nNwNCEBZN1WLFvx
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=1lqJhr1z2IOy2p4h_PUA:9 a=wPNLvfGTeEIA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeDLIIt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 04:08:49 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36662 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbeDLIIs (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 04:08:48 -0400
X-Google-Smtp-Source: AIpwx4/flK3CCwJbdqluNlkeMH1oG0/Yiftr7fpDzmRZCM2zixMvj21cTeQrZeBq2SNeaJhFatS6tQ==
Date: Thu, 12 Apr 2018 10:08:44 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jan Beulich <JBeulich@suse.com>
Cc: x86@kernel.org, tglx@linutronix.de, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, mingo@redhat.com,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, hpa@zytor.com
Subject: Re: [Xen-devel] [PATCH] x86/xen: zero MSR_IA32_SPEC_CTRL before
 suspend
Message-ID: <20180412080844.mof7ukyeuhd3dsoq@gmail.com>
References: <20180226140818.4849-1-jgross@suse.com>
 <5AA8F00302000078001B15EE@suse.com>
 <6b59ac31-7e90-1c18-2467-d7d294da6e5b@suse.com>
 <5ACDEE5B02000078001BA2DE@prv1-mh.provo.novell.com>
 <20180411115350.lvx5yaevoq6arwg3@gmail.com>
 <5ACE149E02000078001BA424@prv1-mh.provo.novell.com>
 <20180412073219.2h5fqc7megvepoa6@gmail.com>
 <5ACF2CB002000078001BA984@prv1-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ACF2CB002000078001BA984@prv1-mh.provo.novell.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Jan Beulich <JBeulich@suse.com> wrote:

> >>> On 12.04.18 at 09:32, <mingo@kernel.org> wrote:
> 
> > * Jan Beulich <JBeulich@suse.com> wrote:
> > 
> >> >>> On 11.04.18 at 13:53, <mingo@kernel.org> wrote:
> >> > * Jan Beulich <JBeulich@suse.com> wrote:
> >> > 
> >> >> Additionally, x86 maintainers: is there a particular reason this (or
> >> >> any functionally equivalent patch) isn't upstream yet? As indicated
> >> >> before, I had not been able to find any discussion, and hence I
> >> >> see no reason why this is a patch we effectively carry privately in
> >> >> our distro branches (and likely other distros do so too).
> >> > 
> >> > The patch was merged 6 weeks ago and is now upstream:
> >> > 
> >> >   71c208dd54ab: x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend
> >> 
> >> I'm sorry, but no, this isn't the patch I was inquiring about.
> >> Instead I'm wondering of the disposition of the patch disabling
> >> IBRS around a CPU going idle.
> > 
> > Got any specific link or subject line for that submission?
> 
> Sure, as written in the original response to Jürgen's patch:
> https://patchwork.kernel.org/patch/10153843/

Argh, indeed you did!

In any case, this submission from Tim Chen:

   [PATCH v3 0/5] IBRS patch series

Contained a glaring bug in patch #2 which Thomas pointed out, and AFAICS the 
series was never resubmitted to lkml so it got lost.

In any case thanks for the reminder!

Thanks,

	Ingo
