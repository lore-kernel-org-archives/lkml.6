Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6934C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEC621473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NLJNiyt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEC621473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeJDPZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:25:11 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39310 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbeJDPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:25:11 -0400
Received: by mail-it1-f196.google.com with SMTP id w200-v6so12870720itc.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lyvIaNzi3as9klnx/wt8BAP/YKGZAKnJ8N23b4uyts=;
        b=NLJNiyt1k5x2l1SodsnmAuYQuBCh2RxXNQo6mq+pzdvW7er1w1zopR84x0et+H+1+d
         FXofF2yCiBcOL1O+XZNBB5TGVNtDP45k18dRDRhJkxB7DtenrVUsvr2gpx5OS5H/szvo
         o/ZN6Yg+omLdhqpF5+HYFkjJ9FbHsqYB4PLuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lyvIaNzi3as9klnx/wt8BAP/YKGZAKnJ8N23b4uyts=;
        b=Rf43EvEQCpfwk1oRrPBSq6oYbvjZQCrnexUPAlcBsHCb+ybQbqWK3NKKADY1XFKvlk
         B5qPApgTN7sx8occPMw5x9ixSzBVcXtPld2txO8UqRH2NWAXSz3UdzXRW42Pzx/WLFCZ
         r+JrHj3R6zAOABHdGREDMSvpsgsdOqex6//kQjtB3YQjMz8kFZ3synWnNxDGygn0EXUQ
         YerR32d2OTrO3pdcQhVR3IfOJnx5GsfHVVop3tfYUqivunHuBWHtOIsxodv5wl5W2Jb1
         jdNJbzfRcV9V5ZaKzIJ7R7OR24qTXcJOMmB95CiE4qsxdheyE2whxuKO1lgZMKdEXO18
         L3Bw==
X-Gm-Message-State: ABuFfohkNzyTPdDv9ebLl8L1ZXzXeDMDNH6lr8G4XebNG96uwAgm+Qwr
        myKQy4GmUV2pcBipbJBbC2W5anP0Xb30cHFyU9sGZA==
X-Google-Smtp-Source: ACcGV60I5CqioR8lqxqClpeXlwcYNMSSftas+oMQSni1agw64Rog4BVZbGYK/R7fNww1i0vb7JssCoScEMJWemubztg=
X-Received: by 2002:a24:d857:: with SMTP id b84-v6mr4570925itg.77.1538641982594;
 Thu, 04 Oct 2018 01:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181003222715.28667-1-robh@kernel.org>
In-Reply-To: <20181003222715.28667-1-robh@kernel.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 4 Oct 2018 10:32:50 +0200
Message-ID: <CAKMK7uHYnOVJBn57M0yxgXWAxrkg79+rz0zX+7XRHt8KwgvOuw@mail.gmail.com>
Subject: Re: [PATCH] Add a skeleton Travis-CI config
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 12:27 AM Rob Herring <robh@kernel.org> wrote:
>
> It's convenient to use Travis-CI for doing kernel builds. Doing so
> requires a github repo, Travis-CI enabled for that repo, and a
> .travis.yml file in the repository. This commit addresses the last part.
> Each repository branch must have a .travis.yml file in order to run
> Travis-CI jobs.
>
> Obviously, we can't create a single configuration that works for
> everyone as every developer will want to run different configs and
> build targets. Therefore, this only adds a skeleton .travis.yml file.
> With this a user can either set $CONFIG and $TARGET in their Travis-CI
> environment or customized builds can be triggered remotely.
>
> Here's an example of setting up a matrix build of different
> architectures:
>
> body='{
>   "request": {
>     "branch": "master",
>     "config" : {
>       "env": {
>         "global": "CONFIG=defconfig TARGET=all",
>         "matrix": [
>           "ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-",
>           "ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-",
>           "ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-"
>         ]
>       }
>     }
>   }
> }'
>
> curl -s -X POST \
>    -H "Content-Type: application/json" \
>    -H "Accept: application/json" \
>    -H "Travis-API-Version: 3" \
>    -H "Authorization: token $TOKEN" \
>    -d "$body" \
>    https://api.travis-ci.org/repo/robherring%2Flinux/requests
>
> Additionally, it is possible to override 'scripts' or any other part of
> the config as well.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I'm wondering if there's other interest in this. If so, please chime in.
>
> Maybe I should be looking at Gitlab CI instead, but Travis I know
> already and Gitlab just seems to be the shiniest new thing. In any case,
> both could coexist.

So I haven't looked in-depth at the travis+github combo, but on gitlab
you can set the path for your .gitlab-ci.yaml file per-repo. Which
means each maintainer group can have their own thing, without
trampling on each another's feet.

I guess if gitlab+travis can't do that then a dispatcher like you
propose here would be good. Personally I have reservations with gitlab
though, since it's proprietary infrastructure not under out control.
That's a big reason for why fd.o opted for gitlab, and the handful of
graphics projects that tried out a gitlab+travis workflow all plan to
move back to gitlab.fd.o. Gitlab definitely works - there's enough
projects out there to prove that :-) But in the kernel we've already
seen how that can go all wrong with bitkeeper.
-Daniel

>
> Rob
>
>  .travis.yml | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 .travis.yml
>
> diff --git a/.travis.yml b/.travis.yml
> new file mode 100644
> index 000000000000..ba1e59dd44f6
> --- /dev/null
> +++ b/.travis.yml
> @@ -0,0 +1,23 @@
> +language: c
> +
> +sudo: false
> +dist: trusty
> +
> +cache:
> +  apt: true
> +
> +env:
> +  - CONFIG=allnoconfig TARGET=all
> +
> +addons:
> +  apt:
> +    packages:
> +      - build-essential
> +      - bc
> +      - gcc-arm-linux-gnueabihf
> +      - gcc-aarch64-linux-gnu
> +      - gcc-powerpc-linux-gnu
> +
> +script:
> +  - make $CONFIG
> +  - make $TARGET
> --
> 2.17.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
