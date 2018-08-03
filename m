Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67214C46469
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129C02178D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="XGbr8q1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129C02178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeHCX1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:27:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40250 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729660AbeHCX1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:27:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15-v6so6607807wrs.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l1tAkLcH7lLC/RDYF8Guzuabgc/xwWes/KPNuA5AhRI=;
        b=XGbr8q1D3QfUbht9WiOxMZ+CELSxGQJaa6dPA6OWSq9pjdDU1TiKuKiHYwOsUdJ4fx
         wuNB6iBiRjEKHjXb0xjaup4d0mlszEFmBOCaQ89FPRufZB8HLu6OJj7hjaU1OQQq6Ba9
         IoJU/mDyup8OmULBZHOa8pfhGL+Umf8LmfxXiDiwZp4Wr3dV6WecfaLyXaJCoxQyv/xB
         vDAHWQ+zsnOVJLVimsfGL5HhaXOyY7/bN6DVtk8gkrG9hvkI0YDKTKWWpQInx4tSVgZM
         XjpS6+RzY7FsCErK8OTNSPMo9Md1tHmMltHTVkw5R4iMd3y6f0ZGOywiQwSOoCBOfaQS
         QLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l1tAkLcH7lLC/RDYF8Guzuabgc/xwWes/KPNuA5AhRI=;
        b=fucNZTd2BcUj9hJgQKhcwxxfTzXuFcJbRI9DTzx8d9lPrnTNKd+MFwlxPsbNF85XRn
         ftnrMF983KUKC8lO5Bbhk69nbEx5Ru6B6qZ1bFXnfULIqJOjCKEDuAusGorh/nxLL8Ma
         dNXsM2lnXIw9QDMKUkZD8JVSPArD/gqzT6HnXDJIyizdr+hXqpUcWsvMPoPW/FXZTito
         XFNMagt63Y47OuhHxQFm3csIyHzsHPQoo/WcB+a85UaVnvDRyfvR8ZMP6iwRsKqWfRCZ
         QidQA5kuJl6Sjwy7Y7k70YKG4LFpFmf6nNCpUel6I7HqTBJhVyK/Qna8jrST38UbAxo3
         QyRA==
X-Gm-Message-State: AOUpUlHkYkDGpAiFCT2+zIZGxon5fQ429Ukuw0AS/xIKQmivgVLz/wVE
        jnc5l72g/aSqEHbHmhIaOjOz587MiGjgFMUm3rOXjQ==
X-Google-Smtp-Source: AAOMgpfB1mvRmHnkVxJloWGVvSKo9llDapZzeT5BgPa5ikgcFbKaYKxRjSatrpfBoh0PRt6DGyKKTpdaOcWHWVS647w=
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr3537290wrd.67.1533331762210;
 Fri, 03 Aug 2018 14:29:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 14:29:01 -0700 (PDT)
In-Reply-To: <CAHmME9oThR-dE3gTW0UyqAGZO80qu19ktG4YTb4iL6CNpzNNaw@mail.gmail.com>
References: <20180801072246.GA15677@sol.localdomain> <CALCETrXD_VyoyW5C1U34o-ySJ4nFcO6PQ+ZNBVYxCpJ-f65CHw@mail.gmail.com>
 <CAHmME9oThR-dE3gTW0UyqAGZO80qu19ktG4YTb4iL6CNpzNNaw@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 3 Aug 2018 14:29:01 -0700
Message-ID: <CALCETrVziUpAU4nTaZ=t5ct=1jsWswWOy7KDNxXGPD1L=tMTGQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] zinc: Introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        "Daniel J . Bernstein" <djb@cr.yp.to>,
        Tanja Lange <tanja@hyperelliptic.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Karthikeyan Bhargavan <karthik.bhargavan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 7:48 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hey Andy,
>
> Thanks too for the feedback. Responses below:
>
> On Wed, Aug 1, 2018 at 7:09 PM Andy Lutomirski <luto@amacapital.net> wrote:
>> > I think the above changes would also naturally lead to a much saner
>> > patch series where each algorithm is added by its own patch, rather than
>> > one monster patch that adds many algorithms and 24000 lines of code.
>> >
>>
>> Yes, please.
>
> Ack, will be in v2.
>
>
>> I like this a *lot*.  (But why are you passing have_simd?  Shouldn't
>> that check live in chacha20_arch?  If there's some init code needed,
>> then chacha20_arch() should just return false before the init code
>> runs.  Once the arch does whatever feature detection it needs, it can
>> make chacha20_arch() start returning true.)
>
> The have_simd stuff is so that the FPU state can be amortized across
> several calls to the crypto functions. Here's a snippet from
> WireGuard's send.c:
>
> void packet_encrypt_worker(struct work_struct *work)
> {
>     struct crypt_queue *queue = container_of(work, struct
> multicore_worker, work)->ptr;
>     struct sk_buff *first, *skb, *next;
>     bool have_simd = simd_get();

Gotcha.  That was very hidden in the 24k lines.  Please make this (and
any similar goodies) be their own patches.

Also, please consider spelling it differently:

simd_context_t simd_context = simd_get();

Because we'll feel very silly the first time some architecture has
more than one possible state.  (It wouldn't be entirely insane for x86
to distinguish between "no SIMD", "XMM only", and "go to town!", for
example.)
