Return-Path: <ard.biesheuvel@linaro.org>
X-Cyrus-Session-Id: sloti22d1t05-2832218-1520936010-2-12400612316746698658
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H2 -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.223.194', Host='mail-io0-f194.google.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ard.biesheuvel@linaro.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520936009; b=BpgY0O2WCfO400RNqGYcn6g/xSpv13LjmiTsmbDSJtqWjlq
    nZATyFvBwy6pz16Sx/iCT6LxBv/Wpi19TJqGcYgMzS7LSn0s0x/2AfsXhYP3MHYR
    aSVz+8maeHbWQmnvv0oPU8eCIfZmr8HXHvNIm/t0i6yF+1lqQwr5WbUV/zktRMgC
    ueDenso5Rp1rNWXkTOwEB/4Wr1g5zhsiSwLtEht6E+OpfoLiGi22Yr4wb/20NSfy
    98cLcZuEMSSD/T9qaWVZsNhotr56AzR1M/OmUuQDI9aNSHa3ONlq8qy9wa2xdDSE
    WvVXqig9SUbYR1s+ebEdoo+oUIJxcXOQEKMpQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1520936009; bh=PMBjTZaid5TlKJEK+lqgFQXjIOEKwY1hIPW7n+IpYYY=; b=I
    D9qYweyIxfBfJM9LSoBqtZgAKl+7Q5unIuBm79xXYFdj57XqHU1G4ew2iRM7o1VX
    66A7FUQFPbDsOo5eDZBiMrkpGj2y8UKuBtfsO+TYaU6vDz4E0HO83IfwM/9xVUMl
    S7cwWQXSIips4/rQCS33gPNdlEnDOw03azpBl++trV9CYliUV6HwIJUWQtiMx9aD
    qQHsm6hPK/wWa/jOAzyZZvdcdWyJFjeHlyTORgUSqH6pZTDJtQAuvN8eVQLdyZMy
    ZYwCKT6kRQ21xI7kQwVozAy8KbcwtN+AKuC370T1m2oKf5r70W+/+TUZoQqRc0ex
    5ZK6dguf2txCXQtlDHDpg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=UMft3UI1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.223.194 (mail-io0-f194.google.com);
    spf=pass smtp.mailfrom=ard.biesheuvel@linaro.org smtp.helo=mail-io0-f194.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=m5r2lqjD;
    x-ptr=pass x-ptr-helo=mail-io0-f194.google.com x-ptr-lookup=mail-io0-f194.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=UMft3UI1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.223.194 (mail-io0-f194.google.com);
    spf=pass smtp.mailfrom=ard.biesheuvel@linaro.org smtp.helo=mail-io0-f194.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=m5r2lqjD;
    x-ptr=pass x-ptr-helo=mail-io0-f194.google.com x-ptr-lookup=mail-io0-f194.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELvpkXn668VzTqiY6tn6b8LxH8ujeoveUP2DvnbIpX2+saesy5e1LdfbHvQwnB5BvtOhUiDXdV4B27l0J+pbv4c=
MIME-Version: 1.0
In-Reply-To: <20180313100442.GB1999@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com> <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com> <CAKv+Gu-HdLkjYeNBQOW=JuWt3GjdZJFjyXCHCbGU01hkO81BNg@mail.gmail.com>
 <20180313100442.GB1999@kroah.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 13 Mar 2018 10:13:26 +0000
Message-ID: <CAKv+Gu-v6U49_OZyt6HHmCJ7srYnNw040LpVkFnzx+BGKVC0aA@mail.gmail.com>
Subject: Re: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
To: Greg KH <greg@kroah.com>
Cc: Alex Shi <alex.shi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13 March 2018 at 10:04, Greg KH <greg@kroah.com> wrote:
> On Wed, Mar 07, 2018 at 06:24:09PM +0000, Ard Biesheuvel wrote:
>> On 2 March 2018 at 16:54, Greg KH <greg@kroah.com> wrote:
>> > On Fri, Mar 02, 2018 at 05:14:50PM +0800, Alex Shi wrote:
>> >>
>> >>
>> >> On 03/01/2018 11:24 PM, Greg KH wrote:
>> >> > On Wed, Feb 28, 2018 at 11:56:22AM +0800, Alex Shi wrote:
>> >> >> Hi All,
>> >> >>
>> >> >> This backport patchset fixed the meltdown issue, it's original branch:
>> >> >> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
>> >> >> A few dependency or fixingpatches are also picked up, if they are necessary
>> >> >>  and no functional changes.
>> >> >>
>> >> >> The patchset also on repository:
>> >> >>    git://git.linaro.org/kernel/linux-linaro-stable.git lts-4.9-spectrevv2
>> >> >>
>> >> >> No bug found yet from kernelci.org and lkft testing.
>> >> >
>> >> > No bugs is good, but does it actually fix the meltdown problem?  What
>> >> > did you test it on?
>> >>
>> >> Oh, I have no A73/A75 cpu, so I can not reproduce meltdown bug.
>> >
>> > Then why should I trust this backport at all?
>> >
>> > Please test on the hardware that is affected, otherwise you do not know
>> > if your patches do anything or not.
>> >
>>
>> I don't think it is feasible to test these backports by confirming
>> that they make the fundamental issue go away. We simply don't have the
>> code to reproduce all the variants, and we have to rely on the
>> information provided by ARM Ltd. regarding which cores are affected
>> and which aren't.
>
> You really don't have the reproducers?  Please work with ARM to resolve
> that, this should not be a non-tested set of patches.  That's really
> worse than no patches at all, as if they were applied, that would
> provide a false-sense of "all is fixed".
>

I know that on x86, the line between architecture and platform is
blurry. That is not the case on ARM, though.

Unlike platform firmware, the OS is built on top of an abstracted
platform which is described by ARM's Architecture Reference Manual. If
ARM Ltd. issues recommendations regarding what firmware PSCI methods
to call when doing a context switch, or which barrier instruction to
issue in certain circumstances, they do so because a certain class of
hardware may require it in some cases. It is really not up to me to go
find some exploit code on GitHub, run it before and after applying the
patch and conclude that the problem is fixed. Instead, what I should
do is confirm that the changes result in the recommended actions to be
taken at the appropriate times.
