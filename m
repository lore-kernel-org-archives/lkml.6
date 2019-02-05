Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C057EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D7620844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549363807;
	bh=H9fSZ0olXc9t16Ss7LIVLXSyjkfUYZICIMeEgeO8Thg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EPoPcdGbD8tjPYOIQGzBYT5fRMr0+aV7NmiGvfszDFgfWN6G2Ysaaq5SMGyk986sa
	 DJkArHpPmsCXTCpf4evU2Ib2fEFyUVOfWolFcuRwYFZ2LSruJp0jBzCJp3vpfCGEb2
	 3aQiUa/JMvxP/wQxCTzdjvG2n2J6T3v2RA8xgUTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfBEKuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:50:05 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46780 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfBEKuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:50:05 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so4827177otm.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 02:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjTdwGDu+kRGZUpV0vd9TcujInSfgY5jlOEre3yEaBk=;
        b=Fu3H5rQObVW6TfeKZGk4mbsd/qAcP/glbtpLrZyPHR26tjHZYO8rZ8dyBT7Jxpeb2r
         7rg0Whr13PMIQ0N3Es/oEuUar8NgwaZnHjQLs84qsebeW0fOMh9hayHRGJMLIMouTPsp
         L1cosnOsfHalEu5IAcPoPrrUvmX2+swP11poPhK70UC7+N+xy+0R2PtuD/rgF8lUWoSf
         8awcKWarbyhOlmfypdHwmlf/gzdnDtAMJmM/AySc7SL4RS7SZWKzn8k199iU4+FI0f0x
         Tphj+EvcxoYq805Pz6Jsx2MoNd+FV4+OlL1byAhCeC5UsIC+1qulcy9SRkZfafifHh6e
         rltQ==
X-Gm-Message-State: AHQUAuaZ+5IPv7u36bD8MPekMP5et5Bi6k9CsagVHvPk1m2PIU0TQOAv
        C4K9fG1FrQ8KEH6F9bvPCfJdCaGK9Gk18FXerpY=
X-Google-Smtp-Source: AHgI3IZxxpaOW+lynb2ZV1kpB+2LDA6MWcPX9WFIrtFKu4fnuW7xIC8FPoT0BSDZzr7RW/oZzIKYeiROHq2zF2R/gAg=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr2216749otn.200.1549363804653;
 Tue, 05 Feb 2019 02:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20190204140800.28544-1-omosnace@redhat.com>
In-Reply-To: <20190204140800.28544-1-omosnace@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Feb 2019 11:49:53 +0100
Message-ID: <CAJZ5v0gXbpJLAKHH+P6wwmfKyVb02_J8bXyadFJBU=KDh+M5Hg@mail.gmail.com>
Subject: Re: [PATCH] sysfs: remove unused include of kernfs-internal.h
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 3:08 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> This include is not needed (fs/sysfs/file.c builds just fine without
> it). Remove it.
>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  fs/sysfs/file.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index 52d9235e0291..130fc6fbcc03 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -17,7 +17,6 @@
>  #include <linux/seq_file.h>
>
>  #include "sysfs.h"
> -#include "../kernfs/kernfs-internal.h"
>
>  /*
>   * Determine ktype->sysfs_ops for the given kernfs_node.  This function
> --
> 2.20.1
>
