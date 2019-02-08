Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B268C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A31D20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFd/Sccm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfBHNlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:41:17 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45752 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfBHNlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:41:17 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so2528759lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svZgzNemUQklRFY6TmqfVviG4WpWzMkRoAQ7E0zpyec=;
        b=pFd/SccmKp1MSwy91mBYxpElSVwDJbhwUoKSLGYt56YuKzcW2pZ556dO4W1rb0AnQ1
         tI+W/bf5o6lnW022KmGmvCPH+hXB9S6FPBBsxNa7eaHqNqXnYzfhK3cRQ4jRa24R6nLi
         F4XdESt68QH5u9lfdjoFarDoiR0KHC2Y6hjwUOq4W2vhPcXjNW5XgVDz/4ycPE7pVE6w
         Ke5DJDe4C5bTsWJxxJB6/sVm3hSpb0JFkqLG4twK6QI+cxvxUI9VQ/eNeOXthZqIk2yi
         R0FIMvwv2farHn4SWNKLnoesBITIBiHBncGpGx212krW7XrRNzcAeAmlaLZx+L5MaB6w
         uMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svZgzNemUQklRFY6TmqfVviG4WpWzMkRoAQ7E0zpyec=;
        b=XOxgzpkkUgjFjeSqnDz+AYmn3ChoVK54tt9JD7W255/L5NYVr3CdhhoswEtsuvHbiS
         XQRONyfWo+9Dmo9Wdi3jZKrpX2UgxGqBSkSIew5vOEF53nqjfV8iQX31TDa10vZqgaEk
         CI3CQSFBcZKh3d+yccGSyu0i9GWW/LJIdeFCabjdfffq5kOgpVz7Ij4HbX6obDAvwehi
         5UXfEkssGxmReVHPY7deveD/Zf43bbWfsmrS6yezanSFKqs6wV/JjE7M/yLkEl9NP+9P
         qeVX8JZUES43cIp0dWlGnalAXCpqexp53YkQp5PyX1A3Pj77rWmaMyRUny/9UToFvN2i
         7f6Q==
X-Gm-Message-State: AHQUAuZpv8HjSCYNzLs5XxlYKUqO1UA1ncJPChn0E6FkvOcyiaVhlruL
        xGF6NXAaPTb9hRxLZhIL9GtKYQzB/LXYWDZsMI4+VjRz
X-Google-Smtp-Source: AHgI3IY5KiIyDMByC8TsyQkRLAp95+w33f3lTRfK4jj/qF56+dSk4aE3cAvdodZ8prhZG4VBYlV2X5Vid+QBMrIVeEM=
X-Received: by 2002:a19:c502:: with SMTP id w2mr13222967lfe.168.1549633274948;
 Fri, 08 Feb 2019 05:41:14 -0800 (PST)
MIME-Version: 1.0
References: <c1638e5c06be365ad205e4717fd9f226cd1983a2.1549379326.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <c1638e5c06be365ad205e4717fd9f226cd1983a2.1549379326.git.nikolaus.voss@loewensteinmedical.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 14:41:03 +0100
Message-ID: <CACRpkdb0Dd_k-a_T94RcJwz89rN75+rGMA=p1yJ8_vwwZJjqQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers/gpio/gpio-adp5588.c: add device tree support
To:     Nikolaus Voss <nv@vosn.de>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 4:17 PM Nikolaus Voss <nv@vosn.de> wrote:

> Make platform data optional and add DT id table.
> Switch to dynamically mapped GPIOs and IRQs if not provided
> via platform data.
>
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

Patch applied with Michael's ACK.

Yours,
Linus Walleij
