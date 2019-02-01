Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D79C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9472920863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSAK2T7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfBAVHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:07:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41479 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBAVHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:07:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so8541114wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 13:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HsZVSBWj7z0mRspqZ9McYt5MdfZqk7xNhC76T48JB/g=;
        b=KSAK2T7rwkDrGQNINWJdMUGkZJL1c5dPtQ2fSypqWMesU8h2ZmYmUIhw3LCblpwkB+
         xH74Z/yQFP+OsMfUODqRzl/j9BgdeEgVXPntxju5T7DNB7RA0fDBpx4wzEjNBW01YcEX
         1483H8cIq7BwueGQL1tBQGe4+1B8Cu9gru50MMYaV+mEtExRYCV26jnrzUg8Wo+QNVAn
         +TOvtV+0PV7DvlCGevaI+rv+QXZZBWscZgP+AEw4qEDcZsKcOUs6CVl49CTmITSPvMEZ
         Gwm7LdaPqZ4oMd9txinudAKYPRRBYfonEKRgVK4UAFtfpAbvfb/ZhMA7HwpnJ26o00Kj
         CcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsZVSBWj7z0mRspqZ9McYt5MdfZqk7xNhC76T48JB/g=;
        b=scItA84PRhSHbsHHRwpraknQK7z0wbup+m0YLxBsCbKktheC064OHeA1NI9gHFzto2
         50pW4iGfAnuQ+JOolwm/AAFUtqZ1gjGuPK1UzNULih9MYoDWx2MVD6Js62xR2Cv0380E
         EuBS2gkB5Z1pHDYha3vusWbm1QNTPRxSLo4699GuiLLq/x2iopU5I1MY2WXkJMwilc1G
         Ch2DRBSPq3eMCTu86/bSKKqkOoTFV//AsZqW9cEZKZKn7RNwafMmjEsX0CQR1C1IxBeJ
         5bNwU+uNG+3a8PVJH/pchC3vU0EOcojmZhlgHRNPaVaIF414DnfIC0AR1lkckME858pl
         tCwg==
X-Gm-Message-State: AJcUukd5UfHZuHG9nWS47IbiqqBLRPf/hBbdyNTAjEnrluloXrM71MTP
        hNBSn8i2viDzmnIS98SQxQ4p+TKxulknIoUUT9I=
X-Google-Smtp-Source: ALg8bN4Z06iBHk1WK/Ip1OAoQPKwFyyevMpWgCDYPjCqWwEzj6Ml/WDD/7j8vVKNk+VtB4bMHamBY4q95kHj76uz1GI=
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr38483727wrh.317.1549055259620;
 Fri, 01 Feb 2019 13:07:39 -0800 (PST)
MIME-Version: 1.0
References: <20190201201226.12812-1-natechancellor@gmail.com>
In-Reply-To: <20190201201226.12812-1-natechancellor@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 1 Feb 2019 16:07:26 -0500
Message-ID: <CADnq5_NTyJMt5Kipvx6vMKfGBAtcf76hwmAHVaj5N-Mp6ChRRg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use memset to initialize variables in fill_plane_dcc_attributes
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 3:25 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:2314:38:
> warning: suggest braces around initialization of subobject
> [-Wmissing-braces]
>         struct dc_surface_dcc_cap output = {0};
>                                             ^
>                                             {}
>
> Previous efforts to fix this type of warning by adding or removing
> braces have been met with some pushback in favor of using memset [1][2].
> Do that here, mirroring commit 05794eff1aa6 ("drm/amdgpu/gmc: fix
> compiler errors [-Werror,-Wmissing-braces] (V2)") in this tree.
>
> [1]: https://lore.kernel.org/lkml/022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com/
> [2]: https://lore.kernel.org/lkml/20181128.215241.702406654469517539.davem@davemloft.net/
>
> Fixes: 7df7e505e82a ("drm/amd/display: Set requested plane state DCC params for GFX9")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied all three patches.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dccad2d207ce..1c1c162c4eee 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2310,12 +2310,15 @@ static bool fill_plane_dcc_attributes(struct amdgpu_device *adev,
>                                       uint64_t info)
>  {
>         struct dc *dc = adev->dm.dc;
> -       struct dc_dcc_surface_param input = {0};
> -       struct dc_surface_dcc_cap output = {0};
> +       struct dc_dcc_surface_param input;
> +       struct dc_surface_dcc_cap output;
>         uint32_t offset = AMDGPU_TILING_GET(info, DCC_OFFSET_256B);
>         uint32_t i64b = AMDGPU_TILING_GET(info, DCC_INDEPENDENT_64B) != 0;
>         uint64_t dcc_address;
>
> +       memset(&input, 0, sizeof(input));
> +       memset(&output, 0, sizeof(output));
> +
>         if (!offset)
>                 return false;
>
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
