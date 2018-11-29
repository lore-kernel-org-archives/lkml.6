Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5649CC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBFA2086B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCXTIhcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBFA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbeK2RJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:09:00 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36675 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbeK2RI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:08:59 -0500
Received: by mail-lf1-f68.google.com with SMTP id a16so546150lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 22:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kvYuXWJb3wfH2ctVWpTKMWzdPFqTmLIU5Gos37Q74SE=;
        b=kCXTIhcKlTGdmceCbnHWQ8ciRmACWFHJ+tra+/lPNV1XZbmoZkX4wAO5MBAI2gUWkf
         vLufzrArvn7NLL3fn921JgFF73sBl2R8qJA3IKu7pS9OV/DmJxQkdPDzPwmihUJpYJdV
         LvhnWkMoo1fYLQ3PmROm9TJFU1damebLrGkRbL4gTeklfzHt/OFL9t3LejYNA1SZzA3v
         l35WKWfORk06MjTc+2qNya3oF/CZY88jDHQ6fvnzEANtjh5QKQQ8H+7IW7DkKI1b0wtD
         bgwFEZtFGw+VA5i5zM2MLudaEA0zjuyQiT642HhITWm1m+I4w48OQWT+pXvfj8xEXcYR
         ybeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kvYuXWJb3wfH2ctVWpTKMWzdPFqTmLIU5Gos37Q74SE=;
        b=ZZljBCANOIiZWty3IlZ/1jtR9LPsuDlZTn4X5v7wFEGFCEcx5kTUW7glAdyhDYzTXE
         p+w+QVoKjoTFSiVtk44RuC7E3rnTxxZsXKDdVETPr1MHc1qfdAdhPuDXchYtF2nmf7CG
         /yWYMvECF69SgN6JC73qv3u9F9FoITYat/6Nxb79BNxYqelYo2CQsHDWJd9fekj+sGr9
         BNM95uFXF2lqrz1g/ad4C6yULc5MbhLdpUDwJ2xhv46qumf0iSuc2uoG45j+3kr527xy
         ynyQ8rzESPuEvsWoL0GnQNt9lEyRQgPmgkRRIUBM1zhaga2/PrypAueEHl+v5gRGl2vp
         WsiQ==
X-Gm-Message-State: AA+aEWbFnYfqf3cAqao2raJgTAqnyis/mBQxE0R9b2hMaxL1An/xAy2d
        TCOgp5oEO8mkleLHUqAfglOWgVLBtQ/txZPiFbHrPQ==
X-Google-Smtp-Source: AFSGD/Vl+VMlb7fkhdGBwe3WndQGofSs53VdLWpJf8rKb/aAFqOTchXYIFEMnCQBJAwI7lkEkLfbBdKxipL+VeUelvI=
X-Received: by 2002:a19:ee08:: with SMTP id g8mr144852lfb.72.1543471486357;
 Wed, 28 Nov 2018 22:04:46 -0800 (PST)
MIME-Version: 1.0
References: <20181115154826.GA27948@jordon-HP-15-Notebook-PC>
 <CAFqt6zZy0-dy=a+KDrx7V1-j37pAVmt2r6bOkjgHwiopG-L+xA@mail.gmail.com> <5480157.mmjlM7ZeET@diego>
In-Reply-To: <5480157.mmjlM7ZeET@diego>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 29 Nov 2018 11:34:34 +0530
Message-ID: <CAFqt6zbqjFa-zS7TLx3Tcr3nvsdrbxsrOswWoh5xb_SoxPn98A@mail.gmail.com>
Subject: Re: [PATCH 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, hjc@rock-chips.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 8:49 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Souptick,
>
> Am Montag, 26. November 2018, 06:36:42 CET schrieb Souptick Joarder:
> > On Thu, Nov 15, 2018 at 9:14 PM Souptick Joarder <jrdr.linux@gmail.com>
> wrote:
> > > Convert to use vm_insert_range() to map range of kernel
> > > memory to user vma.
> > >
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >
> > Any feedback for this patch ?
>
> sorry, took a bit longer to find time for a test-run.
>
> Except the missing EXPORT_SYMBOL already pointed out in patch1,
> my displays are still working on modern (with iommu) and the older
> (without iommu) Rockchip socs, so
>
> On rk3188, rk3288, rk3328 and rk3399
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> and in general
> Acked-by: Heiko Stuebner <heiko@sntech.de>

Thanks Heiko.
>
>
> Heiko
>
>
