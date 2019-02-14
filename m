Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A5EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1287222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udO5+wPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392953AbfBNB4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:56:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43499 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392852AbfBNB4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:56:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id z20so2771664ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 17:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vE7YI1+jpF5FB3wbYkt2nJv6AYL+YBfSQ5+TzTwVsl8=;
        b=udO5+wPIBTYdeajBV3p4KSC/1FuLKSpWJCvhBUHybjbZb3ocibgFiZ4Joxz2x9Hqw1
         yptzru6jRDGlhRtSICAV+cKObWDdzc/EOJoCBnFV1QfBarZIKbpQFqjeKnbRkHNqRfry
         w93BZv5DjX7kZ0aDDMa1njMIpMD0okjODVS9ozP7VTzavUPkDaf4wtUFYsNfhL/aS12V
         jHoOimqFtP5wc6toyUaiuvs7oillZKsunxW27SXflyYVJqCxc9i/gh3o4r6cqfkVT5dX
         Pfl2JpEADQGhAMIZb2qYEEhBeJIm3+svBlTKa+IksFvtoL4oFl7mxU0FWKjeJP/AFR/e
         AeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vE7YI1+jpF5FB3wbYkt2nJv6AYL+YBfSQ5+TzTwVsl8=;
        b=qoObjkZyI5idqOvtf2VW7Gd4GuLx63DC0WaP8jI7+RNzliU/uWdIQdARUdx5hlJlFA
         XkwS534BczZrA/JaLkEtsUJ8e2ejb3RtP6oFIxb5f5AhaZXIp6r1Psfui3Q9pK8GEGGj
         bfnTSyZwF0MiQf1QAU3G8lfkCXApSPt14zN9ExKZz4//7TSWHTVHKDF37z4qrsqBAkos
         aWa0N1V8JmB2wMaE143p1r/XRM9IMXI1XJsFXBlt2uHH1Y9T0O/XuyNpr1Xd56VI9847
         z0iHhRGSA6hgd2m4R7L+iU6zpXYJI5/ZgFqiDIObySGhivssHYTcx4RNdCU+n7OfDTUW
         FudQ==
X-Gm-Message-State: AHQUAubtOj0dlA+k6yxE1mFbTrmW5GcfuD4zpmdvr3y1s4eovmvRzJV3
        rGLcCgSuBtqdpUYiVl1jEZ9VQg4ytd2vGrcfnPKGzg==
X-Google-Smtp-Source: AHgI3IYknKajOolFCf7n/uhfd3liGBSlNzqLUCIzka1X1PZK1LiUPGgVFObyELcOutHdWysAZsIKXEG6xUxmkmgcwWk=
X-Received: by 2002:a2e:868c:: with SMTP id l12-v6mr693138lji.90.1550109398924;
 Wed, 13 Feb 2019 17:56:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550060543.git.baolin.wang@linaro.org> <f34970a034946bacda19202e2ce9973ca732c925.1550060544.git.baolin.wang@linaro.org>
 <CAK8P3a38=4JZvqPi8f8Mpup2P70c+_xsM48-b35BVRYWGeHp9w@mail.gmail.com>
In-Reply-To: <CAK8P3a38=4JZvqPi8f8Mpup2P70c+_xsM48-b35BVRYWGeHp9w@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 14 Feb 2019 09:56:26 +0800
Message-ID: <CAMz4kuJ3-tjXUKk0Hcr3gJLRNmg1REe4NPm3AaXc=Nq21AKzZg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: sprd: Remove wildcard compatible string
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        DTML <devicetree@vger.kernel.org>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 at 22:32, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Feb 13, 2019 at 1:34 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > Remove wildcard compatible string.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
>
> Looks good to me. It does break using the new dtb file on older kernels,
> but I suppose this is not a case we care much about yet on your
> platform, given that both the dts file sand the drivers in the
> kernel are still  work in progress.

Right. Thanks for your reviewing.

>
> I had started the other reply I just sent before I saw this new mail.
>
>     Arnd



-- 
Baolin Wang
Best Regards
