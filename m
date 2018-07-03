Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E805C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2579623FA0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEp2GJKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2579623FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeGCUpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:45:06 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:50211 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752647AbeGCUpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:45:04 -0400
Received: by mail-wm0-f50.google.com with SMTP id v25-v6so3651659wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MMGMM4CLuMXurBjyG688g+eLjzm41pZfsrrws4esvP0=;
        b=QEp2GJKzH6Y302dkcN4GZwH/PukFn1MznDKAW9mS+90n2G4zPNMAl8DluKQ/jKV9bC
         TFoBp2fvGX1O1mHr4vxVPv8RPq64dXyGjBC5hxSv/oSPuuPZskGw7ZHhp6IiqbNuOtEf
         gLbegm6+lpLU0WlaLvO9T1Enl1e2C2AWNaB3yvhR3D//JUIEWSFJYnaAE4W3gSnD1330
         ppxZ3nErczltLEMXW9sAqrs9opyGvfYgbaMHchkMBUIkk4okq66xUSkbFAEAY9dmkjf9
         h5wVhEtU3UtPUIKRKIAq1OczwP9qGdLuvITUWqcmt6M+xfSl1EJvpqyF6lZ1Aom2dvpJ
         g8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MMGMM4CLuMXurBjyG688g+eLjzm41pZfsrrws4esvP0=;
        b=I8SMSGW4Xs2OPVAcZ2RQQoWrEECfIhALuGbI3GrP4v0g0bjEny1Y4ME0CMqrMF//mg
         Xo2casEFFOKHQileN3Z2mU8EMwgs75Wj9jXz6sj/LOsPk/xdzhQq//NUZEWhUQN32eOn
         My34FMfKV7mBE3Cjlk169eL23nlW4tnzEo58phMHT4caIfMmppzU3sVfVl9j198Rer7V
         mXBozhvrSeXlR0rDMyDdZQ9z8/9etD4KEgRU5cheB32m1NHOE5oNQe1Ga0YtTf/lQPIx
         O3QjemM6NHvPrRda0WKCOgx1iZzBLBI2n5mbKb0QqfoEGLPAmRCR5Y18OVQpLf7fcriK
         IV/A==
X-Gm-Message-State: APt69E3Y6bDdyIxJWsB6k9o7pW0h5BGJz/3LX9IK8FIU3PFMKYvCubDl
        j4dreoruV0D8BTSeZMTgU3WZ8JbDEpOmhm4NX4A=
X-Google-Smtp-Source: AAOMgpd7Qwy8g3zeZYUDrFz3Qp5TBMBskO6gwlrINf5J8OmpM5sj6aZ5mttkrMZzo4yMzTZiB/dfVbk9MWvGzJ3N580=
X-Received: by 2002:a1c:7a06:: with SMTP id v6-v6mr11921075wmc.90.1530650703433;
 Tue, 03 Jul 2018 13:45:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:8e6b:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 13:45:02 -0700 (PDT)
In-Reply-To: <20180703170515.6298-1-eric@anholt.net>
References: <20180703170515.6298-1-eric@anholt.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 3 Jul 2018 16:45:02 -0400
Message-ID: <CADnq5_PbJrJUiJ0h+ORZKoeRjP=xY70_UpKHdTE7uQUHpX1dkA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/v3d: Delay the scheduler timeout if we're still
 making progress.
To:     Eric Anholt <eric@anholt.net>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 1:05 PM, Eric Anholt <eric@anholt.net> wrote:
> GTF-GLES2.gtf.GL.acos.acos_float_vert_xvary submits jobs that take 4
> seconds at maximum resolution, but we still want to reset quickly if a
> job is really hung.  Sample the CL's current address and the return
> address (since we call into tile lists repeatedly) and if either has
> changed then assume we've made progress.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: Lucas Stach <l.stach@pengutronix.de>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/v3d/v3d_drv.h   |  2 ++
>  drivers/gpu/drm/v3d/v3d_regs.h  |  1 +
>  drivers/gpu/drm/v3d/v3d_sched.c | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index f546e0ab9562..a5d96d823416 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -189,6 +189,8 @@ struct v3d_job {
>
>         /* GPU virtual addresses of the start/end of the CL job. */
>         u32 start, end;
> +
> +       u32 timedout_ctca, timedout_ctra;
>  };
>
>  struct v3d_exec_info {
> diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
> index fc13282dfc2f..854046565989 100644
> --- a/drivers/gpu/drm/v3d/v3d_regs.h
> +++ b/drivers/gpu/drm/v3d/v3d_regs.h
> @@ -222,6 +222,7 @@
>  #define V3D_CLE_CTNCA(n) (V3D_CLE_CT0CA + 4 * n)
>  #define V3D_CLE_CT0RA                                  0x00118
>  #define V3D_CLE_CT1RA                                  0x0011c
> +#define V3D_CLE_CTNRA(n) (V3D_CLE_CT0RA + 4 * n)
>  #define V3D_CLE_CT0LC                                  0x00120
>  #define V3D_CLE_CT1LC                                  0x00124
>  #define V3D_CLE_CT0PC                                  0x00128
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 808bc901f567..00667c733dca 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -153,7 +153,25 @@ v3d_job_timedout(struct drm_sched_job *sched_job)
>         struct v3d_job *job = to_v3d_job(sched_job);
>         struct v3d_exec_info *exec = job->exec;
>         struct v3d_dev *v3d = exec->v3d;
> +       enum v3d_queue job_q = job == &exec->bin ? V3D_BIN : V3D_RENDER;
>         enum v3d_queue q;
> +       u32 ctca = V3D_CORE_READ(0, V3D_CLE_CTNCA(job_q));
> +       u32 ctra = V3D_CORE_READ(0, V3D_CLE_CTNRA(job_q));
> +
> +       /* If the current address or return address have changed, then
> +        * the GPU has probably made progress and we should delay the
> +        * reset.  This could fail if the GPU got in an infinite loop
> +        * in the CL, but that is pretty unlikely outside of an i-g-t
> +        * testcase.
> +        */
> +       if (job->timedout_ctca != ctca || job->timedout_ctra != ctra) {
> +               job->timedout_ctca = ctca;
> +               job->timedout_ctra = ctra;
> +
> +               schedule_delayed_work(&job->base.work_tdr,
> +                                     job->base.sched->timeout);
> +               return;
> +       }
>
>         mutex_lock(&v3d->reset_lock);
>
> --
> 2.18.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
