Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2972082-1523602161-2-10123239245478232528
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
    1523602161; b=hUg2qRCbEZXuaj6UFkZmrkhpWmXgW4I03sCKXB573b/XFonkA6
    pQlUrYsOoncLoQnCg0edhETwb20kxuCGdrjYW+iulab98tTx76TJt3DDpOfwyauo
    PbwQZXxDMV87VDAGm7inu3RKUUcFZgK014heUXXhUFcoA7789Ba3pG9o7gdzqQ1Z
    3ivmxhLjLMFPC12Jey3Q/djMRLS229daqt/G0BdRfDXH+cj05GhXo0AE8RgHvRBT
    K4U7ZidxUkfztNxPWqaKCyxN7Bs4Xw85IomBTQ76AM9hoXBLTT92N+OGUK6iVyCD
    KLuS4LKMPQ3yYRK2N1wxpJfGBT0o/k/VLTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523602161; bh=zoQeseEZbSVm9CyOCeQMNj63DcUSJJ
    G81lMSpaGD+dI=; b=Vt5/1lLqCOKdX0xMc6egWSgumfn68w3biOAmVzdHY4n13r
    cGpaC+a/ezmWIAjWDPUSk4B0Q/Sg7/GMShZwt4B65hSMJgPpENeXSZYHAPP9JUSq
    U0uowTj0Gtug42a8GnhSU9eion719i2k34w8Y0Z5+1hoGaDnbS8SVTFaI3FJeJqG
    uBTwl9ARn3UMxBpKjYXi4mJIh2opqt8wHlHm+CLOaljXoXs+18H7SJtgcGznR3An
    8d1RdFgmexFwepLunUhKyB85USWCVUSMETAr5nCNai6fJIU80A+NupHbdgWwq360
    WCINqZ0sWpyCOnNoWXPdkbk8XMBuLt0Yq/sGUxWA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfG7TAYKYFO2mPCNYckI/NLwpdZD6upxQ8RUg5HYdA3ozMI5Vll3Voa/V1WlktG8f6/uPMP3qzudzbrnoACzKDJyr/AqPNPSbMZX3qZvabZKrU4Zvugmv
    RSOWohmEGwFSGhQjPwc+6FbCSsI1Ri7MKSwnfvsc2VC5jYWmm/p0f+TOnngzfi30QP0LDSejCyQNEaE+wb75DDD7mo/OV8cFh4Kmi9gzcUq6b/7EhyixtbBz
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=Bw3ktndXgr9-i4oSfuIA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbeDMGtU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 02:49:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:40924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750980AbeDMGtT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 13 Apr 2018 02:49:19 -0400
Date: Fri, 13 Apr 2018 08:49:17 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Jann Horn <jannh@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mmap.2: MAP_FIXED is okay if the address range has been
 reserved
Message-ID: <20180413064917.GC17484@dhcp22.suse.cz>
References: <20180412153941.170849-1-jannh@google.com>
 <b617740b-fd07-e248-2ba0-9e99b0240594@nvidia.com>
 <CAKgNAkgcJ2kCTff0=7=D3zPFwpJt-9EM8yis6-4qDjfvvb8ukw@mail.gmail.com>
 <CAG48ez2NtCr8+HqnKJTFBcLW+kCKUa=2pz=7HD9p9u1p-MfJqw@mail.gmail.com>
 <13801e2a-c44d-e940-f872-890a0612a483@nvidia.com>
 <CAG48ez085cASur3kZTRkdJY20dFZ4Yqc1KVOHxnCAn58_NtW8w@mail.gmail.com>
 <cfbbbe06-5e63-e43c-fb28-c5afef9e1e1d@nvidia.com>
 <9c714917-fc29-4d12-b5e8-cff28761a2c1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c714917-fc29-4d12-b5e8-cff28761a2c1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 13-04-18 08:43:27, Michael Kerrisk wrote:
[...]
> So, you mean remove this entire paragraph:
> 
>               For cases in which the specified memory region has not been
>               reserved using an existing mapping,  newer  kernels  (Linux
>               4.17  and later) provide an option MAP_FIXED_NOREPLACE that
>               should be used instead; older kernels require the caller to
>               use addr as a hint (without MAP_FIXED) and take appropriate
>               action if the kernel places the new mapping at a  different
>               address.
> 
> It seems like some version of the first half of the paragraph is worth 
> keeping, though, so as to point the reader in the direction of a remedy.
> How about replacing that text with the following:
> 
>               Since  Linux 4.17, the MAP_FIXED_NOREPLACE flag can be used
>               in a multithreaded program to avoid  the  hazard  described
>               above.

Yes, that sounds reasonable to me.

-- 
Michal Hocko
SUSE Labs
