Return-Path: <ard.biesheuvel@linaro.org>
X-Cyrus-Session-Id: sloti22d1t05-3903547-1520447053-2-7253357917415133595
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H2 -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.223.195', Host='mail-io0-f195.google.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ard.biesheuvel@linaro.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520447052; b=d+LzkEemDXg6eBIytBS3/isycJ1LDNUN5EXPOXsFtdJ0YID
    wJrr3vcPe2Pw1llDG4CUNZEIzSFcY7cODBt3U5FIcE6+xx9lMLNIXoGxsrm2mDnz
    LRkrbHNwgRFCNz05Q/Or4uQJFgv83VI2bl9Y6LfOk0o7Jp4WzVpx9ZB5nn0tVef2
    N/bhI0jVkXqFD8HZIJVb5sgTYWzLqe4TZmPG0insiy0VJ8wVrkCSUj2y6t0dsZZF
    iDDhOCOAKe903tCyecGLWpQ+RuY4pm8hAyk2zj3h0LwFMnCApjjc2Lu/Sfw/TTGM
    Brgb8VvXRjqc1hbF+ASUSYH1fvT0J+Nx1n2q8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1520447052; bh=0UGdShqpV/9RCb3lzGxqVE4DvhpFaxTfo211it5EX2A=; b=F
    7Dc4fMZswCbBrtVq6wewHdXvdfHCDNpS0OkueTHi+klwrounYVyQC8FgnkJLhrcZ
    4NIBjpfH4fxcIAPbrn/2TJ2n4n/3cRtFeC85eHKbfxsjh4MB75AbZz2ulCaoJS8U
    pa3tyskVNb7RPj4uigocvDqbDWvCXWT9U/bG8Pz6jLrbsdyXTi6MjpwV5EHHRuHa
    TaFRGofwiSD1hKo3AdlVkK5jf+oKrnaLSl+39NwYUxebpmNH5DVrRCo1Jvs+fN4w
    48pwlaHfvTFWdZ2arnmpwES+JrVlGVGEvuI7KFxESf+nZ6pd9J0a9cqCj24OIha8
    9Quzx9NJSkVIJHQeAIk0w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=jI00VsbE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.223.195 (mail-io0-f195.google.com);
    spf=pass smtp.mailfrom=ard.biesheuvel@linaro.org smtp.helo=mail-io0-f195.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ErRYFdT+;
    x-ptr=pass x-ptr-helo=mail-io0-f195.google.com x-ptr-lookup=mail-io0-f195.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=jI00VsbE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.223.195 (mail-io0-f195.google.com);
    spf=pass smtp.mailfrom=ard.biesheuvel@linaro.org smtp.helo=mail-io0-f195.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ErRYFdT+;
    x-ptr=pass x-ptr-helo=mail-io0-f195.google.com x-ptr-lookup=mail-io0-f195.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELtQFsZX71gi8rka7QsZLuTZk/j66Sxq4/Pz/BwIQCOFTy+riASCFAHbdhAHwXW9bT2EJhjbEikwIdjo5l5Aj1o=
MIME-Version: 1.0
In-Reply-To: <20180302165415.GB8704@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com> <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 7 Mar 2018 18:24:09 +0000
Message-ID: <CAKv+Gu-HdLkjYeNBQOW=JuWt3GjdZJFjyXCHCbGU01hkO81BNg@mail.gmail.com>
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

On 2 March 2018 at 16:54, Greg KH <greg@kroah.com> wrote:
> On Fri, Mar 02, 2018 at 05:14:50PM +0800, Alex Shi wrote:
>>
>>
>> On 03/01/2018 11:24 PM, Greg KH wrote:
>> > On Wed, Feb 28, 2018 at 11:56:22AM +0800, Alex Shi wrote:
>> >> Hi All,
>> >>
>> >> This backport patchset fixed the meltdown issue, it's original branch:
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
>> >> A few dependency or fixingpatches are also picked up, if they are necessary
>> >>  and no functional changes.
>> >>
>> >> The patchset also on repository:
>> >>    git://git.linaro.org/kernel/linux-linaro-stable.git lts-4.9-spectrevv2
>> >>
>> >> No bug found yet from kernelci.org and lkft testing.
>> >
>> > No bugs is good, but does it actually fix the meltdown problem?  What
>> > did you test it on?
>>
>> Oh, I have no A73/A75 cpu, so I can not reproduce meltdown bug.
>
> Then why should I trust this backport at all?
>
> Please test on the hardware that is affected, otherwise you do not know
> if your patches do anything or not.
>

I don't think it is feasible to test these backports by confirming
that they make the fundamental issue go away. We simply don't have the
code to reproduce all the variants, and we have to rely on the
information provided by ARM Ltd. regarding which cores are affected
and which aren't.

What we can do (and what I did for the v4.14 backport) is ensure that
the mitigations take effect when they are expected to, i.e., confirm
that the trampoline vector table and page tables are being used (which
can be done using the exploit code for variant 3a btw), and to check
that the branch predictor maintenance code is called as expected. For
variant 1, we just have to have faith ...

Note that I haven't done so for *this* backport, and I currently don't
have any time to spend on this.
