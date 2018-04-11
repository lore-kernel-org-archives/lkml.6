Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2304996-1523447646-2-11286837700699463306
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
    1523447645; b=TkhOetTRwpkvlyHB3uBsvZyMxYrs6QLBvWU8QQuC7v79oEZjkb
    jHtBNcm2VQ4Fcx0TAT4Yv0EUTKkqDehu4tmGgd8Khjbiuen9uallWeXQuYCjOX+6
    KB8x68Kqrk7yA8Qdw0WR4qHvMRRCtB+GsG6W86KLKTii/Iuys8FKpSdhCpzv5EaU
    dkB3O0IiO/yJHZ3R7vgatOZ47xiyGAVX5kvIFqXyknqSiGgmReJmR6/LniesAIVt
    HS/pAX90PGNCS3yL2EsSbOG6U5z88UA0dreT7r1h00t2TWjphfZh0Un2pAAJXf8V
    sTrBFD9ujcccm0LXpsR07Ufrny8/48qH3w3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523447645; bh=xcXKnQXijA4VRsLDKd9sNlzKdOWjuJ
    w6QTgQKW5GxCY=; b=kLkDNMfQyXbu0Xjc+0XUKemfH9leInkPEgGBlyPg1cEacY
    BRmJICiC2nyUMw+KMLqlBDhKF234UraumJjf9i9CB+UJiS3DPJ3L+Bs1jvwcF3I7
    HX8K1VkoR3FsPWryZ3Y08wQFQXgk3RGMXvchyyVo4E1O4vbUwRDAEmgA/L5SBVid
    ZFeKbM0iR4vZRSdx+nOqZiVnjWWNjr3tvYq70FTfG71jAEVLdyVI5ECD/gh1k4Iy
    9ljI89UazHTE6kXdP4VCdCy8/3zJvP9/gPX3O9CzhRaItLvDt9DbX8kXLthM3NDP
    1D9uavDkra/c6BnIqDYjRuox2KUovqvWuDzsedFw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JxVFRLeK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qUxxh2cf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JxVFRLeK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qUxxh2cf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNUzTmZ+HVa3V2G1WSFViT2ppFPy7GXZwSvtfvbdZXEvcAbrr1QOVajE9MeWu7EUdYORrBUzGYYUSgmcAx+ZsKb3Pxq9339tVJUa6g8z4v9dRb9ZcdmM
    oyHhWJKGLfVNXvwycirbMgTA88VjCTmzFpbWXtt6hFuv4MFaKvs4noMeKDBiDN6hKFcbaO0N+nxfoOAZb3J9SKzL412bML/sXWxbFOwzWojyZjqzZ/WN7evn
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=XurM9gvZ91SzJE9LI-4A:9 a=CjuIK1q_8ugA:10
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeDKLx4 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 07:53:56 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34921 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbeDKLxy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 07:53:54 -0400
X-Google-Smtp-Source: AIpwx4/O10r4MNkf00LJLpQhi1zvmIKsEi+3unZ1s6mFmIVjbBrJ+4SDnmQmskSRpmWJ8hWlq9LIng==
Date: Wed, 11 Apr 2018 13:53:50 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jan Beulich <JBeulich@suse.com>
Cc: tglx@linutronix.de, mingo@redhat.com,
        Juergen Gross <jgross@suse.com>, hpa@zytor.com,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [Xen-devel] [PATCH] x86/xen: zero MSR_IA32_SPEC_CTRL before
 suspend
Message-ID: <20180411115350.lvx5yaevoq6arwg3@gmail.com>
References: <20180226140818.4849-1-jgross@suse.com>
 <5AA8F00302000078001B15EE@suse.com>
 <6b59ac31-7e90-1c18-2467-d7d294da6e5b@suse.com>
 <5ACDEE5B02000078001BA2DE@prv1-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ACDEE5B02000078001BA2DE@prv1-mh.provo.novell.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Jan Beulich <JBeulich@suse.com> wrote:

> Additionally, x86 maintainers: is there a particular reason this (or
> any functionally equivalent patch) isn't upstream yet? As indicated
> before, I had not been able to find any discussion, and hence I
> see no reason why this is a patch we effectively carry privately in
> our distro branches (and likely other distros do so too).

The patch was merged 6 weeks ago and is now upstream:

  71c208dd54ab: x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend

Thanks,

	Ingo
