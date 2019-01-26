Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E2BC282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13471218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlX4IY1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfAZDmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:42:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45053 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfAZDmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:42:21 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so8885105edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 19:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bz5xbLN1LlTc1jcBMgIUmo/QyfyWOqoeVgo0gmif0cg=;
        b=XlX4IY1en317kTf1prwZuwAkDb+pCX7AN0QMH8dc/aaRyjXMPDf/oQ3iDYMnOFeLkr
         /FgC0Prr0rSxuwEppwKKGqgQ/xQtGtuUKHFVvtriwuz3A+ZT7M2zAXl37n6ekewe3Cvh
         lEBt8VmIQNgIS9QZBUPAjtM7V0tTtU5ldKBNM/FnNdCNiuwGZW/GTynD8UctOsDCzNzW
         7AQDNTns4UBdAzbJDR47hSFBeP3rh0FuGDnQniRLZNuGm3P4dOtU3aWxRFlXzIoI2e9/
         rHishHSuIjbEYc8AiPxDh7cewnWT3sXcctBc9JTzExIdpD2GS8068MKbysw32GycnrV0
         XGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bz5xbLN1LlTc1jcBMgIUmo/QyfyWOqoeVgo0gmif0cg=;
        b=FNBEWm+JnkcoVU0fwRF9uYmUsLwI6nmjux718tG0IZ+TdAZiXSBB/jBNLraOadNZ7F
         k9WjJO1BNyvKankHIO+2cjxPtJnOEmKurXPlHlEYUOL7LmotE4TckSIrk6h4B2Cp3zhY
         uIM+ngLaI06e5fVIW6w4OUsGISp7df9Fz7YI1acGzgtZUoC6mwV+UYoPQoQkhTXsjUea
         X1zSOnoEiae8/0g5AS+gFxRPcJiEqEqmj5r8LpIXfZYE6BIGgDiJ94G7rrCyF/rz4FDf
         XD1S4n/XsXDg0MbBzCquuJ66kFkgl2S2yfQcv3IqoxLceveTxSxq6MEA/NSMgVSrpK9N
         yZ/w==
X-Gm-Message-State: AJcUukeYZxilHZvdkUpfxa1+vXrsy3XEOFh3eY3TPs7fNb1shZ6J5FFk
        2N+lF3DUkLv8uFKGkiEiQtw=
X-Google-Smtp-Source: ALg8bN7KPZ2IC1wQE0iW+R5e2D5PWmi/9utfdm/dL/qxq/zEcw3ZS0ZBmD4cnVZX0/gT+taFfRTpEw==
X-Received: by 2002:a50:aa68:: with SMTP id p37mr12717706edc.168.1548474137460;
        Fri, 25 Jan 2019 19:42:17 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id p22-v6sm6805122ejf.48.2019.01.25.19.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 19:42:16 -0800 (PST)
Date:   Fri, 25 Jan 2019 20:42:14 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Wentland, Harry" <Harry.Wentland@amd.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: Pass app_tf by value rather than by
 reference
Message-ID: <20190126034214.GA24554@archlinux-ryzen>
References: <20181210234201.4850-1-natechancellor@gmail.com>
 <CAKwvOdkOwdrsOAADGp9To2F5o2AAW7123yADFzYLMawwsinmug@mail.gmail.com>
 <20181211214240.GA31705@flashbox>
 <CAKwvOdn4467193YUMCboj+Z62m0+pVMAbjAc4avCsSsng7hpPg@mail.gmail.com>
 <61e435a1-6f54-ad91-50a6-9989cf75ba90@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e435a1-6f54-ad91-50a6-9989cf75ba90@amd.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 08:09:00PM +0000, Wentland, Harry wrote:
> On 2018-12-11 5:07 p.m., Nick Desaulniers wrote:
> > On Tue, Dec 11, 2018 at 1:42 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> >>
> >> On Tue, Dec 11, 2018 at 01:25:00PM -0800, Nick Desaulniers wrote:
> >>> On Mon, Dec 10, 2018 at 3:42 PM Nathan Chancellor
> >>> <natechancellor@gmail.com> wrote:
> >>>>
> >>>> Clang warns when an expression that equals zero is used as a null
> >>>> pointer constant (in lieu of NULL):
> >>>>
> >>>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4435:3:
> >>>> warning: expression which evaluates to zero treated as a null pointer
> >>>> constant of type 'const enum color_transfer_func *'
> >>>> [-Wnon-literal-null-conversion]
> >>>>                 TRANSFER_FUNC_UNKNOWN,
> >>>>                 ^~~~~~~~~~~~~~~~~~~~~
> >>>> 1 warning generated.
> >>>>
> >>>> This warning is caused by commit bb47de736661 ("drm/amdgpu: Set FreeSync
> >>>> state using drm VRR properties") and it could be solved by using NULL
> >>>> instead of TRANSFER_FUNC_UNKNOWN or casting TRANSFER_FUNC_UNKNOWN as a
> >>>> pointer. However, after looking into it, there doesn't appear to be a
> >>>> good reason to pass app_tf by reference as it is never mutated along the
> >>>> way. This is the only code path in which app_tf is used:
> >>>>
> >>>> mod_freesync_build_vrr_infopacket ->
> >>>>     build_vrr_infopacket_v2 ->
> >>>>         build_vrr_infopacket_fs2_data
> >>>>
> >>>> Neither mod_freesync_build_vrr_infopacket or build_vrr_infopacket_v2
> >>>> modify app_tf's value and build_vrr_infopacket_fs2_data expects just
> >>>> the value so we can avoid dereferencing anything by just passing in
> >>>> app_tf's value to mod_freesync_build_vrr_infopacket and
> >>>> build_vrr_infopacket_v2.
> >>>>
> >>>> There is no functional change because build_vrr_infopacket_fs2_data
> >>>> doesn't do anything if TRANSFER_FUNC_UNKNOWN is passed to it, the same
> >>>> as not calling build_vrr_infopacket_fs2_data at all like before this
> >>>> change when NULL was used for app_tf.
> >>>
> >>> Nathan,
> >>> Thanks for sending this patch.  I was hoping to provide review sooner,
> >>> but have been quite busy lately.
> >>>
> >>
> >> Late review is better than no review, I appeciate you taking the time to
> >> do this!
> >>
> >>> Yeah, especially for LP64 targets, the pointer to enum is larger than
> >>> just the enum, and if it's not being updated ("in/out paramter")
> >>> there's no need to pass by pointer.
> >>>
> >>
> >> Thanks for confirming!
> >>
> >>>>
> >>>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >>>> ---
> >>>>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7 +++----
> >>>>  drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 2 +-
> >>>>  2 files changed, 4 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> >>>> index 620a171620ee..520665a9d81a 100644
> >>>> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> >>>> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> >>>> @@ -656,7 +656,7 @@ static void build_vrr_infopacket_v1(enum signal_type signal,
> >>>>
> >>>>  static void build_vrr_infopacket_v2(enum signal_type signal,
> >>>>                 const struct mod_vrr_params *vrr,
> >>>> -               const enum color_transfer_func *app_tf,
> >>>> +               enum color_transfer_func app_tf,
> >>>>                 struct dc_info_packet *infopacket)
> >>>>  {
> >>>>         unsigned int payload_size = 0;
> >>>> @@ -664,8 +664,7 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
> >>>>         build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
> >>>>         build_vrr_infopacket_data(vrr, infopacket);
> >>>>
> >>>> -       if (app_tf != NULL)
> >>>> -               build_vrr_infopacket_fs2_data(*app_tf, infopacket);
> >>>> +       build_vrr_infopacket_fs2_data(app_tf, infopacket);
> >>>>
> >>>>         build_vrr_infopacket_checksum(&payload_size, infopacket);
> >>>>
> >>>> @@ -676,7 +675,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
> >>>>                 const struct dc_stream_state *stream,
> >>>>                 const struct mod_vrr_params *vrr,
> >>>>                 enum vrr_packet_type packet_type,
> >>>> -               const enum color_transfer_func *app_tf,
> >>>> +               enum color_transfer_func app_tf,
> >>>>                 struct dc_info_packet *infopacket)
> >>>>  {
> >>>>         /* SPD info packet for FreeSync */
> >>>> diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> >>>> index 949a8b62aa98..063af6258fd9 100644
> >>>> --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> >>>> +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> >>>> @@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
> >>>>                 const struct dc_stream_state *stream,
> >>>>                 const struct mod_vrr_params *vrr,
> >>>>                 enum vrr_packet_type packet_type,
> >>>> -               const enum color_transfer_func *app_tf,
> >>>> +               enum color_transfer_func app_tf,
> >>>
> >>> Don't you need to update the callsite of `mod_freesync_build_vrr_infopacket` in
> >>>
> >>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#4949:
> >>>
> >>> -                                           NULL,
> >>> +                                          transfer_func_unknown,
> >>>
> >>
> >> That change in commit bb47de736661 ("drm/amdgpu: Set FreeSync state
> >> using drm VRR properties") in -next is what prompted this patch (the
> >> warning in the commit message is not present in mainline):
> > 
> > Ah! Sorry, I was looking at mainline.  I should have noticed
> > bb47de736661 wasn't there.
> > 
> > Shouldn't that change fail to compile, as transfer_func_unknown is an
> > `enum color_transfer_func` value, but
> > mod_freesync_build_vrr_infopacket takes a *pointer* to an `enum
> > color_transfer_func` value?
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/amd/display/modules/freesync/freesync.c#n675
> > 
> >>
> >>         mod_freesync_build_vrr_infopacket(
> >>                 dm->freesync_module,
> >>                 new_stream,
> >>                 &vrr,
> >>                 packet_type_vrr,
> >>                 transfer_func_unknown,
> >>                 &vrr_infopacket);
> >>
> >>> Maybe at that point the `if (app_tf != NULL)` could be replaced with
> >>> `if (app_tf != transfer_func_unknown)` hoisted from
> >>> `build_vrr_infopacket_fs2_data`? (There's only one caller of
> >>> `build_vrr_infopacket_fs2_data` today, maybe fine to leave the
> >>> unconditional call and check).
> >>>
> >>
> >> Hmmm that's not unreasonable I suppose. I guess it depends on if
> >> build_vrr_infopacket_fs2_data could ever be called from outside of
> >> build_vrr_infopacket_v2; if it can, it makes sense to leave the
> >> conditional check for 'app_tf != transfer_func_unknown' in
> >> build_vrr_infopacket_fs2_data and leaving the unconditional call
> >> to it in build_vrr_infopacket_v2 (since app_tf is no longer a pointer,
> >> no need to check against NULL).
> >>
> >> I'm happy to do a v2 if the maintainers feel strongly about it, thank
> >> you for bringing that up.
> > 
> > Don't worry about it, I think it's fine.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > 
> 
> Sorry for being late to the game. FWIW, code is also
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> We can change the comparison separately later.
> 
> Not sure why this was ever passed as a pointer.
> 
> Harry

Thanks Harry, could you (or someone) pick this up? This warning is now in mainline.

Nathan
