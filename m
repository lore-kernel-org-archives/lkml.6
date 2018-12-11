Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64262C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4E22084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggBjtbLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4E22084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeLKWHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:07:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35394 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKWHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:07:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so7567368plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=twFZ/2Ir9ejk1DL1/3Wlf4z6CSxQsJRNL6sDSH+8W+A=;
        b=ggBjtbLia7bT85yMpMNGBwhDIXFfrj5IvhoRjauDa8C97jtKzdUgPEziBZNWJzCJik
         Bbps46cU+2m5bWPL87/NAMKd4pYMuO4qwOQXCLIfQxWD0vXW5YCYNhJ+6j0WAX1QpEK9
         zHswKz1hB3Lb60qjnZtEsyskM4OTXyjzDA9c1pKcFRps1cwuaNPUu+XNHLdNd4+E15el
         2xnIfM6W2QjYY489G8h3OQblKbU0ocZ4jrPIepQPCEtpQ51ugsoTFh8AOKNQh5cB2TTX
         kldz+o9b8AlEE7b/NbpOZ0XEjsRI6OFg6DF8EzqpqypVXaSeIgPv/j/cLYZKGWDFs9iv
         iUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twFZ/2Ir9ejk1DL1/3Wlf4z6CSxQsJRNL6sDSH+8W+A=;
        b=puXXUwinJfV7+oDhQtHF6C0sEsRdsEnNbUH9EEDixDnh8rM1kMt9/QfLFn1sH+sP0U
         bYyVgr8wXeSJxZN8xOq5hL+iks6YGq9fWo/KLsk92lyVu9D4NpAy7K2VSx8FJNANgJeo
         jvvZd5ROk4zBnYLDSyAsJC1agvQP/RO/FlXkSexVdsfxdzbeZDJ565J9bOTYLn7KBJjn
         yHzir6Z+7A0N7OY3j1gCoq+7t++46mGT8STbxJHlTfmvb0wzxX9nTRlhIzru5k2mSN6b
         ort5S2LHPYI62TJS2SdzOwJRWbZPQX5EHxmX/lzgRXZN0cZJkjpaH2l3h3HwqSGD95rV
         9AKw==
X-Gm-Message-State: AA+aEWYrErCQE4SUgrWmRCYUTa4Cgbkt8ZILlBYyt+OhVAcNuwAphIiy
        5oaFZ+waCjh7q6rA55rcV5cTRM1eqBtDZ/P9DuRQ4g==
X-Google-Smtp-Source: AFSGD/VYW/RXGUCPPRAU54cmem7OXOqmKNCrKznHn3qyy2tf1biDn76vFRPqLMXFfrOihVgfiWW3uGym6EMqrbxgVo8=
X-Received: by 2002:a17:902:820d:: with SMTP id x13mr18188407pln.229.1544566063192;
 Tue, 11 Dec 2018 14:07:43 -0800 (PST)
MIME-Version: 1.0
References: <20181210234201.4850-1-natechancellor@gmail.com>
 <CAKwvOdkOwdrsOAADGp9To2F5o2AAW7123yADFzYLMawwsinmug@mail.gmail.com> <20181211214240.GA31705@flashbox>
In-Reply-To: <20181211214240.GA31705@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Dec 2018 14:07:31 -0800
Message-ID: <CAKwvOdn4467193YUMCboj+Z62m0+pVMAbjAc4avCsSsng7hpPg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Pass app_tf by value rather than by reference
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 1:42 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Dec 11, 2018 at 01:25:00PM -0800, Nick Desaulniers wrote:
> > On Mon, Dec 10, 2018 at 3:42 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Clang warns when an expression that equals zero is used as a null
> > > pointer constant (in lieu of NULL):
> > >
> > > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4435:3:
> > > warning: expression which evaluates to zero treated as a null pointer
> > > constant of type 'const enum color_transfer_func *'
> > > [-Wnon-literal-null-conversion]
> > >                 TRANSFER_FUNC_UNKNOWN,
> > >                 ^~~~~~~~~~~~~~~~~~~~~
> > > 1 warning generated.
> > >
> > > This warning is caused by commit bb47de736661 ("drm/amdgpu: Set FreeSync
> > > state using drm VRR properties") and it could be solved by using NULL
> > > instead of TRANSFER_FUNC_UNKNOWN or casting TRANSFER_FUNC_UNKNOWN as a
> > > pointer. However, after looking into it, there doesn't appear to be a
> > > good reason to pass app_tf by reference as it is never mutated along the
> > > way. This is the only code path in which app_tf is used:
> > >
> > > mod_freesync_build_vrr_infopacket ->
> > >     build_vrr_infopacket_v2 ->
> > >         build_vrr_infopacket_fs2_data
> > >
> > > Neither mod_freesync_build_vrr_infopacket or build_vrr_infopacket_v2
> > > modify app_tf's value and build_vrr_infopacket_fs2_data expects just
> > > the value so we can avoid dereferencing anything by just passing in
> > > app_tf's value to mod_freesync_build_vrr_infopacket and
> > > build_vrr_infopacket_v2.
> > >
> > > There is no functional change because build_vrr_infopacket_fs2_data
> > > doesn't do anything if TRANSFER_FUNC_UNKNOWN is passed to it, the same
> > > as not calling build_vrr_infopacket_fs2_data at all like before this
> > > change when NULL was used for app_tf.
> >
> > Nathan,
> > Thanks for sending this patch.  I was hoping to provide review sooner,
> > but have been quite busy lately.
> >
>
> Late review is better than no review, I appeciate you taking the time to
> do this!
>
> > Yeah, especially for LP64 targets, the pointer to enum is larger than
> > just the enum, and if it's not being updated ("in/out paramter")
> > there's no need to pass by pointer.
> >
>
> Thanks for confirming!
>
> > >
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7 +++----
> > >  drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 2 +-
> > >  2 files changed, 4 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > > index 620a171620ee..520665a9d81a 100644
> > > --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > > +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > > @@ -656,7 +656,7 @@ static void build_vrr_infopacket_v1(enum signal_type signal,
> > >
> > >  static void build_vrr_infopacket_v2(enum signal_type signal,
> > >                 const struct mod_vrr_params *vrr,
> > > -               const enum color_transfer_func *app_tf,
> > > +               enum color_transfer_func app_tf,
> > >                 struct dc_info_packet *infopacket)
> > >  {
> > >         unsigned int payload_size = 0;
> > > @@ -664,8 +664,7 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
> > >         build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
> > >         build_vrr_infopacket_data(vrr, infopacket);
> > >
> > > -       if (app_tf != NULL)
> > > -               build_vrr_infopacket_fs2_data(*app_tf, infopacket);
> > > +       build_vrr_infopacket_fs2_data(app_tf, infopacket);
> > >
> > >         build_vrr_infopacket_checksum(&payload_size, infopacket);
> > >
> > > @@ -676,7 +675,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
> > >                 const struct dc_stream_state *stream,
> > >                 const struct mod_vrr_params *vrr,
> > >                 enum vrr_packet_type packet_type,
> > > -               const enum color_transfer_func *app_tf,
> > > +               enum color_transfer_func app_tf,
> > >                 struct dc_info_packet *infopacket)
> > >  {
> > >         /* SPD info packet for FreeSync */
> > > diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > > index 949a8b62aa98..063af6258fd9 100644
> > > --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > > +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > > @@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
> > >                 const struct dc_stream_state *stream,
> > >                 const struct mod_vrr_params *vrr,
> > >                 enum vrr_packet_type packet_type,
> > > -               const enum color_transfer_func *app_tf,
> > > +               enum color_transfer_func app_tf,
> >
> > Don't you need to update the callsite of `mod_freesync_build_vrr_infopacket` in
> >
> > drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#4949:
> >
> > -                                           NULL,
> > +                                          transfer_func_unknown,
> >
>
> That change in commit bb47de736661 ("drm/amdgpu: Set FreeSync state
> using drm VRR properties") in -next is what prompted this patch (the
> warning in the commit message is not present in mainline):

Ah! Sorry, I was looking at mainline.  I should have noticed
bb47de736661 wasn't there.

Shouldn't that change fail to compile, as transfer_func_unknown is an
`enum color_transfer_func` value, but
mod_freesync_build_vrr_infopacket takes a *pointer* to an `enum
color_transfer_func` value?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/amd/display/modules/freesync/freesync.c#n675

>
>         mod_freesync_build_vrr_infopacket(
>                 dm->freesync_module,
>                 new_stream,
>                 &vrr,
>                 packet_type_vrr,
>                 transfer_func_unknown,
>                 &vrr_infopacket);
>
> > Maybe at that point the `if (app_tf != NULL)` could be replaced with
> > `if (app_tf != transfer_func_unknown)` hoisted from
> > `build_vrr_infopacket_fs2_data`? (There's only one caller of
> > `build_vrr_infopacket_fs2_data` today, maybe fine to leave the
> > unconditional call and check).
> >
>
> Hmmm that's not unreasonable I suppose. I guess it depends on if
> build_vrr_infopacket_fs2_data could ever be called from outside of
> build_vrr_infopacket_v2; if it can, it makes sense to leave the
> conditional check for 'app_tf != transfer_func_unknown' in
> build_vrr_infopacket_fs2_data and leaving the unconditional call
> to it in build_vrr_infopacket_v2 (since app_tf is no longer a pointer,
> no need to check against NULL).
>
> I'm happy to do a v2 if the maintainers feel strongly about it, thank
> you for bringing that up.

Don't worry about it, I think it's fine.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
