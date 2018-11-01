Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C3FC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012F62064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGhSWv7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012F62064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeKAWpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:45:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38578 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeKAWpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:45:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id v1-v6so16845353qtq.5;
        Thu, 01 Nov 2018 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pMB5PMrMTYCRVJ3Z5w7mSTwmfDrCS/MwLqLqMx4V+Wk=;
        b=oGhSWv7XODIa9r6+NVuo9v7LooSBgas1OtvW1F4D86BJlS09aDZb7aAuhmSUqHjWzE
         v883+NSZDDmVMKRMufZo3FnpSU4/vRifYZCbx9+ybZZYfBmqA6rSB5SubYHigfJzP+7v
         fzfqzQEbGkLYIC2LXl+g5wVU6ZMwgRJjrhjreMXL3vb9Hm1ySO2mwhh8ZoEIsBeFHQvk
         aH5tXmUCQCUXMecvyC5EzZ2MbuViUMhttPP5v8M7AefNiagMGY35XqZ9p0dCV2Wx7TKm
         IKwrKMjvNp7hfsiENCPPjCQ/PZu07ojRIgdwHZ3JPTEl4DUusZn/FBNGWME6G83T5Oy7
         AOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMB5PMrMTYCRVJ3Z5w7mSTwmfDrCS/MwLqLqMx4V+Wk=;
        b=iah1mXNSkcs03NEb7Re/9HMdjxKvh5y5d9q6ylV0aHGJ+IDSZ5Bck8PYZw3Z4CPHIc
         neYp6koWN4vaZZbyVwn/LAw46Hb6C8wF1zX1Krhrnu1hh+CcB6upgDxe5kRJPkR4TvYE
         XTnXHxYr+ADlX0kMcV5lgJ1fpREbXbHcRCemFGRyZGpWTf3mWADqZ3gGftUDkxeuE9MK
         hI6RPlTPnUlMDQw24uo/J2UlwSc5wzkoKseQ+ZTZwaoyCn0N3Oq0k294SivfGRAZmqIa
         5YxGCXiqrCsFOj/bAyJveEp3TBN3OQWMW7gDJ9CptOID0AJKVGIAgLpshMNcJFotdfbb
         ifjQ==
X-Gm-Message-State: AGRZ1gIJOgGL1bSxbtn3eF0QirDAg1v9bwGuGDLP8853xj3UQP+OBtpy
        aAMZfYJQPtKpRgzAeRnqJO0EKyKJll3Ty2Nh7l0MttfxLro=
X-Google-Smtp-Source: AJdET5cIWmvZnw9Hp9j7szNy24cgSCOPzwnjb7QDDvwjTyQfz7T2uOgfmGtK9b1ncr6EtMgtRMOZpAIpqhAffcKQxEw=
X-Received: by 2002:aed:3b76:: with SMTP id q51mr3578512qte.229.1541079752224;
 Thu, 01 Nov 2018 06:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <1541085002-42993-1-git-send-email-peng.hao2@zte.com.cn> <1541085002-42993-4-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1541085002-42993-4-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Nov 2018 15:42:21 +0200
Message-ID: <CAHp75VcvWwUJ=_LupAeuOFGLMTaBfB-g17kwQ=G1KF-zDS_8Hg@mail.gmail.com>
Subject: Re: [PATCH V5 4/8] misc/pvpanic :convert to SPDX license tags
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 9:00 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
>

After addressing Mark's comment consider to move this to be patch 7/8
in the series.
Otherwise,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index 66534d4..0bcf1cd 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -1,21 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
> - *  pvpanic.c - pvpanic Device Support
> + *  Pvpanic Device Support
>   *
>   *  Copyright (C) 2013 Fujitsu.
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
>   */
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
