Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DAAECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801342147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="VbTMn9jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801342147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbeIQUVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:21:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41673 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbeIQUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:21:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id b12-v6so7543093plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QFe5O0BbarCm42o+NA11nxio8+ywxPv3qhJutPW8ZPA=;
        b=VbTMn9jnq5qoBtg1SRKDkPSni/fcOUIe3p9hWQmSd1fc4YIzFgxH0hwBQMs6TRpl0r
         Ot89rMbx4Ihwg+s8XEnnclgm755RwM4PqR46FLLc91ieAgnLEO0T5+5/5tvcJIp1Del5
         1Lc+bWvzwt/sKV0vuwno7Me1Nf7vi8EdO6z86s+yFCDk+UgF8u7kYQVBP1xRuM/NhLcb
         PDzBfITs2yc2bwvq1gqqZCelg090+HWFkowPF8V9cFKQI/12bSzBqYdESYsr2vAj9NSh
         oRSXjh0ZvXznVSSYmFl/vGT+kkaeR5HTUbtO8V0u4sZdooUb/5n36cxRyjYxVT20Wkhf
         1n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QFe5O0BbarCm42o+NA11nxio8+ywxPv3qhJutPW8ZPA=;
        b=Qj/jQGt8tIr54r+mNno+AdfTqxojWvMotFpcUeuLPq2XF1A2JqyA378yv7VcCEiNVO
         khPobtAXtxTfocN1tJU9J7UHUGq1qGvQumEXDPBapbTYQnDCLnxVwlpO5sLDQZmMw14E
         wJ8q5vrRyp5En4Lo3q1KpYoM8H2P/YcHjo1a2GrALV+3XCKG7OhmTi2vsJw9P9eDwJFK
         5x+dyrDmy8L3n96kmigG0/opgSIJvsvLCBtFwEDPsz0SCqZrEO4m7a9yuaWaNwa78Rbe
         CDzMEL01LhBng38IxPRpe2XXqBvkZo2rHd/2iiLcApC60Q0nr4Da4EvVWpOuPmgnyZA0
         SuUA==
X-Gm-Message-State: APzg51B2S3t2wQlLQ0oT5V47OcoQmHqlRArexqVKDwEcoODeESvhQbOU
        n7QPj1vEuXiUBM3V0AKgBzHpze0W5qM=
X-Google-Smtp-Source: ANB0Vda/xL6/is7PICa5U/N5PKwyC8Zywxr9UcFjOWh6KX9DTq3U4dw8TN+i/noRCmMX5GopQwCqYA==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59-v6mr25322888plp.18.1537196038658;
        Mon, 17 Sep 2018 07:53:58 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:d8c5:6393:c455:3e7? ([2601:646:c200:7429:d8c5:6393:c455:3e7])
        by smtp.gmail.com with ESMTPSA id 143-v6sm22116890pfy.156.2018.09.17.07.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 07:53:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAHmME9ohGPTX-fkhP6zaWdx3SbkiqO5kWkWE-bDk=pm-nUqYvw@mail.gmail.com>
Date:   Mon, 17 Sep 2018 07:53:56 -0700
Cc:     Andrew Lutomirski <luto@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8937D6B1-D21C-4C47-8A89-A466CDB6FB04@amacapital.net>
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com> <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net> <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com> <CAHmME9ohGPTX-fkhP6zaWdx3SbkiqO5kWkWE-bDk=pm-nUqYvw@mail.gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Sep 16, 2018, at 10:07 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
> Hey Andy,
>=20
> Thanks a lot for your feedback.
>=20
>> On Mon, Sep 17, 2018 at 6:09 AM Andy Lutomirski <luto@kernel.org> wrote:
>> 1. Zinc conflates the addition of a new API with the replacement of
>> some algorithm implementations.  This is problematic.  Look at the
>> recent benchmarks of ipsec before and after this series.  Apparently
>> big packets get faster and small packets get slower.  It would be
>> really nice to bisect the series to narrow down *where* the regression
>> came from, but, as currently structured, you can't.
>>=20
>> The right way to do this is to rearrange the series.  First, the new
>> Zinc APIs should be added, and they should be backed with the
>> *existing* crypto code.  (If the code needs to be moved or copied to a
>> new location, so be it.  The patch will be messy because somehow the
>> Zinc API is going to have to dispatch to the arch-specific code, and
>> the way that the crypto API handles it is not exactly friendly to this
>> type of use.  So be it.)  Then another patch should switch the crypto
>> API to use the Zinc interface.  That patch, *by itself*, can be
>> benchmarked.  If it causes a regression for small ipsec packets, then
>> it can be tracked down relatively easily.  Once this is all done, the
>> actual crypto implementation can be changed, and that changed can be
>> reviewed on its own merits.
>=20
> That ipsec regression was less related to the implementation and more
> related to calling kernel_fpu_begin() unnecessarily, something I've
> now fixed. So I'm not sure that's such a good example. However, I can
> try to implement Zinc over the existing assembly (Martin's and Ard's),
> first, as you've described. This will be a pretty large amount of
> work, but if you think it's worth it for the commit history, then I'll
> do it.

Ard, what do you think?  I think it would
be nice, but if the authors of that assembly are convinced it should be repl=
aced, then this step is optional IMO.

>=20
>> 2. The new Zinc crypto implementations look like they're brand new.  I
>> realize that they have some history, some of them are derived from
>> OpenSSL, etc, but none of this is really apparent in the patches
>> themselves.
>=20
> The whole point of going with these is that they _aren't_ brand new,
> yet they are very fast. Eyeballs and fuzzer hours are important, and
> AndyP's seems to get the most eyeballs and fuzzer hours, generally.
>=20
>> it would be nice if
>> the patches made it more clear how the code differs from its origin.
>> At the very least, though, if the replacement of the crypto code were,
>> as above, a patch that just replaced the crypto code, it would be much
>> easier to review and benchmark intelligently.
>=20
> You seem to have replied to the v3 thread, not the v4 thread. I've
> already started to include lots of detail about the origins of the
> code and [any] important differences in v4, and I'll continue to add
> more detail for v5.

This is indeed better.  Ard=E2=80=99s reply covers this better.
