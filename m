Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-87399-1524829585-2-17808957709292643763
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
    1524829584; b=MSL84uknn3MMexzbpvL6LmDlNnBfCtlridPABpzJvFzxMZct5e
    6mmvFNiKTce8PT8hoSScJASq7AaR1iPzVwqGT4H8inaZZmzQUrmpgs/08BOKjB/q
    94Ax9VFVeGwvUa6YL/dYn2BdDesmiLZLuNdVypkj4hgQ0Qw/rNkejy90e568d+xz
    bvRdhprJ6/rM+tOazcSIvJgHdn/IbyMJnAvKph/FWj7UmlOz/bmeULZ/gFaFzj2y
    OtJrvd+1EujSOJn2N/51pQRdXRVCPNbh4+Yunmvh8eqSWEkMyLj2TYMqVrDE75+y
    3C7Dp1GqKndUmJw2XPZj/qDs9sgXNHWqLq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524829584; bh=XXhtVaVN6pRwiqWlIqUgT2YDPZmbaM
    XYN/SA1QAEizY=; b=YuSao4xrsPE7XAYtJDRwMVkN7BAdLCUhfs9EJSaK11OAx4
    RBc+o1hP/TXWZvks9TSVW5VMOOHnwpX4C7l/OQN4EE0sLPDNdA0thf0+rVb2Rx5e
    93wTUn5t3WGeujfDlBA515hKSQkJuG0IASDilkwZkUJ/yeFOSfLmK3YesdwgLGcn
    jZYZ0yxyIE9r9sTcKMeQb5WQ32/B/32R8WV+6NyuJcCpd1YtCP+b+/j0fKLdYDlt
    sitSfHVt0sTHyNzsfuEqqRXE7RGwLXNZEwxcQZlKb7sP8S6b8K3DkW7NOfpxICfV
    Gsqs+vFVUmB/tSlQDXgZQXaLcTNpBvYCPNevMBtQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=OTG8Ib+z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=OTG8Ib+z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ6KnU9h4pNCjJ8VsuWhP2+rGDZjMqpwUMsXlzK5jSQ4mPxvk/5DSksQ297cYveCQ/8p5ny3cwSZfIawn1b3iffXhvjYazcknyX0DmFuVBG3Wys3NuxR
    Ftg7+D4qm1zToKl4CvtjGdbIYEb1Fo2NxS+RT5XFTohLJlud8hD/WKQJZmLaveMnaINQr7Czr7lFtUbiDqavXF7aNcTD33/Z5KIYNzNbXV2heilgRyCQD274
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=tA7aZXjiAAAA:8 a=P2oPjIs6qmg0OA5TXlUA:9 a=CjuIK1q_8ugA:10
    a=kIIFJ0VLUOy1gFZzwZHL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757820AbeD0LqW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 07:46:22 -0400
Received: from 8bytes.org ([81.169.241.247]:38640 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbeD0LqV (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 07:46:21 -0400
Date: Fri, 27 Apr 2018 13:46:19 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: "Kani, Toshi" <toshi.kani@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Message-ID: <20180427114619.GV15462@8bytes.org>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org>
 <1524759629.2693.465.camel@hpe.com>
 <20180426172327.GQ15462@8bytes.org>
 <1524764948.2693.478.camel@hpe.com>
 <20180426200737.GS15462@8bytes.org>
 <1524781764.2693.503.camel@hpe.com>
 <20180427073719.GT15462@8bytes.org>
 <20180427113923.GF17484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427113923.GF17484@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 01:39:23PM +0200, Michal Hocko wrote:
> On Fri 27-04-18 09:37:20, joro@8bytes.org wrote:
> [...]
> > So until we make the generic ioremap code in lib/ioremap.c smarter about
> > unmapping/remapping ranges the best solution is making my fix work again
> > by reverting your patch.
> 
> Could you reuse the same mmu_gather mechanism as we use in the
> zap_*_range?

Yeah, maybe, I havn't looked into the details yet. At least something
similar is needed.


	Joerg
