Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F52C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB3120867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xkp/4BCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB3120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeH2P6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:58:53 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41328 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2P6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:58:52 -0400
Received: by mail-io0-f196.google.com with SMTP id q4-v6so4235240iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emMVttPbR8HwSseuKffnoFbLZcrzgMkQTD0T9mDdwh0=;
        b=Xkp/4BCcZ+1BUx/bFC/xufAvXKGx1BK14Atkh98eaxeMndF2y3cVOF3bRm9fm7qbHY
         ziD6S1GeBjKJLroBWq9bU+AvGsPc/I6pM6Z0PGHknUTq+fDzIKFA/swTspIuDzemDA4e
         L3imSjy0OB7aMnpOBLsmYKOQVkNzY3K6QvSXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emMVttPbR8HwSseuKffnoFbLZcrzgMkQTD0T9mDdwh0=;
        b=Lw7Ij115Er8VZeqXqlXvi0+8pVg+b5S9phbiRSyRQYFuGHZFSz6fYJZXRybozCu01Y
         1sKDRVLGjEPVBcjph9R758S5efLEJAphCjLt3w8oHphlifYep4oZkmwlM/dUwihd9woV
         IOjD8PZQ42nieNCbp7TCBgPhFNi8rSZJSIHWU2SMqJHwYvq4Gjbf2IKwWBEnzCaz/Jxg
         RE4kHRiqun99PXd/eaJFI8HO5B3/Lc24xLmsVl+I2rlHyeLVcWwKEZhBxww7L6lLXuGW
         aQUAufh4URcEsLC1l2o/8KyjBMXUycQibqgJ2Wg9lAR3ZachXL39skHD7vbMY8NdH3Dq
         VWSQ==
X-Gm-Message-State: APzg51ArGTBofARZyH94tzlFlcemydzpPvR2Eby60ZOAViXFuVYh57kX
        8OagltU2xrqJ5Pi/hXBcnsYoC4y8j+OUjEBHeniOvQ==
X-Google-Smtp-Source: ANB0VdaE3g9ol2ZHCMzopAT0L31dqsdrM5rikOTWi9kKb83KurFZ46NErsVteARns7e9L3ClHxnIBUCNHVuVxMny168=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr4523383ioa.277.1535544137758;
 Wed, 29 Aug 2018 05:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-18-robh@kernel.org>
In-Reply-To: <20180828015252.28511-18-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 14:02:04 +0200
Message-ID: <CACRpkdb0k15=8M4Q=KiH4VFWZKVyOg0NcSTxjmJApTnuTgFmfA@mail.gmail.com>
Subject: Re: [PATCH] gpio: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 3:53 AM Rob Herring <robh@kernel.org> wrote:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied.

Yours,
Linus Walleij
