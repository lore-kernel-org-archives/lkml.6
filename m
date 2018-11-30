Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBCAC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B892146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUQGknUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B892146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbeLAJdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:33:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbeLAJdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:33:17 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC4442146F;
        Fri, 30 Nov 2018 22:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543616550;
        bh=k1xNQffQWPandFrKviicPOU9k6KxJ1GoFqxgq3ggYzA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mUQGknUa4g+fcp70Y9faAaLHBP/ykizuy+KQ4buJufF3Zj6Nrf+F1A9XpGp1gLzFR
         1J5sDoX9am2/eK9oTCSku6mniXKwB3SHbLrflVBmGNQ3JxJOzHfNc7a7PvoIwpmwLY
         9PeyMwCtNiruR8NvAs8Ymc2taZ3ldbxq2IjDcsWw=
Received: by mail-qt1-f172.google.com with SMTP id n32so7665474qte.11;
        Fri, 30 Nov 2018 14:22:29 -0800 (PST)
X-Gm-Message-State: AA+aEWY4SP/It5Bsu/xKKs85gyaMnI46feZlnMVXh5+nxYWbr3pMENhL
        S+1mImubthouP0reU/LO0DLuXmKBOueqZklivw==
X-Google-Smtp-Source: AFSGD/UBeIuCHplLMR89+mMnrwyjn6O0ySCyoSj4r6wLnxo1X039Y0/torLc2WlvsQzkZngYZjXyXKclCiUs1ogWorU=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr6957373qta.38.1543616549098;
 Fri, 30 Nov 2018 14:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20181130203232.5743-1-robh@kernel.org> <CAKMK7uGrBnaip1E+vp6foGfvdRb2=bhPNOmmZfjTUt2HZPLQcA@mail.gmail.com>
In-Reply-To: <CAKMK7uGrBnaip1E+vp6foGfvdRb2=bhPNOmmZfjTUt2HZPLQcA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Nov 2018 16:22:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKwnzA+e6pbfUCzCX5ZCJAYixjJtDV2Dfh9u-bgOBKYHQ@mail.gmail.com>
Message-ID: <CAL_JsqKwnzA+e6pbfUCzCX5ZCJAYixjJtDV2Dfh9u-bgOBKYHQ@mail.gmail.com>
Subject: Re: [RFC PATCH] of: Add a GitLab CI config file for unittests
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 2:53 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Fri, Nov 30, 2018 at 9:32 PM Rob Herring <robh@kernel.org> wrote:
> >
> > This adds a GitLab CI config file running the DT unittest in a usermode
> > Linux build. The corresponding CI job can be found here:
> >
> > https://gitlab.com/robherring/linux-dt-unittest/pipelines
> >
> > This CI job can be duplicated by others by creating a kernel repo on a
> > GitLab instance and configuring GitLab CI to use
> > drivers/of/.gitlab-ci.yml config file.
> >
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Adding dri-devel.
>
> > ---
> >  drivers/of/.gitlab-ci.yml | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100644 drivers/of/.gitlab-ci.yml
> >
> > diff --git a/drivers/of/.gitlab-ci.yml b/drivers/of/.gitlab-ci.yml
> > new file mode 100644
> > index 000000000000..44a4824f5c33
> > --- /dev/null
> > +++ b/drivers/of/.gitlab-ci.yml
> > @@ -0,0 +1,18 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +
> > +image: registry.gitlab.com/robherring/docker-images/ubuntu-kernel-build
>
> I think it's better to include the docker recipe too. One because
> shipping pre-built dockers is a license nightmare, second because
> better hackability. For a full on example see:
>
> https://gitlab.freedesktop.org/drm/igt-gpu-tools/blob/master/.gitlab-ci.yml

Humm, but in the end you are still publishing the docker images either
way. It's just a difference of publishing across projects and whether
it's 2 jobs or 1 job with 2 stages.

I do tend to prefer the Travis-CI simplicity of just listing packages
to install. It seems like the same could be done with docker and some
magic on the server side. At least for the simple case of 'install
this list of packages'.

> For the kernel I guess the question is where we should put all the
> docker files. There's going to be some need for subsystem specific
> tooling (e.g. we want something that has igt installed eventually for
> anything drm), so maybe just keeping them in subsystem directories is
> best. Was at least my plan with drivers/gpu.

My plan (to the extent I have one) was to put the common parts into
the docker image and leave the small job specific things in the job
setup. Then I can use the same docker image across jobs. Maybe that's
a pointless goal in the docker world.

My dockerfile is simple enough, I could probably just create it within
the .gitlab-ci.yml.

Rob
