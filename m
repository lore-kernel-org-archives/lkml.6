Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ED7ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FE12147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="u7LKRZ9Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EIw9lXXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FE12147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbeGLUeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:34:18 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:46005 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732391AbeGLUeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:34:18 -0400
Received: by mail-yw0-f194.google.com with SMTP id 139-v6so10926283ywg.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Qp9XrCjDlrTvpp2/shwNgeaHX5kY0gaKvBENU8mBZjI=;
        b=u7LKRZ9ZeRBwzjeVNzoV7Xfv5YMs6fu/qC1gwMpLcgFOtjv+atyVWw0pb9IDiLUWP2
         wHJ0PWFJKvCjnYqposDHnn6e/Pqt7GpDexL1OpGv/1qSmOkOa0e4PoAlKqyHGb7iqbcR
         qn6lCJmPzyHKeHOwUJ4MR6YwjiYuMIdD5a3y+YrIhmaLesgLFL22EeJan7qoxDl9DIEZ
         wbA+8YCe0jbqDum7CSgOoierE/HccGWocNx+zUqGn4P3rivvw3rmLqHDKMyQJkSKmbSa
         RQubGnSS298uf9QaXvQZM62a28gHRs9LHmWLET88eUTPYtow2q8h5/R+GfWZdUOT9X0L
         mvng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Qp9XrCjDlrTvpp2/shwNgeaHX5kY0gaKvBENU8mBZjI=;
        b=EIw9lXXUlooim1Aa5qnaxRgwF6K07Ltyu4/D2A8DZq0jIiCj8NNJ7kj0LiFRGazcjE
         76lnXdxhjt8ZMQnGGxiW0jxwf1ZSeyqJ3buFC3gsEHMKSzTFbmaejVT9+PN+8FyIQRpd
         OtvHFYV78BB51m+su5tN9slyCR1RFEIi1rCRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Qp9XrCjDlrTvpp2/shwNgeaHX5kY0gaKvBENU8mBZjI=;
        b=Yug7Hh3yg8J1p3rzphphVqySo22NVhhVrKmGewhjDfDJV+mJ9dm3kdC3Q991zL1i9M
         SqMhE8pw2E0A704/6vGPTHd8wmJX6wnoYPqS1ZNU33GV4yQO8guOiv8fOnBaEzOGCpZl
         mdsbdkAgqkyJyeoIu2ZVjflDCxea3nMSvTU+nZVoKIHxHOn6g56EDzbTvLj+pRHIqqhY
         9wvOi4BiFme4UiINaYECK0Waxx+y+Encg7tzRw/vELPiVJ/rcDnf0ESFonSgyzNiInnq
         yeQUFBtrlNboBaxjCjL9pwpR7u2XdujO4D6dB8THaFu7Dgs0ptmV7B3k4SN9G5e0hxkY
         4fag==
X-Gm-Message-State: AOUpUlFrShufpQUCJ+nKcR+V1kWlUoRGkhVIhcBsEhPcHkr92+CwV1b8
        ynoAjrXXiYgC2aIlmvZXXaaGqniuZWR/x0/AAb4A+A==
X-Google-Smtp-Source: AAOMgpc9QjX2DL2NiO2ps53oHYDVlNidIgKnqx5GPQ9LGwCOMIH1QdBw/MqL+0vBfbwjgQNN5seNToHZ3e6CuTHUWwk=
X-Received: by 2002:a0d:e2cd:: with SMTP id l196-v6mr1821350ywe.38.1531426987898;
 Thu, 12 Jul 2018 13:23:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 13:23:07
 -0700 (PDT)
In-Reply-To: <CAK8P3a1k+cy9wAVNQMWE4tdA4aV8tiu6K3haLc+kMPt0iiUQ9Q@mail.gmail.com>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-14-keescook@chromium.org>
 <CAK8P3a1k+cy9wAVNQMWE4tdA4aV8tiu6K3haLc+kMPt0iiUQ9Q@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 12 Jul 2018 13:23:07 -0700
X-Google-Sender-Auth: 7MCj1LJXpxMe0BIhEdizAc2qcJs
Message-ID: <CAGXu5jLUME9cjntUUed9EYukzEaODDzqRmtGht=uu7YVAG2WWg@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] rxrpc: Prepare to remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 8:11 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Jul 11, 2018 at 10:36 PM, Kees Cook <keescook@chromium.org> wrote:
>> Two uses of SKCIPHER_REQUEST_ON_STACK() will trigger FRAME_WARN warnings
>> (when less than 2048) once the VLA is no longer hidden from the check:
>>
>> net/rxrpc/rxkad.c:398:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>> net/rxrpc/rxkad.c:242:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>
>> This bumps the affected objects by 20% to silence the warnings while
>> still providing coverage is anything grows even more.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> (adding David Howells to cc)
>
> I don't think these are in a fast path, it should be possible to just use
> skcipher_alloc_req() instead of SKCIPHER_REQUEST_ON_STACK() here.
> From what I can tell, neither of the two are called in atomic context, so
> you should be able to use a GFP_KERNEL allocation.

Sure, I can do that instead.

-Kees

-- 
Kees Cook
Pixel Security
