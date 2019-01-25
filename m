Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130C7C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63DE218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3As3Hav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfAYRmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:42:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37996 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfAYRmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:42:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so11180181wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 09:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KB5hRAPY3O95oNsGa06XKA/vJaO61M8l8JOqzf1yAfU=;
        b=G3As3HaviClRz2UHJzmUlc3x05U/S7U4uvea3knWdyPLzs8wk+IStcTO2YtucFwFd/
         cg/twdjSKDm46qBnXy42yKNq30haVO5PvoEp9dGGzzxQVhMcSfeI+bCOYsDcGuWlH6H7
         H4PS4QxMMv6b8xVjgDPHCu5gO9El9Rnw5wGwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KB5hRAPY3O95oNsGa06XKA/vJaO61M8l8JOqzf1yAfU=;
        b=HHV8bj+pP1jB2g6+Q+tYg2uT1ZUiaK1AaKY4VmWXVh7kTS5Vol9ndgwbEmX3eWgfpz
         WtR1t8UPogEX6vE9+w+1DmC+4zoESlZ8aUA6i79Pu6ApT7s5tMS4Tu4/UgXQ24ykMrng
         9JN4U4irk4pELKHdNurgPLVjM3U5ke25gIv0cg/2aWqKLYf3otZUczqdkc965vF3D3vK
         xzCQMl+evKWnXuDekWYDAF8yPrLyc4TuKBtqHFr9xjDYix4zguYd3VhmWyEwuB8QCPjE
         6VSQqFIquCyD/JV3xjh/fhJ7dn4ckZLTWGw5auNaX9BfDGvEUf+OzzYPMVXlQ3g8g4Sp
         JqJA==
X-Gm-Message-State: AJcUukcCTi2KSaLBlnbQw/ufn0aItuLvd+fmoQfP4vJGCOE/NuGDgb4O
        Fc3iy51FUePksRPisa0UxjswzglJOyRJhBC4JHqLzg==
X-Google-Smtp-Source: ALg8bN6Z2dlCm2gFbOWA8Rz+eqROIb4vmS+NSKlqmwCbSqG4hM6TmiSXL/fZ0qgxxQb9Suc4RuDtpc886aQTGwQFrd8=
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr12045757wrs.75.1548438120630;
 Fri, 25 Jan 2019 09:42:00 -0800 (PST)
MIME-Version: 1.0
References: <1548273966-5889-1-git-send-email-john.stultz@linaro.org> <107a6e2e-ddd8-cbc1-5680-1b5899665327@arm.com>
In-Reply-To: <107a6e2e-ddd8-cbc1-5680-1b5899665327@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 25 Jan 2019 09:41:48 -0800
Message-ID: <CALAqxLW9B6zZi=iQK02QEcAq=xzBiZ-xO-18t2izsKgJstzfmQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Ryan Grachek <ryan@edited.us>,
        Alistair Strachan <astrachan@google.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        "stable #4 . 17+" <stable@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 3:18 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi John,
>
> On 23/01/2019 20:06, John Stultz wrote:
> > From: Alistair Strachan <astrachan@google.com>
> >
> > This reverts commit abd7d0972a192ee653efc7b151a6af69db58f2bb. This
> > change was already partially reverted by John Stultz in commit
> > 9c6d26df1fae ("arm64: dts: hikey: Fix eMMC corruption regression").
> >
> > This change appears to cause controller resets and block read failures
> > which prevents successful booting on some hikey boards.
>
> FWIW, you might want to have a play with the pinctrl settings - I've
> seen various flakiness with HS200 eMMCs on Rockchip boards which could
> be solved by bumping up the drive strength.
>

Hm. Thanks for the tip. I'll have to dig around to see if that can
help. In the meantime though, I think the revert is the right
solution, as this is currently blocking some boards from booting
mainline.  We can then look to re-enable HS200 mode if we can sort out
the issues we saw with boards using hynix mmc chips.

thanks
-john
