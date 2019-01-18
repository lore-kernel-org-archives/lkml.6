Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E057C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F0A20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aq9bJpSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfARSNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:13:04 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45968 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfARSND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:13:03 -0500
Received: by mail-vk1-f196.google.com with SMTP id n126so3255369vke.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 10:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J32IDp9YkQnRqh2wZB2qisJnRhCbto/nhyLrG0nFb5Y=;
        b=aq9bJpSeBElhGQs4ySBKE3ZOYCFsR/5AfswBY+sHI0CInQdDmE7ij0e8zqhIqGzsKd
         SvPDS3Bsb5MocNA/ZanjITLLevPxmzUqs+TE501SzrFcm3UK/0WQ6+c3WfTzIuaSTwN1
         mDHcdtryIeAzzQFd2PwySJl0KnoDIPIQ34a04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J32IDp9YkQnRqh2wZB2qisJnRhCbto/nhyLrG0nFb5Y=;
        b=RQBRpOv1rrcHWEKYdDHWOm+LtFCoINSboIllpGrEiqSxzmGm2uwBLi1tf+CxYkUeUc
         JMryi9Ij8osYLUv5ES8q9ZYAlN99dreGHoyg94ln9d68k8LRx+YRPRLYdjRFHMIPs703
         F7g5LCCY4fy2tcMQ/Li2fK1ib1lMdsUWTEADE3DBrVkbCi6OSl44mAUBsaeTT/1ghpsC
         uJu0ka/fgG56XDA3ihyHmQlaTbsM/dNiw+GgWs9JP2ZbTxPq5hnDDwp/gPCO0ld2ISA4
         LZrZDToZ4a0IjM5VPMg2QLaARLviu5m5HI4SRefvs9gU4z3sVHj5BTiNBET8UojlQIAM
         +pjg==
X-Gm-Message-State: AJcUukdqOTP2nIv0QyNoL826y9mNSPVSkS6bY8CPikhDyIfxDSfrb3V3
        KznhnZ/OXQnjlvg+l9XGGryE39cvrZQ=
X-Google-Smtp-Source: ALg8bN4P4ZzKN+w22//hNZ43k1f8QuybSnKqQ4S3itYvcom2H3R5Rfp4rH8PpoPTaQxqpzso95TXJg==
X-Received: by 2002:a1f:d1c3:: with SMTP id i186mr7594104vkg.51.1547835181571;
        Fri, 18 Jan 2019 10:13:01 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id l197sm79008261vke.18.2019.01.18.10.13.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 10:13:01 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id b74so8937636vsd.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 10:13:01 -0800 (PST)
X-Received: by 2002:a67:dd94:: with SMTP id i20mr8656894vsk.111.1547834800077;
 Fri, 18 Jan 2019 10:06:40 -0800 (PST)
MIME-Version: 1.0
References: <20181220173026.3857-1-jcrouse@codeaurora.org> <20181220173026.3857-2-jcrouse@codeaurora.org>
In-Reply-To: <20181220173026.3857-2-jcrouse@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 18 Jan 2019 10:06:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WjLB8TV80cMef9ZqYn7h3szJ6x67_6pL9FnM1Q+8i_2A@mail.gmail.com>
Message-ID: <CAD=FV=WjLB8TV80cMef9ZqYn7h3szJ6x67_6pL9FnM1Q+8i_2A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/msm/a6xx: Add support for an interconnect path
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Johan Hovold <johan@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Evan Green <evgreen@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 20, 2018 at 9:30 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Try to get the interconnect path for the GPU and vote for the maximum
> bandwidth to support all frequencies. This is needed for performance.
> Later we will want to scale the bandwidth based on the frequency to
> also optimize for power but that will require some device tree
> infrastructure that does not yet exist.
>
> v5: Remove hardcoded interconnect name and just use the default

nit: ${SUBJECT} says v3, but this is v5.

I'll put in my usual plug for considering "patman" to help post
patches.  Even though it lives in the u-boot git repo it's still a gem
for kernel work.
<http://git.denx.de/?p=u-boot.git;a=blob;f=tools/patman/README>


> @@ -85,6 +89,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
>                 dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
>
>         gmu->freq = gmu->gpu_freqs[index];
> +
> +       /*
> +        * Eventually we will want to scale the path vote with the frequency but
> +        * for now leave it at max so that the performance is nominal.
> +        */
> +       icc_set(gpu->icc_path, 0, MBps_to_icc(7216));

You'll need to change icc_set() here to icc_set_bw() to match v13, AKA:

- https://patchwork.kernel.org/patch/10766335/
- https://lkml.kernel.org/r/20190116161103.6937-2-georgi.djakov@linaro.org


> @@ -695,6 +707,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>         if (ret)
>                 goto out;
>
> +       /* Set the bus quota to a reasonable value for boot */
> +       icc_set(gpu->icc_path, 0, MBps_to_icc(3072));

This will also need to change to icc_set_bw()


> @@ -781,6 +798,9 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
>         /* Tell RPMh to power off the GPU */
>         a6xx_rpmh_stop(gmu);
>
> +       /* Remove the bus vote */
> +       icc_set(gpu->icc_path, 0, 0);

This will also need to change to icc_set_bw()


I have the same questions for this series that I had in response to
the email ("[v5 2/3] drm/msm/dpu: Integrate interconnect API in MDSS")
<https://lkml.kernel.org/r/CAD=FV=XUeMTGH+CDwGs3PfK4igdQrCbwucw7_2ViBc4i7grvxg@mail.gmail.com>


Copy / pasting here (with minor name changes) so folks don't have to
follow links / search email.

==

I'm curious what the plan is for landing this series.   Rob / Gerogi:
do you have any preference?  Options I'd imagine:

A) Wait until interconnect lands (in 5.1?) and land this through
msm-next in the version after (5.2?)

B) Georgi provides an immutable branch for interconnect when his lands
(assuming he's landing via pull request) and that gets pulled into the
the relevant drm tree.

C) Rob Acks this series and indicates that it should go in through
Gerogi's tree (probably only works if Georgi plans to send a pull
request).  If we're going this route then (IIUC) we'd want to land
this in Gerogi's tree sooner rather than later so it can get some bake
time?  NOTE: as per my prior reply, I believe Rob has already Acked
this patch.


Does anyone have a preference?  It's be nice if whoever is planning to
land this could indicate whether they'd prefer Jordan send a new
version to handle the API change or if the relevant maintainer can
just do the fixup when the patch lands.


Thanks!


-Doug
