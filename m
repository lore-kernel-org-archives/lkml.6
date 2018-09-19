Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E02C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2E82151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLaOOrmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2E82151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbeITBez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:34:55 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:56069 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeITBez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:34:55 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so10007087itj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 12:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hkNUf5XSaJnGSboqpwoEp+f0so5NrbKQBmmw4lVzaE=;
        b=OLaOOrmF4TC4PWeWBWxQWDggnry4L175dZJOqDnGG1BAPjx0T9jKpo+4ycHnuvTFMs
         Dh7wn658kNQI5Hn7TFJ1MGwT9eC6yENIZhCB/axnymPtq7yd4h4RtJCpUG3L2q4mLLG8
         M2VYrilP1UzjqJop5mBhnUQpSg2/tMmmp6IGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hkNUf5XSaJnGSboqpwoEp+f0so5NrbKQBmmw4lVzaE=;
        b=iRO+8quxXCUQZteYTr/vjkU5R8EBiqtEwSFpxQBvUqcC1Oe0vr51y25oX2zEluiFfc
         nf7n+RtKEhxAFwB+sstY5kfcQiKc80B4mhELFuDBGT2XjWR+F1PuX0zUpvogxChfnfFj
         jXv6TgRTCY0Uxkv2Unu/whtTUpmZBdQsBCEj9Hgls8pKQd9DKYIo5QCEvphMDx0mnVqb
         CV/5Q4AbrnujWlijk4iTZ4JqTqfSLGUafjah6xPohbp6IRQna0AICDcHqP1br0VtzLsM
         3asePxgTcIzdbJhQGjOBJHWhYic1nR9yF0IyAhZ6XTPWk8WzP9hWGMIDcCMGiicZeWox
         5nJA==
X-Gm-Message-State: APzg51ChGWkUQTTzIU2AJEZuuUeHwgpjuY9fzSi97u9pKMnyDb+JNG42
        NWk3woEZlAscDzn9VLj52BARCtWrb0dfHtCT1QXpsg==
X-Google-Smtp-Source: ANB0Vdaagzyl3wnKjr9qdCJWoV2GcxX8xx/lvkoVgo6/hG67wwWsJOvktppUTCwI+N6rCP4TMbf0yhKBQqzWTINKZNk=
X-Received: by 2002:a24:6b0d:: with SMTP id v13-v6mr23803203itc.16.1537386927732;
 Wed, 19 Sep 2018 12:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 Sep 2018 12:55:15 -0700
Message-ID: <CACRpkdYAvhaH6+L8J0sdQd7vYzrAioFhUZAcu2eB6t2hRK0L9Q@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/5] Support children for legacy device properties
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Input <linux-input@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 11:16 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The generic device properties APIs are very helpful as they allow abstracting
> away details of the platform (whether it is ACPI, device tree, or legacy board
> file), so that individual driver does not need separate code paths to support
> all variants. However there are drivers that currently can not use generic
> device properties API as they need notion of children properties, for example
> gpio_keys driver, that expects every button to be described as a sub-node of
> main device.
>
> This patch series introduces notion of sub-nodes for static properties and ties
> it up with GPIO lookup tables so that they are usable with sub-nodes as well.

This is the patch series I would have written, had I been smart enough.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
for the series.

I can't test the SIM.ONE board with this until next week but the approach
is definately what we want, not just for legacy boards, but also for any
other non-discoverable hardware we currently poke into
drivers/platform or arch/x86/platform etc.

Yours,
Linus Walleij

Yours,
Linus Walleij
