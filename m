Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-382606-1523519638-2-2080146056402670722
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523519637; b=B7YJX42J4hHfSrN+ldYB/2/Ai/iGa9IdrdesOndWBsBbt6EJla
    mHy71mmfBaGLdrdIDM9XKyant651yJ2E5NvZMYYWRvo4pl3LaMQ334Gj0nsEqSIp
    +wGxqde5jpwrvFt2C8YCFaJNGcsiwtx7xpW6azoKmV9KgvxHp78K2dH6cGWyDwsM
    twnlBp4NtjTSslXxM8W/q8iRYpG9LA1xI++dmdj5z5RwwyJENa+S257md5xJbm2v
    NDDAuko8bchuZTVgvRFMnb2JKfJ4QC1dIPq8F1NVGxyknmAito7hzLs83uFsLzYu
    D++advkeqCDoTULPmCOa3AhY4jlGyKY+OQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:in-reply-to:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523519637;
    bh=pfspkVgzxn9Eg8MphFY1AgTZe1iUhSWkInw81816MPU=; b=oDHhFp5Dhg6f
    45hcLHtA4XFtEbxgPOhxwoe/i5HloHHf+lLbb6n5Fm7PnUXqDV/LOxGP5kQlJedz
    5YUrSJO7/gIcHKxYkbReY8MbjUDa7MZMWPDHtCtk5GxlwWZDn4jL34YyjrU04wQy
    hmanOe3OpfPLzJxHVGbQJPqyiBYqNaSGm4DPXWr/Uof0vYzVifpts6w6SFJAcV5M
    Pug+wOcp8/FDckx1PEFJ+dQqsRFR6nVmm4RYozKq3qG2K3pi86X8Z9n2oYLRVdwH
    bOKDtxWfuMOXW9aAtk+WBgegN9rXPHYQGQKEbBPgudR8C6YQcy/j5cLZ0FqEClvr
    IgubTNzi7A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-90 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-90 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHPhOtnJz1cpjRs+T9ygJvk88+yJZJehRdw8/Ufy2fFC+0rjQmyVFTdDm2dizgf9pkJMoCAHrn863T7YX1CVtDiHO2MVeekNaHFnr4qJMCFbqOVsSPZK
    AC1rCe+5KIyeO+mpE0j3DAmL/fqENOSeMU2FtlE1eHBbH7ObId81nVlzmkyvCBsNrRSsRnGei18p5AACHr1qfdys5YFENodscGhczVkMnwLN4Im6K4ippAud
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=QqQqCG9i_pYyf1wnCmUA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbeDLHxz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 03:53:55 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:60039 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbeDLHxz (ORCPT
        <rfc822;groupwise-stable@vger.kernel.org:7:2>);
        Thu, 12 Apr 2018 03:53:55 -0400
Message-Id: <5ACF2CB002000078001BA984@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Thu, 12 Apr 2018 01:53:52 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Ingo Molnar" <mingo@kernel.org>
Cc: <x86@kernel.org>, <tglx@linutronix.de>,
        <xen-devel@lists.xenproject.org>, <boris.ostrovsky@oracle.com>,
        <mingo@redhat.com>, "Juergen Gross" <jgross@suse.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <hpa@zytor.com>
Subject: Re: [Xen-devel] [PATCH] x86/xen: zero MSR_IA32_SPEC_CTRL
 before suspend
References: <20180226140818.4849-1-jgross@suse.com>
 <5AA8F00302000078001B15EE@suse.com>
 <6b59ac31-7e90-1c18-2467-d7d294da6e5b@suse.com>
 <5ACDEE5B02000078001BA2DE@prv1-mh.provo.novell.com>
 <20180411115350.lvx5yaevoq6arwg3@gmail.com>
 <5ACE149E02000078001BA424@prv1-mh.provo.novell.com>
 <20180412073219.2h5fqc7megvepoa6@gmail.com>
In-Reply-To: <20180412073219.2h5fqc7megvepoa6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>> On 12.04.18 at 09:32, <mingo@kernel.org> wrote:

> * Jan Beulich <JBeulich@suse.com> wrote:
> 
>> >>> On 11.04.18 at 13:53, <mingo@kernel.org> wrote:
>> > * Jan Beulich <JBeulich@suse.com> wrote:
>> > 
>> >> Additionally, x86 maintainers: is there a particular reason this (or
>> >> any functionally equivalent patch) isn't upstream yet? As indicated
>> >> before, I had not been able to find any discussion, and hence I
>> >> see no reason why this is a patch we effectively carry privately in
>> >> our distro branches (and likely other distros do so too).
>> > 
>> > The patch was merged 6 weeks ago and is now upstream:
>> > 
>> >   71c208dd54ab: x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend
>> 
>> I'm sorry, but no, this isn't the patch I was inquiring about.
>> Instead I'm wondering of the disposition of the patch disabling
>> IBRS around a CPU going idle.
> 
> Got any specific link or subject line for that submission?

Sure, as written in the original response to Jürgen's patch:
https://patchwork.kernel.org/patch/10153843/

Jan
