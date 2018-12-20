Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B459C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4371021720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8bTQ2ok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbeLTQzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:55:07 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:35940 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732570AbeLTQzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:55:06 -0500
Received: by mail-wm1-f43.google.com with SMTP id p6so2973958wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 08:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQM56/DAQi4hOp+0xgr8IIx0Y25ue+iTF7xXK/bLQKg=;
        b=Q8bTQ2okcO6UTyM8CuifwLyyUqmGjuSaDCvMc59mMLznK9JuPMReFD8KMwW0BDfpxd
         shH4Y8iC1oo9yLYmB/DubLBh2TB2MM+mGeM61ctdtkgWouSLKAE23Em3pKdeMa1l5ih9
         h9UoCNyrPOyuOYALijKMCQqeFDhY9AHV1HUQLBXWq6hS2yFWy/ts5xqyudNLvHciJwis
         lXsdERk9Cxe2BstDhQr0w0Aebem1NcYJjVcD+Cj5U/6JCH/SnYxJEX8XhSGJDzOZrY/v
         EcPNskYd7RrHaYrzR+G9uz68Kkz2InhpxuqLF8uZ7CiH65DVDlEkJmAx65sk/CRdhLGT
         /+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQM56/DAQi4hOp+0xgr8IIx0Y25ue+iTF7xXK/bLQKg=;
        b=A9yvU7Zzsa+mB71kOzeQPf2hp0w53KgmTY127vtPLGJhG9m3/5CQ/5r7YaIs1km2Ht
         fvfwES8zrwG2tp6d9Z7Wv37ustVk40RLIFbNh2/TqS7S7Oj35jHRW2MR5R3UPxgYyBo9
         PqGXafi9Hbu4VLBP2zrSCI/4jdZyBHx1KVQaOvJrY6/HXD+djm8U5b0l15ogcg4oSjOv
         AWaBvQ179Voh0xAd5oSAXTdBZPO27neUjKBUDUrKLJEq0eLZgvIFVFWdXyMLNoCP7miJ
         l25p6mz/5hhlMr0yaNksJCJvWohrKiq8JOQs3d0NYAlifnOCC9+GZkF4utO90lHutul+
         NESg==
X-Gm-Message-State: AA+aEWa/LNzMJRK1dAe4L8BJTehg8c+ARfwISVtjvT+suApVVLMza5SK
        Au6TLzN7atlJBuzAYbexiQMd3pfyc0Xt7QSGxHTI7cfl
X-Google-Smtp-Source: AFSGD/UzazZx/Y8TNxa2ISHOBuJ8jgowcyFRKr36410TrwxEcOSMDpweIj/qXwUBFSPtwXQdDGEgeJsr/MEnNmsZQQY=
X-Received: by 2002:a1c:6243:: with SMTP id w64mr11209289wmb.153.1545324905347;
 Thu, 20 Dec 2018 08:55:05 -0800 (PST)
MIME-Version: 1.0
References: <20181220122841.GA24907@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181220122841.GA24907@hp-pavilion-15-notebook-pc-brajeswar>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 Dec 2018 11:54:53 -0500
Message-ID: <CADnq5_Oq4TZee5C1mU4Rrdin8gLbBM5hFWn2hS+NsvVhUfndsQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display/dcn10_hw_sequencer_debug: Remove
 duplicate header
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Wesley.Chalmers@amd.com,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 9:36 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove custom_float.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
> index 64158900730f..5a563e231be8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
> @@ -40,7 +40,6 @@
>  #include "ipp.h"
>  #include "mpc.h"
>  #include "reg_helper.h"
> -#include "custom_float.h"
>  #include "dcn10_hubp.h"
>  #include "dcn10_hubbub.h"
>  #include "dcn10_cm_common.h"
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
