Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EF1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B162321720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpytKtYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbeLTQ40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:56:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35267 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbeLTQ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:56:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so2502448wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 08:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aPxdpKWB0Vy2Yg4uUEsqW4RBYHJyaPxqerPSLHDjQiY=;
        b=rpytKtYmEsvd1SF2y5MesK/7GkLxbVePUU36sZT1avbJBWqo5+Wwx+JJRmfp6R7I43
         H753gDhOljzOvJVS4ks1Ndu5LZ/+UzE4A9aGPoOVV49Qk7ovppi2/ftT9jIS9n+ENtNZ
         kxriRq2Ukei0NfH5ilCpF2sUmHWywtCACMcz4KUR+mFV+4p2MhNgrdr/0YqM2WUb/7vq
         3WtNpDuf5kiuGfiLPONxcD76Q9VMkEnCkvzhsEpEro0+fU5NiXshGmcT3Sz07m5AhCzR
         v7CK6Huw//Nv5IwvHfVrm4Q9Qfi2Z0ieerfWLk9oeB7l5KNaKaik0wHUQk/iiDro+EX4
         BqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPxdpKWB0Vy2Yg4uUEsqW4RBYHJyaPxqerPSLHDjQiY=;
        b=jgghStpak1OhCBnFDiCkGaQB4qSWBNeEHk3mNGGuGsNe46TMtl9irf+W1orf+oXJ21
         TS8aMxfHjIid7zV1n1yoqDOvicEvkzgrnZqaGYZ6NwKm4bqS+uvYwis9+RrhfQa6S/HI
         kHSXC3N9hFFlh7Pe0MY2Ce1AQYxcEiDGbJ37NEeYdoOkCaobvrGONeD5wS9HaPIotZEi
         iws1lPjzXaGfhhUCKZsKBfdbFEuKHjfqvOy0FAhdhiSpHvZaIixg53eGM8or9JzfoHbo
         iArlcxpSXw7IlStjbrznMnZoY+wKBPh3iUboXEtVExCRtAoPeMp+mXI87ak8is4+hv/B
         7FfA==
X-Gm-Message-State: AA+aEWa8CSuZWWrgAFpzm4sFwNkDmuQe4vlk+Mw4SWhgX0ld6AtrVRp7
        m4ouyAtNfZXyVzSNNC1AkFChjP3jHdH3YCb9Pm8=
X-Google-Smtp-Source: AFSGD/XWogbhpmP4pt2ui/FzDCpgMIqJRatGTZCxzpdKr1J4BmfJOVSbAR+fhUAe9Ifr8ZAhPg8m8GR+m3QNZbC91vY=
X-Received: by 2002:a5d:5351:: with SMTP id t17mr23347224wrv.288.1545324983952;
 Thu, 20 Dec 2018 08:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20181220123455.GA24952@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181220123455.GA24952@hp-pavilion-15-notebook-pc-brajeswar>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 Dec 2018 11:56:11 -0500
Message-ID: <CADnq5_MGmr0Zi+QB_ha2CrEq+SF=TM17wzu9=q-RDZa_RmMuEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display/i2c_hw_engine_dce110: Remove duplicate header
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
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
> Remove reg_helper.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Applied.  thanks!

Alex

> ---
>  .../gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c  | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c
> index 9cbe1a7a6bcb..137350142fb2 100644
> --- a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c
> +++ b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c
> @@ -97,7 +97,6 @@ enum dc_i2c_arbitration {
>  #define FN(reg_name, field_name) \
>         hw_engine->i2c_shift->field_name, hw_engine->i2c_mask->field_name
>
> -#include "reg_helper.h"
>
>  static void disable_i2c_hw_engine(
>         struct i2c_hw_engine_dce110 *hw_engine)
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
