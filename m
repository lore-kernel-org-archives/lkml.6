Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC0FC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D78214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB2b13aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfA2Paq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:30:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32809 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfA2Paq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:30:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so13238510wmh.0;
        Tue, 29 Jan 2019 07:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApP0G7zhFbiBNT4ApKogZnRvv1+iU2xMzLHxYpKK6vM=;
        b=EB2b13awBjwlF7iMMYVeHFEErTB3YUwNsZZ4E32chgSWCN4j+bOxbLNA1e3WEJqkvh
         jWVgI1fg3zmKnj4TtKybKwJoCC+5ZawqTrUsrmVLuYoos2pHYxjQlLje0d+3DIB9mmE8
         LgTidnXtqo+XsjBQaWJu4Wlkjrizp8E3S665rsTWvmzLV4RD21RPJkbrZZZkPyXTO+k2
         KE40nz81yBa9RvRh4WSkgj/dSm9uu7WqKuRjGjxZkQzhNPpsaTbhyB4LHWIYZm3PX7Ew
         YsxOzC6hvuBBwgaosRlEvWMp/N9XpXOWEVyWJFKlzf88s1iyaq5Ilzhw/qrvrq+kZ8C+
         YDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApP0G7zhFbiBNT4ApKogZnRvv1+iU2xMzLHxYpKK6vM=;
        b=kzV3BV0rjKGdL4iewL3THWYdOcf+E+IgKVWZGngcGcoCZlzFr74NRJba35ZbhRtOTA
         XQLA4huhuQdu+m3KMq00QSls5NzFE1sFz/V/9V+ge3klvCXymoeYV+EHlaFIM2P61H5e
         akxzZNxT1txNad1YE3rKRIXkUwp+uXPTBICVclUVNqgC6oTQExXkAE2q2XO7jMZ2ORVa
         aGXCZR7s9WiDGe/jhgLo3ddWdnPhPnxyjXgCcsxXkZzvrEMGbPyBwDav88YnvUwIl/5N
         iOzf05Io7nCdGr+kHMJ2+DA/FcW5JRboEyilMwJ0uiNEmmgyjHlKtnOmzgfeMiVuGWeM
         qiTg==
X-Gm-Message-State: AJcUuke8zvfS65lxuyPs+63vF4ITk/Qs+X+F1VJWAxBOk9Py1yr3LtBx
        wauiDGT8n8hh7BfT+BMoVv8WePNDX7J0/h9qXN4=
X-Google-Smtp-Source: ALg8bN4/YNAeUIm8Mv8Xveks6DaMLPMyKSHfNBQkPiKVnkCie+yPptqNxloB+YdY7CbrfIPXqk7hvUF/NwXqYY73Fz0=
X-Received: by 2002:a1c:6243:: with SMTP id w64mr21188256wmb.153.1548775843989;
 Tue, 29 Jan 2019 07:30:43 -0800 (PST)
MIME-Version: 1.0
References: <20190125005304.183322-1-ndesaulniers@google.com> <04bc6844-2a3b-2de8-60a7-a027149709fd@amd.com>
In-Reply-To: <04bc6844-2a3b-2de8-60a7-a027149709fd@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 29 Jan 2019 10:30:31 -0500
Message-ID: <CADnq5_OuSD7Bmeg3CP0Y6JTo9Xso2FTZ3tKk-u1C+-B32eUGmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: add -msse2 to prevent Clang from
 emitting libcalls to undefined SW FP routines
To:     "Wentland, Harry" <Harry.Wentland@amd.com>
Cc:     "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>, "S@google.com" <S@google.com>,
        "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Daenzer, Michel" <Michel.Daenzer@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "S, Shirish" <Shirish.S@amd.com>,
        Matthias Kaehlcke <mka@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        James Y Knight <jyknight@google.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 10:29 AM Wentland, Harry <Harry.Wentland@amd.com> wrote:
>
> On 2019-01-24 7:52 p.m., ndesaulniers@google.com wrote:
> > arch/x86/Makefile disables SSE and SSE2 for the whole kernel.  The
> > AMDGPU drivers modified in this patch re-enable SSE but not SSE2.  Turn
> > on SSE2 to support emitting double precision floating point instructions
> > rather than calls to non-existent (usually available from gcc_s or
> > compiler_rt) floating point helper routines.
> >
> > Link: https://gcc.gnu.org/onlinedocs/gccint/Soft-float-library-routines.html
> > Link: https://github.com/ClangBuiltLinux/linux/issues/327
> > Cc: stable@vger.kernel.org # 4.19
> > Reported-by: S, Shirish <Shirish.S@amd.com>
> > Reported-by: Matthias Kaehlcke <mka@google.com>
> > Suggested-by: James Y Knight <jyknight@google.com>
> > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > Tested-by: Guenter Roeck <linux@roeck-us.net>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> and applied.
>

This patch causes a segfault:
https://bugs.freedesktop.org/show_bug.cgi?id=109487

Any ideas?

Alex

> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 2 +-
> >  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> > index 95f332ee3e7e..dc85a3c088af 100644
> > --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> > @@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
> >       cc_stack_align := -mstack-alignment=16
> >  endif
> >
> > -calcs_ccflags := -mhard-float -msse $(cc_stack_align)
> > +calcs_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
> >
> >  CFLAGS_dcn_calcs.o := $(calcs_ccflags)
> >  CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > index d97ca6528f9d..33c7d7588712 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > @@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
> >       cc_stack_align := -mstack-alignment=16
> >  endif
> >
> > -dml_ccflags := -mhard-float -msse $(cc_stack_align)
> > +dml_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
> >
> >  CFLAGS_display_mode_lib.o := $(dml_ccflags)
> >  CFLAGS_display_pipe_clocks.o := $(dml_ccflags)
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
