Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02514C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3632086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcnyPvCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3632086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeIZBZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:25:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42031 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeIZBZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:25:23 -0400
Received: by mail-io1-f65.google.com with SMTP id n18-v6so21368520ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 12:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hqj9sxfHL4+nnoioNvGJ0QwEnHVqHYvJCYXK0FLJxyU=;
        b=BcnyPvCIHZOMr+1lVaWonikbXRInFRSlYb9jcHhIZFv9Tx/IQN13xi2ak4g1bMIvIa
         cRxrnchXoSsHivsYw09j1SQK68Pv1LiWmGLpt33DS1I8IqZMvk0d5h0NCFiP6Xdp6BxB
         rcUM82J5oeM1FPU6AOZvvkkUtMpLsqhdnF8W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hqj9sxfHL4+nnoioNvGJ0QwEnHVqHYvJCYXK0FLJxyU=;
        b=Yb1Y3Rq/fmGY4GzoI516X77Eqa1joGhXGEw2Axg5Zhh8XhKIz2sTvBCGm4RC81wWG8
         mOrfy699v+8Qi36YWZy3WQQ10r4HtsiC+/g5PCiiKci6gsm1JwYU/aHP+vhGK4ykS9w2
         uDVjSkfz8O47lYs8WiyuHPllaa9igVUuZQStgSNX76kCvdhxQPMPh9k2nZ6vj2bTJxFh
         +AVMkj/xnS7esCjPnKh4cT6c8G9NcrESmPYII4IMluu/GyoZkIpUAgC+Of4kPeWHwE4+
         RkiVJkq3E23wbWNAa3ktEe3NYg0ll1yUI/+39lfrxoYIlnFbbMtSdTOqbfnvxSJM7VIL
         Qb7w==
X-Gm-Message-State: ABuFfohv35UGJnYNF7SyFOj824y4utxn1rIX3HE3X6mCUkSXk8krqu1C
        ak/4l+M1MuButGhYqJoNpSy9ZOhko47jCjQxN5PdFg==
X-Google-Smtp-Source: ACcGV61FJByoDXcGshdY3PcN1vnmwXxGo49RLOPj6dxPrVQy842caFW9ibrLARMRuWquvTVSWXJWA7D7h+hmI5iDxHY=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr2239891iog.175.1537902982801;
 Tue, 25 Sep 2018 12:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180919221331.2511558-1-taoren@fb.com> <CACRpkdZGjvLZY7snev5W2rRGgO7bQsSqn5u2v5Nw0tH9sa4yBw@mail.gmail.com>
 <84F9ED20-0964-462E-B389-39B107A232D3@fb.com> <CACPK8XeEZeMskkxNChhNSO+brpoPJ5FqweWNXe22BpyytwCwFw@mail.gmail.com>
 <E3FA56EF-0B3C-4DBE-9A63-428EB342887D@fb.com> <CACPK8Xd03w51FM8iJsFNhWkpRFMhy97XZpxOhbRwbD3ytQcRbg@mail.gmail.com>
 <571BD9E6-5A5B-4B66-AFAB-EC4E97B0A0D7@fb.com>
In-Reply-To: <571BD9E6-5A5B-4B66-AFAB-EC4E97B0A0D7@fb.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Sep 2018 21:16:09 +0200
Message-ID: <CACRpkdZbHwTFbi__5gobypc43OzvgpJ3qL5c9=xLq8KEbVQqdw@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix set_next_event handler
To:     sdasari@fb.com
Cc:     Joel Stanley <joel@jms.id.au>, taoren@fb.com, cov@fb.com,
        Andrew Jeffery <andrew@aj.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 7:13 PM Sai Dasari <sdasari@fb.com> wrote:

> =EF=BB=BFOn 9/24/18, 4:21 PM, "openbmc on behalf of Joel Stanley" <openbm=
c-bounces+sdasari=3Dfb.com@lists.ozlabs.org on behalf of joel@jms.id.au> wr=
ote:
>
>     I will then add it to the set of tests I run when testing aspeed
>     kernels.
>
> Thanks Joel! Curious to know what would be the best place to keep these k=
ind of Kernel test cases for sake of review and/or adding new test cases as=
 needed.

tools/time in the kernel tree?

Uh oh there is something familiar there already:
ls tools/time
udelay_test.sh

Yours,
Linus Walleij
