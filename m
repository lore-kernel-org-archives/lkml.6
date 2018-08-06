Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4DDC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532482192C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfVwMQJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532482192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbeHFWjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:39:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33867 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732548AbeHFWjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:39:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so13579068wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iceIl3iBNRVZ7OQHceMwYVzznx+ypAEG5YDUFF1m98w=;
        b=GfVwMQJzZbqpZUQD9v7IhuUxOs4HXvnOYqZUHf/vDQuQ66zTuBdmVwJd8V2xhgIWHN
         QeyLL7vlEjyQWGl6XRUVX2rPUkNLAHFh/P7WgdptnV2QMqGNqVdpWTfWlpDQKFeGMGmN
         PE/XvlsJsC420OTjWJvKJRH1nVDsvrU5dmLrKAIiiubOU63GAPVFVJbqfOJTbUL2k+jd
         2TUna6XIt+SlUhVeSlOYs3NjFlTObiOKpbqDvJbAMZDUHS5PMgloyzy91UAreqBxKXN9
         0hce/y78/ui1RqYMtbs+E6KBjRWNdHMBuFfzbCK51qqybmi1n5DZLzPPKAVKpqtSg86V
         bkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iceIl3iBNRVZ7OQHceMwYVzznx+ypAEG5YDUFF1m98w=;
        b=jCkLKM8BF+0EKLzvBG+L8xYCAffgpwFkHwadz7fYO/gdTuY9GS91crfZ4q8LbHoXDq
         kMAYcBoD/etz1qTNbRU3K7Qs5TkGRPRDbs9C+bHwc+c74jLLcjAzExpHNONl3OwaASI5
         9S+pp4HKID8orWd7zDi3em3RVEHBxKZSC7eUXaXPhJF7T1SstYZn44IfGymAlfzCXwWZ
         7PbHJe9oJ/VZr0AjTArFTUGiUMwFEEFYP7/YqwGEWN9g9geUGbYL4400rsGmLXd7OVXK
         /oTOZP3Dm45sk4LPZql9RTR3WWRQSblkMySMWvgT8WsLdYYRD2osl+ZtLKTFGNRSXISq
         RnTA==
X-Gm-Message-State: AOUpUlHfq8wuji4Otn+lmrOZ2XeF9+6Tq7/uCCEVVjJL6x6kg/a0UK3v
        7DB/EYYYlRgSxzYYT2yWeFOJDv0BpGPOmCHQo1mCRA==
X-Google-Smtp-Source: AAOMgpfNWFvOkEt+7CZgNH2lc4jB/XAS4SAQM4Es1cUbE6b1eiXomrnseUxd/wGaSuagFDkJVuE2UUEJmiBmpI8gAwg=
X-Received: by 2002:adf:b583:: with SMTP id c3-v6mr10973426wre.79.1533587304510;
 Mon, 06 Aug 2018 13:28:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:979e:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 13:28:23 -0700 (PDT)
In-Reply-To: <20180804003344.18775-1-baijiaju1990@gmail.com>
References: <20180804003344.18775-1-baijiaju1990@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Aug 2018 16:28:24 -0400
Message-ID: <CADnq5_Pd+1oBNQYQ_LWtBEfD1b=392Cx4MbPDuKWghnDnVZP+Q@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: radeon: si: Replace mdelay() with msleep() in si_pcie_gen3_enable()
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

On Fri, Aug 3, 2018 at 8:33 PM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> si_pcie_gen3_enable() is never called in atomic context.
> It calls mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep().
>
> This is found by a static analysis tool named DCNS written by myself
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/si.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
> index 1907c950d76f..c28743443970 100644
> --- a/drivers/gpu/drm/radeon/si.c
> +++ b/drivers/gpu/drm/radeon/si.c
> @@ -7181,7 +7181,7 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
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
