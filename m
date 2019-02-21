Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCF8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3312086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir3kaq5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfBUBJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:09:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34854 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBUBJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:09:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id p19so1984838plo.2;
        Wed, 20 Feb 2019 17:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XazLWlV0OGpxiqeWsTijGEnFhzyXIMqtdbgnm6gIsFM=;
        b=Ir3kaq5OJ38gwHc9MbQ93aEeS78o9Jb4ne68ygRM17PEd63kJOo+HfHEWvo2v6rFiJ
         KNYERTWt52IYRarCIpcC1mVk1oyBJSudCfe/mrer7nGIXxOQfMaIBZgPLS5E0qfkrTuR
         Ufcc+iHE+jP6nCO9LsKxSD5q7SBg9FiHsm2wuwXwH1rl5CqFTnOIsTsRYhJM99KY7ViM
         RDtd512mwClfGkHF+cFrWtS4roAOGZlMoAUDdXJCtPTQKqqgDUvg55Iz6UpGom9V5/tM
         rYjA6mpl3jFJNGylRInO0RX6Q8KhsMw2lnhEeJib7zATI8G10gN3XcdVfuDdZ2ooSgqO
         Krag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XazLWlV0OGpxiqeWsTijGEnFhzyXIMqtdbgnm6gIsFM=;
        b=tQD+ULYz3cCSfjmpAWczOy06LwI645/UfJoHcL8Z3wmFPfCRn9wTNR+7d/aqvpVY8Z
         VOtoy+DS1U9IfoBh0LdBfDNKOvcRfz31HXaHOGXocNFqfckbf7V5YtBoqMRQkCACwBwz
         q4xMoaE2RMjc14AlobwUVWCsdDk9WG+MeOkUg+QKtd9KttqT6/OKc37ZqZn8X3MvsN6w
         sT/fevD+Vi6dLpHk/IrD5wY2GSvp+eCq/goYKDaS9/f5u7AaqA+k6VE1/2AHpYSMuyFs
         DMdOchW5j1CZqG0LaBorNaUQqnLhDkcz4QGx8b1trpVOXiWXxkvXLwpHujkumYN5cxzV
         51Xg==
X-Gm-Message-State: AHQUAuYZsRn4/OPB4riM8r26HObgyIC7ZRHoyVBB/EX+Qhutk+qs8T10
        4hhpSSrfAEfNaE3cOkf8APk=
X-Google-Smtp-Source: AHgI3IZYhlTQw7CzP9sWgh7rfxqpLNlgl3p6nVnERXteNg31B4yHe6oKSgrg84EyP7emiFpwT7JXKQ==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr39384222plp.118.1550711366749;
        Wed, 20 Feb 2019 17:09:26 -0800 (PST)
Received: from icarus ([2001:268:c0a3:577d:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id d23sm26808746pfn.180.2019.02.20.17.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 17:09:25 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:09:54 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/8] iio/counter: add FlexTimer Module Quadrature decoder
 counter driver
Message-ID: <20190221010931.GA3471@icarus>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-5-patrick.havelange@essensium.com>
 <20190220164154.00547a77@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220164154.00547a77@archlinux>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 04:41:54PM +0000, Jonathan Cameron wrote:
> On Mon, 18 Feb 2019 15:03:18 +0100
> Patrick Havelange <patrick.havelange@essensium.com> wrote:
> 
> > This driver exposes the counter for the quadrature decoder of the
> > FlexTimer Module, present in the LS1021A soc.
> > 
> > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> Given you cc'd William, I'm guessing you know about the counter
> subsystem effort.  I would really rather not take any drivers
> into IIO if we have any hope of getting that upstreamed soon
> (which I personally think we do and should!).  The reason is
> we end up having to maintain old ABI just because someone might be using
> it and it makes the drivers very messy.
> 
> I'll review as is though as may be there are some elements that will
> cross over.
> 
> Comments inline.  William: Looks like a straight forward conversion if
> it makes sense to get this lined up as part of your initial submission?
> You have quite a few drivers so I wouldn't have said it needs to be there
> at the start, but good to have it soon after.
> 
> Jonathan

I agree, we should try to merge this as part of Counter subsystem
introduction rather than as another IIO Counter driver. As we determined
when adding support for the STM32 timers, the existing IIO Counter API
is fundamentally unsuitable for representing counter devices. So
regardless of how a new Counter API is merged, the existing IIO Counter
API must be deprecated.

Patrick, I apologize for the confusion this has caused. Would you be
able to convert this driver to use the proposed Counter subsystem API
from this patchset that I believe you encountered before:
https://marc.info/?l=linux-arm-kernel&m=153229982404051

Although it was last updated in October, I believe you should be able to
rebase that Counter subsystem introduction patchset cleanly on top of
the IIO tree (if there are any merge conflicts send me an email). Take a
look at the generic-counter.rst file under the Documentation/driver-api/
directory for an overview of the API; the counter drivers under the
drivers/counter/ directory also make good references.

If you have any difficulties understanding the API, or any other
troubles, don't hesitate to ask. Hopefully, I've made the documentation
clear enough to make the conversion of this driver quick and easy -- and
if not, then it's something I need to fix, so let me know. :-)

William Breathitt Gray
