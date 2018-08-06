Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FE8C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9057C21A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOP7qbBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9057C21A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbeHGCAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 22:00:22 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38649 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731096AbeHGCAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 22:00:22 -0400
Received: by mail-oi0-f65.google.com with SMTP id v8-v6so25334646oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 16:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkBiaToi/uo9OrWM9aAgk5o8cI/FWPbBDKYQcZNiDvo=;
        b=EOP7qbBNlUcyRRz9Bk5xsjGTTu9Zp2o29ayI2YG0SZHEZSqxC1ZI6Xh5FuXnyZhQgm
         zsIw8UUWkH9HVLi7jZqozx58jOTL/SnayCqE53lBWOXvbR4PCedu3xqNrt2404njsVSY
         HTdhpo1QjJZctmy43ZXn21Qzc+7zEIdBrfKkdb8mPcX1lnrCqf43ce1gDW3GEeXjb/U0
         D3x4AQvaNjCMYZ8yignQvK7nmKWr7Ppv28lEzfcHSMWFd46N/Lv0c7q4cxyOD0tgel5f
         beKgUSutlAtkX8H0pP8KruNlD/fS37ZLgNkph+gyXjzjIApME7jIiPZhWPvKNY8TgVHp
         WstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkBiaToi/uo9OrWM9aAgk5o8cI/FWPbBDKYQcZNiDvo=;
        b=bovtas5aLTeyIUceAC23WIcOYY+CrbD4GXLxZzqboPitAmySG28K1MUWSNXGs/e7Io
         N3OOBD+Jgh3KzSs7fiLTurugrpEaUipbZ2nq3V2ffoT00xvvlyjL0LPJGJbvOm2oT7ha
         tFfCtPlezrYVkGUR0SJzeIOZyVYm2G31N/8KwrWJh8MTbw/MzZXw7MFsgQR6weBcKhsk
         jFLGTAI0AyIZd8nwP4XuMCdaBKOMjcqPAJRGQC9HijnEXCa1SlKc57IliyFXBZSrLfdT
         ROaLBFcEyLXaz3b+Ls5ws4S2ULuOtC8mcJvBxvwq+54c5HHFuX53KCLRKJMA8xTGTiIB
         NQNg==
X-Gm-Message-State: AOUpUlG22D/FKH34emFLb1IpjhS4ftFc4RWPUWCcK+cRMZJBiS91uSWk
        /FdqKzHhFEKq0mdb8Mr+BxHCVOTvvsVpy9gPLni6/Q==
X-Google-Smtp-Source: AAOMgpeOCiPHau4px/XukwmxHBGQgVFreVqhIKGu243/PqLq30xTEJP7khfGr2O90FyPYa4LME96k+l7XeP+Yjt8SwA=
X-Received: by 2002:aca:5754:: with SMTP id l81-v6mr18125268oib.100.1533599333356;
 Mon, 06 Aug 2018 16:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180806223300.113891-1-ebiggers@kernel.org> <20180806223300.113891-4-ebiggers@kernel.org>
 <CAHmME9rbe6eT6dkUqKnp-GxcqGrp-tvMfTMr8kZtsn=S3cmP8A@mail.gmail.com>
In-Reply-To: <CAHmME9rbe6eT6dkUqKnp-GxcqGrp-tvMfTMr8kZtsn=S3cmP8A@mail.gmail.com>
From:   Paul Crowley <paulcrowley@google.com>
Date:   Mon, 6 Aug 2018 16:48:41 -0700
Message-ID: <CA+_SqcD+KpQ_X6iXUCpQh0N6pWzBorstBJDx7eBqcybY4Dvy8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] crypto: chacha20-generic - refactor to allow
 varying number of rounds
To:     Jason@zx2c4.com
Cc:     ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        samuel.c.p.neves@gmail.com, tomer.ashur@esat.kuleuven.be,
        Eric Biggers <ebiggers@google.com>, djb@cr.yp.to
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Salsa20 was one of the earlier ARX proposals, and set a very
conservative number of rounds as befits our state of knowledge at the
time. Since then we've learned a lot more about cryptanalysis of such
offerings, and I think we can be comfortable with fewer rounds. The
best attack on ChaCha breaks 7 rounds, and that attack requires 2^248
operations. Every round of ChaCha makes attacks vastly harder.

Performance is absolutely crucial when it comes to disk encryption;
users and vendors will push back hard against encryption that degrades
the user experience. So we're always going to choose the fastest
option that gives us a solid margin of security, and here that's
ChaCha12.

I'd like to turn the question around. Why 20? DJB's 20 round proposal
predates his 12 round proposal, but I don't think that's a reason to
choose it when all cryptanalysis has considered reduced-round
variants. The 20 round variant is more widely used, but again I think
that's informative more about the historical order of things than the
security. If 20 is better than 12, is 24 better than 20? What is it
that draws you to 20 rounds specifically?

(apologies for reposting, I forgot to set Plain Text Mode.)

On Mon, 6 Aug 2018 at 16:16, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hey Eric,
>
> On Tue, Aug 7, 2018 at 12:35 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > In preparation for adding XChaCha12 support, rename/refactor
> > chacha20-generic to support different numbers of rounds.
>
> I'm interested in learning the motivation behind going with ChaCha12.
> So far, the vast majority of users of ChaCha have been getting along
> quite fine with ChaCha20 and enjoying the very large security margin
> this provides. In some ways, introducing ChaCha12 into the ecosystem
> feels like a bit of a step backwards, even if it probably still
> provides adequate security (though ChaCha8 probably shouldn't be used
> or included at all). I realize the simple answer is just, "because
> it's faster." But I'm wondering specifically about the speed
> requirements and on what hardware and in what circumstances you found
> ChaCha20 was too slow, and if this is the kind of circumstance you
> expect to persist into the future.
>
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fscrypt" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
