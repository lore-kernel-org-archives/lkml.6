Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668DFECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2FC21502
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KO5l5Lu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2FC21502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbeIRVj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:39:29 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53522 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbeIRVj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:39:29 -0400
Received: by mail-it0-f65.google.com with SMTP id p79-v6so4001405itp.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NtXWoNn35FhQAdR9Y1Om2DHk9oKWquyXrXE/yY3N/Bo=;
        b=KO5l5Lu+TvoTxio0gIbAuIhWs0zWO7fz9N8CBUawBrKsSEljcZOBa7DgVedVFXhX30
         bvKn5/QarVGJkGzYF0ftTAn6lpVKHOCjU1XcamWTuZiIjMv/Joo/o/q3efkbxw3wkKlz
         6cpkjaf9YSSc/aye1rBbKIeWIja/1AzcRmaV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NtXWoNn35FhQAdR9Y1Om2DHk9oKWquyXrXE/yY3N/Bo=;
        b=AwtSe+gbByr3B7bdYRP1Vv1W9/YxY5BVcObz8jh0aP4KkO4dhlW6Mk96DxN1akEXxB
         tyfZMZDA1RrNLl/U+pYOZ5rTir9K+SmfVqjXTliDaOMCcug6VceIwgCq1woFr5o58KCp
         6KxrH3qsbKRiRl7p7B1WcH94Ix7RB3b6K+AsDv7DJo3cOVquXdt39pgexIvDj6Wz/nCf
         /AIqZXljkppUdbn/jyTHVg2OdFqfZ3QXuUH83NkawH7ega8wp2kW9siQpghOVJ9oS8Mx
         lJ7+wQDIXpMx+JKmCUeOT6kVVGNJkbhthldfBE76+zHO9VFXuDy5e8jOdxzB+uqcz5g6
         zo1Q==
X-Gm-Message-State: APzg51BZ73kV9j7oJVwY+s3k/bgVXbTNGxoB+Zc0I6ntGTPvTqwkifkF
        0BXbI2vuLk7Nzjj2zQnpROP9tZKhq5C3YdRmeC4oxg==
X-Google-Smtp-Source: ANB0VdZcbyVzhC6g3IVqsr67cyP0sVVqn39EZAg9zY/ojHe6cJZEpAw5WUqWZ/3QkU5LKZMFCZLYH8nDmF9aivc+lPE=
X-Received: by 2002:a24:57cb:: with SMTP id u194-v6mr17247859ita.148.1537286774777;
 Tue, 18 Sep 2018 09:06:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 09:06:13
 -0700 (PDT)
In-Reply-To: <8937D6B1-D21C-4C47-8A89-A466CDB6FB04@amacapital.net>
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
 <CAHmME9ohGPTX-fkhP6zaWdx3SbkiqO5kWkWE-bDk=pm-nUqYvw@mail.gmail.com> <8937D6B1-D21C-4C47-8A89-A466CDB6FB04@amacapital.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 18 Sep 2018 09:06:13 -0700
Message-ID: <CAKv+Gu-t5HPj+Y3-7JqkaKTdt-0ewOUobQaEuikpeOaX_SF+zg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Lutomirski <luto@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 September 2018 at 07:53, Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>
>> On Sep 16, 2018, at 10:07 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote=
:
>>
>> Hey Andy,
>>
>> Thanks a lot for your feedback.
>>
>>> On Mon, Sep 17, 2018 at 6:09 AM Andy Lutomirski <luto@kernel.org> wrote=
:
>>> 1. Zinc conflates the addition of a new API with the replacement of
>>> some algorithm implementations.  This is problematic.  Look at the
>>> recent benchmarks of ipsec before and after this series.  Apparently
>>> big packets get faster and small packets get slower.  It would be
>>> really nice to bisect the series to narrow down *where* the regression
>>> came from, but, as currently structured, you can't.
>>>
>>> The right way to do this is to rearrange the series.  First, the new
>>> Zinc APIs should be added, and they should be backed with the
>>> *existing* crypto code.  (If the code needs to be moved or copied to a
>>> new location, so be it.  The patch will be messy because somehow the
>>> Zinc API is going to have to dispatch to the arch-specific code, and
>>> the way that the crypto API handles it is not exactly friendly to this
>>> type of use.  So be it.)  Then another patch should switch the crypto
>>> API to use the Zinc interface.  That patch, *by itself*, can be
>>> benchmarked.  If it causes a regression for small ipsec packets, then
>>> it can be tracked down relatively easily.  Once this is all done, the
>>> actual crypto implementation can be changed, and that changed can be
>>> reviewed on its own merits.
>>
>> That ipsec regression was less related to the implementation and more
>> related to calling kernel_fpu_begin() unnecessarily, something I've
>> now fixed. So I'm not sure that's such a good example. However, I can
>> try to implement Zinc over the existing assembly (Martin's and Ard's),
>> first, as you've described. This will be a pretty large amount of
>> work, but if you think it's worth it for the commit history, then I'll
>> do it.
>
> Ard, what do you think?  I think it would
> be nice, but if the authors of that assembly are convinced it should be r=
eplaced, then this step is optional IMO.
>

I don't think there is any problem with switching to faster code
immediately, as long as we have data that supports the claim  that it
is actually faster on hardware people care about. The arm64 ChaCha20
code in the kernel is slower than the OpenSSL code as far as I know,
so I have no problems whatsoever with dropping it. The ARM version,
however, is slower on Cortex-A7 (according to Eric's benchmarks),
which is the only 32-bit ARM core anybody cares about these days.

>>
>>> 2. The new Zinc crypto implementations look like they're brand new.  I
>>> realize that they have some history, some of them are derived from
>>> OpenSSL, etc, but none of this is really apparent in the patches
>>> themselves.
>>
>> The whole point of going with these is that they _aren't_ brand new,
>> yet they are very fast. Eyeballs and fuzzer hours are important, and
>> AndyP's seems to get the most eyeballs and fuzzer hours, generally.
>>
>>> it would be nice if
>>> the patches made it more clear how the code differs from its origin.
>>> At the very least, though, if the replacement of the crypto code were,
>>> as above, a patch that just replaced the crypto code, it would be much
>>> easier to review and benchmark intelligently.
>>
>> You seem to have replied to the v3 thread, not the v4 thread. I've
>> already started to include lots of detail about the origins of the
>> code and [any] important differences in v4, and I'll continue to add
>> more detail for v5.
>
> This is indeed better.  Ard=E2=80=99s reply covers this better.
