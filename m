Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD19C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8340620883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeYm1XTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfAHVRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:17:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33619 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbfAHVRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:17:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so5568779wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 13:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wy/ZhK1DF0f8O5ZNA6S/iQBUn9NUM0liNaalzHWrKBs=;
        b=aeYm1XTXo8J5yPu00+PY/m01vk0w12BawB+mDTB52RK2uuyAXW1+wrDjmwDPSidTFJ
         VhtcV4Nh5YfDo2PQQFWo5bAQJQFHVPHv/mRFLULFHSEvAdcUMtnZqsMqM9VQz5h7sClH
         SHdV+x9KsIb589xiGps5+mVROjeb8tze+WUyuPU4Z+IA90bPNhWHnFt4CYqjAo9pDEc0
         wZHSVlY3wFtx02xxf6u5oxlIuMctO5TIwltC4JaN6T//F+YSx9rONbLKbun6igpQDuD/
         DZMJOIQ8Tmw+MXgz/XsVW+ugGyrtA/Kcicyt8oyS0deuxI+byzDmwYlvc/icJcMp6wjS
         +Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wy/ZhK1DF0f8O5ZNA6S/iQBUn9NUM0liNaalzHWrKBs=;
        b=BMN2kM+GmLvYr0aG6kri+91WeB6kMDmPZj8m0Wl5UnSMH6ZUCXUy9ro/wm0YPqG6h+
         iAZTnBKVNiszRNQIN7gNpgZ5svPQ8RHtbp9v/ikOZg4wPDrLcMw+VeA5FqiXWe1oaOs1
         hkh3oGNEgZtxHCYxUKx0Gw7tSi7KkzCCD4zExgZdWOvx/iooelNmx3m3rClzds9jgyur
         zst8lfxiUKAt4fYJSWIaYcWFQ2+wsvti+QDoCyu8lPFdjFD/+/esEgD+SNlhL+OEaXX+
         uvMzZGPbKLzV3K5iP4J5EChRQTnj58AGcu2shJjhf/xMFg2lnk2BO8ofC6pRMF8YJXQq
         8fMg==
X-Gm-Message-State: AJcUukf9xVEfT6uQvvQLmwHz0YSB0FD5A+l39AxBuymqahbWnN0kp6Ri
        0nL77bqPm7cQA3ZkYihBCU1+RtY+DFYCtGLQalw=
X-Google-Smtp-Source: ALg8bN5u95tbJPo6hDsDGENFL7v93TjMOppWNIl/cvSTtB7G6pP3EaFhYgZNHGIg90EWeCWPUzoJqIUQacOoKwhpmDI=
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr2541076wrh.317.1546982263799;
 Tue, 08 Jan 2019 13:17:43 -0800 (PST)
MIME-Version: 1.0
References: <20190108211133.32564-1-lyude@redhat.com>
In-Reply-To: <20190108211133.32564-1-lyude@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 8 Jan 2019 16:17:31 -0500
Message-ID: <CADnq5_N=wu0C+ZknUqXhodOye3i-ySGVVn9Mrb4_6W1jRPp_EA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/amdgpu: Fix suspend/resume issues with MST
To:     Lyude Paul <lyude@redhat.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>,
        "David (ChunMing) Zhou" <david1.zhou@amd.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
        David Francis <david.francis@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>, Jerry Zuo <Jerry.Zuo@amd.com>,
        Tony Cheng <tony.cheng@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, Shirish S <shirish.s@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Anthony Koo <anthony.koo@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 4:11 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Fix the suspend/issues that Jerry Zuo found in amdgpu, and add some
> compiler warnings for drivers ignoring the return code of
> drm_dp_mst_topology_mgr_resume() to help ensure we don't need to fix
> this again in the future for someone else's driver.
>
> Cc: Jerry Zuo <Jerry.Zuo@amd.com>
>
> Lyude Paul (3):
>   drm/amdgpu: Don't ignore rc from drm_dp_mst_topology_mgr_resume()
>   drm/amdgpu: Don't fail resume process if resuming atomic state fails
>   drm/dp_mst: Add __must_check to drm_dp_mst_topology_mgr_resume()

I can take these through the amdgpu tree or you can commit them to
drm-misc (assuming you have commit rights).  Either way works for me.

Thanks,

Alex

>
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 37 +++++++++++++------
>  include/drm/drm_dp_mst_helper.h               |  3 +-
>  2 files changed, 27 insertions(+), 13 deletions(-)
>
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
