Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202B5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82782083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSxYPXWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfBEBhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 20:37:36 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44467 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfBEBhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 20:37:36 -0500
Received: by mail-vs1-f68.google.com with SMTP id u11so1199386vsp.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 17:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zzrQqa4or0zUtyuzPrE2+DdtnHjjl4bvtJyFlMH93mw=;
        b=KSxYPXWomQVnntpqlR7M47/CZNJ77g8cgYXZY862N8qYSSFAbJeORmFD7aGf4HEEBf
         y88qIkbCHtij/Ma1PLHqyI6ahi21YU4EvVdHedb3Jyq98V8E2WwQxC7j0xqaDMt+vlBL
         FcHsEM847a4WqFrqhhUTFFEbslN/tT5iwBng6bk4uECUA/hPCVuEkEtWiKDQAvFvSa0P
         QSyQaQ40CcDGiLyarRTY3fs60zN9L7cSgv/6noboVsgkIfmFg2hZ10VXd4btQqHRVjjO
         3qoaeoS9BIM9vFRzYwiaevKCKpOIu7IiKQfFjx1VFdsWo1alPN1OKd43wQeEfC4OR1JM
         Xpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzrQqa4or0zUtyuzPrE2+DdtnHjjl4bvtJyFlMH93mw=;
        b=sK4AEqc5TwxVF67CsqhABNJL/hoMQou9aCwCPlpRNQHtkNgTLUCrqbSprWw/XX6BCO
         RfoMV5SjeoZWQC3INHQWs3qeYw93IwUgUh6XyLsJuRYfEe5aJ6U6uulZSohjzGwWNo4W
         CkhzAnaqrmoLr0BZZMo1sx83qmDxlfiN2kPlpT9mHLT018E0ZEdapW+zTB6Lbe4OAfTM
         ZMiljgvdCpBE+iga6n2USIw9wAQ69C6Vh94FESGnkwjPSGQA1t07yjDshwSyC239Vlkq
         Nv0aJ5WaffRNCxS2PqhqW640v2DGSIBAwsgKltgfVGjgF8ONEi9bXYMvLviMUINZ3wMO
         Uf/w==
X-Gm-Message-State: AHQUAubsDmsplx8sYBCO2I+U6rOn7MVPF99lYZNq8UJV/suJyy2I6wZR
        0krtU0f1V9TmdVe+KQySPpDR6V4ewA/sGouL9ct1dA==
X-Google-Smtp-Source: AHgI3IYGli6XcWoVYxdwSaRJfx9A4ElwykRPJFTgOupt26QkaH49jz2hm2tNZ8KCYtkcyeEe7xqYuclPNyIw6fjc/3k=
X-Received: by 2002:a67:5b01:: with SMTP id p1mr1013312vsb.132.1549330655035;
 Mon, 04 Feb 2019 17:37:35 -0800 (PST)
MIME-Version: 1.0
References: <20190202002023.29665-1-lyude@redhat.com> <20190202002023.29665-5-lyude@redhat.com>
In-Reply-To: <20190202002023.29665-5-lyude@redhat.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Tue, 5 Feb 2019 11:37:26 +1000
Message-ID: <CACAvsv4=+WjPHw8e3CwN-PARxoU3PsyMj9xjYhT72igg0KEN3w@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v3 4/4] drm/nouveau: Move PBN and VCPI
 allocation into nv50_head_atom
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2019 at 10:20, Lyude Paul <lyude@redhat.com> wrote:
>
> Atomic checks should never modify anything outside of the state that
> they're passed in. Unfortunately this appears to be exactly what we're
> doing in nv50_msto_atomic_check() where we update mstc->pbn every time
> the function is called. This hasn't caused any bugs yet, but it needs to
> be fixed in order to ensure that when committing an artificially
> duplicated state (like during system resume), that we reuse the PBN of
> that state to perform VCPI allocations and don't recalculate a different
> value from the drm connector's reported bpc.
>
> Also, move the VCPI slot allocations while we're at it as well. With
> this, removing a topology in suspend while using nouveau no longer
> causes the new atomic VCPI helpers to complain.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: eceae1472467 ("drm/dp_mst: Start tracking per-port VCPI allocations")
> Cc: Daniel Vetter <daniel@ffwll.ch>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>

> ---
>  drivers/gpu/drm/nouveau/dispnv50/atom.h |  6 ++++++
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 28 +++++++++++++++----------
>  drivers/gpu/drm/nouveau/dispnv50/head.c |  1 +
>  3 files changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/atom.h b/drivers/gpu/drm/nouveau/dispnv50/atom.h
> index a194990d2b0d..b5fae5ab3fa8 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/atom.h
> +++ b/drivers/gpu/drm/nouveau/dispnv50/atom.h
> @@ -116,6 +116,12 @@ struct nv50_head_atom {
>                 u8 depth:4;
>         } or;
>
> +       /* Currently only used for MST */
> +       struct {
> +               int pbn;
> +               u8 tu:6;
> +       } dp;
> +
>         union nv50_head_atom_mask {
>                 struct {
>                         bool olut:1;
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 60d858c2f2ce..e8bb35f6d015 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -659,8 +659,6 @@ struct nv50_mstc {
>
>         struct drm_display_mode *native;
>         struct edid *edid;
> -
> -       int pbn;
>  };
>
>  struct nv50_msto {
> @@ -765,17 +763,26 @@ nv50_msto_atomic_check(struct drm_encoder *encoder,
>         struct drm_connector *connector = conn_state->connector;
>         struct nv50_mstc *mstc = nv50_mstc(connector);
>         struct nv50_mstm *mstm = mstc->mstm;
> -       int bpp = connector->display_info.bpc * 3;
> +       struct nv50_head_atom *asyh = nv50_head_atom(crtc_state);
>         int slots;
>
> -       mstc->pbn = drm_dp_calc_pbn_mode(crtc_state->adjusted_mode.clock,
> -                                        bpp);
> +       /* When restoring duplicated states, we need to make sure that the
> +        * bw remains the same and avoid recalculating it, as the connector's
> +        * bpc may have changed after the state was duplicated
> +        */
> +       if (!state->duplicated)
> +               asyh->dp.pbn =
> +                       drm_dp_calc_pbn_mode(crtc_state->adjusted_mode.clock,
> +                                            connector->display_info.bpc * 3);
>
>         if (drm_atomic_crtc_needs_modeset(crtc_state)) {
>                 slots = drm_dp_atomic_find_vcpi_slots(state, &mstm->mgr,
> -                                                     mstc->port, mstc->pbn);
> +                                                     mstc->port,
> +                                                     asyh->dp.pbn);
>                 if (slots < 0)
>                         return slots;
> +
> +               asyh->dp.tu = slots;
>         }
>
>         return nv50_outp_atomic_check_view(encoder, crtc_state, conn_state,
> @@ -786,13 +793,13 @@ static void
>  nv50_msto_enable(struct drm_encoder *encoder)
>  {
>         struct nv50_head *head = nv50_head(encoder->crtc);
> +       struct nv50_head_atom *armh = nv50_head_atom(head->base.base.state);
>         struct nv50_msto *msto = nv50_msto(encoder);
>         struct nv50_mstc *mstc = NULL;
>         struct nv50_mstm *mstm = NULL;
>         struct drm_connector *connector;
>         struct drm_connector_list_iter conn_iter;
>         u8 proto, depth;
> -       int slots;
>         bool r;
>
>         drm_connector_list_iter_begin(encoder->dev, &conn_iter);
> @@ -808,8 +815,8 @@ nv50_msto_enable(struct drm_encoder *encoder)
>         if (WARN_ON(!mstc))
>                 return;
>
> -       slots = drm_dp_find_vcpi_slots(&mstm->mgr, mstc->pbn);
> -       r = drm_dp_mst_allocate_vcpi(&mstm->mgr, mstc->port, mstc->pbn, slots);
> +       r = drm_dp_mst_allocate_vcpi(&mstm->mgr, mstc->port, armh->dp.pbn,
> +                                    armh->dp.tu);
>         WARN_ON(!r);
>
>         if (!mstm->links++)
> @@ -827,8 +834,7 @@ nv50_msto_enable(struct drm_encoder *encoder)
>         default: depth = 0x6; break;
>         }
>
> -       mstm->outp->update(mstm->outp, head->base.index,
> -                          nv50_head_atom(head->base.base.state), proto, depth);
> +       mstm->outp->update(mstm->outp, head->base.index, armh, proto, depth);
>
>         msto->head = head;
>         msto->mstc = mstc;
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c b/drivers/gpu/drm/nouveau/dispnv50/head.c
> index ac97ebce5b35..2e7a0c347ddb 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/head.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
> @@ -413,6 +413,7 @@ nv50_head_atomic_duplicate_state(struct drm_crtc *crtc)
>         asyh->ovly = armh->ovly;
>         asyh->dither = armh->dither;
>         asyh->procamp = armh->procamp;
> +       asyh->dp = armh->dp;
>         asyh->clr.mask = 0;
>         asyh->set.mask = 0;
>         return &asyh->state;
> --
> 2.20.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
