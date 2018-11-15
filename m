Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3508DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB51208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhkISYUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB51208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388589AbeKPECm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:02:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36251 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeKPECm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:02:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so2164124pgm.3;
        Thu, 15 Nov 2018 09:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G4D7WJ/hBzEye/EUTRh+exlih9C1bIqp9OyFvvPCJjg=;
        b=FhkISYUfhyLnpvUbUb+SbyIKHrcntFz+w6MhT6LZCBFrbNMXfP0XDLN9xs7mJf8WCL
         Wi75B08HUF5hV2EcnCFFLdGF7z/QdOPl2Hp+42HHZqfuGD86pbuBISpUB53mI31XT5xA
         qFzgevEr8ej+ZdYvWs3uJHNvbfbz+gm0QAdhl781be1EgHsr/TDyMPprDQ2fS0xZPqtm
         XsKl6DbaheDEw/tnIQ690WVobQWeb+hLtesYiRIFRMwwogJJMFSVlTNDFavUxk1oBQqw
         P0K4l9IbICyxJrVzR0ecz7p7ri0dxiJTtfKWVEhUI02QL1ahIQKdOi33j2UW0kfdfb66
         plow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4D7WJ/hBzEye/EUTRh+exlih9C1bIqp9OyFvvPCJjg=;
        b=SRknVH2hIQC+4A0S5QuPdntXH9V0wCbjbDEkNJ8NTGJd3nw5rp/qblUfeNXGKQui5/
         /uFcz2bu9rSOW9lCUS289WqLyzEPE3aPFPXA5DhuUTfk+rb+DjEBqGzpBJLUa6Hd9yk4
         3b7DDlII7EocR+4v2Z8clQkk0oapav2p/+d/aa5zZMPTeLt1X7ygZ8INsOiXRu3I4ZAs
         o8YuVub0boOmunrql0m+zGmfRO9AtfKPFjqMaCr9Sw/WOUt4VQn9NYeQAEsxvIElJkaJ
         5V7GvudlgULc6M0Vp3O5YJDHvcxsaQEm7Xp7qnookgzoqYjH83UZ0iTfyfBl5nu7AInr
         hszg==
X-Gm-Message-State: AGRZ1gKtGl8ImvgZyP+Rhd9DOvnDuqPbOBMcMlvy1XCusYp5QUf0Baaq
        gLhNuK/VVstgfrbQqeC31lbVvl+UIscuOG6OX5ueMw==
X-Google-Smtp-Source: AJdET5cXFNU1hlY8ahAd169uv1DDz3s/+pUaL3Tv6CyzqE/VFiGL73GFRVSNarCdvTuygwYAUwZY/VthsrKLyZF3MZU=
X-Received: by 2002:a63:5153:: with SMTP id r19mr6654726pgl.281.1542304433757;
 Thu, 15 Nov 2018 09:53:53 -0800 (PST)
MIME-Version: 1.0
References: <5bdd3128.1c69fb81.4bd46.f7ce@mx.google.com>
In-Reply-To: <5bdd3128.1c69fb81.4bd46.f7ce@mx.google.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Thu, 15 Nov 2018 23:23:42 +0530
Message-ID: <CAJr6mf0GLRQiu-FBjQfWmvJsAPQLsY8XH_aacgHUmxz=yts-Wg@mail.gmail.com>
Subject: Re: [PATCH] arch/sparc: Use kzalloc_node
To:     davem@davemloft.net, khandual@linux.vnet.ibm.com
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 10:54 AM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replaced kmalloc_node + memset with kzalloc_node
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Any comment on this patch?

> ---
>  arch/sparc/kernel/iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
> index 40d008b..05eb016 100644
> --- a/arch/sparc/kernel/iommu.c
> +++ b/arch/sparc/kernel/iommu.c
> @@ -108,10 +108,9 @@ int iommu_table_init(struct iommu *iommu, int tsbsize,
>         /* Allocate and initialize the free area map.  */
>         sz = num_tsb_entries / 8;
>         sz = (sz + 7UL) & ~7UL;
> -       iommu->tbl.map = kmalloc_node(sz, GFP_KERNEL, numa_node);
> +       iommu->tbl.map = kzalloc_node(sz, GFP_KERNEL, numa_node);
>         if (!iommu->tbl.map)
>                 return -ENOMEM;
> -       memset(iommu->tbl.map, 0, sz);
>
>         iommu_tbl_pool_init(&iommu->tbl, num_tsb_entries, IO_PAGE_SHIFT,
>                             (tlb_type != hypervisor ? iommu_flushall : NULL),
> --
> 2.7.4
>
