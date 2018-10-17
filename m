Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE219ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA272148D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPGsuXH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA272148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeJQO6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbeJQO6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:58:53 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 202DA21527;
        Wed, 17 Oct 2018 07:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539759879;
        bh=G1mvetJk5seD6XN4CuaVcBYqeHgmBF6th/f6EdxofuI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TPGsuXH7DYMCHpbH82Dq0mrtt+y4d2qeChfPCEZR65JRfYfdUoj4e/HRhmXQFdO2G
         QW7nz8VuvRdizyVF9+trgwJ9jhxN6vCwFyUfAywjBcGCWT0ofNsg0I/+wkXnV7yyhX
         q7h2I5CYAkxSkxY58ONOvhBZt21VAkwM/LGXj8+c=
Received: by mail-lf1-f47.google.com with SMTP id v22-v6so7138384lfe.12;
        Wed, 17 Oct 2018 00:04:39 -0700 (PDT)
X-Gm-Message-State: ABuFfoj/ReupRSMlnKj2O/nOmNGK+4Jc3PDQtWhcVmhItGW0wt8ACjre
        XLT38LnJIU6oEKaHAHgf1NFq6Lf+4jP2kX+Vq58=
X-Google-Smtp-Source: ACcGV63LiaQGuOEaRavwhyjTBL8Z27M7f0/oFBwucGrXG2kA9NBCEsM5xW4GCW/PN1e+zXdwjqXt2u2xYpVdUXbLBcc=
X-Received: by 2002:a19:288c:: with SMTP id o134-v6mr15944816lfo.124.1539759877149;
 Wed, 17 Oct 2018 00:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181016145647eucas1p206c068806214535da339588d77cbdfa5@eucas1p2.samsung.com>
 <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
 <20181016145647eucas1p206c068806214535da339588d77cbdfa5~eHqLYh2dR2135021350eucas1p2K@eucas1p2.samsung.com>
 <CAJKOXPe4Jf3QVbQ6BFPFptkgvmmpNu+QCmDoD3JqhyYOidJ7vA@mail.gmail.com> <20181016154833eucas1p2b2e7cbb90df83737e655bb8a343c4eab~eIXYh7z9r2960029600eucas1p2p@eucas1p2.samsung.com>
In-Reply-To: <20181016154833eucas1p2b2e7cbb90df83737e655bb8a343c4eab~eIXYh7z9r2960029600eucas1p2p@eucas1p2.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 17 Oct 2018 09:04:26 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdfkdAAoEj=J4T4yxC2EL8rcu88P2Yg2OkUCq89CW3Qiw@mail.gmail.com>
Message-ID: <CAJKOXPdfkdAAoEj=J4T4yxC2EL8rcu88P2Yg2OkUCq89CW3Qiw@mail.gmail.com>
Subject: Re: [PATCH 06/11] DT: arm64: exynos: add support for thermal trip irq-mode
To:     l.luba@partner.samsung.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 at 17:48, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi Krzysztof,
>
> On 10/16/2018 05:09 PM, Krzysztof Kozlowski wrote:
> > On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> >>
> >
> > Hi Lukasz,
> >
> > Thanks for patches.
> >
> > I did not receive the first patches in the series. It is okay (depends
> > on the context) but in such case sending cover letter to all people is
> > quite useful. It helps to understand the entire patchset. Since I did
> > not get them, I really do not know:
> > 1. Whether DTS patches are independent?
> > 2. How this fits in the big picture of Exynos thermal?
> I have lost your email for my 'cc' command line, my apologies.
> I will add you in v2.
> Here you can find the cover letter:
> https://marc.info/?l=linux-pm&m=153970180314648&w=2
> regarding
> 1. they are independent
> 2. It will be less confusing and more coherent with documentation
> when we use 'passive' for DVFS cooling. Unfortunately, when 'passive'
> is set, it registers our trip points for polling and thermal schedules
> the work. I had conversation with Daniel regarding this setup,
> please check these email:
> https://marc.info/?l=linux-kernel&m=153924620318766&w=2
> and my response:
> https://marc.info/?l=linux-kernel&m=153933708316168&w=2

I see it on the linux-pm, I'll reply there.

Best regards,
Krzysztof
