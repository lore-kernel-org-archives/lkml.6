Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A7AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE172170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfIVLQqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE172170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbeI1AbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:31:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37635 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeI1AbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:31:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so2537443pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZtG4/vcM42ddSOkegOG9pv0meOBfwefQ0R0Jgpl8DU=;
        b=JfIVLQqLJlIHOxw/VQjpFIGBnIonYbMNu7GRZnYyG17m0ungk3LyZ8ydmu7Ex6a9j7
         Qt23iu6J0zIpop5QADWOw/WOSyDWIgNCUNb8s3Y4rY6UwronilSPIn/rlMTWKoYSWY1S
         qN3ebgLfmRjarYYnwF5rvxK478I6EN9PkUg5SPZZYjlmnKvSTWkSiDDxTqlXavr8XFyj
         FP/1qAzKomIy4H67b3DvjawQ03sy7aqel44abiCXVftQ8UPKDmhvlFQ3flRsLwplIwaO
         c6+0Sf8GTLqk9XQ+jrmhh3EPMyJmNr76aLjiNPLWKGfr4TJJ//Kb3d2ImXeqm3pMX438
         5o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZtG4/vcM42ddSOkegOG9pv0meOBfwefQ0R0Jgpl8DU=;
        b=kid05AtcAVH6lX4bsghsF8HjdFohkP6W/OODRBCbEpibGhZx735kQdoqztxRRhoq4W
         fOOnUw4EmeA9jYdSn3e30lOL4uLZou0illyUlsx/YIKl2MDf+0IHOq7B5fjWUNplmNjN
         +DEhFHIWzNLEmv574G8Sb+i4nlEMBPJLsWMvevbP3zKYOiwSqlpsJoI+HuviBQdK5np2
         qZJ1ke8yEH3dyYSu4jyzX7cLrFP4CV+CWflLSkLmfDsvXgQiZlu/6PVL3VUGK/YEhPYc
         pHWGyydeypmBEepwGws/BdimRhdZji2swOMRWEWC3HsVY/9OdDtnA0vVEwk0DRR73KxX
         DOQQ==
X-Gm-Message-State: ABuFfoh25nBxyvvuFyEI2wB8U4jtM8qls64/Ea2p4ZE5Ddydka9Ria9T
        x3C9pHexqqbqPsWynuibUQH8wfJDKHZNhmjuxs0hjg==
X-Google-Smtp-Source: ACcGV63t1zHcWXq22L/gTk1PMUuyluXcq7H3ckru4hVqSNe5GazmHdeBhiAeHKiXRKiE6c0b5mLcwb5h+AtFikKoVEs=
X-Received: by 2002:aa7:800f:: with SMTP id j15-v6mr12747031pfi.174.1538071911309;
 Thu, 27 Sep 2018 11:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180921215505.14634-1-natechancellor@gmail.com>
 <20180927180632.11520-1-natechancellor@gmail.com> <20180927180816.GA12545@flashbox>
In-Reply-To: <20180927180816.GA12545@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Sep 2018 11:11:39 -0700
Message-ID: <CAKwvOdk1AM9K=GQtFb2dWOor8Py5O-t7Q6g-rYbygJtF_DpjbA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Use proper enums in process_channel_reply
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

On Thu, Sep 27, 2018 at 11:08 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Sep 27, 2018 at 11:06:33AM -0700, Nathan Chancellor wrote:
> > Clang warns when one enumerated type is implicitly converted to another.
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:315:19: warning:
> > implicit conversion from enumeration type 'enum
> > aux_channel_operation_result' to different enumeration type 'enum
> > aux_transaction_reply' [-Wenum-conversion]
> >                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
> >                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/aux_engine_dce110.c:349:19:
> > warning: implicit conversion from enumeration type 'enum
> > aux_channel_operation_result' to different enumeration type 'enum
> > aux_transaction_reply' [-Wenum-conversion]
> >                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
> >                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > The current enum is incorrect, it should be from aux_transaction_reply,
> > so use AUX_TRANSACTION_REPLY_HPD_DISCON.
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> > ---
> >
> > v1 -> v2:
> >
> > * Rather than change status to an integer, use the proper enumerated
> >   type from aux_transaction reply as suggested by Nick and confirmed
> >   by Henry.
>
> Sigh Harry, sorry...

Thanks for the patch, Nathan.  Don't worry about sending a v3 over
this; its below the commit line so this detail wont get committed.

>
> >
> >  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c                    | 2 +-
> >  .../gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c    | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> > index 3f5b2e6f7553..aaeb7faac0c4 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> > @@ -312,7 +312,7 @@ static void process_channel_reply(
> >
> >       /* in case HPD is LOW, exit AUX transaction */
> >       if ((sw_status & AUX_SW_STATUS__AUX_SW_HPD_DISCON_MASK)) {
> > -             reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
> > +             reply->status = AUX_TRANSACTION_REPLY_HPD_DISCON;
> >               return;
> >       }
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
> > index 8eee8ace1259..59c3ed43d609 100644
> > --- a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
> > +++ b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
> > @@ -346,7 +346,7 @@ static void process_channel_reply(
> >
> >       /* in case HPD is LOW, exit AUX transaction */
> >       if ((sw_status & AUX_SW_STATUS__AUX_SW_HPD_DISCON_MASK)) {
> > -             reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
> > +             reply->status = AUX_TRANSACTION_REPLY_HPD_DISCON;
> >               return;
> >       }
> >
> > --
> > 2.19.0
> >



-- 
Thanks,
~Nick Desaulniers
