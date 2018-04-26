Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3121895-1524773264-2-10150792165399053296
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524773264; b=qqf/4r8NMlY4W92elhgcr53lQYOBz4o1iaVrnFlrFgF9dhXZup
    pzNErT208C2JAhEqY96fn9x9KQSplEy+tsDqHSTnbiPQyyTSBY7O2UCWvBJz9Ck9
    w9outXXfrU7XI6jQf6u2AovTN8CABgQeyvUNfFbpzBJdcWoQffsQkFgyERB/Li1t
    FaYivZ2+HL7/FyGvm5BBnObCYm0UH2sIZc5affsPIBm0msE4fwDsMXD9t0Cw7Msp
    mVYYkh77vUWclvH8RUzCncbOB8DxhRiI/kd1Nx3l2LIvJ0AJwRPNcekpBLaGy0KZ
    781G9jfWq0dNBEYp4ko1pvx+aFPE7IsTaF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524773264; bh=HtW6C3DNE0d/RqyH11pKxt3HkSQKjJ
    ZfE2TRim0DVd8=; b=vXicSGCz4VqQSCOsJioMMqEAbYO0vBjw8eLgueNwQ8m8Tf
    FNoim3QHCAO4YsjlaDive0zvBN6V2fTuZhPAk3iHsJKQuDVxFJk7miqcxIVTHndG
    yWMdwaOKn9PoAeBVgmsXtaQWQfqmhPM2CvJxuhAZVR0QphaG7l4wWW4HwwFlXlPs
    ukIrqc6ZOvnAGrfzq/KB/j2Eehz0T8n8fi5MNMnV4qX0PWq15unERYqedVqOc/VD
    2BQVNBXj6gx1BiKiiFql6GqXDBjzNyPx+yFz/QO8RWjMs16euAe37rT7u7Vsbjub
    sJ2om1gqwvbdNkLzpapQRqb/TfdGCaPWCRpfz1VQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=kdEjNscN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=kdEjNscN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMmg3MgLB2HJvNl9w+6lGGygi2Yp+QU3EExZYiQIL/mLB1nwnTY2pmQfyAwcp3wH53GXYSgBrCKFXW7rNsT3k+b66crPSVxgS+4B0GIyltPPKtbsWdYN
    rM+nXh24MqL07hhC2mVas0bvYnp931Hny6QYaTSYVj0SWxgqebeY9XaPWHTX7wFXl6gHh2Znmbwv/D7fCIHfuejxdQ2I8AgBNlrXfDxcSl5vxdPpnvac4lDe
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=tA7aZXjiAAAA:8 a=GQPbXzJ74lNKkey2py4A:9 a=CjuIK1q_8ugA:10
    a=kIIFJ0VLUOy1gFZzwZHL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753793AbeDZUHk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 16:07:40 -0400
Received: from 8bytes.org ([81.169.241.247]:54596 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752418AbeDZUHj (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 16:07:39 -0400
Date: Thu, 26 Apr 2018 22:07:37 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
To: "Kani, Toshi" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Message-ID: <20180426200737.GS15462@8bytes.org>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org>
 <1524759629.2693.465.camel@hpe.com>
 <20180426172327.GQ15462@8bytes.org>
 <1524764948.2693.478.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524764948.2693.478.camel@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 05:49:58PM +0000, Kani, Toshi wrote:
> On Thu, 2018-04-26 at 19:23 +0200, joro@8bytes.org wrote:
> > So the PMD entry you clear can still be in a page-walk cache and this
> > needs to be flushed too before you can free the PTE page. Otherwise
> > page-walks might still go to the page you just freed. That is especially
> > bad when the page is already reallocated and filled with other data.
> 
> I do not understand why we need to flush processor caches here. x86
> processor caches are coherent with MESI.  So, clearing an PMD entry
> modifies a cache entry on the processor associated with the address,
> which in turn invalidates all stale cache entries on other processors.

A page walk cache is not about the processors data cache, its a cache
similar to the TLB to speed up page-walks by caching intermediate
results of previous page walks.


Thanks,

	Joerg
