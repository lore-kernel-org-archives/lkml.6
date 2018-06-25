Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4864C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0B1216F3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="AT4BzfOt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T/ixsBMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0B1216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932523AbeFYXNg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:13:36 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:39042 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbeFYXNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:13:32 -0400
Received: by mail-yb0-f196.google.com with SMTP id k127-v6so753512ybk.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2I/TSRshrHUJp/sKcK1TeJxvZIG63wO38KwuqhdzdqM=;
        b=AT4BzfOtTSj1SooXe/+N3QdTtOgmXphOhHdAMKZPjBuBRCE0j6pxdmnMJk59FC2B8+
         650E7jvJQW+lUyhMUR2sUKhR5ASmtAUtaG+QadgFk3ASstEMleISwyH3O383Q/hvUdlw
         elNH9df42llvkOnRl7k2MCRSmJqrHt4c+nicR8Gxg37CkYdoDfYs3eSnIyPZ1sZMq4t/
         WpsqMtFIwe6jun1UML5zlpTum65hoHmoBTLVdUHjME4xmd+/NI+PNxy5jedgY6DoFkQd
         N20VVM9+fzx2x2Ad8N6svDRGoQedmjY572OD3bhv7pZpoe7PZAowb1La4hnSP02MAtDG
         j3eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2I/TSRshrHUJp/sKcK1TeJxvZIG63wO38KwuqhdzdqM=;
        b=T/ixsBMe1AuNcWd3JaJXxAXw96JmXyTmh4muUsLRqdnwJ4bwsjh1Hgm96tkToPiGg/
         YSZBUa2GwITmjvQcUINvvfpQfvUzEeGdsCdbw5ECJAgY/xa5CExL3CWMd0MErCa69Zzr
         MFMtw4ibSgdsAV9KMiuZsGohuAZVb1GhHN234=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2I/TSRshrHUJp/sKcK1TeJxvZIG63wO38KwuqhdzdqM=;
        b=ADwuuXSK/SJmsvwW6MrVN1q+ddLb5hDF4lKMiFvC9u1g0fD7of28i3UvKR3dKerP3F
         66zQiXG9bACTA97hIMhyLQ4tmS93zBWZpH9081FUA38Fcl1BfDmd95NGD+fHcCm4388E
         XH+CRK7hRga5tZ00y5yxiNR6flMkBjuAZP0bMLKc6CUlkacbo0b0Kmu0NEYOMFTG0Do8
         eW4Hyb+HweLWLPmfcC7sTNY/tsVKOt/t6JDlQpMg6uv1NX/Tya5TvFinQagef+CLvGW+
         0iLnrTJzJppf/5NniWDPgoZY2YliH9Ct5QRS5+zhd3ZxTLXvNL6WQzbCSHDVTNlMQ7B3
         hrFg==
X-Gm-Message-State: APt69E2HSowJ8zAo8wYJ24/NJufATm7G0dcB0kemuSdpzjaRtJQ72zmW
        rNryz9oNRDh0T+2cz1iojj+ImUrTst1LBLfhS0rvjw==
X-Google-Smtp-Source: ADUXVKKrVP0oMUqzl8j5kzAuoOLiIULWVDGYkHhvQFkeeemSUV6alYwFh4PQ6qLVxTFHqf+eaO36awq/lzjT3Xez+Ls=
X-Received: by 2002:a5b:b4e:: with SMTP id b14-v6mr7596340ybr.463.1529968411904;
 Mon, 25 Jun 2018 16:13:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 16:13:31
 -0700 (PDT)
In-Reply-To: <20180625225609.GA181665@gmail.com>
References: <20180625211026.15819-1-keescook@chromium.org> <20180625211026.15819-11-keescook@chromium.org>
 <20180625225609.GA181665@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 25 Jun 2018 16:13:31 -0700
X-Google-Sender-Auth: lZz4HLcLOw5dCHXQdCTjtbWayFQ
Message-ID: <CAGXu5j+XG7y1RGMLt_=cDyiXxVhQX78_6VdHG3qwzdcwt8n7vw@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v2 10/11] crypto: ahash: Remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
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

On Mon, Jun 25, 2018 at 3:56 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Mon, Jun 25, 2018 at 02:10:25PM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this caps
>> the ahash request size similar to the other limits and adds a sanity
>> check at registration. Unfortunately, these reqsizes can be huge. Looking
>> at all callers of crypto_ahash_set_reqsize(), the largest appears to be
>> 664 bytes, based on a combination of manual inspection and pahole output:
>>
>> 4       dcp_sha_req_ctx
>> 40      crypto4xx_ctx
>> 52      hash_req_ctx
>> 80      ahash_request
>> 88      rk_ahash_rctx
>> 104     sun4i_req_ctx
>> 200     mcryptd_hash_request_ctx
>> 216     safexcel_ahash_req
>> 228     sha1_hash_ctx
>> 228     sha256_hash_ctx
>> 248     img_hash_request_ctx
>> 252     mtk_sha_reqctx
>> 276     sahara_sha_reqctx
>> 304     mv_cesa_ahash_req
>> 316     iproc_reqctx_s
>> 320     caam_hash_state
>> 320     qce_sha_reqctx
>> 356     sha512_hash_ctx
>> 384     ahash_req_ctx
>> 400     chcr_ahash_req_ctx
>> 416     stm32_hash_request_ctx
>> 432     talitos_ahash_req_ctx
>> 462     atmel_sha_reqctx
>> 496     ccp_aes_cmac_req_ctx
>> 616     ccp_sha_req_ctx
>> 664     artpec6_hash_request_context
>>
>> So, this chooses 720 as a larger "round" number for the max.
>>
>
> This isn't accounting for the cases where a hash algorithm is "wrapped" with
> another one, which increases the request size.  For example, "sha512_mb" ends up
> with a request size of
>
>         sizeof(struct ahash_request) +
>         sizeof(struct mcryptd_hash_request_ctx) +
>         sizeof(struct ahash_request) +
>         sizeof(struct sha512_hash_ctx)
>
>         == 808 bytes, on x86_64 with CONFIG_DEBUG_SG enabled.
>
>         (Note also that structure sizes can vary depending on the architecture
>          and the kernel config.)
>
> So, with the self-tests enabled your new BUG_ON() is hit on boot:

Ugh, right. Wow, that _really_ gets big. Which are likely to wrap
which others? Looks like software case plus hardware case? i.e.
mcryptd_hash_request_ctx with artpec6_hash_request_context is the
largest we could get? So: 80 + 80 + 200 + 664 ? Oh, hilarious. That
comes exactly to 1024. :P

So ... 1024?

-Kees

-- 
Kees Cook
Pixel Security
