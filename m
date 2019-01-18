Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66EAC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EF72086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjJ5dCoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfARTQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:16:47 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38508 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfARTQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:16:46 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so7239571ith.3;
        Fri, 18 Jan 2019 11:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDXl7WSUi074jkd7X6KXoC9QfpZB6qA/GGHETltYmD0=;
        b=SjJ5dCoqac7VkCfxy04aVxLJLojiT4OuWSvB3RqmSa77ELKfTkdHNP/6JAqeZN/WeD
         mHz3jinBxfbdx+zMMyQ1jZ+m5BJ9EegmSpi2aQEfpV97RWM5W40cZFqZwUpnduizZyPR
         4dIxmJHqDQMMdGBnUS6p0seHmc4JeM66Q+pf6M/Xc1RaAQhWc1cgtquJgrLO7gn1BVsF
         g3oFxOBrz6LedKIvPPMsnyGOLpVbbA4XoACqiQbLPd/UT9agBbP8kdN8VO/dG2yMKO17
         UvMXTXdODGilwVaOQyK92hp0XMQ1EkCER/94HykClQm/vCnivz4B/pBfOHdgr5XGrrcO
         pF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDXl7WSUi074jkd7X6KXoC9QfpZB6qA/GGHETltYmD0=;
        b=XrvVo77JvzH/o2GnO013d5dcL8+NsR74LvEjep3SaD13r1CdODiBE22P/VEZr8fzsV
         D46RZDljvz1sOCKB6MnVtZGZYNBe3HzG3YvisQZX/OoblCsjN31YCFJdxj0GtexZMzwz
         xL9fY2+RxqC1HoBxakf1BXStDQK+IPIvoTXLw4JUA3gM0bgKF0ubnLmxUbFYHOJU5hp5
         X59UI8hJhDHeh5e750xtirRFqEmNMsIlOcGl09DrwiqtSRO+U+BtW4ju5bd0xq6l/FhZ
         hqYooKYUuv/1w7sbTBkLAW9Kriv3HyquWbApiJuqqFK6Nml7WKyHiMjEml/DXfHgyqt7
         Db0A==
X-Gm-Message-State: AJcUukd2nXjQqm7sbMZEtxoJKfjrH0aMO4HLCAjCGLIBEfEH11cpcseR
        5SDPLoVgl7FuOPipJjKLegbGl2aElfXZjpHbiSA=
X-Google-Smtp-Source: ALg8bN4+STjkiQljSbIwf9wOS2jkVEHOa8WBSHvMp7uPK4FuAd3VMA6E1MjRxcPMD0TS7wIpyoq4q+vPbIJUmUB3uAw=
X-Received: by 2002:a24:3dd5:: with SMTP id n204mr12804949itn.104.1547839005126;
 Fri, 18 Jan 2019 11:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20181220173026.3857-1-jcrouse@codeaurora.org> <20181220173026.3857-2-jcrouse@codeaurora.org>
 <CAD=FV=WjLB8TV80cMef9ZqYn7h3szJ6x67_6pL9FnM1Q+8i_2A@mail.gmail.com>
In-Reply-To: <CAD=FV=WjLB8TV80cMef9ZqYn7h3szJ6x67_6pL9FnM1Q+8i_2A@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 18 Jan 2019 14:16:32 -0500
Message-ID: <CAF6AEGtjHWTSSaeMuGsL7+2bSsBBHWV3TVf8m2ru40d+wKeeMA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/msm/a6xx: Add support for an interconnect path
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
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

On Fri, Jan 18, 2019 at 1:06 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Dec 20, 2018 at 9:30 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Try to get the interconnect path for the GPU and vote for the maximum
> > bandwidth to support all frequencies. This is needed for performance.
> > Later we will want to scale the bandwidth based on the frequency to
> > also optimize for power but that will require some device tree
> > infrastructure that does not yet exist.
> >
> > v5: Remove hardcoded interconnect name and just use the default
>
> nit: ${SUBJECT} says v3, but this is v5.
>
> I'll put in my usual plug for considering "patman" to help post
> patches.  Even though it lives in the u-boot git repo it's still a gem
> for kernel work.
> <http://git.denx.de/?p=u-boot.git;a=blob;f=tools/patman/README>
>
>
> > @@ -85,6 +89,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> >                 dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
> >
> >         gmu->freq = gmu->gpu_freqs[index];
> > +
> > +       /*
> > +        * Eventually we will want to scale the path vote with the frequency but
> > +        * for now leave it at max so that the performance is nominal.
> > +        */
> > +       icc_set(gpu->icc_path, 0, MBps_to_icc(7216));
>
> You'll need to change icc_set() here to icc_set_bw() to match v13, AKA:
>
> - https://patchwork.kernel.org/patch/10766335/
> - https://lkml.kernel.org/r/20190116161103.6937-2-georgi.djakov@linaro.org
>
>
> > @@ -695,6 +707,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
> >         if (ret)
> >                 goto out;
> >
> > +       /* Set the bus quota to a reasonable value for boot */
> > +       icc_set(gpu->icc_path, 0, MBps_to_icc(3072));
>
> This will also need to change to icc_set_bw()
>
>
> > @@ -781,6 +798,9 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
> >         /* Tell RPMh to power off the GPU */
> >         a6xx_rpmh_stop(gmu);
> >
> > +       /* Remove the bus vote */
> > +       icc_set(gpu->icc_path, 0, 0);
>
> This will also need to change to icc_set_bw()
>
>
> I have the same questions for this series that I had in response to
> the email ("[v5 2/3] drm/msm/dpu: Integrate interconnect API in MDSS")
> <https://lkml.kernel.org/r/CAD=FV=XUeMTGH+CDwGs3PfK4igdQrCbwucw7_2ViBc4i7grvxg@mail.gmail.com>
>
>
> Copy / pasting here (with minor name changes) so folks don't have to
> follow links / search email.
>
> ==
>
> I'm curious what the plan is for landing this series.   Rob / Gerogi:
> do you have any preference?  Options I'd imagine:
>
> A) Wait until interconnect lands (in 5.1?) and land this through
> msm-next in the version after (5.2?)
>
> B) Georgi provides an immutable branch for interconnect when his lands
> (assuming he's landing via pull request) and that gets pulled into the
> the relevant drm tree.
>
> C) Rob Acks this series and indicates that it should go in through
> Gerogi's tree (probably only works if Georgi plans to send a pull
> request).  If we're going this route then (IIUC) we'd want to land
> this in Gerogi's tree sooner rather than later so it can get some bake
> time?  NOTE: as per my prior reply, I believe Rob has already Acked
> this patch.
>

I'm ok to ack and have it land via Georgi's tree, if Georgi wants to
do that.  Or otherwise, I could maybe coordinate w/ airlied to send a
2nd late msm-next pr including the gpu and display interconnect
patches.

BR,
-R

>
> Does anyone have a preference?  It's be nice if whoever is planning to
> land this could indicate whether they'd prefer Jordan send a new
> version to handle the API change or if the relevant maintainer can
> just do the fixup when the patch lands.
>
>
> Thanks!
>
>
> -Doug
