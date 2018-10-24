Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D11ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCF12082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BCa/w9Kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCF12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbeJYEis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:38:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46185 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYEir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:38:47 -0400
Received: by mail-io1-f66.google.com with SMTP id y22-v6so3950749ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 13:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myUIaGAQ4FX09BC3WcQ/tTbGenycR0huzAA5WP9HNOM=;
        b=BCa/w9Kqa9uMTeQwC1JOhravLnMIgNNPp8L1DXtvsKbPyw8Gzfh5L3JzRb+eI4HCAg
         HjS2dou6uBQ189nOnHvQGwo/ZRm2eUgRRFAqtPONkVsGYF0c9W+6HAQTFcmIajf/HEmq
         JuM4St/WzCKJ5lA+rwMCD0bGoQcuNoUNDnhw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myUIaGAQ4FX09BC3WcQ/tTbGenycR0huzAA5WP9HNOM=;
        b=rmbPy2H08Nwmmt8TBP3FaMwgByEDQOfT1N6o8ZtyTM3V4FEAuYAAtGc8+U7l98zYTz
         xgtx3zs9AwsobIkotCzRwW+Hdu/u94iHUS3uwwkchWTgENLbi/5Ws21VESyNzRIDRhx/
         mVgHZkURtfzwsGRTb71IBIiQ7iMQlnkMhqGAQSEBZM/xsiEjt6a2u+UA0H3E3ihoAtG/
         TMbAuey5akvrDrKDEB6IARRs8qvwRpk07hK6Igavt+WP8GMf11v9J+cXXTZDzGpkBuMc
         qCkbijMz9r009MdkWmveuFLMEEzDiRkTPmArhw/OvfTCk5WQ8IhA4FJU4zNdhiEdSMK5
         WYFQ==
X-Gm-Message-State: AGRZ1gLeT3T8znIueiHydVX8I4PZZJIbcCKBuZuxhB+QJ9nnHRiGBsdO
        3Iygd7lgVkKaJKVX41CnJpJWmdlxWBvSKllVrDucjYnkf6Gx7Q==
X-Google-Smtp-Source: AJdET5eLstqBg2h3GbonuFksgEXQq4ZMRiv99rVwn5cFUv3HtbaQvHtHPVMlnYbM36oA68bbtoagdoolPEirK3hdR0w=
X-Received: by 2002:a6b:ac45:: with SMTP id v66-v6mr16627405ioe.66.1540411758345;
 Wed, 24 Oct 2018 13:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181024013132.115907-1-dbasehore@chromium.org>
 <20181024013132.115907-2-dbasehore@chromium.org> <154038647375.53599.631725372765617195@swboyd.mtv.corp.google.com>
In-Reply-To: <154038647375.53599.631725372765617195@swboyd.mtv.corp.google.com>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Wed, 24 Oct 2018 13:09:07 -0700
Message-ID: <CAGAzgspGA0CExLBrJvM8E7a1ybp=PRDz6kJ-dKyp0hi9db-19g@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: Remove recursion in clk_core_{prepare,enable}()
To:     sboyd@kernel.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org, corbet@lwn.net,
        Stephen Boyd <sboyd@codeaurora.org>, jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 6:07 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Derek Basehore (2018-10-23 18:31:27)
> > From: Stephen Boyd <sboyd@codeaurora.org>
> >
> > Enabling and preparing clocks can be written quite naturally with
> > recursion. We start at some point in the tree and recurse up the
> > tree to find the oldest parent clk that needs to be enabled or
> > prepared. Then we enable/prepare and return to the caller, going
> > back to the clk we started at and enabling/preparing along the
> > way.
> >
> > The problem is recursion isn't great for kernel code where we
> > have a limited stack size. Furthermore, we may be calling this
> > code inside clk_set_rate() which also has recursion in it, so
> > we're really not looking good if we encounter a tall clk tree.
> >
> > Let's create a stack instead by looping over the parent chain and
> > collecting clks of interest. Then the enable/prepare becomes as
> > simple as iterating over that list and calling enable.
> >
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
>
> Did you change anything substantially? Or is it just a resend of my
> patch from a while ago? If you can add a link to the original and also
> describe what changed in a maintainer tag it would be much easier for me
> to compare.
>

It should just be your patch with the compilation warning fixed.

This is picked up from https://lore.kernel.org/patchwork/patch/814369/
