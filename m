Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AD4C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9482087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX3Ufj81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9482087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeJECFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJECFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:05:47 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96337213A2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 19:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538680269;
        bh=A1oujNri9AkGRYKGNVxXZ6NoHCpf7Hq/uVr7hEo2Xvc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IX3Ufj81t49cF5qhoMhWpKR/EgNJ/hVHADf8E0estAL/nh+aml0HVuzWE19r+/P2V
         oMoCQj6yhD5VZsGRbkdDW/LkgraFZpo6kwQnNd9pWXiHkHiToU1FowYk6Oeo4y0Gvn
         GTt9ulfMJ63P+8UygdxyzHWKg6nR+rDLXmryCKTA=
Received: by mail-qt1-f172.google.com with SMTP id c56-v6so11129153qtd.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 12:11:09 -0700 (PDT)
X-Gm-Message-State: ABuFfojHsmmE8TYlROzzkYTNRsHbKoAt/pC1IDrIb723tJSgZ0xdynY7
        kLnChB0IftVMa6yA7JzSljWWDDJNv3Pxwah3Qw==
X-Google-Smtp-Source: ACcGV62lR8wA5e2C8nrXghzU4TxNRoGqfhHvkTAaBmFuxR/8HbSNZD43TBaCL2UqMWhF/ebBrOcM1YrcEDTY+3oXGDg=
X-Received: by 2002:ac8:2ac9:: with SMTP id c9-v6mr6598379qta.188.1538680268778;
 Thu, 04 Oct 2018 12:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181003222715.28667-1-robh@kernel.org> <CAKMK7uHYnOVJBn57M0yxgXWAxrkg79+rz0zX+7XRHt8KwgvOuw@mail.gmail.com>
In-Reply-To: <CAKMK7uHYnOVJBn57M0yxgXWAxrkg79+rz0zX+7XRHt8KwgvOuw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 4 Oct 2018 14:10:57 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+DpM5Cea-y08MXDP-AKUE07KpwUoCbiRgH_iSkZU6cSA@mail.gmail.com>
Message-ID: <CAL_Jsq+DpM5Cea-y08MXDP-AKUE07KpwUoCbiRgH_iSkZU6cSA@mail.gmail.com>
Subject: Re: [PATCH] Add a skeleton Travis-CI config
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 3:33 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Thu, Oct 4, 2018 at 12:27 AM Rob Herring <robh@kernel.org> wrote:
> >
> > It's convenient to use Travis-CI for doing kernel builds. Doing so
> > requires a github repo, Travis-CI enabled for that repo, and a
> > .travis.yml file in the repository. This commit addresses the last part.
> > Each repository branch must have a .travis.yml file in order to run
> > Travis-CI jobs.
> >
> > Obviously, we can't create a single configuration that works for
> > everyone as every developer will want to run different configs and
> > build targets. Therefore, this only adds a skeleton .travis.yml file.
> > With this a user can either set $CONFIG and $TARGET in their Travis-CI
> > environment or customized builds can be triggered remotely.
> >
> > Here's an example of setting up a matrix build of different
> > architectures:
> >
> > body='{
> >   "request": {
> >     "branch": "master",
> >     "config" : {
> >       "env": {
> >         "global": "CONFIG=defconfig TARGET=all",
> >         "matrix": [
> >           "ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-",
> >           "ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-",
> >           "ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-"
> >         ]
> >       }
> >     }
> >   }
> > }'
> >
> > curl -s -X POST \
> >    -H "Content-Type: application/json" \
> >    -H "Accept: application/json" \
> >    -H "Travis-API-Version: 3" \
> >    -H "Authorization: token $TOKEN" \
> >    -d "$body" \
> >    https://api.travis-ci.org/repo/robherring%2Flinux/requests
> >
> > Additionally, it is possible to override 'scripts' or any other part of
> > the config as well.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > I'm wondering if there's other interest in this. If so, please chime in.
> >
> > Maybe I should be looking at Gitlab CI instead, but Travis I know
> > already and Gitlab just seems to be the shiniest new thing. In any case,
> > both could coexist.
>
> So I haven't looked in-depth at the travis+github combo, but on gitlab
> you can set the path for your .gitlab-ci.yaml file per-repo. Which
> means each maintainer group can have their own thing, without
> trampling on each another's feet.

Yes, that's a nice feature.

> I guess if gitlab+travis can't do that then a dispatcher like you
> propose here would be good. Personally I have reservations with gitlab

You mean github here?

> though, since it's proprietary infrastructure not under out control.
> That's a big reason for why fd.o opted for gitlab, and the handful of
> graphics projects that tried out a gitlab+travis workflow all plan to
> move back to gitlab.fd.o. Gitlab definitely works - there's enough
> projects out there to prove that :-) But in the kernel we've already
> seen how that can go all wrong with bitkeeper.

The difference here is this is all auxiliary tools on top of the main
workflow, not a core tool everyone relies on.

It would be nice if there was some standardization of CI config files
then moving CI providers would be trivial.

Rob
