Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D3307C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842262089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JoD+em0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842262089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934902AbeFLBEr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 21:04:47 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33903 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934315AbeFLBEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 21:04:46 -0400
Received: by mail-io0-f169.google.com with SMTP id e15-v6so26148018iog.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 18:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s9CtnB5PTakKhR2oybOA6CcNCYSheVb5PT1xfdRRG0Y=;
        b=JoD+em0yFA5RtkiXeUh9cqqL7TXtP39a9nMf3r6lhAzn7754XQWs8MTZ8rSOr2oYhM
         yRn1VH8ARUOfzsGWYBMpxAS0dB+i2kUaAjaAbrE0i8NYE7sQ0u5MqepnjTL50g/M6wGF
         DDyW33fuEKAvJEgryNDtojaPHQU9fbHkWvA3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9CtnB5PTakKhR2oybOA6CcNCYSheVb5PT1xfdRRG0Y=;
        b=DG6X2k0dzVZNqL3APIvbeIHCNKnXDnPlDO63hlakvlp3530ZG/Gtdr0n4Ld8C92xP/
         VVV2pvAWJAw/Lx9hiV3UJ5Odq+w03CR9gKjDhpnYs5kNRJhmuHPlpCtxtHKnWPSKB8CT
         GH1eY8J6/gjDlqsYOJsXGJveX6zkjt210G03bW9M6yCQJE68w4XIvolrrXx0PHG+SF12
         UgeCZvuxfy+zcYIp+l/JcLdf0oYuc7YRUYWdaru1kyiQ9nyWuuHFgzs9FmappaoCXYi0
         dKsFSZ9SjbjkOVD9IKtWubHwGAaHdB7DgpvcTrSOkYZESNAlSB62JoIcFBtY3L4Td5J6
         Xeiw==
X-Gm-Message-State: APt69E03ycJe1MK9OcMRlRmnWhBoGFwUMrhppuhZdu4XtzcdE1EUIfSH
        L8A3xF9YTwAsTj5108XS4oq3R0QNXb/58RlGoC8=
X-Google-Smtp-Source: ADUXVKJQsHsIMD8rV8yJB2l5Srqe5eZ5jV/hFa7NsRSxgysNGaNvt+lH3prz12gF+NfN/ITJgsxkvxZR9KY1G2d7wq4=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr1435294iov.203.1528765485738;
 Mon, 11 Jun 2018 18:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180612000142.28883-1-olof@lixom.net> <20180612000142.28883-3-olof@lixom.net>
In-Reply-To: <20180612000142.28883-3-olof@lixom.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jun 2018 18:04:34 -0700
Message-ID: <CA+55aFy2sOHqcO-6LaKOZ5omyAow15gq+=Z7aOTZisrDihoecw@mail.gmail.com>
Subject: Re: [GIT PULL 2/4] ARM: Device-tree updates
To:     Olof Johansson <olof@lixom.net>
Cc:     ARM SoC <arm@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 5:02 PM Olof Johansson <olof@lixom.net> wrote:
>
> - Qualcomm:
> + SDM845, a.k.a Snapdragon 845, an 4+4-core Kryo 385/845
> (Cortex-A75/A55 derivative) SoC that's one of the current high-end
> mobile SoCs.
>
> It's great to see mainline support for it. So far, you
> can't do much with it, since a lot of peripherals are not yet in the
> DTs but driver support for USB, GPU and other pieces are starting to
> trickle in. This might end up being a well-supported SoC upstream if
> the momentum keeps up.

Isn't the Qualcomm 845 also the SoC in some of the new WARM laptops?

I asked one person that had an older one (ASUS NovaGo - Qualcomm 835),
and apparently you can actually disable secure boot on that thing and
boot from USB.

In other words, it might _actually_ act like a normal laptop.

I'd love to have something that is actually a real honest-to-goodness
ARM laptop finally. Are we getting at all close to that?

                    Linus
