Return-Path: <ard.biesheuvel@linaro.org>
X-Cyrus-Session-Id: sloti22d1t05-3161771-1520946109-2-8382228456291631742
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H2 -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.223.173', Host='mail-io0-f173.google.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ard.biesheuvel@linaro.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520946109; b=qmUj2GlTT8mux8e6uoZP7pOGdlU0T5YQtseZidEwrT/CYK/
    XNrTrsV+ObSz7QhxmpGhrI1UTYRkJMuYnWpf/IKCGb14Q+AFeryOgrbUyrn55cVg
    zNQ8XAOMSgqmUOsh56U3o13bY8etoly/yNxvDIe7kLz60RhLlpHrW17xUSt4pVG7
    mQZ9ZYQBfmOwzTi47ozcv+bNF/DBUhR23BBm3iN6mjg/siS3cXcq1j9iym8rfNXY
    +NqaJlIzcz6lDOR8RMhqGKa/ZBfs8qCFERyc5CXTJeRex6Ntf3/nsXrCyA+Y5jdr
    zs0jPFBk58UJY4TyG4sFob7Dyjoeq2nB4sgliEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1520946109; bh=SyrbspwVa5cnOzDRhXS2hw1O6di1kY+RcJ+sJJ19kcI=; b=o
    0oEwBsBgwpM9hfd8+CBTkv7QPa2f/6QwybFQwh2Frc2r9y9DtceX8TTT/kmeoa58
    qY5YL8fS7RUA1qLDOtmzGaTJUgbDepyjYdoEZxwHvyftMePFPZxHq8WpkyoZeskZ
    0DTHr4F29EpAlnM2wDbKJgsYPDLu77zj9RSq9hd+a5rWYsCz1CJ4D0q9IbL4OEe4
    hPYGeXCceDLKcFIFhi+GBRrqwwcPNEwwiKotzoMj17j+8EpOmy8G6sty3rK3Zjan
    46FbLdT3lGeV8aeKATFXUkr8+79mzx3/THIupzp0Vv+xlUdcrFWhP9Exxb3ZyQSm
    GKj/gf4z+0eh6adujBgbQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=QuohUsNY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.223.173 (mail-io0-f173.google.com);
    spf=pass smtp.mailfrom=ard.biesheuvel@linaro.org smtp.helo=mail-io0-f173.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DIU2CFv4;
    x-ptr=pass x-ptr-helo=mail-io0-f173.google.com x-ptr-lookup=mail-io0-f173.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=QuohUsNY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.223.173 (mail-io0-f173.google.com);
    spf=pass smtp.mailfrom=ard.biesheuvel@linaro.org smtp.helo=mail-io0-f173.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DIU2CFv4;
    x-ptr=pass x-ptr-helo=mail-io0-f173.google.com x-ptr-lookup=mail-io0-f173.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELsrlWDRpV8oMYfX+vAcknxVF5ZOVcQOihn+HKTOX5pZnuaBzCYJ5gt2asWm7u5zp8aUyNrWXoTHERVdzB1ID/I=
MIME-Version: 1.0
In-Reply-To: <20180313103843.GA29908@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com> <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com> <CAKv+Gu-HdLkjYeNBQOW=JuWt3GjdZJFjyXCHCbGU01hkO81BNg@mail.gmail.com>
 <20180313100442.GB1999@kroah.com> <CAKv+Gu-v6U49_OZyt6HHmCJ7srYnNw040LpVkFnzx+BGKVC0aA@mail.gmail.com>
 <20180313103843.GA29908@kroah.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 13 Mar 2018 13:01:43 +0000
Message-ID: <CAKv+Gu8ratRYnGzNm5qppUetEFt4Dief_3_Dj6yaW==DJemeHQ@mail.gmail.com>
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

On 13 March 2018 at 10:38, Greg KH <greg@kroah.com> wrote:
> On Tue, Mar 13, 2018 at 10:13:26AM +0000, Ard Biesheuvel wrote:
>> On 13 March 2018 at 10:04, Greg KH <greg@kroah.com> wrote:
>> > On Wed, Mar 07, 2018 at 06:24:09PM +0000, Ard Biesheuvel wrote:
>> >> On 2 March 2018 at 16:54, Greg KH <greg@kroah.com> wrote:
...
>> >> > Please test on the hardware that is affected, otherwise you do not know
>> >> > if your patches do anything or not.
>> >> >
>> >>
>> >> I don't think it is feasible to test these backports by confirming
>> >> that they make the fundamental issue go away. We simply don't have the
>> >> code to reproduce all the variants, and we have to rely on the
>> >> information provided by ARM Ltd. regarding which cores are affected
>> >> and which aren't.
>> >
>> > You really don't have the reproducers?  Please work with ARM to resolve
>> > that, this should not be a non-tested set of patches.  That's really
>> > worse than no patches at all, as if they were applied, that would
>> > provide a false-sense of "all is fixed".
>> >
>>
>> I know that on x86, the line between architecture and platform is
>> blurry. That is not the case on ARM, though.
>>
>> Unlike platform firmware, the OS is built on top of an abstracted
>> platform which is described by ARM's Architecture Reference Manual. If
>> ARM Ltd. issues recommendations regarding what firmware PSCI methods
>> to call when doing a context switch, or which barrier instruction to
>> issue in certain circumstances, they do so because a certain class of
>> hardware may require it in some cases. It is really not up to me to go
>> find some exploit code on GitHub, run it before and after applying the
>> patch and conclude that the problem is fixed. Instead, what I should
>> do is confirm that the changes result in the recommended actions to be
>> taken at the appropriate times.
>
> To _not_ take that exploit code and run it to _verify_ that your patches
> work, would be foolish, right?
>

Oh, absolutely. But that presupposes access to both the affected
hardware and the exploit code.

> I can't believe we are having the argument of "Test that your patches
> actually work"...
>
> Ugh, these series are all now dropped from my patch queue until you all
> get your act together and get someone to verify the changes actually
> work.
>

Fair enough. If anyone needs these patches for their systems, they can
respond with a Tested-by:
