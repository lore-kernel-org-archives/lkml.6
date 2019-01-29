Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D59C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C3C20880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZxqAvMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfA2TKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:10:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34631 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfA2TKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:10:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so10126750pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 11:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxU847aHR7T2c6M//zdkC2CwszKaMbG6GQ+aqQF2dzA=;
        b=uZxqAvMGC8oULAByjX0cwFaArGfrNRlgVSA0PLO9RYsLPucF4hSRg78LyrpgclcdyH
         2b3A8vsStSq+421IqarusuaEA3+axOEtw+P1jWbcI0pFDKapUiFU4yBwMdbeV7oSNWjH
         Um0HZT5tUJuzN5ttVVKw2T1lDCJSbbBIaLDn/8Os76QVeN6TzEtBwsgey+P+oYVCToMu
         WYO3klMFw+My3tzU5XYVRSoXPsHig5UsGcrKI22O64GWcq6lyHjDGdsIXfPWyh6RNRBR
         jkZ1Gwjp13BuEnJw07/Mc/Gt+bDQOJ3M4pG/hhBkSkPZAdOM815ApwCeC9xBXRhMwvjm
         S51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxU847aHR7T2c6M//zdkC2CwszKaMbG6GQ+aqQF2dzA=;
        b=kXPDk/m2Ves/CKJ/0VjEepeR+fWwfcouksQeZ5jPN5zdp7tAJIbHNJk2VL+VrVGtCH
         k39NpojoSd/WG50BdRnixHVfar/LA/8UhYKpseQAa7B8bfJ7xWPCbRE1Mn2N8Icxq5JT
         ewXAHV4kI8+lMrNnDHCxWXXJiuo0WB688e/WYTria3Si+j8l+M+rxWP1s6xsltm7cz38
         vKf0jHr1RfRRjrX5m999W2WxxMjo+xDzvA9Rm1o3J+Nv9pFdHA4FbiOXcx48LD9h7xbB
         /QIxD9asLo9RHEoLmC+KaHtGZOElMjrBCnwZWfAQbPbvYy8DAMKyzHNbWjC/ICnpO4Js
         nTnQ==
X-Gm-Message-State: AJcUukehfzVuXURs7lTEmSjVs07LEwa9G+hUuIkvEGWaFTLZrWEwstfS
        vPzzPX6KF87tepxanB3daaOe1YqdFoFucRzaIvp3ag==
X-Google-Smtp-Source: ALg8bN5hjm3d/AIOt3UtbIb7EhAPn78lmnQO7AhNyq+os2tY8n1mHgVmdWgSTArmyTyLJ64Q6MeyAJ6h1597vxnikEE=
X-Received: by 2002:a62:b80a:: with SMTP id p10mr27269424pfe.32.1548789041503;
 Tue, 29 Jan 2019 11:10:41 -0800 (PST)
MIME-Version: 1.0
References: <20190125005304.183322-1-ndesaulniers@google.com>
 <04bc6844-2a3b-2de8-60a7-a027149709fd@amd.com> <CADnq5_OuSD7Bmeg3CP0Y6JTo9Xso2FTZ3tKk-u1C+-B32eUGmQ@mail.gmail.com>
 <20190129185601.GA17525@roeck-us.net> <da0beeff-96eb-5585-50ef-904c8fe8af4d@amd.com>
In-Reply-To: <da0beeff-96eb-5585-50ef-904c8fe8af4d@amd.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Jan 2019 11:10:30 -0800
Message-ID: <CAKwvOdkzVv4_hruDkbgiq0TRbPw6uyXAHZ+tAWyqN7CoyOLU_g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: add -msse2 to prevent Clang from
 emitting libcalls to undefined SW FP routines
To:     "Wentland, Harry" <Harry.Wentland@amd.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Alex Deucher <alexdeucher@gmail.com>,
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
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggestions:
1. revert patch
2. get me the disassembly from gcc of the translation unit in question.
3. land patch that adds clang guards or something different based on 2.

Revert first; ask questions later.

On Tue, Jan 29, 2019 at 11:01 AM Wentland, Harry <Harry.Wentland@amd.com> wrote:
>
> On 2019-01-29 1:56 p.m., Guenter Roeck wrote:
> > On Tue, Jan 29, 2019 at 10:30:31AM -0500, Alex Deucher wrote:
> >> On Fri, Jan 25, 2019 at 10:29 AM Wentland, Harry <Harry.Wentland@amd.com> wrote:
> >>>
> >>> On 2019-01-24 7:52 p.m., ndesaulniers@google.com wrote:
> >>>> arch/x86/Makefile disables SSE and SSE2 for the whole kernel.  The
> >>>> AMDGPU drivers modified in this patch re-enable SSE but not SSE2.  Turn
> >>>> on SSE2 to support emitting double precision floating point instructions
> >>>> rather than calls to non-existent (usually available from gcc_s or
> >>>> compiler_rt) floating point helper routines.
> >>>>
> >>>> Link: https://gcc.gnu.org/onlinedocs/gccint/Soft-float-library-routines.html
> >>>> Link: https://github.com/ClangBuiltLinux/linux/issues/327
> >>>> Cc: stable@vger.kernel.org # 4.19
> >>>> Reported-by: S, Shirish <Shirish.S@amd.com>
> >>>> Reported-by: Matthias Kaehlcke <mka@google.com>
> >>>> Suggested-by: James Y Knight <jyknight@google.com>
> >>>> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> >>>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >>>> Tested-by: Guenter Roeck <linux@roeck-us.net>
> >>>
> >>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >>>
> >>> and applied.
> >>>
> >>
> >> This patch causes a segfault:
> >> https://bugs.freedesktop.org/show_bug.cgi?id=109487
> >>
> >> Any ideas?
> >>
> >
> > Set -msse2 only for clang ? I suspect, though, that this might only
> > solve the compile problem. If I understand correctly, the first
> > warning in the log is due to BREAK_TO_DEBUGGER(), suggesting that
> > something is seriously wrong. Maybe enabling sse2 results in different
> > results from floating point operations.
> >
> > Unfortunately I don't have a system with the affected GPU,
> > so I can't run any tests on real hardware. Unless someone can test
> > with real hardware, I think we have no choice but to revert the
> > patch.
> >
>
> Might be a good idea. Even though, best to revert for now until we understand what's going on.
>
> It seems like people at AMD building with gcc 5.4 are fine, but those using gcc 7.3 or 8.2 experience the crash.
>
> Harry
>
> > Guenter
> >
> >> Alex
> >>
> >>> Harry
> >>>
> >>>> ---
> >>>>  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 2 +-
> >>>>  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 2 +-
> >>>>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> >>>> index 95f332ee3e7e..dc85a3c088af 100644
> >>>> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> >>>> +++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> >>>> @@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
> >>>>       cc_stack_align := -mstack-alignment=16
> >>>>  endif
> >>>>
> >>>> -calcs_ccflags := -mhard-float -msse $(cc_stack_align)
> >>>> +calcs_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
> >>>>
> >>>>  CFLAGS_dcn_calcs.o := $(calcs_ccflags)
> >>>>  CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
> >>>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> >>>> index d97ca6528f9d..33c7d7588712 100644
> >>>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> >>>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> >>>> @@ -30,7 +30,7 @@ else ifneq ($(call cc-option, -mstack-alignment=16),)
> >>>>       cc_stack_align := -mstack-alignment=16
> >>>>  endif
> >>>>
> >>>> -dml_ccflags := -mhard-float -msse $(cc_stack_align)
> >>>> +dml_ccflags := -mhard-float -msse -msse2 $(cc_stack_align)
> >>>>
> >>>>  CFLAGS_display_mode_lib.o := $(dml_ccflags)
> >>>>  CFLAGS_display_pipe_clocks.o := $(dml_ccflags)
> >>>>
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx@lists.freedesktop.org
> >>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



-- 
Thanks,
~Nick Desaulniers
