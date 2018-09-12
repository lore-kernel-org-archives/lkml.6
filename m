Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2C2C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A5820866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A5820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeILP2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:28:30 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35041 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeILP23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:28:29 -0400
Received: by mail-qt0-f195.google.com with SMTP id j7-v6so1261784qtp.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 03:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81sB+O8iCk2WDsipWkaqzgbOf+7YFxoDyhiKH/Vmba4=;
        b=QKqC1q8ATpE7KzWDgz3qhNGNkr94jviaxZ01BWttxgxTYVVgDZ5B/uL05jnxro2Q0w
         HRnIUTeFcJXisAej20gEHq6XUIv1soxpY1teR9PZITRSQWHgY4gNzPR8MdKsbkXDJ1/5
         5JfqS2f+WN1QGzzvm9lmJW2/IWNfH2or5Mr2iA0HCYc/OieiLnVpo05T7LsK2oHeogvK
         zh/SKfEfsKuxvAqTteBp9flkbB6Dzj6gcS/tvwu9jwawmCCT1RWhE4OitAG0n/+E/fFx
         dc7R2Soi8PNky26hi6GOnxYK7XoRptFAJtY6ad3S9ihfspyIbEC8G+L0ZlGHSUmjfIu+
         uOjQ==
X-Gm-Message-State: APzg51Bc1iEiItMONd/BR+5tD1HWsomnCNPgRxTTErVaGMVLPutso1Jj
        OcASg7O3cYLXeLEUcHJ4LxFstjh6uKLDngdCVZs=
X-Google-Smtp-Source: ANB0VdalmEZxg1kVqhpgDSqdxWts15CaMxH+Uhn8g7BWGWpad1mNLBZho9oqz9E4oma8v8hN7CWYFDnrr7GfavHkgLo=
X-Received: by 2002:a0c:c171:: with SMTP id i46-v6mr807337qvh.40.1536747876693;
 Wed, 12 Sep 2018 03:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <4853c5b7-fc65-5499-a129-52bfc6c2851f@gmx.de>
In-Reply-To: <4853c5b7-fc65-5499-a129-52bfc6c2851f@gmx.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Sep 2018 12:24:20 +0200
Message-ID: <CAK8P3a0KE+OEW2aSXd0Xgjd-1JeQC3+G+k6EdCdZQPRm+nFWmQ@mail.gmail.com>
Subject: Re: [PATCH] drbd: avoid clang warning about pointless switch statement
To:     20170201165532.2605534-1-arnd@arndb.de
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        drbd-dev@lists.linbit.com,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 12:01 PM Philipp Klocke <Phil_K97@gmx.de> wrote:
>
> Hello,
>
> I've also stumbled across the "warning: no case matching constant switch
> condition '0'" and wanted to fix it.
> As your suggestion is probably the best way, I wanted to ask why it
> didn't get merged yet.
>
> Maybe the patch got lost?

I think I never followed up on the patch when it didn't get merged the
first time around. If you have a copy at hand, could you add your
Signed-off-by and send a version that applies to the current kernel?

    Arnd
