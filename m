Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2374CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6F020870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6F020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeIJRK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:10:56 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42360 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJRK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:10:56 -0400
Received: by mail-qt0-f196.google.com with SMTP id z8-v6so23772831qto.9;
        Mon, 10 Sep 2018 05:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdBpssGbEHp3QH0N6UKJjZ8IZ0dsF56sg+zppGD0ous=;
        b=b6UegEmGJ/Pu25YMrMtcwoZqD14I8x4uEVcy0A09lRQek3ZQCCLjbVWp14Uiq0u2+5
         yeJ9NkSkNrPhaQPCtOAuiohNPbPy+GRDjTm0PKVOXQlWX3WUtBWDbo16FDUtm645NYm/
         tEZou5oXyo5+veXz16xEGnVH47MALcGb5GK+xOptmDtQ4FFV1cT+oRWN4b4P1K3w68sw
         B+RVh3/ZyBx2gc29Gl9H2wLAdhYEU6JQFHihtcb1Ql5wQ/Um89oFd0lLtBw8/TGqjL0h
         HeDHe5EqzePo7eypQvprAs567wu78/kKKtC+X2asukuk1I/FdP6vg3imEiOthjQnam3O
         9OdA==
X-Gm-Message-State: APzg51DgeDRLBsBcK14xPIq/XWiymQKI0s0UVGPk6d7FNNIy202jFQIf
        FTliryiyURRG0brrVc7l533EfnJffHMAw4A0Y8Y=
X-Google-Smtp-Source: ANB0VdY5yztkLzTdhJOvG2AnoAzTvmRSDrKFvlzCrEf32ZtHWlMZPGnaEn3mJkc3ZfYTj8EfUGEmqQfca36e2Tz4qI8=
X-Received: by 2002:a0c:fb08:: with SMTP id c8-v6mr14183683qvp.149.1536581828186;
 Mon, 10 Sep 2018 05:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180908045928.26201-1-igor.stoppa@huawei.com>
In-Reply-To: <20180908045928.26201-1-igor.stoppa@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 10 Sep 2018 14:16:52 +0200
Message-ID: <CAK8P3a02Q0_r4sqzJzA01GEHf0oUyevwwVg+E0_iCEkLFrwOaw@mail.gmail.com>
Subject: Re: [PATCH v2] asm-generic: bug: unify hints for BUG_ON()
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     igor.stoppa@huawei.com, linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 6:59 AM Igor Stoppa <igor.stoppa@gmail.com> wrote:
>
> If BUG_ON() is used instead of BUG(), it means that probably the
> preferred outcome is to not BUG(), therefore the condition tested should
> be unlikely().
>
> However, when CONFIG_PROFILE_ANNOTATED_BRANCHES is enabled, the hint is
> disabled, to avoid generating false-positive warnings caused by
> -Wmaybe-uninitialized.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>

I assume this will be included in a longer patch series rather than
going through
my asm-generic tree, right?

     Arnd
