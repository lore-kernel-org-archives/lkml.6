Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6128DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E722098A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnO75UNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E722098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeJKCb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:31:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55507 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeJKCb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:31:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id 206-v6so6618373wmb.5;
        Wed, 10 Oct 2018 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wayis21wLrrt8tq09JBpiEWjxujHZPLag+28fCjQGBo=;
        b=lnO75UNxfIs2rvuhmg732XXJOy//jmTvOnGMpxuH3NJIrY7gb8VBCoRcLlgMfujDRW
         1VDFMBm+aQQctMqziH+tlf9NrpMMBT6beEGy5o8uRrxOc1tRipn5tLoLBnHSC/44W47G
         VXqgPyW8oaf47/5BnfXG/Oskp+PgFOr7r46gZPgFlRrLrPAv6NpJd5CTW+rjRehaWJqP
         SiW/oZxIuHYNcrDuRKvDu5iRN9PHPrJYFFCxriCZv/mprg5lVhJH4sglh1vyOcDek6+e
         O3iXRDoWmjl9+LeLpeSQLWKVbFrMpPzwENJPxvhCxTPSihyJ+RSJg3rZ0eF1go4HOZ/y
         u3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wayis21wLrrt8tq09JBpiEWjxujHZPLag+28fCjQGBo=;
        b=D3AmCu4LpgZqy1PytkOg36uDnJZPYZ5Va5R2ymbVPQeO/AMb1fmC671uBNLK3qRxx9
         YJZwK37qCv82PHfrBArtf7KL4hjYIST7+DE1Pw6EMbZHIOhAnE/pAiUD/+dFCTZ8z8zI
         9/RF8jw10UDwe9m3dGLaGrVezPX8sxB45t4EowLieBGhBkHMVO0BaaJzzHlBWEqjCap8
         lDL6hfIuqVEL2qLaHJkyX9WGEMtriK4Y+hFKypPU07Q5ryxkOveLMdtkDf6n9oZLne5p
         AcrIh0l5aZw+pFemwg/aYPt1JPkTBcKrlj8gHGzHItqSnBm/t0M9kICDiRoqI1FXYtZg
         iIJg==
X-Gm-Message-State: ABuFfohgU3cJ+FUj4pBwycznDrUWhP5/pWmMYcI+gBZ5DbxkhDYoY/Xx
        186JivGjiYXFoSpFPqfdx8eL1gNRJqsUW28pA86+euXb
X-Google-Smtp-Source: ACcGV605mQ9HweMmIO9xxIIUc7Iq7M1JxXfXMLHVT6xU69KvffpT/+BKdzszQr8e8WcwVI80gnwlpkIJJRyMRMTRj0o=
X-Received: by 2002:a1c:607:: with SMTP id 7-v6mr1870389wmg.103.1539198506125;
 Wed, 10 Oct 2018 12:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181008162228.4599-1-colin.king@canonical.com> <20181009104318.GA20785@hr-amur2>
In-Reply-To: <20181009104318.GA20785@hr-amur2>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 10 Oct 2018 15:08:13 -0400
Message-ID: <CADnq5_N+qw=fwYP=_8XRLVt792tiSALxGWd-scBzJVORkPVaLw@mail.gmail.com>
Subject: Re: [PATCH][drm-next] drm/amdgpu/powerplay: fix missing break in
 switch statements
To:     Huang Rui <ray.huang@amd.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Dave Airlie <airlied@linux.ie>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Quan, Evan" <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 6:44 AM Huang Rui <ray.huang@amd.com> wrote:
>
> On Mon, Oct 08, 2018 at 05:22:28PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There are several switch statements that are missing break statements.
> > Add missing breaks to handle any fall-throughs corner cases.
> >
> > Detected by CoverityScan, CID#1457175 ("Missing break in switch")
> >
> > Fixes: 18aafc59b106 ("drm/amd/powerplay: implement fw related smu interface for iceland.")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Acked-by: Huang Rui <ray.huang@amd.com>
>

Applied.  thanks!

Alex

> > ---
> >  drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c      | 2 ++
> >  drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c    | 2 ++
> >  drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c | 2 ++
> >  drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c   | 2 ++
> >  drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c   | 2 ++
> >  5 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> > index 18643e06bc6f..669bd0c2a16c 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> > @@ -2269,11 +2269,13 @@ static uint32_t ci_get_offsetof(uint32_t type, uint32_t member)
> >               case DRAM_LOG_BUFF_SIZE:
> >                       return offsetof(SMU7_SoftRegisters, DRAM_LOG_BUFF_SIZE);
> >               }
> > +             break;
> >       case SMU_Discrete_DpmTable:
> >               switch (member) {
> >               case LowSclkInterruptThreshold:
> >                       return offsetof(SMU7_Discrete_DpmTable, LowSclkInterruptT);
> >               }
> > +             break;
> >       }
> >       pr_debug("can't get the offset of type %x member %x\n", type, member);
> >       return 0;
> > diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> > index ec14798e87b6..bddd6d09f887 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> > @@ -2331,6 +2331,7 @@ static uint32_t fiji_get_offsetof(uint32_t type, uint32_t member)
> >               case DRAM_LOG_BUFF_SIZE:
> >                       return offsetof(SMU73_SoftRegisters, DRAM_LOG_BUFF_SIZE);
> >               }
> > +             break;
> >       case SMU_Discrete_DpmTable:
> >               switch (member) {
> >               case UvdBootLevel:
> > @@ -2340,6 +2341,7 @@ static uint32_t fiji_get_offsetof(uint32_t type, uint32_t member)
> >               case LowSclkInterruptThreshold:
> >                       return offsetof(SMU73_Discrete_DpmTable, LowSclkInterruptThreshold);
> >               }
> > +             break;
> >       }
> >       pr_warn("can't get the offset of type %x member %x\n", type, member);
> >       return 0;
> > diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> > index 73aa368a454e..2d4c7f167b88 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> > @@ -2237,11 +2237,13 @@ static uint32_t iceland_get_offsetof(uint32_t type, uint32_t member)
> >               case DRAM_LOG_BUFF_SIZE:
> >                       return offsetof(SMU71_SoftRegisters, DRAM_LOG_BUFF_SIZE);
> >               }
> > +             break;
> >       case SMU_Discrete_DpmTable:
> >               switch (member) {
> >               case LowSclkInterruptThreshold:
> >                       return offsetof(SMU71_Discrete_DpmTable, LowSclkInterruptThreshold);
> >               }
> > +             break;
> >       }
> >       pr_warn("can't get the offset of type %x member %x\n", type, member);
> >       return 0;
> > diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> > index ae8378ed32ee..a2ba5b012866 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> > @@ -2619,6 +2619,7 @@ static uint32_t tonga_get_offsetof(uint32_t type, uint32_t member)
> >               case DRAM_LOG_BUFF_SIZE:
> >                       return offsetof(SMU72_SoftRegisters, DRAM_LOG_BUFF_SIZE);
> >               }
> > +             break;
> >       case SMU_Discrete_DpmTable:
> >               switch (member) {
> >               case UvdBootLevel:
> > @@ -2628,6 +2629,7 @@ static uint32_t tonga_get_offsetof(uint32_t type, uint32_t member)
> >               case LowSclkInterruptThreshold:
> >                       return offsetof(SMU72_Discrete_DpmTable, LowSclkInterruptThreshold);
> >               }
> > +             break;
> >       }
> >       pr_warn("can't get the offset of type %x member %x\n", type, member);
> >       return 0;
> > diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> > index 3d415fabbd93..9f71512b2510 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> > @@ -2185,6 +2185,7 @@ static uint32_t vegam_get_offsetof(uint32_t type, uint32_t member)
> >               case DRAM_LOG_BUFF_SIZE:
> >                       return offsetof(SMU75_SoftRegisters, DRAM_LOG_BUFF_SIZE);
> >               }
> > +             break;
> >       case SMU_Discrete_DpmTable:
> >               switch (member) {
> >               case UvdBootLevel:
> > @@ -2194,6 +2195,7 @@ static uint32_t vegam_get_offsetof(uint32_t type, uint32_t member)
> >               case LowSclkInterruptThreshold:
> >                       return offsetof(SMU75_Discrete_DpmTable, LowSclkInterruptThreshold);
> >               }
> > +             break;
> >       }
> >       pr_warn("can't get the offset of type %x member %x\n", type, member);
> >       return 0;
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
