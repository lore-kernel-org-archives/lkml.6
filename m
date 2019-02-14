Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA56C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FCF222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550154262;
	bh=ZviCB4UK+yPmuMDh7PuGrRRgjNrg+f4+Z5wYwmTpiVU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=petr4qgypUAfAo91XDpC0SWxU2FgO8vOEa1rUW7WBwWDgL8KN/GKuT75t8a53E61S
	 LnyDmKUAynNv8q0lwjjO9MM5yNAAwAJ+l/jb/YVwaq2+3W8WobF+JfLWnxnsqQ3kWw
	 0h+iDaT2IJEqNkw0WugP3uft4ilwNKcI7RT2U14k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439193AbfBNOYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:24:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732882AbfBNOYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:24:20 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DFA3222D9;
        Thu, 14 Feb 2019 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550154259;
        bh=ZviCB4UK+yPmuMDh7PuGrRRgjNrg+f4+Z5wYwmTpiVU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vDtFvFc83qDStPyHEZLUlwUrpwWXv74xEIrNY/2b3RNdd2MhFRWIdFWRFtahgoUFc
         i3L0Ezh0zr18lZflRFlepGVeddLxITeJVwKNL0IHH+XswCSQG8vNQnJhxTnxbyUzX9
         pH0HivZPJZ4QmNa/jhgJP2KbHnD14XeC5nOXKn0c=
Received: by mail-qt1-f171.google.com with SMTP id z39so7047743qtz.0;
        Thu, 14 Feb 2019 06:24:19 -0800 (PST)
X-Gm-Message-State: AHQUAuaFRHFBW0hUQv+dUs+bLMTL3Zo9Ge8xBDzj60PxQyqknZ0vyE2e
        MHcfmrmLkXI68LwBB7/ZKkHlN7dA8HU5qMnl3w==
X-Google-Smtp-Source: AHgI3IaAqyV0Bi9f8MwikDZm6bMdc94+avjRW4HSg1PgsYazr6lpxXVkrHs76nh+5S5uNjuJQGCucf7rkxY5jC/iQnc=
X-Received: by 2002:ac8:4548:: with SMTP id z8mr3116552qtn.257.1550154258491;
 Thu, 14 Feb 2019 06:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-6-robh@kernel.org> <CGME20190213161024epcas3p3acc5c074714ad1d44fb90ab3f21cfcff@epcas3p3.samsung.com>
 <CAL_Jsq+xpRPvj=UcSo+jQKX1pB=9B3SV9jB5ZVhaVsKvOqtoOg@mail.gmail.com> <5cc4b5a3-c4ad-46a9-2856-3ed67c6755d3@samsung.com>
In-Reply-To: <5cc4b5a3-c4ad-46a9-2856-3ed67c6755d3@samsung.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Feb 2019 08:24:07 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+hoRE5UG3+Z9OKDc3xmkJbGgQpUF+M4pzXJ_BSjj0kfg@mail.gmail.com>
Message-ID: <CAL_Jsq+hoRE5UG3+Z9OKDc3xmkJbGgQpUF+M4pzXJ_BSjj0kfg@mail.gmail.com>
Subject: Re: [PATCH] devfreq: Use of_node_name_eq for node name comparisons
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 9:49 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Hi Rob,
>
> On 19. 2. 14. =EC=98=A4=EC=A0=84 1:09, Rob Herring wrote:
> > On Wed, Dec 5, 2018 at 1:50 PM Rob Herring <robh@kernel.org> wrote:
> >>
> >> Convert string compares of DT node names to use of_node_name_eq helper
> >> instead. This removes direct access to the node name pointer.
> >>
> >> For instances using of_node_cmp, this has the side effect of now using
> >> case sensitive comparisons. This should not matter for any FDT based
> >> system which all of these are.
> >>
> >> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> >> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> >> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> >> Cc: Kukjin Kim <kgene@kernel.org>
> >> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> >> Cc: linux-pm@vger.kernel.org
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-samsung-soc@vger.kernel.org
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> ---
> >>  drivers/devfreq/devfreq-event.c     | 2 +-
> >>  drivers/devfreq/event/exynos-ppmu.c | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > Can someone apply this please.
>
> Myungjoo picked up this patch[1] on devfreq.git
> but has not yet sent the pull request.

Okay, thanks.

Please add that tree to linux-next or reply to patches when they've
been applied, so submitters have some way to know when their patch is
accepted.

Rob
