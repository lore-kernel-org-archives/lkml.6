Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB588C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00DA2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XA4140bC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00DA2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeLCJos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:44:48 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33544 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeLCJor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:44:47 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so7943476itk.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 01:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Oo32VVsYmPry9+f8DWOR0NGFz2f9fT3cn4yoPNUDcc=;
        b=XA4140bC2ZxcXC2xZ64Iosuza5gH5DtORINToSnfBNJaWMxYt+DAobBRiVkZNi+oPM
         Y/8NZfj6bbDOSPCGIklwiP6ssjlL55lvux56S9EudA1VIz/yd2sjnEZ6ocDGLHy6+icC
         WLe52JhpKZGdGImq2bmpfuLFr5eWHTy/z30Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Oo32VVsYmPry9+f8DWOR0NGFz2f9fT3cn4yoPNUDcc=;
        b=iyRm5qAqQxrGRGtj0g/jP2Jr0vb+8X3vr0XqLsMEHai88lLWpJn2Fz4Q6ojIVXUNW/
         GZ1lY8KXQq+/XSkl0s9nxdxeaV+EXq06CMZQy4vQ+hYQFFo5jV/Z8mtcP+vQklWSP4mY
         9A2FSFv7H9uAY4LFeThm6Wm9JR6+sTpHB/CvlE2b27EjPn32VMu16AC19Y1WajqlxDJO
         LJTX9wh4cAnoCr6zEP5TTyCIsEHlo5LyqCxewi1YFzUV8KJU4+vay8nERJg9NzXx32x7
         dVsTjAwaBUpt0Tf9AgZBKGa49XZi0hot4MJtI+iydRfCg6UEKNm5n3TQcx1BTJ9Csr0T
         1Mrg==
X-Gm-Message-State: AA+aEWZs0RwXp1/QAUAL6zOGGxp5ho/lBuiGh9ZJcTp4tULIqXCR9ufF
        7ci5Lrovr7iW1JHv70lkB/zSNVBOa3hoYtskyK3+Ow==
X-Google-Smtp-Source: AFSGD/VQJciOD7xP2xny6eLLvKTKU4UajB7IpGIr6GX9LxJ5o08UYNknI30r5ACp9rbcberi1/Nr8XIB+iKuo0mtfx0=
X-Received: by 2002:a24:5411:: with SMTP id t17mr6871416ita.32.1543830270402;
 Mon, 03 Dec 2018 01:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org> <20181130075849.16941-4-wens@csie.org>
In-Reply-To: <20181130075849.16941-4-wens@csie.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 3 Dec 2018 15:14:19 +0530
Message-ID: <CAMty3ZBFVStHNbYaBxT+Rmy6+g4jtm0cFKk8BL5BDid3c5VW-Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] ARM: dts: sunxi: h3/h5: Drop A31 fallback compatible
 for CSI controller
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> The CSI controller found on the H3 (and H5) is a reduced version of the
> one found on the A31. It only has 1 channel, instead of 4 channels for
> time-multiplexed BT.656. Since the H3 is a reduced version, it cannot
> "fallback" to a compatible that implements more features than it
> supports.
>
> Drop the A31 fallback compatible.
>
> Fixes: f89120b6f554 ("ARM: dts: sun8i: Add the H3/H5 CSI controller")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
