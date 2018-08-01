Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B9DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBD520894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kx6Snyob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBD520894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389753AbeHARIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:08:22 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:39418 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389627AbeHARIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:08:22 -0400
Received: by mail-lf1-f48.google.com with SMTP id a134-v6so13590640lfe.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iqkJ59FpCJb/jM6D0w/mu/JMYDq4xxExpNeal9UGa84=;
        b=kx6Snyob6JA7PrWj73gY2/deRHsyJWLWxJ/Uokon4Hr8Qgd/B+PDSEBXpZ9Oxr/QuZ
         2LsM9NgOJQ32yWPbg8qBjeZ/riD94Wo4h4zzkLkvgnxqZ2f6cOo0D4WYl74yI5BN4vsO
         XGmEgnwvHwUXznFep6lDeI9V890UDTn72fGt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iqkJ59FpCJb/jM6D0w/mu/JMYDq4xxExpNeal9UGa84=;
        b=Liw/7J8+3K/5soFQKKgF2cz4miejVtxRPhnrUpGH9/SYpvcnpJD/VVjfJzJfcBoNGh
         5XnQuwyim3DtkFE91H2ZxbhLlCZBSIAWl5Nk0R8tXXkwPn4/hZ4huDTBi4NfDF6LpiDs
         NQtzzikgH2Jo0D5T56YeSPytjfSnUH/XaZ9J50qzpyMD2dG2vmK7LxvDJgG2im/b92Cr
         CsxzHB1VNunLWUBA/Leo+RnQiP3fLyZuET1vTxXTNT8uwr41gUzdhMja4cv/7jfQp/e4
         aNkWwvvylIX+M5xn76LHoCw2yhyzbonzB7Dh03cxnNgXChBkjSuBpNvpD2zgsn2tuJJG
         u6eg==
X-Gm-Message-State: AOUpUlEI9EQ0022CyvPO3AkmqN3qqR1mYNc220GVD5Bf/o62Fj7TibUP
        O4pv+MlguCcK6bBJmYO3108X1ZzliSZlmoiGWSg+xbZG
X-Google-Smtp-Source: AAOMgpfgxlEjQ/E9O4jFVW1UYDPKRFEPDZRPkh2vkSV/qpwKQKR4LMpzDsdJMwYGwwF9w7I3EREdGca8RwxeBvBUxzU=
X-Received: by 2002:a19:f104:: with SMTP id p4-v6mr13900172lfh.137.1533136928487;
 Wed, 01 Aug 2018 08:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180801154525.79da6372@canb.auug.org.au>
In-Reply-To: <20180801154525.79da6372@canb.auug.org.au>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 1 Aug 2018 09:21:56 -0600
Message-ID: <CANLsYkyX5yT0MozSN36OR0z1vXR9ndELv9m-fb4ULu07oZHLXw@mail.gmail.com>
Subject: Re: linux-next: please clean up the coresight tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018 at 23:45, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Mathieu,
>
> All but the last 9 commits in the coresight tree have been merged into
> the char-misc tree as different commits (they were sent to Greg as a
> patch series rather than a merge request).  Can you please rebase your
> tree into commit ccff2dfaceac ("coresight: tpiu: Fix disabling timeouts")
> from the char-misc tree to avoid further conflicts (and duplication if
> you ask Greg to merge your tree rather than take a patch series).
>

Absolutely  - right away.

Mathieu

> --
> Cheers,
> Stephen Rothwell
