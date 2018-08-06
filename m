Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A921DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568342192C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqKLjHCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568342192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbeHFWhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:37:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37930 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeHFWhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:37:42 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so15598471wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m7OO6IzlGEerBTUkEkIyXsKmilNIrbAQX9DW0iRztZc=;
        b=kqKLjHCvDJOrc/Ifo8VT+GzCF1qITMjgqI03ZNz8rqsVhSX6Gss/5sKUaxdeBzGiSm
         jvYk+7BAStfjyw751H3sGbIygzqcSHrpJCnjmB0FMuNvb7bW5STDKevxkxFQdbBzvxeQ
         el7FfA3hHNpKMPE0OoDBRnjOvmjRVl5W0o3U16uFeoGNENpj8ESce/8GbCx4iiB34Th3
         eAYDGvlbX6m85tvVLVsj7qOi+vCnitSWsv6mbWNfnDTN+xivcl7Fo3L4PXsC/VcPoCyT
         f3dWz+d2EKrVzwZSSmmXFbc37x9ULar1afQRom6m3ZBrEkyaaiH2aEA5UCh4kHLgy+6Y
         NjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m7OO6IzlGEerBTUkEkIyXsKmilNIrbAQX9DW0iRztZc=;
        b=qcmiDAABXmKCL5BQs5XpF8kqCUEQ82OS+034Yp8+F535Ii5GJbsJfDoL475SzlM8bl
         cry2Ljr1ji5S0RiP8y7ra2Dds9PZU+6MrlQ12wSNiCcYl4p7W4BC03R5cxg81CR+o6zl
         WCU4GwB/u2SFsjSXYnTuPz1DbGCmDxJQ5630bPSZMpFUntAYvPPZG1l4YJLdKAINjpw1
         vh1d804FFlE3ztEmrcg93uo8k97cwXHO0S7D/ZBhbA7FUCLSzLp0E8GltCzNOczqHcTe
         OB1NzvKp2OXwjlN6xF1n+Zc9ct0SyV3MKfjJB4+ImrgmnkZ2wel/VPslJnRDkxOrCsfz
         MUwQ==
X-Gm-Message-State: AOUpUlE6qHXail92G1JzdnVlYJPMuBxbIBy67AbPXFbJ2w39pFSlGWna
        TzeyqZsi69yBw7Wv9h2KeKPG6mJJcNGs86Ojvf0=
X-Google-Smtp-Source: AAOMgpdM9MFDkldN/RnjkMhSvzhnim2nPqzvrJBlY0K9Umg+NgPd69XJm3NL97UwAVl3k7dnGCOeGrS9iJkOCtyaGnk=
X-Received: by 2002:a1c:6fdd:: with SMTP id c90-v6mr12360965wmi.16.1533587216649;
 Mon, 06 Aug 2018 13:26:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:979e:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 13:26:56 -0700 (PDT)
In-Reply-To: <20180804002535.18434-1-baijiaju1990@gmail.com>
References: <20180804002535.18434-1-baijiaju1990@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Aug 2018 16:26:56 -0400
Message-ID: <CADnq5_MW=3-PbZnb_9JQgfoYBZh8iti0tY+zP+mkZzK6upVHFg@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: radeon: cik: Replace mdelay() with msleep() in cik_pcie_gen3_enable()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 8:25 PM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> cik_pcie_gen3_enable() is never called in atomic context.
> It calls mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep().
>
> This is found by a static analysis tool named DCNS written by myself.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied.  thanks.

Alex

> ---
>  drivers/gpu/drm/radeon/cik.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
> index 7c73bc7e2f85..c1b4d4fbcf3a 100644
> --- a/drivers/gpu/drm/radeon/cik.c
> +++ b/drivers/gpu/drm/radeon/cik.c
> @@ -9598,7 +9598,7 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
>                                 tmp |= LC_REDO_EQ;
>                                 WREG32_PCIE_PORT(PCIE_LC_CNTL4, tmp);
>
> -                               mdelay(100);
> +                               msleep(100);
>
>                                 /* linkctl */
>                                 pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
> --
> 2.17.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
