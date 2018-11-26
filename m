Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3D0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF24020865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="yc7LjynO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF24020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeK0Aa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:30:28 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41011 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeK0Aa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:30:26 -0500
Received: by mail-ot1-f50.google.com with SMTP id u16so16548648otk.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 05:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:references:in-reply-to:date:message-id:subject:to
         :cc;
        bh=zHLNl/ll49Oot9MZZct25czzcfmqR08RrvsLo2mzHkg=;
        b=yc7LjynO3uwJUHAwB8JJB6EZYIt000t0/t143fLdn+Fml4HqU6lya/0m4/My01DIMb
         4IcPWnQLpe2rb+yFkgsgita6TVNcFPuDWBwXLxXiX8gDZrkTlABo9eXai1xauQRr8yBY
         52APVWsVfWVKQvjf75zCX23PKZl9t5aC/k2hbVypFkTkxbDqiyZnxZP7fKGY+yVOdRb9
         pLTzrR+TJ+rGu/Ln2NMWVYXwbhnH5BiQQbKM1K5Ilht0FcL8zBtJUr+FUrTSBFqtkfXO
         wIzx8UqkWITDJC1k3q/z0HHYevcd4sYk06nIbSrDQOlSuMTAY+q3RLDbrlhz856Wm+3W
         fM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:references:in-reply-to:date
         :message-id:subject:to:cc;
        bh=zHLNl/ll49Oot9MZZct25czzcfmqR08RrvsLo2mzHkg=;
        b=Q62l07tX3Qr4froCO4I0n64qXz8tl1ZcdS5EkpOTkEGGoX31dVQTU5Z0/InDaNJOFF
         qqALiPdAKZfCe3V4vvLQ0W8BCC84zgzi1YZPnrFzu9Fsh2sJevOQtm9zkpzTxQ++QewX
         0OCF8ypgnL1ppGTolH2eovm1b1wy3VA3LoOYl9IU3daGywo5m6aCSpoBwZjjTJrCyGNC
         FK2AYaN9tvh/hJ6h5y9814h1vl8eVy4dnZmSr1B0bDgWz2evCaXr17nFLpVmz+NjtiO/
         dTzAJ3wKlOGa6mvPRKLPM/c9atm3eM2om5pk6/zNKGBa11/GdKjRCMw2bnw6GmM0ouIm
         IBWw==
X-Gm-Message-State: AA+aEWa/+VgzEv3kxh8KLfLAln1ZmCDUs8jrMM4i0VyXdKbXws8idGmB
        45oK1ZQXeasnX5PoYhfbrVm04w==
X-Google-Smtp-Source: AFSGD/VvDGtzH3zu1vB7L4dqinPZbgHEssG6k8QGUacknaL5TF2NK1QLJ5GS7scOy6mdBobKpAKP6A==
X-Received: by 2002:a9d:886:: with SMTP id 6mr16574865otf.256.1543239376103;
        Mon, 26 Nov 2018 05:36:16 -0800 (PST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id p203sm86279oic.49.2018.11.26.05.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 05:36:15 -0800 (PST)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-ot1-f52.google.com with SMTP id w25so16518703otm.13;
        Mon, 26 Nov 2018 05:36:14 -0800 (PST)
X-Received: by 2002:a9d:5325:: with SMTP id g37mr16168013oth.253.1543239374185;
 Mon, 26 Nov 2018 05:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20181125211907.9895-1-otavio@ossystems.com.br>
 <20181125211907.9895-8-otavio@ossystems.com.br> <3361921.c4PKPBIJKP@phil>
In-Reply-To: <3361921.c4PKPBIJKP@phil>
Date:   Mon, 26 Nov 2018 11:36:01 -0200
X-Gmail-Original-Message-ID: <CAP9ODKrX__KXo-XEdoaL=qwALFAxyzKV4-xu_t5baMqN1kQH4g@mail.gmail.com>
Message-ID: <CAP9ODKrX__KXo-XEdoaL=qwALFAxyzKV4-xu_t5baMqN1kQH4g@mail.gmail.com>
Subject: Re: [PATCH 08/13] ARM: dts: rv1108: Fix the PMU interrupt number
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Fabio Berton <fabio.berton@ossystems.com.br>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

On Mon, Nov 26, 2018 at 3:59 AM Heiko Stuebner <heiko@sntech.de> wrote:
> Am Sonntag, 25. November 2018, 22:19:02 CET schrieb Otavio Salvador:
> > According to the Rockchip vendor tree the PMU interrupt number is
> > 76, so fix it accordingly.
> >
> > Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> > Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
>
> looks ok, especially as the TRM I have doesn't list neither irqs :-)
> But please explain the second Signed-off by Fabio?
>
> If Fabio is the original author, the patch From should reflect that
> and the Signed-off-by lines should be swapped. As it is now
> I would expect Fabio being the one sending the patches.
> Or is it supposed to be a "Co-developed-by:"?
> See Documentation/process/5.Posting.rst.

He works with me and he applied and tested it in our internal tree for
our customer. He reviewed and tested this with me, so I'd like to
provide him credit as well.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
