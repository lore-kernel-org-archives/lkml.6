Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B96C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE9E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE9E2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeH2ROs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:14:48 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36100 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2ROs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:14:48 -0400
Received: by mail-qt0-f194.google.com with SMTP id t5-v6so5641316qtn.3;
        Wed, 29 Aug 2018 06:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98R+mOLqMXtvPuw9rGi7IzvACRbbGXHC9Q6xjqcG/VE=;
        b=VbQ6Zyb++qF/7Ev6hLGHabIWGEpR2zOizcrFdfJEzznEpvO3x1Fix0R5+Dl/iUZJbf
         QEiYL//nqpX0wtXt8gzHpcJOid34gPEhKk0Ulg0Og9BMh0HeNSt/bEER8xT1Vc1qaJVV
         onTdSFSi9j3QDa0/meGjnvSFvQ04Apnyij86Hz9pRFDbalTGxvfPSyXFuYr624bfNIGU
         PMvwTC7heWZ1UK++amNzrhwgCZGWxTnMP9dRVAUY55RX3P9bgEq4I0EHCJZCAR6gDmAY
         Z5hoqPcisQ9aionXuW7rf7uUwHy45N6uwanDUtQjBESM29MuE7sP1H+pCb9hP5wdFrOb
         UIfg==
X-Gm-Message-State: APzg51CQlDTNvK2Ga6RZEYMqIkd6FVn9bxFnqwC6XhOqK0clIMEUndCD
        AFOi6kGK9RBtlk6/L1V9KeRPiRd3C+G8xv0NSvQW0Q==
X-Google-Smtp-Source: ANB0VdbHYsYDUxPMXmZgwhfrpE50p2+abtdOuv76WpRbOPZV5hVcBJaOB/uzRGltvrgtUjXtHL/LX+2bkjWsHkmdG0U=
X-Received: by 2002:ac8:6959:: with SMTP id n25-v6mr6808317qtr.9.1535548672319;
 Wed, 29 Aug 2018 06:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180827194531.3796559-4-arnd@arndb.de> <20180829125052.GA114325@lkp-g5>
In-Reply-To: <20180829125052.GA114325@lkp-g5>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Aug 2018 15:17:35 +0200
Message-ID: <CAK8P3a11PnCsDTfqk-7fVyntOw83vC3-6VPXq39wkK+3GtH=aw@mail.gmail.com>
Subject: Re: [Y2038] [RFC PATCH] y2038: __get_old_timespec32() can be static
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@01.org, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 2:52 PM kbuild test robot
<fengguang.wu@intel.com> wrote:
>
>
> Fixes: ee16c8f415e4 ("y2038: Globally rename compat_time to old_time32")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
> ---
>  time.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/time.c b/kernel/time/time.c
> index f1983f4..e3a7f7f 100644
> --- a/kernel/time/time.c
> +++ b/kernel/time/time.c
> @@ -863,7 +863,7 @@ int put_timespec64(const struct timespec64 *ts,
>  }
>  EXPORT_SYMBOL_GPL(put_timespec64);
>
> -int __get_old_timespec32(struct timespec64 *ts64,
> +static int __get_old_timespec32(struct timespec64 *ts64,
>                                    const struct old_timespec32 __user *cts)
>  {

This was caused by an older patch and we already get the same
warning in mainline linux, the bot triggered again after I renamed
it. Anyway, the fix is good, and I'll come up with a proper changelog
to include it in my series.

      Arnd
