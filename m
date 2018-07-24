Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAE2C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B3D20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng2TCdrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B3D20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388849AbeGXV5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:57:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33256 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388690AbeGXV5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:57:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id r24-v6so6626580wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=geto6TEds4J48/qWPw030L/yQw8RmJ9eE0n+jGzwFow=;
        b=Ng2TCdrgfBmnbqNsewAD/Dcjk6aqj8oP+bQAzmGuFfPaHLekj/tPGsme+Afwr/Nh7m
         32nzg2n9AZqx4ieLnbpWp2MUHkda9xuMSKe3oO6zTfUzbsP4SZQ2sxu6KQro9fuPnIfJ
         3YWk1Xy/rf0lw/Ef0UDnTB4tH94Rlf+KsP1gIUr9f4n0yrUFFI/ewQ+M+55EVvbYKFOn
         EkJkT+a0ODWdybKfdh1jO3qW4rlCsptUOIuOc2B62IpWIVUZIMdo1Id22kl0uBRr+vf4
         abI7xcwe84uHs+UbhKunbwljM2BLZMMn43j/HEgE8tyCj7StgHU+euQrZSEtawWh179L
         IdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=geto6TEds4J48/qWPw030L/yQw8RmJ9eE0n+jGzwFow=;
        b=kdQah6DSMgtJLPG0oQ/B0g1yYMOAggLzTGd3OdI2JIzH6JjkmdfKoKHP0nUWI1Is+V
         AOmZXCw0SdbfuXRKh8VDhL1MHN42HUcNIjB12dXKJHyyLxnqmZl7eEo+WfH6clm2mS1p
         84AwJmKgiX54j3PAibnXIMcCQerAIkDs5VlgAJP48NUgJ4u+HrezLWv5U+IaKuT7zqz7
         uvWvdtAFl3Fq/uQfqTxxXVintFYRezBCRHCVCztRSe/rpA1KNGx/ssueFWtHvSsbIBMD
         6RXrXtFnwvUUvXsgEdAERbXxPsXPUujcMAjrj9nUmSIcjrVanZduT9D2xDQQcsVtuWO9
         D1JQ==
X-Gm-Message-State: AOUpUlFvx/OxQba9tcoM0We0aBzJYZC1hyHPlhyM/AZm/giwNbqoSCga
        mJVHkmVizgCb9KD5fbpk4DDcy0Vi59u7ob97TqI=
X-Google-Smtp-Source: AAOMgpe1HoYtCrpIFsoDGhveTeRUcBJ7KzI6TBoj1x2YKCJaNq+B88oBXmlscOnTZ2I2OmrMCg+6hRemAKsS7GWYBFM=
X-Received: by 2002:a1c:d750:: with SMTP id o77-v6mr2818652wmg.67.1532465373957;
 Tue, 24 Jul 2018 13:49:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:979e:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 13:49:33
 -0700 (PDT)
In-Reply-To: <20180723142956.3718-1-baijiaju1990@gmail.com>
References: <20180723142956.3718-1-baijiaju1990@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Jul 2018 16:49:33 -0400
Message-ID: <CADnq5_MWJhQfqYL7KOnx5O+WfgZT01PhvPpROMj2_CeCCaA+iQ@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: amdgpu: Replace mdelay with msleep in cik_pcie_gen3_enable()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        "Li, Samuel" <Samuel.Li@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:29 AM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> cik_pcie_gen3_enable() is only called by cik_common_hw_init(), which is
> never called in atomic context.
> cik_pcie_gen3_enable() calls mdelay() to busily wait, which is not
> necessary.
> mdelay() can be replaced with msleep().
>
> This is found by a static analysis tool named DCNS written by myself.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/cik.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index 0df22030e713..5b7fab2c2008 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -1476,7 +1476,7 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
>                                 tmp |= PCIE_LC_CNTL4__LC_REDO_EQ_MASK;
>                                 WREG32_PCIE(ixPCIE_LC_CNTL4, tmp);
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
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
