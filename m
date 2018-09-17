Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A66ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A6B214EE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ttla7pXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A6B214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeIQX1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:27:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39833 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQX1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:27:10 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so7773955plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 10:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SjhPsiMTC+ekQXohtuqrvOyaIkAsZKCnqlyw6OFTGyc=;
        b=ttla7pXjL8RzrOTsZfX5hhNPU+NsVHk2WJrEH2otBz67Zs8C1NOfTLImzVJUVZWtO/
         VIVCUtG4gLqHYhfTa8Zz0TakT5FZ+AqkS0mzLz4wS6FL9yOjjOJIdcPKcR6FHPyrB4Sn
         SrfrkLUtVzy73EUp3rRhdhXVMiGHHd8G3pg8jexN/wx6+c5jHi6qxUo2mWLl/nXmPNFJ
         nWMLsMyzjGRDuKNR+YJ+qlGz1R9h1Dc6K4CmTESjev+oFNEQsT8PbHkymaC29uIzb+l8
         1JE5D+soe+ohIqrxX/uzkKLL6gn+mhJg1rdeqKIIwpk4oW+gcDNoXfWZBQJvMSOZFlL9
         NOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjhPsiMTC+ekQXohtuqrvOyaIkAsZKCnqlyw6OFTGyc=;
        b=ryAFQlF9h/vBFHpomyFk9JOSm2XZxUAf8nNbVYKd/3Nox+n4WJfXBFY5lVrgnhX2d1
         qxMAGXJJ0hzpe/fCOJSkWz3Q9wPpr8ulXvmH8/Eek+Pxo+IDuBNtcOj8HS2dIjnMCYWK
         GvXsopiH1356VDTX3BAbF7PbpR3/hx8NGwdzngIsZGpApyIKHQZDr/hQSfrSB1NEhv6/
         1co3XRGoNvoqxAli5doRZtoPDDJXKp9SjUzfI6E9thmjt3xpvQpjIWrP5oSNFJnCQHEO
         UTpgJGHMlczEXlJwQKRsS6u5nTcloAmmruturjh/vr5yuh49yQYIB9uUYtmsulO3/P1q
         InsA==
X-Gm-Message-State: APzg51DWngZxnGlAJjXN/Fm6AIc8Uf7qXqmFZWU7Ks/mY5SBKNKVWysz
        DctVPy2d7qyC6t19Y3JILF4cA0P4W8pfetxNv+OC2w==
X-Google-Smtp-Source: ANB0VdaBAP7/ZxUAMgl9pfx22+Mm3jVRITz0zqDfHqXyx9UL9231pfWnZcFqZyuT4E02h+oDqd4wLoFwZwZ+FjUqpEQ=
X-Received: by 2002:a17:902:708a:: with SMTP id z10-v6mr26239116plk.229.1537207123596;
 Mon, 17 Sep 2018 10:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180915054739.14117-1-natechancellor@gmail.com>
In-Reply-To: <20180915054739.14117-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Sep 2018 10:58:32 -0700
Message-ID: <CAKwvOdmQ4pbbPuvYrVYB9myD8ap36h6nLjEdL-mSbYjM37UJ_g@mail.gmail.com>
Subject: Re: [PATCH] [media] dib7000p: Remove dead code
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 10:47 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns that 'interleaving' is assigned to itself in this function.
>
> drivers/media/dvb-frontends/dib7000p.c:1874:15: warning: explicitly
> assigning value of variable of type 'int' to itself [-Wself-assign]
>         interleaving = interleaving;
>         ~~~~~~~~~~~~ ^ ~~~~~~~~~~~~
> 1 warning generated.
>
> It's correct. Just removing the self-assignment would sufficiently hide
> the warning but all of this code is dead because 'tmp' is zero due to
> being multiplied by zero. This doesn't appear to be an issue with
> dib8000, which this code was copied from in commit 041ad449683b
> ("[media] dib7000p: Add DVBv5 stats support").
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/media/dvb-frontends/dib7000p.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb-frontends/dib7000p.c
> index 58387860b62d..25843658fc68 100644
> --- a/drivers/media/dvb-frontends/dib7000p.c
> +++ b/drivers/media/dvb-frontends/dib7000p.c
> @@ -1800,9 +1800,8 @@ static u32 dib7000p_get_time_us(struct dvb_frontend *demod)

Something looks wrong here (with this function).  The patch is no
functional change, since as you point out `interleaving` is
initialized to 0, then never updated before read, but I think there's
an underlying bug here that should be fixed differently.  Thanks for
the patch though, as it does raise the question.

dib7000p_get_time_us has this comment above it:

  1798 /* FIXME: may require changes - this one was borrowed from
dib8000 */

Wondering if it has the same bug, it seems it does not:
drivers/media/dvb-frontends/dib8000.c#dib8000_get_time_us():3986

dib8000_get_time_us() seems to loop over multiple layers, and then
assigns interleaving to the final layers interleaving (that looks like
loop invariant code to me).

Mauro, should dib7000p_get_time_us() use c->layer[???].interleaving?
I don't see a single reference to `layer` in
drivers/media/dvb-frontends/dib7000p.c.

>  {
>         struct dtv_frontend_properties *c = &demod->dtv_property_cache;
>         u64 time_us, tmp64;
> -       u32 tmp, denom;
> -       int guard, rate_num, rate_denum = 1, bits_per_symbol;
> -       int interleaving = 0, fft_div;
> +       u32 denom;
> +       int guard, rate_num, rate_denum = 1, bits_per_symbol, fft_div;
>
>         switch (c->guard_interval) {
>         case GUARD_INTERVAL_1_4:
> @@ -1871,8 +1870,6 @@ static u32 dib7000p_get_time_us(struct dvb_frontend *demod)
>                 break;
>         }
>
> -       interleaving = interleaving;
> -
>         denom = bits_per_symbol * rate_num * fft_div * 384;
>
>         /* If calculus gets wrong, wait for 1s for the next stats */
> @@ -1887,9 +1884,6 @@ static u32 dib7000p_get_time_us(struct dvb_frontend *demod)
>         time_us += denom / 2;
>         do_div(time_us, denom);
>
> -       tmp = 1008 * 96 * interleaving;
> -       time_us += tmp + tmp / guard;
> -
>         return time_us;
>  }
>
> --
> 2.18.0
>


-- 
Thanks,
~Nick Desaulniers
