Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD9CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40882086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xnicgEf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40882086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeIZBsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbeIZBsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:48:46 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 004982086E;
        Tue, 25 Sep 2018 19:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537904380;
        bh=gCPKOYRlWMbEHI0LiMO6QmLim6qfo6LLGuxYRRolJe0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xnicgEf2MUhRyBsOFg3njXneF5xXxMGnMpxRbQPZovkNyRx5dvrP+lXexJyVBmXCK
         kfCVJvpnZimzM1mb5q+K0ifybMBTvZl913hIptvY5NRb6JGYjv5/enCcZep3zsZzDh
         lsTegfszdNNO0C43LFkf9qQH4zwkmCGxkjTXqyKg=
Received: by mail-qt1-f180.google.com with SMTP id x23-v6so14747649qtr.1;
        Tue, 25 Sep 2018 12:39:39 -0700 (PDT)
X-Gm-Message-State: ABuFfojo9qIMm7rvaPIkNORk6qLcXcjUapzwjgIn0drDJv09VXyH5efr
        3PtF06SumB8XYGe1Pxzb4kfWYaeiUuUBIv2JEg==
X-Google-Smtp-Source: ACcGV60XtltzYhoeeBquO/MuAhTFolgz8JAECWY6O7AMrEh/fEPmHEEzmwuHOSlxSz2Mon+0ZX15pz2EAkl79vPyAeg=
X-Received: by 2002:ac8:190e:: with SMTP id t14-v6mr1982814qtj.327.1537904379248;
 Tue, 25 Sep 2018 12:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180911170825.17789-1-dmurphy@ti.com> <20180911170825.17789-4-dmurphy@ti.com>
 <20180924161844.GA29028@bogus> <20180924180219.GA24418@amd>
In-Reply-To: <20180924180219.GA24418@amd>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Sep 2018 14:39:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLsKtzvnkfwy4H7QQyRqwEEmSp_qi_28=QoLJqs0w2NNw@mail.gmail.com>
Message-ID: <CAL_JsqLsKtzvnkfwy4H7QQyRqwEEmSp_qi_28=QoLJqs0w2NNw@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] dt-bindings: leds: Add bindings for lm3697 driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 1:02 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > Add the device tree bindings for the lm3697
> > > LED driver for backlighting and display.
> > >
> > > Signed-off-by: Dan Murphy <dmurphy@ti.com>
>
> > >  .../devicetree/bindings/leds/leds-lm3697.txt  | 86 +++++++++++++++++++
> > >  1 file changed, 86 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> We already have binding for lm3697 in
> Documentation/devicetree/bindings/mfd/ti-lmu.txt . Is it good idea to
> have second one?

Of course not. Now that you mention it, I do remember seeing some
discussion on this.

Rob
