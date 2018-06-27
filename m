Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B870FC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5674925E69
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XlY/viHp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RAhGaqA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5674925E69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965629AbeF0SMP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:12:15 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37942 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754551AbeF0SMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:12:13 -0400
Received: by mail-yb0-f193.google.com with SMTP id f12-v6so1111113ybp.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 11:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+3WyL1KjXAlJ0OQAvAuvefVeszKGoirfBzF+8NClxqc=;
        b=XlY/viHpz8wFXIL3EwyTFa7BqpgAlD8V7xmn6l4It6z39/7Aqjp+hWAIR7BX/DgSMZ
         gW2zGDCDL5hXiAo83ATLeOBqvypFSlxKcLQSgPiRLKQ24PodvpFAr3VSQEWpd9EJGdc6
         GORd9haAbEtMPm++O4eU7q3bzHwHwrHebkUuqwwBFGxIHa20vP+tYzpHGmfOq13Nn04R
         spV4G1Ye/e+k7SJ/dPgGtQPCMhhjhKEroLqhQdYRqYX0+VXNlbvpD5jjtCpaBeCumHWj
         X5AeQzsf+7h26FurEPfjYZp/mGV/6/TLbkXnGRfkoxVK2AE/FIwOMBoHLxV5JIrP65sq
         2jOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+3WyL1KjXAlJ0OQAvAuvefVeszKGoirfBzF+8NClxqc=;
        b=RAhGaqA8cbGQ0MJgcymQPf/wO0fetoldKL7c7JXUWVAuLkGCfhZbrZmRk/lo0PGM+S
         1AP3DXwHpt+ZDIsVbYlYm0VzGF3KnWCpM/DeDRsruCVINx+xDKokdImAshNkVyQkwoE0
         Tpbe1lb2DNJpDDbsWahWFImXxT17OmrQhfI6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+3WyL1KjXAlJ0OQAvAuvefVeszKGoirfBzF+8NClxqc=;
        b=TAwFLwqlTlwIgj/hS/xTq7xtQDcwtlGDSqmvENTjKvsOiDcdv/3Q3kQjQ0pKSlZul+
         uF2oQfIBcq+Rptt+oFV9XHnrp8ms8C44A+G0Tk/Edp3WKyD9AKW51mKwYjwB5owoavPb
         vwO+uuD0r72q0oUlzm0IDbdQnxfm6YZWBuWe3uvoiim0VmVZbx8V64x+lOKZiEBMxRWe
         zULiwRxxW8KD6v/YwT6kjoJUAlCmMRhNNKc6KrN3HnO8R8aLIzCJ5ImaxVYCtpPqStIe
         xP8NIw5IIRWpXPpHVjFqz+KDqchr4ojgWfqobG0umZxPavIysSvP+2zq/XEn3G6/j17I
         MTMA==
X-Gm-Message-State: APt69E328BmSpXY+OEVCxxt7m14mWeBMdRV0+c5jiS7Ltbucz4v5zloY
        ZeUcFQaO+t9ia3m+dHy76QqPfNzHcXChw2NtbG7Lxg==
X-Google-Smtp-Source: ADUXVKLD41/7+94vZiyb6BM87CXkR8QrdQ1iXeAGFP07+afEasDrLur2y6YvCyRCml0JYL5LlgpZeoCliXQR8RObT/Y=
X-Received: by 2002:a25:3445:: with SMTP id b66-v6mr3678350yba.484.1530123133000;
 Wed, 27 Jun 2018 11:12:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 11:12:12
 -0700 (PDT)
In-Reply-To: <20180627143453.gu44ghqh6jnaf4tz@gondor.apana.org.au>
References: <20180625211026.15819-1-keescook@chromium.org> <20180625211026.15819-11-keescook@chromium.org>
 <20180625225609.GA181665@gmail.com> <20180626091958.zy3m24sjukfbn7av@gondor.apana.org.au>
 <CAGXu5j+2UEUMJ0RL_XDm+Z2jBaPgshbiKaKmrYTQiP7yB2eKng@mail.gmail.com> <20180627143453.gu44ghqh6jnaf4tz@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Jun 2018 11:12:12 -0700
X-Google-Sender-Auth: qFzPiFsxg2UhaAv8pzdmaAAetfo
Message-ID: <CAGXu5jL=p28A=NtVpjjPVLeq4VvBweNjP-K_MWqde-kwDEn2TA@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v2 10/11] crypto: ahash: Remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        qat-linux@intel.com, LKML <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com, linux-crypto <linux-crypto@vger.kernel.org>,
        Lars Persson <larper@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 7:34 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Jun 26, 2018 at 10:02:31AM -0700, Kees Cook wrote:
>>
>> There is no SHASH_MAX_REQSIZE?
>>
>> As for users of AHASH_REQUEST_ON_STACK, I see:
>
> These users are only using the top-level ahash interface.  The
> underlying algorithms must all be shas.

typo? "shash" you mean?

I don't really understand the crypto APIs -- are you or Eric able to
help me a bit more here? I don't understand that things can wrap other
things, so I'm not sure the best way to reason about the maximum size
to choose here. (And the same for skcipher.)

-Kees

-- 
Kees Cook
Pixel Security
