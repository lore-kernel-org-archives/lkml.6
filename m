Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A87AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1022B21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AV1F5GEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfBAU2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:28:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44136 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfBAU2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:28:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so8415363wrt.11;
        Fri, 01 Feb 2019 12:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O5FPdZJxgnROwXW/bgk2CO46K60+/uD5f3CNKzfbARA=;
        b=AV1F5GEaQogbMf3JdKCJzLr5RbxQRk5WPZXeDphViAs/Yk+h0nZgTRndIrWPK4GPrp
         XqA/POHB6MOjWgYULXarCt3iikubhXLpJxGuFeREzv1nOzIgJAIZ2VD74v3XiM1ofp9X
         7T98GtU1Q6Wr34Z9qg+3TJAUqDVnGkiysShBvaPKmygk3eKWz19hxdeq2dWsEovWiXtY
         XR7bk3qevQSFzwFm5o1mCeWK+pWVpECczrfhPKKVwd6wzT8VtGSMIEKPz8nrLy6sWOm1
         z9zgWpfR4hoWxLSximOE3CoYjJkwA1voLdtVO/eJZCPtswaAoYfRTPSnOh/P0OLChagg
         IMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5FPdZJxgnROwXW/bgk2CO46K60+/uD5f3CNKzfbARA=;
        b=LaDJ49V3LTRKLTsQ90bhaU6bJOHyz9TT7MWRTYtnsCKjoUvXL4XgLVke7aS3rXN214
         MCjwCxIWbgmAjMaZtI9r8c4FLqekwfc+2dplAmk/sTP66wEfvg0cmWnMcvon8ziWH6Ny
         8wu4B8/ayZcXKKd08oHTSL6OpJYdAVmoC46QcQno3naS3dI/bkPD81hgbVVsUOqH8xOP
         zMM9AsEcNxz12zM8Qh1Jgrn8lcsjc9MBr1CXZ0+KO92rdsXy4FMuB/yvbR3My6741tIh
         L/VGiVFKBaCid0mVoybTve/FqyvJpLX/R+TF0wgTvbeB/qU859SSpH94sefpT20/nV0i
         ipkw==
X-Gm-Message-State: AJcUukeTGkbdZc3HnoncnxWN0HARTkwtptlSsmSElt+c+nOn7QyNbanJ
        IA/ahidr3/Ev4gOcAUsizlKrZYIJdgPqasee++Y=
X-Google-Smtp-Source: ALg8bN6XgAISFDoWwe2BZpvKMiCGzPnDIL1LrNZg2dja5yCIuXPxLg3YdsP//tHWFb81Rsu+Gs5rYkDkXjRfl9tSFrI=
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr38388105wrh.317.1549052890824;
 Fri, 01 Feb 2019 12:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20190201104159.19215-1-colin.king@canonical.com>
In-Reply-To: <20190201104159.19215-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 1 Feb 2019 15:27:57 -0500
Message-ID: <CADnq5_ObHBu6=zZ3Lr0E1AvwwqA3bd8RCQyddc6n188karCTDQ@mail.gmail.com>
Subject: Re: [PATCH][drm-next] drm/amd/amdgpu: fix spelling mistake "matech"
 -> "match"
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 5:42 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dev_err message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index dac187454b33..2ae25095e501 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -129,7 +129,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>         if (!hive) {
>                 ret = -EINVAL;
>                 dev_err(adev->dev,
> -                       "XGMI: node 0x%llx, can not matech hive 0x%llx in the hive list.\n",
> +                       "XGMI: node 0x%llx, can not match hive 0x%llx in the hive list.\n",
>                         adev->gmc.xgmi.node_id, adev->gmc.xgmi.hive_id);
>                 goto exit;
>         }
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
