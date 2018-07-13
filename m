Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC46ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D459620878
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSi2d+sI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D459620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeGMK2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:28:19 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41933 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeGMK2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:28:18 -0400
Received: by mail-lf0-f68.google.com with SMTP id v22-v6so13252366lfe.8;
        Fri, 13 Jul 2018 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9EBEHinVogE2tS+CVyfW+1dy8CEYfaXcExBNn5+ToUE=;
        b=FSi2d+sIF7kZ/c66i0iZwAc5N0obwwEWv85r5+qCLj6SeGnhw0oGb4brZC/qFURg1Z
         +lS93ppSJLsL6kjFfHzXoLZY4yNCThKpsPf/Nm9Rhmm1Xut9TSdG9YLsziI7JjFJH53y
         N4VklUlFkwUrMEq5xCR+olhW4xD+ghw6FEo6qu8G65pJMl/nbOYs1Zdmia/EEg3WeKbn
         Y1cyDmmCL+c64yirOlpMjqetssMB1qvtl2e5op3R41h2KACsuCvcp+A8Ssc2h6c7OwhO
         9PrQqNuGaDDzNavrrP7gPmZ4wxL1aNSC8jXn9IUjuVYAEhpv7Ib/0Ebmz4TDK7qJsUuc
         ZyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9EBEHinVogE2tS+CVyfW+1dy8CEYfaXcExBNn5+ToUE=;
        b=KrY4moxkoUp+U1ZxlAdIKTlwTvtPen630owEuy5xn+tVXszVe7KwQ3c1BlQrW/ed1N
         eXQ2BJueY/N+cFB85k1cZWnLHDIonVO5eLu/s6XAhNigb4rUKEQZLBOHKm5ZGzE9EiBi
         4BPoHlnGZOF+20GU3aTS7HbxJ4ERiYJEYJkOW22r/4zil+RZ+airnYLMsXbyHQA/xLf6
         AQgaH65qmjEGLTDHHOQqSBw3WrZ8Hree1FLXs+37CqZaFMdNudV8RZgYHn9LE86LDwoa
         6NiTclcm9eauiE6FpLHdWdNSglO2LS61slj+t1BAHWAZLIrCDpT1xXnxw/afqP7u/mfV
         Y/Sw==
X-Gm-Message-State: AOUpUlGn8qdAWrsLmvviI+is3Kdk1prqclvuMzUyPaG7GClHtePrdFe5
        IvSxel09fIC2g2q9acikLvuaGo0/tFZeiiDHtss=
X-Google-Smtp-Source: AAOMgpdw/DiZ4IQyGlRwY4qpkUjtK/MkL6iThhYDeGLnb2XEA35Y7A1zOaCVY/bJKoMq11p2gL+dC/0tyO7Hu3t5D54=
X-Received: by 2002:a19:5c06:: with SMTP id q6-v6mr4646249lfb.6.1531476856984;
 Fri, 13 Jul 2018 03:14:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 03:14:16
 -0700 (PDT)
In-Reply-To: <CAGXu5jLG4gE44z9cXL3-D1bjbZB1RgTnTsb3PWhU7B3NdRrwVg@mail.gmail.com>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
 <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jLYmC7U=bucFZCLsSXNX=T4WhCccR6hx9dwROYF+ZMt0Q@mail.gmail.com>
 <20180713034406.zwu2pkp3f2onybxs@gondor.apana.org.au> <CAGXu5jLR0zJ6b9axJuG_uvttNShNcN3rhQKGVjW37qPd9saY-Q@mail.gmail.com>
 <20180713052029.cfo24bsr5swtbdja@gondor.apana.org.au> <CAGXu5jLG4gE44z9cXL3-D1bjbZB1RgTnTsb3PWhU7B3NdRrwVg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Jul 2018 12:14:16 +0200
X-Google-Sender-Auth: yWgzPvQWqNpQ_dcvxAKQLsmc0ME
Message-ID: <CAK8P3a3nk4-EewKTXcLENTb86r1+bJz_WrkJoJt+D1uTwcpxPA@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Kees Cook <keescook@chromium.org>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 8:00 AM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Jul 12, 2018 at 10:20 PM, Herbert Xu
> <herbert@gondor.apana.org.au> wrote:
>> On Thu, Jul 12, 2018 at 10:17:29PM -0700, Kees Cook wrote:
>>> What is the correct value to use for AHASH_REQUEST_ON_STACK?
>>
>> As I said to arrive at a fixed value you should examine all sync
>> ahash algorithms (e.g., all shash ones plus ahash ones marked as
>> sync if there are any).
>
> The "value" for the ahash I understand: it has a request size
> (tfm->reqsize, as set by crypto_ahash_set_reqsize()) what should be
> used to measure the shash value? (And how does this relate to the
> value returned by crypto_ahash_reqsize()?) The closest clue I can find
> is this:
>
> crypto_init_shash_ops_async() does:
>         crt->reqsize = sizeof(struct shash_desc) + crypto_shash_descsize(shash);
>
> and that gets called from crypto_ahash_init_tfm(), so if it starts
> with the above reqsize and adds to it with a call to
> crypto_ahash_set_reqsize() later, we'll have that maximum?
>
> So, do I want to calculate this answer as:
>
> sizeof(struct shash_desc) + max(shash descsize) + max(ahash-sync reqsize) ?
> 16 + 360 + 0

I arrived at the same number, looking at all the sizes in shash,
The largest I found are sha3_state (360 bytes) and s390_sha_ctx
(336 bytes), everything else is way smaller.

> It's 0 above because if I look at all the callers of
> crypto_ahash_set_reqsize() that do wrapping, all are ASYNC.
>
> So, should this really just be 376? Where is best to validate this
> size, as it seems checking in crypto_ahash_set_reqsize() is
> inappropriate?

How about crypto_init_shash_ops_async()?

      Arnd
