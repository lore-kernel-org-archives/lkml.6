Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C07EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF6B206A2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phTVbXxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeLOJNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 04:13:16 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35988 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeLOJNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 04:13:15 -0500
Received: by mail-io1-f67.google.com with SMTP id m19so6404935ioh.3;
        Sat, 15 Dec 2018 01:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VF1aZeyMiPPHIzY1pS1EtQQuVYTyqIVSXTQc270tkSs=;
        b=phTVbXxA/d9/HwLKY2wnQjHkLqScDPCceyX/9QjXjRJ2SjmvAYYHfQfzI9fYjjBAsj
         nzi8t+Rq/tw8Q5/3RCXk1vK0GO1/e8pdVUR/pQpouU3DoG4ZMYLLua//Vmmwnj0PogZU
         ScAp6Q4UtImDUvo+gPMOpOpdxCqU9F1CIIK8tGxpAbKJM83tDokL5TNnMgBv9wmUBV+D
         3g1GqlRb6k6UdllMa+1g+WEjlT4/ne5neVbIagrxVIm9RY0FS0v4ajw1iEGvyOHNkJCC
         BX+xYqGI49VG0zd/WUJmVTud9fEW1R8c8pAvjTjStF9Z4R7Uyly9AhlB5k8dBIva18CJ
         hNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VF1aZeyMiPPHIzY1pS1EtQQuVYTyqIVSXTQc270tkSs=;
        b=YQipffn/ZykFWxqjrIFC8ZZ1NLr8T4j+ocmyLtq/RW8KIyz+G5+koK5J+NgJ09WuE3
         2G80jCiDHDvGuYetGUOkKQ1MePQ5hUk64oIWU6KA1FNyzsut0eKJSo9XPjXxRsJLP8ci
         D3R1d3sGBCOnGTib4FNN2a7szan6b00HkcAQjPwmkkC2h9upEHVQwsxDvGHPYt9pkQ5j
         MSJJoCrFYinzFySqsR+rLUkpa2cJYIeNsloHALmLUCDb8AWNnqbpuAtprKScqHfFK6Kj
         nnJAS26tlLgMoZrtGixZCzS0SWnAUPGCZ1IaGpX5rSLbXtAhvr+cVDX4oiPMjdkzYwSU
         5czg==
X-Gm-Message-State: AA+aEWY5rnk0E4+iYg+SLhXK1dp9kJ/GIIIPA1SKJk/ZY8PpSt9FTuLA
        5OCu8MqFqiTETWaismoKJy+vtZ5WY1pVF984hV4=
X-Google-Smtp-Source: AFSGD/WAgzC3G0sY5X7jS4D/tuAP1SqCTGkPlkl6ggFAogKRNTpRFyAufmU/97stGPDwN2sSCdIyovkubfl+i8rNkbs=
X-Received: by 2002:a5e:8b46:: with SMTP id z6mr5002133iom.7.1544865194645;
 Sat, 15 Dec 2018 01:13:14 -0800 (PST)
MIME-Version: 1.0
References: <20181202031912.9736-1-tiny.windzz@gmail.com> <20181204145943.GS154160@art_vandelay>
In-Reply-To: <20181204145943.GS154160@art_vandelay>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 15 Dec 2018 17:13:04 +0800
Message-ID: <CAEExFWscup+j7ich70wo+oWix3iLWQAmWQbdN50cD166E3KQ7Q@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm: remove DEFINE_DPU_DEBUGFS_SEQ_FOPS()
To:     Sean Paul <sean@poorly.run>
Cc:     Arnd Bergmann <arnd@arndb.de>, abhinavk@codeaurora.org,
        bzwang@chromium.org, Colin King <colin.king@canonical.com>,
        airlied@linux.ie, jsanka@codeaurora.org, jcrouse@codeaurora.org,
        ryadav@codeaurora.org, Rob Clark <robdclark@gmail.com>,
        linux@armlinux.org.uk, swboyd@chromium.org,
        skolluku@codeaurora.org, Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 10:59 PM Sean Paul <sean@poorly.run> wrote:
>
> On Sat, Dec 01, 2018 at 10:19:11PM -0500, Yangtao Li wrote:
> > We already have the DEFINE_SHOW_ATTRIBUTE.There is no need to define
> > such a macro separately,so remove DEFINE_DPU_DEBUGFS_SEQ_FOPS.
> > Also use DEFINE_SHOW_ATTRIBUTE to simplify some code.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/gpu/drm/armada/armada_debugfs.c      | 21 ++++--------
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c | 14 +-------
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c     | 33 +++---------------
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c  | 17 ++-------
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c      | 36 ++++----------------
>
> For the dpu portion:
> Acked-by: Sean Paul <sean@poorly.run>
ping......
