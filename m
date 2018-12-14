Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F724C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EA620811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EA620811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbeLNKnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:43:06 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38031 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:43:05 -0500
Received: by mail-vs1-f68.google.com with SMTP id x64so3090748vsa.5;
        Fri, 14 Dec 2018 02:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQb/zWsvPSlE/9czvFyZiZR3y41v02pjZFX0ypWnaoc=;
        b=ONZWpG710qzxS9+mdmfr0rXCmHWg8556avIixng9NauTDGDaZoyzz2MUQbh7dQR4aj
         qqUXIyX5SkQZE9Lf73XjkV3s4j4Ldr9JldqCknFYGJBTyHoG2gIut8sxeWJ0QWhmHknT
         uVQnSuFLCPd1Ap2HCf71pYGKEpM6AssR5cQxlYVxpC/a3dzymH8WvTsecHvJ3SDR1DwA
         BX2mOKQb2j/tDccpkXea7TOcPH0fqSyJkLHhF5gqvs5G0IvMhrNfBPqjB7dJaQODwXxX
         BX3blShY2N5XN/mz4svnq/BA1Kap8UEoSb3z7LjnrBGL8S6CWCibdV3UYGBDz2Vvqnfr
         ILcw==
X-Gm-Message-State: AA+aEWYzmQe1pnimsIcVe9jjppMHaNWPl7vnn8S2N/DebikneJLwtYhv
        a5Edxln3bHwKcPrfn2+Tv1m2tiOwSF4eip+vo0M=
X-Google-Smtp-Source: AFSGD/UKUhTDvL0EcBnku7WYnZTw8mXQsue00cjMQYvs8OiG1zcgXmGRQAEuwELLGvCylsSqI0igOROVEsRGn3qz2Vo=
X-Received: by 2002:a67:3885:: with SMTP id n5mr887559vsi.96.1544784184577;
 Fri, 14 Dec 2018 02:43:04 -0800 (PST)
MIME-Version: 1.0
References: <1544732564-7185-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732564-7185-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:42:52 +0100
Message-ID: <CAMuHMdVnFVQZYvu_zz75=cNq=-g6sMPAiW1Ra7eCSJyXem8CKA@mail.gmail.com>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Hook up r8a774c0 DT matching code
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 9:22 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Support RZ/G2E (a.k.a. R8A774C0) IPMMU.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
