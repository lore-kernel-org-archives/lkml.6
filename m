Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3937186-1523631875-2-11749269622794045643
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523631875; b=NBJ6h//ta8X21SIVWyDzulr2Amf6so6OQJ6DiZuz67Gwjaw2QW
    IWMMbgzeJkSYqoRhfKfFTJeVRW6uDywiWm854e5laNiS9iL/5vgvjfcW2F3WVKCx
    PqEXy21xsq30cunxj17fCfdSRGIEl5ElWRnMO3v7OgVtYWiBmR0AItABypqlNBLF
    ssgskpaaO62g305oQM5qGMzU/kc2qmOFphVLFVGpxYEfVnJAno+XPsg9sV0SnDIf
    gzTw3zDjVSktVRShO+zFjDPKBnvb/nw0AZThK0upxnWLIqGa9VYEPtNUC+xcwcUr
    FAX2yGhycuMaCMDx7BU1fPxOWLBLSNW3ZKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523631875; bh=N6a2lRzftK4yXQ0Gf/8mw3oPmrOr0bX7qqk8IyA1Jq
    Y=; b=lfzrspRmfWd76RpfAlzAkH4PB11J2Vpjm2TRug41n02kNfptoQW5CqvQiZ
    YcCBqfGc9YqvF9YyoOPdBF1BOnRJli6cRovBtBGLuWbylXGWnnWg8EdlkAqTQ3Je
    XM2NlbdqnyZu9O6pBPHcidANPTIl8yUYuuEdnoPBbS65walkgsn7pD/EtIp4P5oh
    tk87CbHNx16o3UBA5qzhBJlLaxqZhZmOaepzpRdCP7LKk1gdP/SRO4qmj+o6OYIW
    z2S5NRHbeBzYAUPJm9HhFH6Hzd2k7eOBNBWq5HBX+Yzy40eU7gtvcZN1rsWyUUYr
    mTWYzET1Uv/PQiMPx8fAnGT5oKMw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=ErtlRouZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y+i/zmki;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=ErtlRouZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y+i/zmki;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHzQZ6d58L1FHAQ2BmmVW1aKytdWNibkf3qirdtkjTxEoxXBDaYCzvbTbWJyKybuW1NQzPxtyF9T7UMogAwjY8fqhD/+aO4tzfT9u/GA/bMGNyjkI9EC
    KJpzTpNYV3+SBy6D7a1XcQ/LG7j43TrHb2SSHiW8IXi4w0vI4OAKYKgvrTkLbSK7iOdZ3QrxFGH0tf9xh6FZNCZ4o4X4WMyiPltod7mySlPX2yI4IWyHGwad
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ujy4fBGP2VYtZIgPQUQA:9 a=hrS_tePeMXBRTOxg:21
    a=8tMpWEajiSbO9r5B:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750837AbeDMPEc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 11:04:32 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44260 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeDMPEb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Apr 2018 11:04:31 -0400
X-Google-Smtp-Source: AIpwx4/0/whxWViZ4SRoVFNLfk+NzP0L44dVkpkVhzB1e1H5Tc9XAXvAtOh59+LqDCpuSnTs9hOj5+4/IZq1IWN8kEs=
MIME-Version: 1.0
In-Reply-To: <20180413064917.GC17484@dhcp22.suse.cz>
References: <20180412153941.170849-1-jannh@google.com> <b617740b-fd07-e248-2ba0-9e99b0240594@nvidia.com>
 <CAKgNAkgcJ2kCTff0=7=D3zPFwpJt-9EM8yis6-4qDjfvvb8ukw@mail.gmail.com>
 <CAG48ez2NtCr8+HqnKJTFBcLW+kCKUa=2pz=7HD9p9u1p-MfJqw@mail.gmail.com>
 <13801e2a-c44d-e940-f872-890a0612a483@nvidia.com> <CAG48ez085cASur3kZTRkdJY20dFZ4Yqc1KVOHxnCAn58_NtW8w@mail.gmail.com>
 <cfbbbe06-5e63-e43c-fb28-c5afef9e1e1d@nvidia.com> <9c714917-fc29-4d12-b5e8-cff28761a2c1@gmail.com>
 <20180413064917.GC17484@dhcp22.suse.cz>
From: Jann Horn <jannh@google.com>
Date: Fri, 13 Apr 2018 17:04:09 +0200
Message-ID: <CAG48ez2w+3FDh9LM3+P2EHowicjM2Xw6giR6uq=26JfWHYsTAQ@mail.gmail.com>
Subject: Re: [PATCH] mmap.2: MAP_FIXED is okay if the address range has been reserved
To: Michal Hocko <mhocko@kernel.org>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-man <linux-man@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 8:49 AM, Michal Hocko <mhocko@kernel.org> wrote:
> On Fri 13-04-18 08:43:27, Michael Kerrisk wrote:
> [...]
>> So, you mean remove this entire paragraph:
>>
>>               For cases in which the specified memory region has not been
>>               reserved using an existing mapping,  newer  kernels  (Linux
>>               4.17  and later) provide an option MAP_FIXED_NOREPLACE that
>>               should be used instead; older kernels require the caller to
>>               use addr as a hint (without MAP_FIXED) and take appropriate
>>               action if the kernel places the new mapping at a  different
>>               address.
>>
>> It seems like some version of the first half of the paragraph is worth
>> keeping, though, so as to point the reader in the direction of a remedy.
>> How about replacing that text with the following:
>>
>>               Since  Linux 4.17, the MAP_FIXED_NOREPLACE flag can be used
>>               in a multithreaded program to avoid  the  hazard  described
>>               above.
>
> Yes, that sounds reasonable to me.

But that kind of sounds as if you can't avoid it before Linux 4.17,
when actually, you just have to call mmap() with the address as hint,
and if mmap() returns a different address, munmap() it and go on your
normal error path.
