Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F069C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F229821927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2aJzK0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391486AbeLUScR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:32:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34189 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeLUScR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:32:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so14801395wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 10:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycfrgqUGjaZqClMDT+P1LH+E0WB9rm7338G/BpAVf6A=;
        b=C2aJzK0zyERQEcJlfRjRVtv0mZADuKmIDIAyDSwrJAtNirygiwfQD+955CmMjSvaWM
         YRzsJaGVoVEdNfeCLfCBh7WS1tG8CHOtkTfItmpk4nSoWPoC3Vf3QfbYe1TK2NLykuYI
         k0A41Wphkl/+d7Eo4KHl1Ii8HGqyCmqNAtT9Qcj2//jdX0hZtu7XXYkbsIYOwPFAj0/D
         RNGqfRT77fSAZTzJLS6H7iSqX9sniE5sXz7987YJg8xTY4oY6dprT2xkuLLT27iXSMwo
         XmS3VC91kF63fVrgDN6zRogUMWAX6CghDlrlqyYezQXuv0fOvLCMLl2dLa8LjlE5AFtf
         drKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycfrgqUGjaZqClMDT+P1LH+E0WB9rm7338G/BpAVf6A=;
        b=Om+O9LKMOCH/59oWkp04GW+X01jbsPOxcb07FM7IdcCMRl+kC0tK624IXONBPJXC15
         6WMRD7mvmel49W8Qx5kpSK6chlWOL80ka38nWRQ3Qair79jgW6YuYyxxxrzPkyoY972W
         BPlt8w9luYYQOjYnU2cvYX+1eVUu12gmuyyJjiY9xcvc1YuWFxKo2Vn8WEEbTBCjIdEz
         qA6fFO58fZrCsqy20iqyK//Iax7jx9v6Tkbk+Xa0xzZNZXYAGBZF/4lbm8hEdkIjbzwQ
         fg1GndAr46XC/EjECEnwMZ73opP+uX0zXx7ff89bt4IpiXMsHTGXSuqnQletzeTKxcmQ
         t5qQ==
X-Gm-Message-State: AJcUukeDJ+YfnJx2kUbA5p717+wSLP4KbcCL+DOUs7hehRC3M0NzidPL
        q85ykNoITMfUf8esSBdBRNjsrhh8SU+DJLr/TQE=
X-Google-Smtp-Source: ALg8bN7HSxkhXSuMCfCEAIteRaVtPPBcpEHfYywEW2rTz4ts6u1QJCPRZ3WZ96vqNp5iWV5DrWcyPxlq+ctr2yfh0v0=
X-Received: by 2002:a1c:9e4a:: with SMTP id h71mr3997725wme.82.1545417134990;
 Fri, 21 Dec 2018 10:32:14 -0800 (PST)
MIME-Version: 1.0
References: <20181221141150.GA2872@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181221141150.GA2872@hp-pavilion-15-notebook-pc-brajeswar>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 21 Dec 2018 13:32:03 -0500
Message-ID: <CADnq5_O3s4FgVDNz=5O4mKOuVeCJUSEfDUri=bQOQHUBv+zU2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay/polaris10_smumgr: Remove duplicate
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
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

Already fixed here:
https://cgit.freedesktop.org/drm/drm/commit/?id=7e07834c12b96214e95a473f7b14fc03b20e2e7a

Thanks,

Alex

On Fri, Dec 21, 2018 at 9:59 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove ppatomctrl.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> index 872d3824337b..2b2c26616902 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> @@ -44,7 +44,6 @@
>
>  #include "smu7_hwmgr.h"
>  #include "hardwaremanager.h"
> -#include "ppatomctrl.h"
>  #include "atombios.h"
>  #include "pppcielanes.h"
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
