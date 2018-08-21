Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EDBC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B0621473
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJdPI6fC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B0621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeHUVYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:24:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55427 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHUVYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:24:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so3780681wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 11:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I07EKvJS33reK/4yVM4Frt/XOASp/B0SX5Kem/UHp5Q=;
        b=MJdPI6fCcE6k6Nvwin1x6q8J9EFQn/BRbAaiMf4lCAmMxE2WmT8UGLl75ytdRa/nkM
         8tZhCQ7ReutRjwVb8YyJybMgFuY0PmtlcjTz855tqMOEItJQ1THl1NfquE1QsyQywVSl
         o0p1MxbUqKO0IQY1hQ761VeDZTwLOwBOKeEUlGw4qH+CyjOmeVj1KV181wjwpND2V4Yn
         jvmx5p/iJognDBHPzm1pMtkEcuOwMmORqhl+9zF9XwX16r6j6uocqMJ+wwjUnGAvWei0
         VDCIBWcYMH9hGMBzvF8gC82O+CLygAYHPD2MXmDrbUsWUult8M8MkJ69UYdTj1p/jWX1
         UUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I07EKvJS33reK/4yVM4Frt/XOASp/B0SX5Kem/UHp5Q=;
        b=gzQJ4GWRsfmH56lhoBvOZ9LIrn+Wt034MC8qRlj8dJZ7TbDInEw4M7EmTRDZDTwnBt
         HZnPjKNZViIVxPowbk+4/L1mcDyYFB6+gBFcs2ReRb2U3Zb5w8GvTYhfy3WpMd5YOD2e
         0ETG859hIMHHisoLYj+PTNFZ91eahHP5296EGgZtJ05M6NS5cH86m4uxnzBl+mKKB6kk
         jBG5rbWo6/m3UaRsjGzmUbO2NFddgKZmc747ajnHm3tClb1op6w6jpiou/MAGt520Xty
         Sf3zprKOpw4g7y+caKJrrv8gIgMnXdHpC/KZHULR+JSthyU+/V7V8MBihOhjAGj7FMrl
         nKMA==
X-Gm-Message-State: APzg51C5aA3f8Dus6f3jw8lg8Qc0nfjT2h2VCh1V62/hc6LAknENGViO
        N0BwAgOqkDJ0ozBWRD1CTJfVaf/lXK3BveZSEN2lVg==
X-Google-Smtp-Source: ANB0VdbqJkAadmObSYXxrZFNHa3Xd2fEuAMOb7ivxuThUnWEZNtQy3HEvQN+B1hQbCT4le7U/cNMAuZ9c/GRtmBx/oI=
X-Received: by 2002:a1c:d750:: with SMTP id o77-v6mr266413wmg.67.1534874600750;
 Tue, 21 Aug 2018 11:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <1534475388-40036-1-git-send-email-wen.yang99@zte.com.cn> <783744d1-29a2-c601-7d1f-b937308d407c@infradead.org>
In-Reply-To: <783744d1-29a2-c601-7d1f-b937308d407c@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 21 Aug 2018 14:03:06 -0400
Message-ID: <CADnq5_NfTLXxLrsx+hUnfShPZFfVpzposmnmXe5WXV_R_WMZig@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix a compile warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     wen.yang99@zte.com.cn, Dave Airlie <airlied@linux.ie>,
        Chunming Zhou <David1.Zhou@amd.com>, zhong.weidong@zte.com.cn,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        jiang.biao2@zte.com.cn, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 3:01 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 08/16/2018 08:09 PM, Wen Yang wrote:
> > Fix comile warning like,
> >   CC [M]  drivers/gpu/drm/i915/gvt/execlist.o
> >   CC [M]  drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.o
> >   CC [M]  drivers/gpu/drm/radeon/btc_dpm.o
> >   CC [M]  drivers/isdn/hisax/avm_a1p.o
> >   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_dpp.o
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In=
 function =E2=80=98dcn10_update_mpcc=E2=80=99:
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:190=
3:9: warning: missing braces around initializer [-Wmissing-braces]
> >   struct mpcc_blnd_cfg blnd_cfg =3D {0};
> >          ^
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:190=
3:9: warning: (near initialization for =E2=80=98blnd_cfg.black_color=E2=80=
=99) [-Wmissing-braces]
> >
> > Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> > Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
>
> works for me.  Thanks.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>

Applied.  thanks!

Alex

>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c =
b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > index cfcc54f..a06a035 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > @@ -1900,7 +1900,7 @@ static void update_dpp(struct dpp *dpp, struct dc=
_plane_state *plane_state)
> >  static void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx=
)
> >  {
> >       struct hubp *hubp =3D pipe_ctx->plane_res.hubp;
> > -     struct mpcc_blnd_cfg blnd_cfg =3D {0};
> > +     struct mpcc_blnd_cfg blnd_cfg =3D {{0}};
> >       bool per_pixel_alpha =3D pipe_ctx->plane_state->per_pixel_alpha &=
& pipe_ctx->bottom_pipe;
> >       int mpcc_id;
> >       struct mpcc *new_mpcc;
> >
>
>
> --
> ~Randy
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
