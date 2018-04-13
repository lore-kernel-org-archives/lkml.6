Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4073160-1523635495-2-14307545208977115399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523635494; b=uR1aJHOJpm6MkYugDatd7JxYsRed8VPOl/ZGCTKv6uZ02oTThb
    zfH2QijYECo206XsRyKzJT5ud1FZHi+5JDqd9tAx+X1/KIOigytpLcPC6DPzJJgE
    +I0LOEDiOuujRWHmtzChtUF+b1ZMHlybwGv7rBICYj9LxSXEc6gEvj0cC6ZB6ixD
    o9H0JCDJIJ4gvvZnmVBYYSgCLWv4F3cKBRYhxPHafEeJPF3e1i7tq+TwalSRc3w/
    gp7aVjN90VkqztSU5O+Qym5bnni12PklMFsdVAqhlMAeVZxslx8zayJ3VCjaPceQ
    u7FdG7C/uxvanQ/w1+reh2Q8CWPZGLreGG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523635494; bh=1BeHtdQuXjNVVcQTHNJFh98pvgpShr
    rS/dMB+rUYFI8=; b=ugP9ChwuJqCNTCsJ0QM2Y1kS3Ji/WhCml41GT7n10T9Bo6
    54K8d3tbpwsGdnFVn/iAPW+voYOE9AM/VrGVDJXh6yj6lss1T/url6+t37FupFh/
    71RukYALDMq9rBoYd76A2mQ1jrhKC7kvcHn2fBL4WGx+yOkncNfQVqIeeqMN52wR
    o4g9UP73+H6dVVoyyw7t8spedRohn2RoHJVZFKVH+3uUgVhXNjYk7wxblmrfZAPV
    N21BfvKpQfkUHDiV4bJx5GpTzsWnV3heS5/1POVpgiAsyyKG7u0GCaoKx9WL87/g
    o7R9KJLQvm7Yae05bh3onYN6awvmOmL70nNx3wFw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIyLIs+JcvnRTenqk3l26agFmw4OQH9Trd1LogqmM2Akm3wOQSY27yRm76pHvrAAIdIMsVgSasLGCrw/zhkpWhlgdGns7GrqtB5MYqJv2htJEnX4x4sV
    euKfs5OfCuhzi3wQy4GPEdyI4+Dh3Fj6TzATU+1Rt/XhYzX/jjM5BLDh6kXLYP1zwQkSWST6vtvsbr7nCoSSLLjGAcDNHf7Zx9/hIupxLY7nu+Z3mgOhL4Mj
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ZrWWl51JjVaizG0nLXUA:9 a=0FeERd84wCimgWsX:21
    a=xMjB1OMYItItyxvs:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeDMQEl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 12:04:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:36362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751421AbeDMQEh (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 13 Apr 2018 12:04:37 -0400
Date: Fri, 13 Apr 2018 18:04:35 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-man <linux-man@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mmap.2: MAP_FIXED is okay if the address range has been
 reserved
Message-ID: <20180413160435.GA17484@dhcp22.suse.cz>
References: <20180412153941.170849-1-jannh@google.com>
 <b617740b-fd07-e248-2ba0-9e99b0240594@nvidia.com>
 <CAKgNAkgcJ2kCTff0=7=D3zPFwpJt-9EM8yis6-4qDjfvvb8ukw@mail.gmail.com>
 <CAG48ez2NtCr8+HqnKJTFBcLW+kCKUa=2pz=7HD9p9u1p-MfJqw@mail.gmail.com>
 <13801e2a-c44d-e940-f872-890a0612a483@nvidia.com>
 <CAG48ez085cASur3kZTRkdJY20dFZ4Yqc1KVOHxnCAn58_NtW8w@mail.gmail.com>
 <cfbbbe06-5e63-e43c-fb28-c5afef9e1e1d@nvidia.com>
 <9c714917-fc29-4d12-b5e8-cff28761a2c1@gmail.com>
 <20180413064917.GC17484@dhcp22.suse.cz>
 <CAG48ez2w+3FDh9LM3+P2EHowicjM2Xw6giR6uq=26JfWHYsTAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2w+3FDh9LM3+P2EHowicjM2Xw6giR6uq=26JfWHYsTAQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 13-04-18 17:04:09, Jann Horn wrote:
> On Fri, Apr 13, 2018 at 8:49 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Fri 13-04-18 08:43:27, Michael Kerrisk wrote:
> > [...]
> >> So, you mean remove this entire paragraph:
> >>
> >>               For cases in which the specified memory region has not been
> >>               reserved using an existing mapping,  newer  kernels  (Linux
> >>               4.17  and later) provide an option MAP_FIXED_NOREPLACE that
> >>               should be used instead; older kernels require the caller to
> >>               use addr as a hint (without MAP_FIXED) and take appropriate
> >>               action if the kernel places the new mapping at a  different
> >>               address.
> >>
> >> It seems like some version of the first half of the paragraph is worth
> >> keeping, though, so as to point the reader in the direction of a remedy.
> >> How about replacing that text with the following:
> >>
> >>               Since  Linux 4.17, the MAP_FIXED_NOREPLACE flag can be used
> >>               in a multithreaded program to avoid  the  hazard  described
> >>               above.
> >
> > Yes, that sounds reasonable to me.
> 
> But that kind of sounds as if you can't avoid it before Linux 4.17,
> when actually, you just have to call mmap() with the address as hint,
> and if mmap() returns a different address, munmap() it and go on your
> normal error path.

This is still racy in multithreaded application which is the main point
of the whole section, no?

-- 
Michal Hocko
SUSE Labs
