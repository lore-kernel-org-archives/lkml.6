Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3575266-1527668843-2-6127571906522550340
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527668843; b=Bw8IG0uX89I/Ws2iFl7IG6BjwrZ3buq3GXnlMm5pPOHsiyJyk5
    2sHmVIrL89dUX2LJeM8+VUhNBwGpkaF9zzoueAudgdiqm7VUNut4cmsSeO+3QURZ
    rlyRyl7i9uqpqB6TA8/FawbMYdLzchqweIbPa6Wom2W9WhCnzNoO49pZha2W+BDg
    JuxsP0pfb7ZCkFUyH7hfBFxH5rF0wGqlCAM2AChDp8HyZGvS9Y8kl8POKJzmgkL3
    UboTL6djlPq44d1V7K1kzdLrNyF+ixOw7EjuChx8YdFWAUrA7a43IEan4dlmNvmw
    9nnth4DockflUKnQFpIMqETyqjGv05KVWieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527668843; bh=surnbEhtMOWyEOr5xlR8y7NY/XYulwIV1W5jk4OsLN
    M=; b=AK6Cj6oTrKwktlLOAReb3p7xDt5iB2MWfsHcwWVwt/qvCud69TxoWk6zzD
    tapx9nFWpTCzolYUv/PCF0s206V9GNQUkKxdq/PN6vlz45Wddr5SyeP6LHge1vdR
    oqei2qlEVR4naRwkRlEUpOxV0bLhjeSFS+ZyxVQ1lGxIcyTOvOOfJwW+vJDv3VN6
    lsTc9PWx5Tp9C3PNNyIL28ClUBBXRnkrGUhDQTRvX0lTg07e7PWF7FkiqkAO8OGI
    pHcR6ToMlSl8s/Gu3TimuUQXZxARAXyqFFGlWWaEg7AmHh2upxqvVbPzaiZCRjSq
    i4Azj9joKmR2brsZT3Em0+XJaaTg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
    header.d=szeredi.hu header.i=@szeredi.hu header.b=QZycjP4d
    header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=EKcqPQUX;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
      header.d=szeredi.hu header.i=@szeredi.hu header.b=QZycjP4d
      header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=EKcqPQUX;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJv7gQFVDXBU70ou4H1i1sIib+nw+o/NyvAvdBbcFXvVOigL3AOKOwpZgvMEEU2r10BPtdAhomawyf485QoCUkzqbpf8S5Dgwvvy4nCpZI+FDiV01EGd
    TNZ9nKv2uoNlWOKtsJPjCP9X026Zn5yJqHMkuTXilIfJxJ06B6phJ9q68oIswd+tmI0zAnVjuqgdk2p7k4JDa4h12NJwaAwOSCXngpuPaW+D6rI5cw5J7KGw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7YwWrYXYVYkA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=JfrnYn6hAAAA:8 a=RYkz1I287A2TY2upbX4A:9 a=QEXdDO2ut3YA:10
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935946AbeE3I1V (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 04:27:21 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43807 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935918AbeE3I1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 May 2018 04:27:19 -0400
X-Google-Smtp-Source: ADUXVKLePDQRTVYY8ab5Z1WV8lvlkeVcKmcG5KOH/0FknUTKfeo6ej5U8AuXrBZFSDqQpXZHS3fV1LHz3YZIq53OqqA=
MIME-Version: 1.0
X-Originating-IP: [194.176.227.33]
In-Reply-To: <d5621dfa-46f6-4b5a-4d69-6c6fb9370cfe@infradead.org>
References: <20180529144612.16675-1-mszeredi@redhat.com> <20180529144612.16675-4-mszeredi@redhat.com>
 <d5621dfa-46f6-4b5a-4d69-6c6fb9370cfe@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 30 May 2018 10:27:18 +0200
Message-ID: <CAJfpegtSm8_xHspGtuP5b+4uasG4jU-apAmsjtJ-fVeL8uhZNg@mail.gmail.com>
Subject: Re: [PATCH 03/28] ovl: Provide a mount option metacopy=on/off for
 metadata copyup
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 10:44 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 05/29/2018 07:45 AM, Miklos Szeredi wrote:

>> +       If this config option is enabled then overlay filesystems will
>> +       copy up only metadata where appropriate and data copy up will
>> +       happen when a file is opended for WRITE operation. It is still
>
>                                 opened

Thanks for the feedback.  Fixed.

Miklos
