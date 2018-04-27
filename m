Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3462897-1524791427-2-6250721591894025980
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524791427; b=DZcCdm8w+OnncbEjC9xdwqpjyHGwT2kzkXyCMncHpU1/FgEb6Z
    VZhVnxPolAkbT2kXTIqveSiGKbv7viBixIYGDnekknY8j1mndDDkk1TWi31m2DZ9
    czXAxTdkpDwtYKHCegPhfmvQC4pvbImpUerMK6+HrEczKzTsWp120vCkyGj5khyZ
    an0MLU6TrToFj0ldMUFvFukvIjMpoEDD1IuTHehUIdSRdjiEtYcQSuKKwcDgpzA8
    93FxnQn7g6aduIDW1FjRwMkchgiaXQp3SdQqLy7w5Mnd1vU8O4amJy+ASjX6e8tq
    pc7PHPjPmFgTvnFWujCOTf8xK8knur8xAJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524791427; bh=Quc+7oH+kNfIeUupHFMMem55u4PsB70tnUidoASA3Q
    I=; b=GVVf3elleV6rnN3QH1FXTjDURONtlnWvnead+KIfI5yqm8b252M3KB3X6J
    HrV81Sob+c/bCWKyeRFacegFsdHpyYotTCdPtkYOHiU8NXckzSry3iINAiFUB85q
    C+hFEjjhHvU0wRAfqjSHZ+mRZJVOyk7burdX0GEyulHSr1ujGzJVpOm0fYZ6tQu8
    okChyM0SiKkjEduUJCBAfniLWkSFsq67j3VC1dUJEF+9dj/kU5LfLux6DNnCFGpw
    5WZfLQ1UagJ/vqLYl78zlUkzbxqP6nFOmXTTOFRZnKy+71KtwElVoCW6npX+ChH1
    ox/DpWT9roMS91hOj2sWHSy2HiWg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDbXSNEDSW/1qSQyVK7ae/yR7chbs11HMXfvl+dGihfDoHQJnTg3ep/zlESm1p+WPt5aigQwoSbo7vdRWrXwO4tudUSaesoj6R6/1MobXL2GpN3WsJ4C
    Wsh4p+tKRcoPLR+mCAY1ybWK6+aavkHQZUL8WhNDZRqtNJsWW139goLz16jPz/YYRKTeww2nUhwOyjJzCMWIhymfmr4GwfbDOGEI/wnzOlA64l84AKkpc1kA
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=HgYBsICCJV1qtiZHONcA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757202AbeD0BK0 (ORCPT <rfc822;linux@kroah.com>);
        Thu, 26 Apr 2018 21:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757195AbeD0BKZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:10:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D1A2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
X-Google-Smtp-Source: AB8JxZosrAm7bs6w5G1Mzaml2unGejqI8pGAJgLYR75a1xAkG6cJA6ZgwseVqFl+Mp+Kp27vNLJ4GWEA69OQZLtJYuo=
MIME-Version: 1.0
In-Reply-To: <20180426061108.GB4977@amd>
References: <20180425154602.GA8546@bombadil.infradead.org> <20180426061108.GB4977@amd>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Thu, 26 Apr 2018 18:10:03 -0700
X-Gmail-Original-Message-ID: <CAB=NE6VvZdbYkUY9mWA9dLwDTBaCVJ=J-w+4S2r7DtHYSkra7A@mail.gmail.com>
Message-ID: <CAB=NE6VvZdbYkUY9mWA9dLwDTBaCVJ=J-w+4S2r7DtHYSkra7A@mail.gmail.com>
Subject: Re: Moving unmaintained filesystems to staging
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Wilcox <willy@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 11:11 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2018-04-25 08:46:02, Matthew Wilcox wrote:
>> Recently ncpfs got moved to staging.  Also recently, we had some fuzzer
>> developers report bugs in hfs, which they deem a security hole because
>> Ubuntu attempts to automount an inserted USB device as hfs.
>
> We promise "no-regressions" for code in main repository, no such
> promise for staging. We have quite a lot of code without maintainer.
>
> Moving code to staging means it will get broken -- staging was not
> designed for this. I believe moving anything there is bad idea.
>
> Staging is for ugly code, not for code that needs new maintainter.

Staging is also a hospice for drivers on their way out. Can some of
these be eventually be axed?

  Luis
