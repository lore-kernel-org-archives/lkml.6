Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB620C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F56620832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oBl84pv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F56620832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeK2M7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:59:41 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36538 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeK2M7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:59:40 -0500
Received: by mail-io1-f67.google.com with SMTP id m19so274229ioh.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 17:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xlLEq1ulY6epJsDII+p9Ka0heaTLS34lV6yWaj1F0M=;
        b=oBl84pv5w64W2C8h9mgHrMCVD/c6fzTAcMScHg9WWy2Va1E9IhyNb8dOdm0G9E6/d/
         l3QX2Z+L6Wj/BpoGKDhqtyJsirVeTCf6hUt0AnBiXpTlYmaRKOVSJZRMVD1s7qMtLemV
         dAZpUr+Oo0VZs5+GRGQ19L1e5OxVYSgKNdyq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xlLEq1ulY6epJsDII+p9Ka0heaTLS34lV6yWaj1F0M=;
        b=lPUMj5PF/0DFpmbIVxS1uEM5BcWqTxE3qNGVYv5jWBXSsLPxxcdeQgIaFobf85zSjt
         OO2BqulrPOC6BWan4HdmAZmAqSx7Aa2lPcaUQ4RmoclcxuPqQJayoLljYCeMYA2PgCSi
         bA8sAV1iJQeJXQx7JKRejzKdd80QlvMVvJ5eDcwkimr75S6quQ2p308GZxvtsX6jhtOs
         DBI6f9y7obQJBpJVqQNJcLQDoPXTD5gn0nFrnYjiQJlM5LULWyA1TWX9Efj6tJ7Yfzin
         +lqJU9EZCtJ/64K8NKR0Qy0IbcxpMRpb1VLhBawZZncy7RG+wgy08FB6ce4FKh65IUH/
         PYIQ==
X-Gm-Message-State: AA+aEWZj2HkIJVZxcu98HPVICEVDt9LH0/Jz8DanNRB5cQRAqt1aSjw0
        WfQf/GgS5XyzcVVvG9G6Bk6JlnaFx7Ym8JSDbO2k8A==
X-Google-Smtp-Source: AFSGD/WXnEvV3tdzp6rgGT+XZxQRCkrAz+12iXHLs2IC3vVyErSo5N4S2D9AJKGiDP71C4TRzLRnskun5RK0SDHd+x0=
X-Received: by 2002:a6b:c948:: with SMTP id z69mr21312734iof.161.1543456560336;
 Wed, 28 Nov 2018 17:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20181128031926.7157-1-ryans.lee@maximintegrated.com>
 <20181128094955.GG6828@sirena.org.uk> <DM6PR11MB3131E267C1EDF9254BC7D313E7D10@DM6PR11MB3131.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3131E267C1EDF9254BC7D313E7D10@DM6PR11MB3131.namprd11.prod.outlook.com>
From:   Grant Grundler <grundler@chromium.org>
Date:   Wed, 28 Nov 2018 17:55:48 -0800
Message-ID: <CANEJEGse1DGQE6K=sn=bfJuQW=-gM6zps+kvKd8y=yzXjrsTZQ@mail.gmail.com>
Subject: Re: [PATCH V2] ASoC: max98373: Added max98373_reset for stable amp reset
To:     RyanS.Lee@maximintegrated.com
Cc:     broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        perex@perex.cz, tiwai@suse.com,
        Grant Grundler <grundler@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Benson Leung <bleung@chromium.org>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        ryan.lee.maxim@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 9:07 AM Ryan Lee <RyanS.Lee@maximintegrated.com> wrote:
>
> >-----Original Message-----
> >From: Mark Brown <broonie@kernel.org>
> >Sent: Wednesday, November 28, 2018 1:50 AM
> >To: Ryan Lee <RyanS.Lee@maximintegrated.com>
> >Cc: Liam Girdwood <lgirdwood@gmail.com>; Jaroslav Kysela
> ><perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Grant Grundler
> ><grundler@chromium.org>; Kuninori Morimoto
> ><kuninori.morimoto.gx@renesas.com>; Benson Leung
> ><bleung@chromium.org>; alsa-devel@alsa-project.org; linux-
> >kernel@vger.kernel.org; ryan.lee.maxim@gmail.com
> >Subject: Re: [PATCH V2] ASoC: max98373: Added max98373_reset for stable
> >amp reset
> >
> >On Wed, Nov 28, 2018 at 03:20:16AM +0000, Ryan Lee wrote:
> >> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> >> ---
> >
> >Not seeing a changelog here like I asked for :(
>
> Actually I added changelog as below. Do you mean this is not sufficient?

The text is probably sufficient but not in a format that Mark can
directly apply.
Please take a quick look at Documentation/process/submitting-patches.rst.

Mark wants the "commit message" to be before the '---' line. So move
the "Changes:" text up to become the commit message and drop the
"Changes" line. That should explain why this commit is needed and
include the S-o-B line.

cheers,
grant

>
> Changes since v1 : Removed unusual repeat for amp software reset and verification.
>                    Amp software reset will be performed once and it repeats verification maximum 3 times if it is failed.
>                    Wait 10ms before every verification trial. Maximum 30ms delay will be applied to wait AMP idle state.
>
> >
> >> Changes : Created max98373_reset function to minimize code duplication.
> >>           Changed regmap_write to regmap_update_bits. Other bits except LSB
> >need to be masked.
> >>           Added reset verification step to make sure software reset is completed
> >well. Software reset is done in 10ms in normal case.
> >>           Revision ID is available when the amp is in the idle state which means
> >software reset is completed.
> >>           Software reset will be performed maximum 3 times to avoid amp reset
> >failure. Generally it is done in the first trial.
> >>           sleep time after software reset is increased + 30ms for every retrial.
> >Maximum possible msleep time is 100 ms (initial 10 ms + 30 ms * 3 times).
> >
> >This looks like it's supposed to be a changelog but it isn't one?
