Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2888943-1524763414-2-2991399896182695352
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
    1524763413; b=wOMkc6me+AgoqHDavmhKiQXAm2JjyboPdt0Ph+yYiwzpeWbhgM
    tdy1U1igAG35iiWKe/DTlMuMhplTTSMfVFwdpdPMfDLqKHi5nBopUMIcYD1R45ID
    en9kVaIbdHTjFfp8D3TR7gUYZ76Qk426B16/NhtMrF8CVNH1WtgNHtHajndgkz8i
    ZCmwN5vp02rQKvD2qk7jNDgmWT2JToKO4F6m1NBiEN1THZBjfmGygrjqkOXN+4sE
    aD786vXLdoOpLie+95Ul+3k5bD/wMpIwmzInomTwjGkXSmO5iYiPP6hHlU+if/6e
    G0xm0uJdCCGNzjStsTbPoKto/EB+k6e2EbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524763413; bh=X/ag1XGVKJf1Rc/ljk3uVrN9gWCXnn
    eu94B22U2P2Mk=; b=wW53iB9M2fVCQcjE/1FS/7hfyTCkDdEDxwokMgEPREUymi
    /ljj3BXcoiHMoBUZO+r5LJRkGhm4P4nsM4e0YEKNHr9Rxzj+xiaOeJ1VlVUUNnMb
    mWRUpnMyHF9OMeesww4zzDZ/xOg9NmsEmby4iJV60R9U4VzBQMrMWJNH29hpGkzS
    Cm3IB4pNJvIhgvSLw8MxH7yi50reV5r/txazSPZRaEgXJ/EKVyi+DrUwGw5vq+3+
    1LDuyGX2KuQeWOBYiMRCC9tvhxJfZuPSmc51TJlRsmYEpxrpyKxaxSKHzBn2SpR3
    +Vz149YCz5L8Er3ynnzpY4L53OEBH3TfHMUasw1A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=FVXebS1V x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=FVXebS1V x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCq4oBprn49VdRT9WOnxhZQKX9QCtCViZQjVQN6A1zwUbCGZD5eApgx8KMYqRrwfz4foA3qZBo54qyhSR0KNZlw0sdlbXgT7w0q+smADpmAUL5jX7IBm
    KersRWybXpPU1SdRgxFn6Ndygj4Mb+4f2VDIl64pulbAY4DceW2VkIHN40t0jjZ4Sm4xGOIXJUCWsepuL7mKaUxcuvkVjyXHxG6ZBZmaRPoWrrh24F3sAxcR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=YluUcLZQcQRogpDqD_YA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754574AbeDZRXa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 13:23:30 -0400
Received: from 8bytes.org ([81.169.241.247]:53510 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753282AbeDZRX3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 13:23:29 -0400
Date: Thu, 26 Apr 2018 19:23:28 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
To: "Kani, Toshi" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Message-ID: <20180426172327.GQ15462@8bytes.org>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org>
 <1524759629.2693.465.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524759629.2693.465.camel@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 04:21:19PM +0000, Kani, Toshi wrote:
> All pages under the pmd had been unmapped and then lazy TLB purged with
> INVLPG before coming to this code path.  Speculation is not allowed to
> pages without mapping.

CPUs have not only TLBs, but also page-walk caches which cache
intermediary results of page-table walks and which is flushed together
with the TLB.

So the PMD entry you clear can still be in a page-walk cache and this
needs to be flushed too before you can free the PTE page. Otherwise
page-walks might still go to the page you just freed. That is especially
bad when the page is already reallocated and filled with other data.

> > Further this needs synchronization with other page-tables in the system
> > when the kernel PMDs are not shared between processes. In x86-32 with
> > PAE this causes a BUG_ON() being triggered at arch/x86/mm/fault.c:268
> > because the page-tables are not correctly synchronized.
> 
> I think this is an issue with pmd mapping support on x86-32-PAE, not
> with this patch.  I think the code needed to be updated to sync at the
> pud level.

It is an issue with this patch, because this patch is for x86 and on x86
every change to the kernel page-tables potentially needs to by
synchronized to the other page-tables. And this patch doesn't implement
it, which triggers a BUG_ON() under certain conditions.


Regards,

	Joerg
