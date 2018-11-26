Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B1AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7981A20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9/lDg+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7981A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeK0HcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:32:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43435 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbeK0HcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:32:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so20357401wrs.10;
        Mon, 26 Nov 2018 12:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfuKDl6p14Zj1JRr1J4usQ1fsai7WppAo1qGcEpU2zk=;
        b=D9/lDg+JwiZXIHDlfqHYOSWE5FygihVeuuyENmPoHAnBRYW24IBJJDzIE56fnF7Sx7
         Jm26HSNcy4RBsrIjlJV5DgxIrv95DALH7Fr3zm2VstwJWHLlY0NTlzAdw3iM2rvgw0/Z
         LDUYbBaLCI3QkPzZXb1j2V/YeyeY9Qi8oOH1rHDZC4/WFHDdxpZnR/WiaJC2SU4kHjYs
         xQf6itplkkXL1Ooi/rpT6s1rXHOkTD5OFOygjIJqNdYKLVPODslOb9B8Kz/hVQlRERbq
         qwkhboRxo8w1+EzZ396H0mw7IZJOa0PIlxfk0TkHvjzpNI2ySerXa6i2cyS5x1zlDDW2
         5kKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfuKDl6p14Zj1JRr1J4usQ1fsai7WppAo1qGcEpU2zk=;
        b=hoekOY9yiYlJ669/N7QSADfnOBo0lFSg1CJkBpEEHNP+O6Th6cHEj4zM0pciqp0A2i
         scLmmHqOlf8rupv2Q2aKoDhb5ZztbRrzHOpCnRZvlPDSwqjkcdwVSS1zVH5WiunhnHoV
         T/lxmUbdayUNZp9dWSIuO/1dHw3eMqBbXdNju+zCpDpt/b2eSzQ4QfbX43MV8Au8Mz6o
         lYlMq/erP6Hwu1ndDfcz3yaUzf9Y4gxrF/7J7vYzt7bgfaSU1hEuCi9FYFpJbEg5uP/u
         yDCEHiDcvjov6E/jqh/PO6jdobvtfofvpymNIPJzqu6pczeFaPT+fR1d70fCxjO/SrVG
         AhrA==
X-Gm-Message-State: AA+aEWZYsLL8j8CuN4/dAjj5ie3aJkDsfRTMkM6V6qbtSdCZhRSgzOqx
        z9C/2PNeCwf2hJbQFjIQSE0xQUnDZPWeLuyHM5s=
X-Google-Smtp-Source: AFSGD/U/9ghz685aJ2mQ2W9GyjEbG3D7a05e5bgPZ1LtUnuZpNn+cJ/hWbOljYnajjIjHqPpm3P0rhZX11/azn7Eshk=
X-Received: by 2002:a5d:488f:: with SMTP id g15mr4135697wrq.15.1543264615455;
 Mon, 26 Nov 2018 12:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20181126150228.8578-1-colin.king@canonical.com>
In-Reply-To: <20181126150228.8578-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 26 Nov 2018 15:36:43 -0500
Message-ID: <CADnq5_Nm_-sLR1OfrXBPsE0YGNCEJ6Wv+sFAa01Am7XLvvpH9g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix spelling mistake "Pramater" -> "Parameter"
To:     Colin Ian King <colin.king@canonical.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:02 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the module description text and
> a comment too, fix them. Also line break overly long comment.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 8de55f7f1a3a..dd03fe77b3ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -454,9 +454,10 @@ module_param_named(cntl_sb_buf_per_se, amdgpu_cntl_sb_buf_per_se, int, 0444);
>
>  /**
>   * DOC: param_buf_per_se (int)
> - * Override the size of Off-Chip Pramater Cache per Shader Engine in Byte. The default is 0 (depending on gfx).
> + * Override the size of Off-Chip Parameter Cache per Shader Engine in Byte.
> + * The default is 0 (depending on gfx).
>   */
> -MODULE_PARM_DESC(param_buf_per_se, "the size of Off-Chip Pramater Cache per Shader Engine (default depending on gfx)");
> +MODULE_PARM_DESC(param_buf_per_se, "the size of Off-Chip Parameter Cache per Shader Engine (default depending on gfx)");
>  module_param_named(param_buf_per_se, amdgpu_param_buf_per_se, int, 0444);
>
>  /**
> --
> 2.19.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
