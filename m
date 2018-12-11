Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A6AC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523282084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dep8vHSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523282084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbeLKWYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:24:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40210 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeLKWYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:24:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so15720895wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TlOjKgflAYFBQU1xBX/OZlZVA67mEmvOWdcDiZG2Ghs=;
        b=Dep8vHSBLiYpMwt95zVUqRfz+EpH9OYJ04R6VEOUZ2vKo7dXp/rbWt56tgYAW/45yb
         AZv3NOZRKBWtvmr15sbtsI7zHIYszr3GUzwVJrVJtE8H87Qwng9ytAwtmqvjQv4LH+81
         8tJwKppMp2UOYWdZj9zUf1h67J8K4a5v92Wcx1QBYPQHG+mObdqCfV1YM5a4STE4rU0Z
         jMPMvclCxiDfzrhkxv33k9mP9v9YOtbbepiVzN/m75ZJTr5+C1cXgfilKVrQO/ls6S2O
         Gf+HIuxTFQ8VVaOMclW2Ci48y7PMV2rYWVxwOjmNwi94UWW4PAV/wyPCHD/SCnpIEqmh
         DyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TlOjKgflAYFBQU1xBX/OZlZVA67mEmvOWdcDiZG2Ghs=;
        b=lPahEd7pLWY1fo2NB3ivV5yDDlwM7uB6GXPxtunQufWB43RcQ4q2iItYVFXQQo5XGc
         TTxz2zK4+JzHuSSULxjrJ1hJ5E/n3xlF/dU9eMhQM3d7tfnJhC7EOSfWwaBJRP2Nhgkt
         ffd+6jnh31pTlhBcXjRfaNsCW5VUDSYiOHrZ3N+uTk33eHLfUSrblL4IPHJYKZ9yi+G1
         5DQshp6kImXwzqCRe5jM2x/Z6vEln0UpdRH0Vj3k0Pfugo6z4JqExv42C8uHWFvhIA7T
         hXdB2PCU3y7Jw2Ixp2kjYJN+bibzXnfWkLslGPsbhxv4OASktSj7LflxS0aEH29Byghy
         4h6A==
X-Gm-Message-State: AA+aEWZHlNhBFikXZIwOhG/W5l1aiwrZOFWjWf+Kat4AXomuyLdU86Yv
        /yfgNyTFxibghcexRRZo2o0=
X-Google-Smtp-Source: AFSGD/XjysSErcO0nZ/3ps4CRju2MOPI23ZxBm71yZsHfX/WPthqr6QAbaQNvQcAq+XDbF06e8++Ow==
X-Received: by 2002:a5d:46c2:: with SMTP id g2mr15765289wrs.49.1544567073069;
        Tue, 11 Dec 2018 14:24:33 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id o82sm1460250wmo.29.2018.12.11.14.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:24:32 -0800 (PST)
Date:   Tue, 11 Dec 2018 15:24:30 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Harry Wentland <harry.wentland@amd.com>, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: Pass app_tf by value rather than by
 reference
Message-ID: <20181211222430.GA17468@flashbox>
References: <20181210234201.4850-1-natechancellor@gmail.com>
 <CAKwvOdkOwdrsOAADGp9To2F5o2AAW7123yADFzYLMawwsinmug@mail.gmail.com>
 <20181211214240.GA31705@flashbox>
 <CAKwvOdn4467193YUMCboj+Z62m0+pVMAbjAc4avCsSsng7hpPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn4467193YUMCboj+Z62m0+pVMAbjAc4avCsSsng7hpPg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 02:07:31PM -0800, Nick Desaulniers wrote:
> On Tue, Dec 11, 2018 at 1:42 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Tue, Dec 11, 2018 at 01:25:00PM -0800, Nick Desaulniers wrote:
> > > On Mon, Dec 10, 2018 at 3:42 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > Clang warns when an expression that equals zero is used as a null
> > > > pointer constant (in lieu of NULL):
> > > >
> > > > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4435:3:
> > > > warning: expression which evaluates to zero treated as a null pointer
> > > > constant of type 'const enum color_transfer_func *'
> > > > [-Wnon-literal-null-conversion]
> > > >                 TRANSFER_FUNC_UNKNOWN,
> > > >                 ^~~~~~~~~~~~~~~~~~~~~
> > > > 1 warning generated.
> > > >
> > > > This warning is caused by commit bb47de736661 ("drm/amdgpu: Set FreeSync
> > > > state using drm VRR properties") and it could be solved by using NULL
> > > > instead of TRANSFER_FUNC_UNKNOWN or casting TRANSFER_FUNC_UNKNOWN as a
> > > > pointer. However, after looking into it, there doesn't appear to be a
> > > > good reason to pass app_tf by reference as it is never mutated along the
> > > > way. This is the only code path in which app_tf is used:
> > > >
> > > > mod_freesync_build_vrr_infopacket ->
> > > >     build_vrr_infopacket_v2 ->
> > > >         build_vrr_infopacket_fs2_data
> > > >
> > > > Neither mod_freesync_build_vrr_infopacket or build_vrr_infopacket_v2
> > > > modify app_tf's value and build_vrr_infopacket_fs2_data expects just
> > > > the value so we can avoid dereferencing anything by just passing in
> > > > app_tf's value to mod_freesync_build_vrr_infopacket and
> > > > build_vrr_infopacket_v2.
> > > >
> > > > There is no functional change because build_vrr_infopacket_fs2_data
> > > > doesn't do anything if TRANSFER_FUNC_UNKNOWN is passed to it, the same
> > > > as not calling build_vrr_infopacket_fs2_data at all like before this
> > > > change when NULL was used for app_tf.
> > >
> > > Nathan,
> > > Thanks for sending this patch.  I was hoping to provide review sooner,
> > > but have been quite busy lately.
> > >
> >
> > Late review is better than no review, I appeciate you taking the time to
> > do this!
> >
> > > Yeah, especially for LP64 targets, the pointer to enum is larger than
> > > just the enum, and if it's not being updated ("in/out paramter")
> > > there's no need to pass by pointer.
> > >
> >
> > Thanks for confirming!
> >
> > > >
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7 +++----
> > > >  drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 2 +-
> > > >  2 files changed, 4 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > > > index 620a171620ee..520665a9d81a 100644
> > > > --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > > > +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > > > @@ -656,7 +656,7 @@ static void build_vrr_infopacket_v1(enum signal_type signal,
> > > >
> > > >  static void build_vrr_infopacket_v2(enum signal_type signal,
> > > >                 const struct mod_vrr_params *vrr,
> > > > -               const enum color_transfer_func *app_tf,
> > > > +               enum color_transfer_func app_tf,
> > > >                 struct dc_info_packet *infopacket)
> > > >  {
> > > >         unsigned int payload_size = 0;
> > > > @@ -664,8 +664,7 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
> > > >         build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
> > > >         build_vrr_infopacket_data(vrr, infopacket);
> > > >
> > > > -       if (app_tf != NULL)
> > > > -               build_vrr_infopacket_fs2_data(*app_tf, infopacket);
> > > > +       build_vrr_infopacket_fs2_data(app_tf, infopacket);
> > > >
> > > >         build_vrr_infopacket_checksum(&payload_size, infopacket);
> > > >
> > > > @@ -676,7 +675,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
> > > >                 const struct dc_stream_state *stream,
> > > >                 const struct mod_vrr_params *vrr,
> > > >                 enum vrr_packet_type packet_type,
> > > > -               const enum color_transfer_func *app_tf,
> > > > +               enum color_transfer_func app_tf,
> > > >                 struct dc_info_packet *infopacket)
> > > >  {
> > > >         /* SPD info packet for FreeSync */
> > > > diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > > > index 949a8b62aa98..063af6258fd9 100644
> > > > --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > > > +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > > > @@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
> > > >                 const struct dc_stream_state *stream,
> > > >                 const struct mod_vrr_params *vrr,
> > > >                 enum vrr_packet_type packet_type,
> > > > -               const enum color_transfer_func *app_tf,
> > > > +               enum color_transfer_func app_tf,
> > >
> > > Don't you need to update the callsite of `mod_freesync_build_vrr_infopacket` in
> > >
> > > drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#4949:
> > >
> > > -                                           NULL,
> > > +                                          transfer_func_unknown,
> > >
> >
> > That change in commit bb47de736661 ("drm/amdgpu: Set FreeSync state
> > using drm VRR properties") in -next is what prompted this patch (the
> > warning in the commit message is not present in mainline):
> 
> Ah! Sorry, I was looking at mainline.  I should have noticed
> bb47de736661 wasn't there.
> 
> Shouldn't that change fail to compile, as transfer_func_unknown is an
> `enum color_transfer_func` value, but
> mod_freesync_build_vrr_infopacket takes a *pointer* to an `enum
> color_transfer_func` value?
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/amd/display/modules/freesync/freesync.c#n675
> 

Unfortunately, no. GCC does not warn like Clang does when an expression
that equals zero is passed to a function requiring a pointer (it just
silently treats it as NULL, whereas Clang audibly complains).

They both do when the expression is something other than zero.

https://godbolt.org/z/goo91G

Nathan

> >
> >         mod_freesync_build_vrr_infopacket(
> >                 dm->freesync_module,
> >                 new_stream,
> >                 &vrr,
> >                 packet_type_vrr,
> >                 transfer_func_unknown,
> >                 &vrr_infopacket);
> >
> > > Maybe at that point the `if (app_tf != NULL)` could be replaced with
> > > `if (app_tf != transfer_func_unknown)` hoisted from
> > > `build_vrr_infopacket_fs2_data`? (There's only one caller of
> > > `build_vrr_infopacket_fs2_data` today, maybe fine to leave the
> > > unconditional call and check).
> > >
> >
> > Hmmm that's not unreasonable I suppose. I guess it depends on if
> > build_vrr_infopacket_fs2_data could ever be called from outside of
> > build_vrr_infopacket_v2; if it can, it makes sense to leave the
> > conditional check for 'app_tf != transfer_func_unknown' in
> > build_vrr_infopacket_fs2_data and leaving the unconditional call
> > to it in build_vrr_infopacket_v2 (since app_tf is no longer a pointer,
> > no need to check against NULL).
> >
> > I'm happy to do a v2 if the maintainers feel strongly about it, thank
> > you for bringing that up.
> 
> Don't worry about it, I think it's fine.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> -- 
> Thanks,
> ~Nick Desaulniers
