Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7F1C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C53218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1wAVGnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbfAaMIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:08:14 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:43957 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfAaMIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:08:13 -0500
Received: by mail-pl1-f174.google.com with SMTP id gn14so1375228plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 04:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BEuhvtd/f6y/iKku12IDkhUOP7e1XXLeb72Q0TpTCQw=;
        b=h1wAVGnCo5s5+SOuwQ5A5RGP8oswa9Goi9dJkS/HrmMueLvlaPpcfVgwlbAoNIKrAo
         4SWHXEf2Q0sfJPYrc+FyEGtZI0EyR8xHJa08Hl4yV2we7DbwsZ30ttJ0aKNaJt3DJsq9
         5BNXqeKFoQR2aDoJe5fHMElwherMvSeIQZllIJnPh05gDHqoR55tB8zamWE6gg++udF6
         ybQE//udvpY03IZI5wxxqHLxdBUO7Nl4XWNfeFvjSjzPa6ZTYWL01+n5y8oa3ACDhaED
         O3d3d4F6kYa8kg6zzaZLkE7bmMpa4uAMHqmGea3DGrTO4fmZDDLsSKttGksVzb5YloZs
         OKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEuhvtd/f6y/iKku12IDkhUOP7e1XXLeb72Q0TpTCQw=;
        b=aEDFCH2oOEWyIBj768VtwQ/ghNpEC1r/fnO1Bj2Q35x7Q9v14NMB0BAN9trINxsd/X
         7TvdsJKyf050A9/EhrPfDD9G5KE47QOheftTbNc/aE3nFSCwh7Hl3fLJVLUSUr+y6ui+
         zl4EVLCT1nzBKD8aBnEHYBzJJWgQN1YBTDhZUmyVnjfKzN9sAHiCVsxPgH1U/GJYCWyz
         nBOiNNjNARL0dZzb2O3V2UFgwD2DSWDQ8kxpn9XVLbfpCeOUqm6J1/ZITxT7RNLApq+t
         JFw3s9JeJ9CjNtrm73kDJCFzFOs5QdBXfsvUTjBpPQEeo8zgpzpFZ6yH05gDz9Wwnjg9
         4MOw==
X-Gm-Message-State: AJcUukd7tQzkMe4KWwGzGf+P0P8FJMFOoFEOf52PJJBkF8AAoOcy3Ir0
        5PKYKsxLzdVMERG1KKHBOok/FeGTZbKcFIn/5lI=
X-Google-Smtp-Source: ALg8bN7UYiKanvFuhGe1NsgTuqfqigfnJuhez4Y7avUrcSgLf0eIGq9iQiUqHAkQBX0EY9gPdihw4PvVxzDcoSZTiKU=
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr32961959plp.172.1548936493210;
 Thu, 31 Jan 2019 04:08:13 -0800 (PST)
MIME-Version: 1.0
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com> <20190131115944.GB19969@kroah.com>
In-Reply-To: <20190131115944.GB19969@kroah.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Thu, 31 Jan 2019 20:08:02 +0800
Message-ID: <CAOLK0pwve6spShSBt_jBwECJWTtTtHYRz+yLi4vz18GnznMw1g@mail.gmail.com>
Subject: Re: [PATCH 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>, mchehab+samsung@kernel.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        nicolas.ferre@microchip.com, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 7:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 31, 2019 at 06:17:32PM +0800, lantianyu1986@gmail.com wrote:
> > --- /dev/null
> > +++ b/drivers/iommu/hyperv-iommu.c
> > @@ -0,0 +1,189 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#define pr_fmt(fmt)     "HYPERV-IR: " fmt
>
> Minor nit, you never do any pr_*() calls, so this isn't needed, right?

Yes, you are right. I will remove it. Sorry. I used pr_info() during
development stage and removed
them before sending patch out. Thanks.

>
> > +static cpumask_t ioapic_max_cpumask = { CPU_BITS_NONE };
> > +struct irq_domain *ioapic_ir_domain;
>
> Global?  Why?

It should be "static" here.

-- 
Best regards
Tianyu Lan
