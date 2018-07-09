Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98721C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E212620882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQ5oCW8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E212620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932828AbeGIM7b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:59:31 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54369 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbeGIM7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:59:30 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so25194662itb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 05:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2XAeNi2poCfAypHP+eZpaU0mY5IWDBJ8cyKUHYMqGI=;
        b=aQ5oCW8hcPkY/PpfY1yxneJo3Xo1VPKGSHh1ttSpoSCbL/Cd4foDoyLhGcWXHLv0KO
         RUBa2eFEzu+k5DBQLabFLOIhHGAeaJGYKQ2RcvKJyojwgIDTTkrPsT8YzsPFxVQu8ID+
         U+74U6jOJ6ya9sF4BQ9k0vdHXt2s3TaotzghY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2XAeNi2poCfAypHP+eZpaU0mY5IWDBJ8cyKUHYMqGI=;
        b=fRm/mgLv9fvKNtBsKJDwKgohdP4W2e2Q0PcSG+RRMPfvxuYnk4v1+pE0N8hmCPxZbU
         RYJF2491h1ct7B/c7rplFivgiLyRPQjRKCyuZmx5qeUB95a+VzW+NR/nKchPngznY+3r
         GzqXu5YyrYNIyeEMfth66YH1lfGbjhZWU2UFUaM0Jtx1Zfcgk7CvYjgjl2PMCr1LzFa3
         a8Mr5DbINjN10odQEgSBrm/rDR02p3hWWRNr5MwA7w7jlwTurRffnMu2rzVfOGuUpfyW
         GjSn/4oHBA8lapU+Nuylu1lghK9hO0aj1WYJ92DV8kNqqbBOVHUrlGa9Oxn84NGbjWZn
         RkGA==
X-Gm-Message-State: APt69E2zeW7pNQPtWOH8lV3CMbZ2sku9JTfFwnCyUqukCHOLfyDMeXRj
        nKftCvwZZv9/j7l13J6R5IQJjn/UgH8jZRRBpHlseA==
X-Google-Smtp-Source: AAOMgpcN1UYLhrDke/B1q1+YtpSNR5xkLzcC65vyOrZpIKY16nENZ0JgVetTeG7GhXRv19JyUeoE4S0wygpplqp8V7k=
X-Received: by 2002:a02:c007:: with SMTP id y7-v6mr17148594jai.87.1531141169786;
 Mon, 09 Jul 2018 05:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180705091018.60524-1-tony@atomide.com>
In-Reply-To: <20180705091018.60524-1-tony@atomide.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 14:59:17 +0200
Message-ID: <CACRpkdYKTKe7c79XDtGf79sOjzDuqEWSJN1KrG2POuemP+TL+g@mail.gmail.com>
Subject: Re: [PATCHv3 0/5] pinctrl fixes for generic functions and groups
To:     ext Tony Lindgren <tony@atomide.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        cvwillegen@gmail.com,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 11:10 AM Tony Lindgren <tony@atomide.com> wrote:

> Here is a resend of fixes for a race issues for generic group and
> functions reported by H. Nikolaus Schaller <hns@goldelico.com>.

I applied these 5 for fixes (no choice I guess) will push them to the
zeroday build for testing and then to next. Added the tags from H.
Nikolaus and Andy on this.

Should this stuff even be tagged for stable? Else I target it
for v4.18.

Yours,
Linus Walleij
