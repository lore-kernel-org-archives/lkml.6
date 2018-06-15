Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F45C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1882208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5rLspkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1882208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966368AbeFOQjN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:39:13 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43699 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966068AbeFOQjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:39:10 -0400
Received: by mail-wr0-f193.google.com with SMTP id d2-v6so10509116wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AA8FLEztVs5cIERNdDgJUMIETbLPvSImr9OdnpMAe3w=;
        b=V5rLspkAGl7JXcdBU/uy70iIFSsMaEypg7IUMazrC1oJaPHECw9sRspwL2KIz9czRF
         mgtwE0E8xyhRjpnSvOTB2dzJNEjpivN3hAHLtoxHpbbXvL2A6smOY/vamcE1ukfzQs5F
         aUsQphM3lSfvPqp9tz2ZE8coVIlUuhPvDifeoX6ebuBSFKvbtOPkyA5zTsSVCRxwZyrE
         6xM2ZRt82zx3RILfQ1nugv5LdW6Xvi+ZQf1BGKiaq5/n7JXDWNAlJPh6W8lDP17MIJVI
         G4GA2bnyTf+quX7MQK6QNaqSdsJPbxkITcy3dOTvzNURG5l5OoAOn74FvPSAkAw8XCDN
         DgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AA8FLEztVs5cIERNdDgJUMIETbLPvSImr9OdnpMAe3w=;
        b=SxoXHjDp2SA8dsu5Rx1EnSFVWMF2oJCdoAZJW8XxDXQKbnE7uxWLNPmQ51sA+Y49Ur
         +5UnptP/PEwgeoXeZdkPseTvS3hU3utbFMae8yuESwR8p5aqHv6D036xISrilTnMGUtG
         MiyQOm2cyGeKk6nnnKyLT7Mm4wAqTFu5Li5yAToZzRD9SB7ahU+GGy+ItsKdGgGt+u1Q
         64WdzIbttQBllXxQxSTNLvQ3/LZdsqAkDvH8e52ESIncvcTXYy1XnciXL7Zj8CjAhRvU
         UIFZe7c056nuE4IgF7AQqgCo11MR+81dSPbiYZtVlJi+oHZsGazyCpZkzzJt6dlxMoKp
         tqvQ==
X-Gm-Message-State: APt69E33CFbw2Dq6OZMADxghL+1iqAjFhEp5giRH+eF3qzzQ4sSYqIeR
        nX0m0OKx2Q20jojMds9DDmpiwdeIErc8Tz3ldPM=
X-Google-Smtp-Source: ADUXVKJlSpp6CslDWCaUW7Mg+hnibPJdbwzGTlg3s0Px7fqgCzj2VAMv1DSowWWlvv7DxTpeB/Hbg4aRb/PY1yY+s1A=
X-Received: by 2002:adf:ba8f:: with SMTP id p15-v6mr2430258wrg.139.1529080748975;
 Fri, 15 Jun 2018 09:39:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:dcc6:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 09:39:08
 -0700 (PDT)
In-Reply-To: <20180615133228.GA28677@embeddedor.com>
References: <20180615133228.GA28677@embeddedor.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 15 Jun 2018 12:39:08 -0400
Message-ID: <CADnq5_PeZBRLVYosQ+rmhDa2QdJv3_FEJJ8Xf6sjoJH5rw8zKA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix type of variable
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     =?UTF-8?Q?Signed=2Doff=2Dby=40freedesktop=2Eorg=3ARoman_Li_=3CRoman=2ELi=40amd=2Ecom=3E?=
         =?UTF-8?Q?=2C_Alex_Deucher_=3Calexander=2Edeucher=40amd=2Ecom=3E=2C_Christian_K=C3=B6nig?=
         =?UTF-8?Q?_=3Cchristian=2Ekoenig=40amd=2Ecom=3E=2C_David_=28ChunMing=29_Zhou_=3CDavid1=2EZ?=
         =?UTF-8?Q?hou=40amd=2Ecom=3E=2C_David_Airlie?= <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 9:32 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Currently, the maximum value that *counter* can reach is 255, and
> code at line 150: while (counter < 1000) { implies a bigger value
> could be expected.
>
> Fix this by changing the type of variable *counter* from uint8_t
> to uint16_t.
>
> Addresses-Coverity-ID: 1470030 ("Operands don't affect result")
> Fixes: 2b6199a1d1b7 ("drm/amd/display: replace msleep with udelay in fbc path")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
> index e2994d3..111c492 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
> @@ -143,7 +143,7 @@ static void wait_for_fbc_state_changed(
>         struct dce110_compressor *cp110,
>         bool enabled)
>  {
> -       uint8_t counter = 0;
> +       uint16_t counter = 0;
>         uint32_t addr = mmFBC_STATUS;
>         uint32_t value;
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
