Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CA4C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C787C214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C787C214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbeIXXT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:19:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39896 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbeIXXT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:19:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id h4-v6so16952180edi.6;
        Mon, 24 Sep 2018 10:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0TCM4fj++RVfFT7IlYxrShViZLYqOAcAyNiekx0Uhsk=;
        b=MdfoA2IatBsmu4rN0ivQTunGflUNerDXx/K0GDudFVYWwktqaGHK2DjgYWj8eXkz5r
         +ee8pU1fw64ZGYWZnlz3yyJZWsrEfU9yoc2f6WKXcUKzs+n8WRIxOrCghEeNrOARIq6H
         tuwtIahuDha0tq636eF0O8cLgyE+/HTaiCLhlrvs0Vvahi6q6rpOoXXYTsfmAsiILmtt
         iD3vC/DuHmQVtaswydH97hzvjBPovE2CQA+s7uauG1TdGAcXtL6vw+hqe9yyoa4ZaLcG
         4gWhWFWAVZgTB3Rw7///YlbjO4wq5heM5+I7dcc3meRchaEP1OtddpZrOZrghP8cRe3Q
         X8BQ==
X-Gm-Message-State: ABuFfohQ1Lvr7a9ydHVVC8oWN69ENizkZTIBpwXwxaSt8sJf6zuIJKKE
        JHgFvAvzSVwiuIbF2ntErbY=
X-Google-Smtp-Source: ANB0VdavR/vFfzTxfuRXEMJZmFUg+rNEL3b8hqCaY/815x9ZhiplFnQOTTsRis7EZWSnmLFL4bUmoA==
X-Received: by 2002:aa7:cb41:: with SMTP id w1-v6mr18694652edt.202.1537809407863;
        Mon, 24 Sep 2018 10:16:47 -0700 (PDT)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id y15-v6sm937202edq.20.2018.09.24.10.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:16:47 -0700 (PDT)
Date:   Mon, 24 Sep 2018 19:16:45 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] dt-bindings: arm: Explicitly mark Samsung Exynos SoC
 as unstable
Message-ID: <20180924171645.GA10910@kozik-lap>
References: <20180830180205.18121-1-krzk@kernel.org>
 <CAOesGMgE6QaasvHi7E55Z4U1Pp0+8QYW2eRLMsExebZ999_UHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOesGMgE6QaasvHi7E55Z4U1Pp0+8QYW2eRLMsExebZ999_UHA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 02:46:20PM +0100, Olof Johansson wrote:
> On Thu, Aug 30, 2018 at 7:02 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Samsung Exynos SoCs and boards related bindings evolved since the initial
> > introduction, but initially the bindings were minimal and a bit incomplete
> > (they never described all the hardware modules available in the SoCs).
> > Since then some significant (not fully compatible) changes have been
> > already committed a few times (like gpio replaced by pinctrl, display ddc,
> > mfc reserved memory, some core clocks added to various hardware modules,
> > added more required nodes).
> >
> > On the other side there are no boards which have device tree embedded in
> > the bootloader. Device tree blob is always compiled from the kernel tree
> > and updated together with the kernel image.
> >
> > Thus to avoid further adding a bunch of workarounds for old/missing
> > bindings, make development of new platforms easier and allow to make
> > cleanup of the existing code and device tree files, lets mark some
> > Samsung Exynos SoC platform bindings as unstable. This means that
> > bindings can may change at any time and users should use the dtb file
> > compiled from the same kernel source tree as the kernel image.
> 
> I have to admit that I don't really like this approach, and I missed
> the patch when originally posted (I did notice it in the pull request
> it came in with though).
> 
> The main concern for me is that with a blanket "everything is always
> unstable" we discard the notion that we should strive for bindings to
> be stable and backwards compatible.

The original idea from Marek was to mark everything unstable. After
comments from Rob I made it weaker already by changing to specific group
of compatibles. Accepting their instability does not mean that we will
be doing this on whenever possible. It just opens the possibility of
finding some balance in cleanups and development. Sometimes things have
to be seriously changed (fixed) and implementing workarounds for
existing ABI might be huge work by itself.

IOW, we want stability but not with the costs of huge development
efforts... because no one else except us cares about the stability.

> 
> Questions that come to mind are:
> 
>  - When do they stop being unstable?

They became unstable in a subjective way so I assume that reverse is the
same, based on consensus and discussions.

I am not sure if a hard time limit is good. There is no timeline for the
Exynos development, no public roadmaps but rather community and
partially volountary effort.  Therefore whatever number we set, it might
be totally not matching reality.

>  - Is there a way to note in the binding itself that it's still
> unstable with an anticipation of when it will be settled in?

Hmm, I see that some existing bindings are being added with "Unstable"
warning:

	git grep -i unstable Documentation/devicetree/

so there should be no problem for putting there a timeframe.

>  - Is there a better way to version the bindings to avoid complete
> backwards compatibility?

Some architectures are using overlays for handling backward
compatibility. Anyway it might put additional effort on driver
development.

> Pointing out a couple of cases where it has been painful to stay
> backwards compatible could also be useful for understanding (even
> though you run the risk of each case being explained away with
> suggestions of how it can be handled).
> 


Best regards,
Krzysztof

