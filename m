Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E028AC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC49321473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfhzR9tE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC49321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbeJFAtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:49:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39926 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbeJFAtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:49:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id c20-v6so13496550otl.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 10:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oG8WQn2IxUV23Frl9GKGcK3r9SskFlESO3IjhBiT+mo=;
        b=dfhzR9tE/sJY7hvL4IOp8S/jTK2VA2Zl91To+E96HDBI+YMVf2S6EqDQ9c+JWn7H+y
         AK8Uac2qlU+5JwG19nSzKznCA/SHCKE3wEgO7c6yuf7osQKRGwSW6AUODPzVw7C0GiPr
         Nwc2AlmJnp+RHQr8yZ6Z4eOR4yy+eFdaC1i203y0isZAT/sRvv3YFlnoMYAC+xZXkPZQ
         dvlN1dEp029Y59k3vkkpBmkFw+iAySft4rlkFJZB/+ccmsS4wWfmNHjYOqxFeURP80Ut
         z5lYh60tkJYkCOoT+8Gvo6WTG63MwDNz9CgL8H2QJ/cmS1zrZlzbFvRDZR3rFzC4Okcd
         f7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oG8WQn2IxUV23Frl9GKGcK3r9SskFlESO3IjhBiT+mo=;
        b=Kf2VFUvj07iWLuH2KTFHC1vBS4imgmSiF4bqHcGKshxg6zRddFHPYzLEnREwL5j21l
         Y4GkDsaTpdeib8wugxMKhKXvd6kuaW7srO9+xeKyVoeDxNkVXh8MBM/IgrF/ibn5SsGV
         huZSkhvv8Gs/ff1l3/+98LljeF/wp++HiUtEC+0PRKDMG2r8ge3j+4N3U5qLoASvSqaL
         war1WNb7ltX8H1m9iG/TIuUmzyVrBw7/wzsvUTZpufILAcIcYt0uBtsFmozoaHv0BAVA
         Rq/O0se1Bz4Z9gl4+KZPAfBwLlr+wNa40z5HZLUXGcmviX479C/zw5/emeBvyS+CkOnI
         BT/A==
X-Gm-Message-State: ABuFfogIvgJN1M/cM/ECCuJrBfiaZGarspm4s7WMxrPjV2vjDoUwXgR3
        opwE1mAOalfzPgDZkvSzs0K7vTIlGNAThLzex4aYCg==
X-Google-Smtp-Source: ACcGV62bLdY9Uo62/NBuUVJlrW5OR/If2wMzxCXhQuZLMqZjIkv3astgK2VVul3F0z6k5lfE2JMOPd/TNmslwVu3bao=
X-Received: by 2002:a9d:49ac:: with SMTP id g44mr7483561otf.198.1538761762069;
 Fri, 05 Oct 2018 10:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181005161759.177992-1-jannh@google.com> <c34442b0-be90-450e-8c20-6e490cc45be9@solarflare.com>
In-Reply-To: <c34442b0-be90-450e-8c20-6e490cc45be9@solarflare.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 5 Oct 2018 19:48:55 +0200
Message-ID: <CAG48ez3OxEhzU3KR8jaRh5fQGF_HNpJB08iXY3ZUv9YY+Q8RRQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: 32-bit RSH verification must truncate input before
 the ALU op
To:     Edward Cree <ecree@solarflare.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 7:45 PM Edward Cree <ecree@solarflare.com> wrote:
> On 05/10/18 17:17, Jann Horn wrote:
> > When I wrote commit 468f6eafa6c4 ("bpf: fix 32-bit ALU op verification"), I
> > assumed that, in order to emulate 64-bit arithmetic with 32-bit logic, it
> > is sufficient to just truncate the output to 32 bits; and so I just moved
> > the register size coercion that used to be at the start of the function to
> > the end of the function.
> >
> > That assumption is true for almost every op, but not for 32-bit right
> > shifts, because those can propagate information towards the least
> > significant bit. Fix it by always truncating inputs for 32-bit ops to 32
> > bits.
> >
> > Also get rid of the coerce_reg_to_size() after the ALU op, since that has
> > no effect.
> Might be worth saying something like "because src_reg is passed by value".
> > Fixes: 468f6eafa6c4 ("bpf: fix 32-bit ALU op verification")
> > Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> Acked-by: Edward Cree <ecree@solarflare.com>
> >  kernel/bpf/verifier.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index bb07e74b34a2..465952a8e465 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2896,6 +2896,15 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
> >       u64 umin_val, umax_val;
> >       u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
> Incidentally, I don't see why this needs to be a u64 (rather than say a u8).

Yeah, the size of the integer doesn't really matter there... but it's
being compared against other u64 values further down, so I also don't
see a particular need to change it.
