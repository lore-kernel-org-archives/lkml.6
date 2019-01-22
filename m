Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279F5C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB82F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OC7zf1jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfAVV0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:26:06 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46109 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfAVV0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:26:05 -0500
Received: by mail-vs1-f65.google.com with SMTP id n10so15641938vso.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 13:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6w26hlfgDNTXLsZw2YsSMtNTh3vRrWi44Y9MhG0Qq8E=;
        b=OC7zf1jtjIVfypEI9AvpeWGEVfy8on+CLx+ZXe6SI8weZuMJ/AljD6BVMNiev9kHcR
         xgZj1DxIWIyWYvA0gUS+3AqUOhCpm1oIgAmJrYKvBmq+S5yTWsyucR881uKlPP8+x1KU
         QQS8WTizSkupdOG7OhLuEwQDrKNLzhbLeZLNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6w26hlfgDNTXLsZw2YsSMtNTh3vRrWi44Y9MhG0Qq8E=;
        b=iNx1rW2ZwSGTY3BC6vcC4LJSneAm2JRC2hp7d/TgOeXWp1FqU1jjktZtdhBXotPzCh
         Uh2MF1/9k13zqr2hDxYu2WJBxfIdDwx5J47ReJMYIQOGHmT44GhvIMBhq57vLv1VFpie
         mm+ERZ2NlYYJYPenZvigpn/g4T2gh4X57j7DKQHC+Llnb4RSZ2afEmSra5wytybvs7d4
         4K7fuBBPVy40ycT7ZmFZQSSMnCe+x86ub0gE7ShffAWbcA81OBjRu/xEDx159vMQvtMo
         zb6jCbZkerbk5uzBApcyOTZWkIpi9D8CCuGIJkObqiv6/C3L5Zd0vtEpKTSmZCTbH2ks
         t17w==
X-Gm-Message-State: AJcUukeRiAgHlNS/8nSwAZ2CxM3BI6X3reOieBti7L82m+tR1R2P7fCk
        dskQU2RjJQr07nQwzwk2XRXbFQrDpqw=
X-Google-Smtp-Source: ALg8bN4oCIWiJesgI2j/rS2AT/kLVbXSEtxMLjXNDLQKyyUSs0bcWIBc3TxflusxL71npAROjkIMSg==
X-Received: by 2002:a67:a8da:: with SMTP id h87mr15673882vsi.143.1548192364063;
        Tue, 22 Jan 2019 13:26:04 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a137sm19930310vsd.24.2019.01.22.13.26.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:26:03 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id z24so8596490ual.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 13:26:03 -0800 (PST)
X-Received: by 2002:ab0:60a3:: with SMTP id f3mr14285167uam.9.1548191885777;
 Tue, 22 Jan 2019 13:18:05 -0800 (PST)
MIME-Version: 1.0
References: <20181220173026.3857-1-jcrouse@codeaurora.org> <20181220173026.3857-2-jcrouse@codeaurora.org>
 <CAD=FV=WjLB8TV80cMef9ZqYn7h3szJ6x67_6pL9FnM1Q+8i_2A@mail.gmail.com>
 <CAF6AEGtjHWTSSaeMuGsL7+2bSsBBHWV3TVf8m2ru40d+wKeeMA@mail.gmail.com> <0a260759-be37-bf8f-6e1b-b24406c8eeca@linaro.org>
In-Reply-To: <0a260759-be37-bf8f-6e1b-b24406c8eeca@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jan 2019 13:17:53 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WdpXTt=3cK+8N0htkBuF5=5haA2n+4b_9QGtMOWm455w@mail.gmail.com>
Message-ID: <CAD=FV=WdpXTt=3cK+8N0htkBuF5=5haA2n+4b_9QGtMOWm455w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/msm/a6xx: Add support for an interconnect path
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
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

Hi,

On Mon, Jan 21, 2019 at 9:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi Rob,
>
> On 1/18/19 21:16, Rob Clark wrote:
> > On Fri, Jan 18, 2019 at 1:06 PM Doug Anderson <dianders@chromium.org> wrote:
> >>
> >> Hi,
> >>
> >> On Thu, Dec 20, 2018 at 9:30 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >>>
> >>> Try to get the interconnect path for the GPU and vote for the maximum
> >>> bandwidth to support all frequencies. This is needed for performance.
> >>> Later we will want to scale the bandwidth based on the frequency to
> >>> also optimize for power but that will require some device tree
> >>> infrastructure that does not yet exist.
> >>>
> >>> v5: Remove hardcoded interconnect name and just use the default
> >>
> >> nit: ${SUBJECT} says v3, but this is v5.
> >>
> >> I'll put in my usual plug for considering "patman" to help post
> >> patches.  Even though it lives in the u-boot git repo it's still a gem
> >> for kernel work.
> >> <http://git.denx.de/?p=u-boot.git;a=blob;f=tools/patman/README>
> >>
> >>
> >>> @@ -85,6 +89,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> >>>                 dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
> >>>
> >>>         gmu->freq = gmu->gpu_freqs[index];
> >>> +
> >>> +       /*
> >>> +        * Eventually we will want to scale the path vote with the frequency but
> >>> +        * for now leave it at max so that the performance is nominal.
> >>> +        */
> >>> +       icc_set(gpu->icc_path, 0, MBps_to_icc(7216));
> >>
> >> You'll need to change icc_set() here to icc_set_bw() to match v13, AKA:
> >>
> >> - https://patchwork.kernel.org/patch/10766335/
> >> - https://lkml.kernel.org/r/20190116161103.6937-2-georgi.djakov@linaro.org
> >>
> >>
> >>> @@ -695,6 +707,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
> >>>         if (ret)
> >>>                 goto out;
> >>>
> >>> +       /* Set the bus quota to a reasonable value for boot */
> >>> +       icc_set(gpu->icc_path, 0, MBps_to_icc(3072));
> >>
> >> This will also need to change to icc_set_bw()
> >>
> >>
> >>> @@ -781,6 +798,9 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
> >>>         /* Tell RPMh to power off the GPU */
> >>>         a6xx_rpmh_stop(gmu);
> >>>
> >>> +       /* Remove the bus vote */
> >>> +       icc_set(gpu->icc_path, 0, 0);
> >>
> >> This will also need to change to icc_set_bw()
> >>
> >>
> >> I have the same questions for this series that I had in response to
> >> the email ("[v5 2/3] drm/msm/dpu: Integrate interconnect API in MDSS")
> >> <https://lkml.kernel.org/r/CAD=FV=XUeMTGH+CDwGs3PfK4igdQrCbwucw7_2ViBc4i7grvxg@mail.gmail.com>
> >>
> >>
> >> Copy / pasting here (with minor name changes) so folks don't have to
> >> follow links / search email.
> >>
> >> ==
> >>
> >> I'm curious what the plan is for landing this series.   Rob / Gerogi:
> >> do you have any preference?  Options I'd imagine:
> >>
> >> A) Wait until interconnect lands (in 5.1?) and land this through
> >> msm-next in the version after (5.2?)
> >>
> >> B) Georgi provides an immutable branch for interconnect when his lands
> >> (assuming he's landing via pull request) and that gets pulled into the
> >> the relevant drm tree.
> >>
> >> C) Rob Acks this series and indicates that it should go in through
> >> Gerogi's tree (probably only works if Georgi plans to send a pull
> >> request).  If we're going this route then (IIUC) we'd want to land
> >> this in Gerogi's tree sooner rather than later so it can get some bake
> >> time?  NOTE: as per my prior reply, I believe Rob has already Acked
> >> this patch.
> >>
> >
> > I'm ok to ack and have it land via Georgi's tree, if Georgi wants to
> > do that.  Or otherwise, I could maybe coordinate w/ airlied to send a
> > 2nd late msm-next pr including the gpu and display interconnect
> > patches.
>
> I'm fine either way. But it would be nice if both patches (this one and
> the dt-bindings go together. The v6 of this patch applies cleanly to my
> tree, but the next one (2/3) with the dt-bindings doesn't.

Ah, right.  You need to be based upon commit 85437cddf4e5
("dt-bindings: drm/msm/a6xx: Document GMU and update GPU bindings")
from Rob Clark's msm-next AKA
<git://people.freedesktop.org/~robclark/linux>

...so I guess the easiest is to have the bindings could go through Rob
Clark's tree and the code through you tree if that's what people want
to do?

-Doug
