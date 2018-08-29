Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B94C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB55420850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PuDNub3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB55420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeH2SAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:00:52 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46200 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbeH2SAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:00:51 -0400
Received: by mail-io0-f196.google.com with SMTP id y12-v6so4556977ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=niFlAg978/cG3aKriwxHa3PJfLick0FP6+ZwOoBkEnc=;
        b=PuDNub3B78CmP/8LZvYVuN6OArQF4o/5PK77Dj8iTS5sABXLMC3p2WqX9dFal1cq4+
         ALChYygGs5zg9+hlWgc+wH9C10MQfxjzMidy4fsYZ1cBeFcOOAuh5UNHbonDRJHeRdeq
         d3kMmoUQ3w2HVt9bvvzeR4tqGSGNYsBPOslTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=niFlAg978/cG3aKriwxHa3PJfLick0FP6+ZwOoBkEnc=;
        b=JqnHX3GPucqVC99GfhBQQzku+xXfkMrwwmaPq2kI34rgVY4BYC3J7v1+kaxJL/xXPV
         An2osxhIRZjdWRFYwtF5E6wWodypWwTwXDr3H+TLbtMFn+4IIqSewfHRCzVNNvjmeeS1
         TkxDmTW4rVx8EmIKlIF5nPeSR9bXJPdRCxrR4ajOaPoJ6nlDAeyKBhrTXGGwQ43/f0ua
         UtE+4nzxJfIa3eni+lsNiXLJLrTj13QaREJBHCIN7QNKh/YYRCTWogbja+Zy4pzeXK7+
         owH252ABxBy4aoIQ9CUXgVAnCCRvFzl3zbGHhmvnrGMRoJnE+y+MJephr33t3GAQfDoJ
         mxgg==
X-Gm-Message-State: APzg51Dqf1IyWmHERtlxqM7mk5u0VBjPk57sy5vqddQ7BqUiJPBXY4O8
        9YfS7jl5ldu8CpDC0sB3MzRwR8I2Wujis+1Fn/53xg==
X-Google-Smtp-Source: ANB0VdYi0DpM1im0wrCbfaB2eRDWg3lPX5ezzDOhg9n+8mp+Djt+SkGjPNuW7jsSnUfUGksPujW7VaJkHiYZtKkS9Fs=
X-Received: by 2002:a6b:7f0c:: with SMTP id l12-v6mr5224376ioq.16.1535551425405;
 Wed, 29 Aug 2018 07:03:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:c046:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 07:03:44
 -0700 (PDT)
In-Reply-To: <20180829063347.GB32392@infradead.org>
References: <20180828142421.15335-1-semen.protsenko@linaro.org>
 <20180828142421.15335-2-semen.protsenko@linaro.org> <20180829063347.GB32392@infradead.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 29 Aug 2018 17:03:44 +0300
Message-ID: <CAKaJLVvhGGoVnWxaDGN60ySiZ_y4xOUkamNQRnad3V7SNsNL-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] codafs: Fix build using bare-metal toolchain
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Paul Sokolovsky <paul.sokolovsky@linaro.org>,
        Miklos Szeredi <mszeredi@suse.cz>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 9:33 AM, Christoph Hellwig <hch@infradead.org> wrote:
> Please just drop the ifdef entirely.  The file is part of the kernel
> tree and can't be used for anything non-Linux.

I have better idea :) We can modify include/linux/coda.h instead, by
checking for __KERNEL__ (along with existing check for __linux__).
This way we can leave user-space API header alone. Don't know how come
I didn't notice that in the first place... Anyway, will send v2
shortly. Thanks for the review.
