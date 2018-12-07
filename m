Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1C1C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9052020989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSLpxFfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9052020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeLGMa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:30:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35785 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeLGMa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:30:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so3420618ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/os7eFrdjZAa8Lq9Ha1NGHegsNC2tJAUi1QBzjgVMQ=;
        b=SSLpxFfyZYwuHYHP7p2Ut2Ty0LIsEi2IOaquypyrl11wWADZI5DTskb1yEnwosmu3F
         QbuaZcnzjsIZ48O/a+3qY3rmAlHrYo/SAVokD6v2CHjIgYsM5viEGzMT/kF1oUCHWnuE
         t8/5HrEp5FGlYzCHYbj+ff8E+Rejt00fJHjvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/os7eFrdjZAa8Lq9Ha1NGHegsNC2tJAUi1QBzjgVMQ=;
        b=Uv7KWlHpslwieG15Li0+9AY18hL4hyc0KsUXVs3uEsiO3ekv3LRQX6wYeiKs2onOfl
         VHp8bohlRtLcU7g1yInDmldH5IlzUPLH3iDBwag1GkpSxd6r6qZJ6IWixI/kkbt6OWiM
         RhAk8e+gX+2RXsLimtEhZKovfZUIc+BqmE146HUOYpU3QAPjkPcV/rIM3mXKn5gJOoqF
         1pCFJlNzmr41rNFQxaXFqi0yrfXmYe39TuTpm7xt2X+zoz7a84VbglY1pPDKNSXFc+eN
         lJOJNmEeAUdU0O4nhBz+tI21ifAmO+5WV4r98VLCKNUbyV3Gf8wJl/piU0JhSLVkY5ll
         Lx8g==
X-Gm-Message-State: AA+aEWYvW1HCXKPnZ7tsx3chZY6Dh7bEVKkdkQgKSZGxCFODQVSGwpDX
        7iiYzRo8Q0G4zqM2z5Gy6aHuSJSXyVJRMId4w4gCQQ==
X-Google-Smtp-Source: AFSGD/WIGfniGElDiivYNO8T1H7qXLY6BOgDe33KqinRMAlSPWQOurZ6BCja9DW032eHL0yw8rctBq1I6VWBugDcKZY=
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr1090584ljj.120.1544185826433;
 Fri, 07 Dec 2018 04:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20181203154100.4280-1-wens@csie.org>
In-Reply-To: <20181203154100.4280-1-wens@csie.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 13:30:14 +0100
Message-ID: <CACRpkdYbdDfN93oXEkSmoFAEdrQwzk7mTCreOgem6RTJPWVj5A@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: sunxi: a64: Drop numeral from csi0/ts0
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        jagan@amarulasolutions.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 4:41 PM Chen-Yu Tsai <wens@csie.org> wrote:

> This small series renames the csi0 and ts0 pin function names to csi and
> ts. This makes the names match the datasheet. As there are only one of
> each type of controller, having a numeral suffix doesn't make sense.
>
> I'd like to do the rename now while we don't have users nor support for
> these two controllers. I planned to send this together with CSI support
> for the A64, but Jagan beat me to it, so here it is.

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
