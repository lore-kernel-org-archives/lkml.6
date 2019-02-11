Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63016C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC6F2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey8lmbJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfBKIV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:21:26 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:45067 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKIVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:21:25 -0500
Received: by mail-pg1-f177.google.com with SMTP id y4so4619970pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3LVTa2lFqZkXo4/ZgV4Wm39FYCcu0nNpMiRyih6YLI4=;
        b=Ey8lmbJIAb5p78KdE4vQN7FCAq9rWmA2i3clrI0mcb0/ocfvHCmhqw/3p3OZDr5/ca
         5jiDtmIw2rnq19U6cbrqBEJIFVPc87GMeheGYlhFubRdNGkI7mBcfbpXQSlL9Ovqyuly
         hkrOtN2je+PgOLPuXuvKyxtfcBXGyANb9X7rT8ABcd+DOCKQkp2lfYONDzE9SvO5a6hE
         txG+AWk498hnL/9tsMohecm14uAZIxwyURwq6qNFdWDw8Ih7TWVUBQOgjlugq9TWYaKi
         bYG91Q2R1l3KO0dH2TgHcs7S4LZ/fOWiBWz6cAXVPnVZNpBeVKd7KtDvqJBTNSWkypyy
         Bt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3LVTa2lFqZkXo4/ZgV4Wm39FYCcu0nNpMiRyih6YLI4=;
        b=nqlL+DzHFoauzRSAJbor7fUkXePWvB18qw54BzB/xVJGj9t0+lC9aF2tVTeAv2gKzj
         vZeus/WeKUp9dp88WqzwM8U9FHy66Yr5mTNkdtYHpCYo8pZbGV+YsQ36PnoLWd7xWCb5
         zBrDHtzR8yB8M6Hn0wM2leQHLCeKCXXul77SZLv4tfvMM38j3nTvRxLjJwBwRkDzkXXQ
         O2vzOH23debz7+Hp9ur2BB7G6mJXlUQmpNgYdIvj3hgcMleezXZSJJKsmkObS4h3iylV
         aGCxWTVLtXvt30lwgOkO0QvFl8L3edL5kGM8wGi/mB0ZHENZZMAG7WZAvKXo7n/zkEM8
         Enaw==
X-Gm-Message-State: AHQUAuZ8a5UxkKz3YivYWT/U1SwFWW8atlt0SYv0Vd2nHDqCbWPaiGZx
        uj1roYoOEo+rbNhU8YQCr42+fXKA+/yi8aKGavA=
X-Google-Smtp-Source: AHgI3IYXPQSAvmtE759ivxmI4mmINx//s2wgLcOtOEzKuK00m45Y53bcGAMRvANAwApm+iVzDitK+ch5rq4HMpr1m6g=
X-Received: by 2002:a63:6506:: with SMTP id z6mr32570199pgb.334.1549873285295;
 Mon, 11 Feb 2019 00:21:25 -0800 (PST)
MIME-Version: 1.0
References: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549553629-8414-3-git-send-email-Tianyu.Lan@microsoft.com> <20190208145159.GA17854@aepfle.de>
In-Reply-To: <20190208145159.GA17854@aepfle.de>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Mon, 11 Feb 2019 16:21:14 +0800
Message-ID: <CAOLK0pyHt3pCiEA4nnrHLXc7gvbB0+vN3_aA+_D27KUi_Dkvdw@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
To:     Olaf Hering <olaf@aepfle.de>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olaf:
             Thanks for your review.

On Fri, Feb 8, 2019 at 10:52 PM Olaf Hering <olaf@aepfle.de> wrote:
>
> On Thu, Feb 07, lantianyu1986@gmail.com wrote:
>
> > +++ b/drivers/iommu/Kconfig
> > +config HYPERV_IOMMU
> > +     bool "Hyper-V x2APIC IRQ Handling"
> > +     depends on HYPERV
> > +     select IOMMU_API
> > +     help
>
>
> Consider adding 'default HYPERV' like some other drivers already do it.
>
> Olaf

Good suggestion and will update. Thanks.

-- 
Best regards
Tianyu Lan
