Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-375971-1523518346-2-16855001409003430006
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 2.361, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523518345; b=HAzgt75XvEjl9RZ0MNbKrQemEvGwjZTCjF5Bv6dag7NbeFDcw0
    +gLaTStBl3ug49bVJYcJfhF2o07ORkdGoJoVzA1kJWHm8IRw5qooPsSx/uz8re+V
    USOkaa4hNYhtjjXmPry2PFb97t9UeRxXcNu2vHMoj22rTGpNOvpFCl6sBId/Tcxa
    +/wRy5gQpSpd+1X6HvZU2YMvjV8eq+Y7Zn9FO/rOK29IgNlUtXr5n19GAssse6AK
    Bp3i0ghEvNTTveWzhbF/OSbxStXO9OLK0a6qzl4Vh8Kaut+NYD9aP94MpfQyykRg
    atsyBySSVjCbZ9bRU8984QaBNC/Stvh7aqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523518345; bh=kKoW4P3U11t+nZlqEw3caFvSam2tA0
    ln/LTQdJ8UJ8E=; b=LY90w3wIMnGx+/OARWu3u1JpfUSzam2bxaEPR+Bs3kEyra
    s1hjuMSX8E1uoe9KOmMvf+xsTK8+pRKXwqzSo0zD/rUHvyR17DSAmy5N8QU7PXCH
    V/i6fYPiTxl3nN2d+9kdIS5jf+e8voVGpa1zCbF0dWm/jpD/2CijMHnqGcd9GI77
    YHQfMuXiv7Y/9bGeDcTs0zLEWtWjMFlggTpvRzZ0qqo0Fc5NJH2ATzTtX7TE5SPb
    9ZookwCsHkPj3BWVCmpEs7nlEwjtsXe3hv/yjpmGrP8UgO9D9NPzaVTSvyroc7uO
    6tW3wIs8svSF266AKuemrUEaLgqztDTwylWQ3awA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J9PN29vh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pcJihsuU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J9PN29vh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pcJihsuU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNbEDODcLAghbTjkuv3RS+0Fkv3tTW2U3r5hhSnmQ/+qVPfGNpoFKp9cq6PHgmzTJjGFJMY/FhsERJ2vc6t9YzR1H040hgOHl6zWQU4ZBz4JXCDQIf8Z
    WpH9pl55bMxM3YHT3LUrnN7j8kB1ysNLac04krXEhWboFlk1DQs9TKDlmN5VwRy4wQS5LPD2jBscktGVqKpmYxbI3Vkwlfqp6AhJo1OpZTHVsD9t8pW8eci/
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=oF3DJRrGEghjypV7kDEA:9 a=CjuIK1q_8ugA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeDLHcY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 03:32:24 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42577 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752041AbeDLHcX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 03:32:23 -0400
X-Google-Smtp-Source: AIpwx4+XKpdYTBD0rx+lrI0PH0LT1K8/H/UFyQUTuZpwwi4ebH7w8a88ftlTbXcsCEU7w6bFxJdpLw==
Date: Thu, 12 Apr 2018 09:32:19 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jan Beulich <JBeulich@suse.com>
Cc: x86@kernel.org, tglx@linutronix.de, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, mingo@redhat.com,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, hpa@zytor.com
Subject: Re: [Xen-devel] [PATCH] x86/xen: zero MSR_IA32_SPEC_CTRL before
 suspend
Message-ID: <20180412073219.2h5fqc7megvepoa6@gmail.com>
References: <20180226140818.4849-1-jgross@suse.com>
 <5AA8F00302000078001B15EE@suse.com>
 <6b59ac31-7e90-1c18-2467-d7d294da6e5b@suse.com>
 <5ACDEE5B02000078001BA2DE@prv1-mh.provo.novell.com>
 <20180411115350.lvx5yaevoq6arwg3@gmail.com>
 <5ACE149E02000078001BA424@prv1-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ACE149E02000078001BA424@prv1-mh.provo.novell.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Jan Beulich <JBeulich@suse.com> wrote:

> >>> On 11.04.18 at 13:53, <mingo@kernel.org> wrote:
> > * Jan Beulich <JBeulich@suse.com> wrote:
> > 
> >> Additionally, x86 maintainers: is there a particular reason this (or
> >> any functionally equivalent patch) isn't upstream yet? As indicated
> >> before, I had not been able to find any discussion, and hence I
> >> see no reason why this is a patch we effectively carry privately in
> >> our distro branches (and likely other distros do so too).
> > 
> > The patch was merged 6 weeks ago and is now upstream:
> > 
> >   71c208dd54ab: x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend
> 
> I'm sorry, but no, this isn't the patch I was inquiring about.
> Instead I'm wondering of the disposition of the patch disabling
> IBRS around a CPU going idle.

Got any specific link or subject line for that submission?

Thanks,

	Ingo
