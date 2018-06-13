Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DD0FEC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DBB208C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCmmGaaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DBB208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935277AbeFMLWw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:22:52 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:41423 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935009AbeFMLWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:22:51 -0400
Received: by mail-vk0-f66.google.com with SMTP id 128-v6so1270671vkf.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 04:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gjO+EMSuj9aylJx8RXimRE/OzbQ9Fo6YhrNiVel9vr8=;
        b=WCmmGaaCIzt/bXdHUpN9aZaYqDI/h3HePJyR43+jXe5GIXtAXaWbloGMPHzoCXKrtm
         eRS6AunGnptp/rRl8sYr+wydvd7dhNxSJN1M5Pga+KHiKuIkeYnoh/+gKmlsso5vhivQ
         arcutBCs9SHigOqANYW4hfz/TFxY58/Rp6qcPXYV0r8TKw+gEupLp8G/GM/+5t3TudmU
         TzAjbq05qGTP9rGr7YcL1Eh+gb3ulwVBwXfGAyHm+9VFOYTv6MUDYSXDM6zp9eYxJLPX
         F1GsUcu8Xbjs8a21sP0FjVoIrCRR1AdYjYKaPKaEuSG3gvCJ7kDNBSArrrII+MFfZ3io
         S9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gjO+EMSuj9aylJx8RXimRE/OzbQ9Fo6YhrNiVel9vr8=;
        b=fQjPviMN+MsIYz+OJsLZ8WTK6ms5W7WJdqvP9vRNhUPihOEuc5PhMXW3VwQRynE0af
         nI5zhclPJ6eGju/o9SNNt9t5IrOnhv9vzwWPK5KmymGy/SHefC9tZyMUhJG5xt0FNdWc
         xe6+yjhMHueeWsZlpxDciSERXP7xTQ0oMCuIZ6+svhCbRMUsK3w7nuIrh+FzYSNhZk5F
         46DvrmuzgNHiBqxxXw4k6q1OqPSAwwjyBxAjh+Aew10doqZDNPcZATUtmTce0FP3s12r
         H/ym78Jv5AkzRRBbkn29bs/kPfNUGeUuGLIKbM1cdbF5uTU9/NS/3YbEmjU3/kDcmhOp
         Evvg==
X-Gm-Message-State: APt69E3k+vYGGu+YzQ2KfhcK5LeJEqnWgxYPReJnjh59wV3zFWhPg5AF
        Cd9a10x4l6wiVSjlWaXAING7AjZmqSYk7qMDRO8=
X-Google-Smtp-Source: ADUXVKIPZyzJ0w+Hf0ayhYF6/PPk+xozuuQv3YuqrKKSsjNwFXyrEyRMXlOqjZfP5Gz1QgE8BG7U6nf0NvO73aOjQV8=
X-Received: by 2002:a1f:d1c5:: with SMTP id i188-v6mr2704497vkg.131.1528888970557;
 Wed, 13 Jun 2018 04:22:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 04:22:49
 -0700 (PDT)
In-Reply-To: <20180613092919.24075-1-thierry.escande@linaro.org>
References: <20180613092919.24075-1-thierry.escande@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jun 2018 14:22:49 +0300
Message-ID: <CAHp75VeXGT3KG9HXQstFJVyHFO8o64Dk0LSo43FzyR0SvPUONg@mail.gmail.com>
Subject: Re: [PATCH v2] lib/test_printf.c: call wait_for_random_bytes() before
 plain %p tests
To:     Thierry Escande <thierry.escande@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 12:29 PM, Thierry Escande
<thierry.escande@linaro.org> wrote:
> If the test_printf module is loaded before the crng is initialized, the
> plain 'p' tests will fail because the printed address will not be hashed
> and the buffer will contain "(ptrval)" instead.
> Since we cannot wait for the crng to be initialized for an undefined
> time, both plain 'p' tests now accept the string "(ptrval)" as a valid
> result and print a warning message.

There are two possibilities:
 1. (ptrval) for 32-bit case
 2. (____ptrval____) for 64-bit case.


-- 
With Best Regards,
Andy Shevchenko
