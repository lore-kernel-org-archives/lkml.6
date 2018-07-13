Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D26EECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BB1208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5+OAx9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BB1208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeGMJaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:30:06 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34007 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbeGMJaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:30:05 -0400
Received: by mail-lf0-f66.google.com with SMTP id n96-v6so26591044lfi.1;
        Fri, 13 Jul 2018 02:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5Bvfon67BDmp31Z9COYKH7Af/D2Kct0djPnYlOf6Qj0=;
        b=L5+OAx9EhX1CNBqI20oeRQfbaNPO4Psp5LYHbxsPy7tOXGZVYLHxqI28g97uJHlIB0
         /FyGqypyYJ5VR65NV/hGR4CIF4sHZvoUGp33FQi8BNQI1RD4zyMVd4WtbBCWc0MoQOdi
         FZHJflqTMMxeEqP3tCc668/tWkearw4AkMbGGi3eCZhmM1/4M89o5WNWZS1RDJ9QNvPQ
         OIeEa2QUUUVzLLkr8alYi8UiLAqIY70Wx5JPVxmZm8/NlULOip7U8nPmSdmHSX8wL1Dz
         QnCc8pyIx8bSiI3+njVv9BG+O5rp2BneXwG9RSANsszMNGiJYwidNgT6VbfJulmcthjl
         8llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5Bvfon67BDmp31Z9COYKH7Af/D2Kct0djPnYlOf6Qj0=;
        b=EoJ8JzjOcf67sg6BCZHKy0YaDxfNVmP6KLSn2txaNlNi8l7s0S/LI/YUs+wGgzMuB7
         Zp5F9IldmlOpRAfsWDvwlyIh8gP92N9BKsA+52D5MA82m/Czd7tiBWqEUBeTITChyCec
         EafcDTbYcA19KvkpqgZ9NZQZBWR2y1qjrRsv7AqK+lov0PQ57NunNRvVQN4VUFOVFiOM
         CuCIDoSkASDPxUSvHvELL7c0wEvIybUVrgFAInn1aYeTUc7xVF6o7QfCY8pI2PIdMl53
         JxHVXGVC+m1JUZGcBEakvCyn3XsCkvGMZmOEunEuHHlXqQzltS9YwBjGoikZuOQuXWPj
         YefA==
X-Gm-Message-State: AOUpUlFxbD8VC8tBKuG+rCqHR7INleftU2A2jUqV4hTwhMTMF74E4aJ4
        KQTxI/bC7/xK5iQnnsRS7rwZ4n6M+GGWvziWWJ1A8Q==
X-Google-Smtp-Source: AAOMgpdB3bJh2Lw4fKTzPpfjrU2eBg971BCXFp2KUqjSMROv/K5FEDwwxrF7BqWhgqIN3fp3hmzTYkgkWwLrglAwOGM=
X-Received: by 2002:a19:b2c7:: with SMTP id t68-v6mr4248295lfk.132.1531473377150;
 Fri, 13 Jul 2018 02:16:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 02:16:16
 -0700 (PDT)
In-Reply-To: <CACRpkdY5oMG0WknSEnG1khTTm_UKwWwdAbAthA54geGhqgyXpQ@mail.gmail.com>
References: <20180710144737.1136856-1-arnd@arndb.de> <CACRpkdY5oMG0WknSEnG1khTTm_UKwWwdAbAthA54geGhqgyXpQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Jul 2018 11:16:16 +0200
X-Google-Sender-Auth: BulammMxklL6EtbpxZ1Q1B8_kis
Message-ID: <CAK8P3a1M78gtJm95eMjrk+N4KdiY3T=dqyksYdNJotd90qV60A@mail.gmail.com>
Subject: Re: [PATCH] [v2] Documentation: document ktime_get_*() APIs
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Gregor Boirie <gregor.boirie@parrot.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 9:24 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jul 10, 2018 at 4:48 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> Cc: Dave Chinner <david@fromorbit.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Stephen Boyd <sboyd@kernel.org>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> v2: minor changes suggested by Randy
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

> This brings into question commit bc2b7dab629a5
> "iio:core: timestamping clock selection support"
> that has bothered me for some time. Now that is ABI, but
> we might be able to do some recommendations based on the
> time base and have a sensible default moving forward.
>
> As I want to make that clock base parsing similar for GPIO
> I first thought it was a good idea to support the same clocks,
> but now it seems like a bad idea.
>
> IIRC you told me to simply hammer down the clock that
> makes the most sense.

Right, my general recommendation would be to return the
result of ktime_get_ns() in a __u64, since this does not suffer
from the settimeofday or leap second issues that clock_realtime
has, using the coarse clock to save 100 cycles per call probably
won't help.

       Arnd
