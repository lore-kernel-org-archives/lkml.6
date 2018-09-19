Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115DFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB5321522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZgxHWlz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB5321522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbeISWeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:34:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40035 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbeISWeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:34:20 -0400
Received: by mail-io1-f68.google.com with SMTP id l14-v6so5050709iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bYN4nchF7JLla5tLmZryLNZGGqi8p5WF3W8RE2ECWQc=;
        b=eZgxHWlzBnrJvDxgFchvKp1iqgLj+ZM3ZJVDhvyu7Z/NBuKUyRDX9EYrHPPsnTshZs
         fu8HY8pYgBMHlmPCkI21JNvWpbKiODHhDJCwOV6A+sxCSKSslMOS6iUGKQs5oxFewPRg
         LlW+REHtDMP0P4aGV3+zYVgIFYBt54nCNy1bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bYN4nchF7JLla5tLmZryLNZGGqi8p5WF3W8RE2ECWQc=;
        b=hQOMEu/PbKXdOPGOzYTiPeqHhBtjDdO3+unxlte3cp+DnNYmObVHhYI7oyL4Xelnsb
         xXOR7tBKMvdJnm8cjwXtNFo1b4clnTDta1dbQMC7vrkumJnaac4faw8lT3t2PXXYZotq
         dvjSykHrdhqoKaJvsZoLH1W4IaDhnxm1JEVWXd0KQVxbpmykIt226aFp0W5bShGWUXNb
         bsusQrf0izn5Kb77qRBB7k/T6AyEWfamZMaCADbMTJAxTBE6jqHbKSW/tuWLD3BX2Hzm
         Yhxu91hV78Tp2+h+4nlv0dPTqTlGrSJKXIZtxpJI7sq0yRrJYKRP1+4zDYs49mpn9cJl
         WgOA==
X-Gm-Message-State: APzg51D88ez8va2uGH8ZV59xnFvzNK7os+lw41t2i7AE5kRi+K7fMHcQ
        8yZnONI34k2mg/EkhU+udficNC6iJeJ8+EHk76VHIQ==
X-Google-Smtp-Source: ANB0VdZBTM2LH0FxgQ1kNPPHsB2wnby1McMq5s0cP/71duyDMQxCFjnUOW3v3ebloP7HSsUJymDF/qQLCQqn/yc+s+g=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr29617290iof.173.1537376133959;
 Wed, 19 Sep 2018 09:55:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 09:55:32
 -0700 (PDT)
In-Reply-To: <20180918203658.GA28723@zx2c4.com>
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
 <CAKv+Gu8QgRo-Oex2Sk5unET3FMq+1Cp2btAWXCB8xsALxjatHg@mail.gmail.com>
 <CAHmME9qwRzuoo-3Hxahwu=Li2LCz06Uowaq1GFmkts6tsffM7w@mail.gmail.com>
 <CAKv+Gu8OKyVvvgLy48GDV2KJt-UmmHbf5x0qNxQC_SDiddb9-g@mail.gmail.com> <20180918203658.GA28723@zx2c4.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 19 Sep 2018 09:55:32 -0700
Message-ID: <CAKv+Gu-JVLCbMuqFzsdC5TwOu0_jS4OeekD_GQcunV_7zGxAbQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 September 2018 at 13:36, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Ard,
>
> On Tue, Sep 18, 2018 at 11:53:11AM -0700, Ard Biesheuvel wrote:
>> On 17 September 2018 at 08:52, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> > Hi Ard,
>> >
>>
>> Given that you show no interest whatsoever in gaining an understanding
>> of the underlying requirements that we have to deal with in the crypto
>> API, the only way to get my point across is by repeatedly stating it
>
> Sorry if I've come across that way, but I am certainly interested in
> gaining such an understanding of said requirements.
>

Excellent.

So you are probably aware that there is a big push in the industry
these days towards high-performance accelerators on a coherent fabric,
potentially with device side caches, and this is the main reason that
the crypto API abstractions are the way they are today.

So while standardizing on Chacha20Poly1305 in WireGuard [while still a
policy decision in my view] seems reasonable to me, the decision to
limit WireGuard to synchronous software implementations seems to me
like something we may want to revisit in the future. What is your view
on that? And is the ChaCha20/Poly1305 AEAD construction in WireGuard
identical to the one in RFC 7539, i.e., could an accelerator built for
the IPsec flavor of ChaCha20Poly1305 potentially be reused for
WireGuard?
