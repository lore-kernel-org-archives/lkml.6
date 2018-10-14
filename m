Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC139C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E232077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pqRXx1sJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E232077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeJNXCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:02:45 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55596 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeJNXCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:02:45 -0400
Received: by mail-it1-f195.google.com with SMTP id c23-v6so25288692itd.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 08:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5yT5eRwQQEdXP0WD3duhWmNWZLNHuYeQ/BhJdbI0o28=;
        b=pqRXx1sJGM9m1sGWHuErvXdp6wtwMM9gZRQN1YpkPo523kvTXu1GoOE5LB3T5wsoTl
         UzxlcfPP+hGObaBzxz7E3A6SAB3PHIlHT4bfVysexb/hppHUtSgbABZ/zm9/7WE2hsa0
         +wwhfIQTRpxVToRyKke2E/UFQig5HxfmAy25LYBO6FYRcKOqwbmbIToZ35e8A9Xfq7Ze
         dET1sSBw99rdFIJ935U/WSErJ0W87v6UAc3MN13mo4qXAkW0ow4vAeyyyPGcQVeI72FU
         aKy50mvUdmEAt1cG/3R9cbhEbbhAzqwL7Nr8iey4iDAc1H8fnbYEWzyZJzj/HKHmaoeT
         XbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5yT5eRwQQEdXP0WD3duhWmNWZLNHuYeQ/BhJdbI0o28=;
        b=CLV4rraFzeWE+cxT+Qee08l1SpH+KVqmJxL9VrJy8xl9/et0wmCBw9FjHxPUK2fuBj
         HO/IqaWFwZ6BtRUc5SGVCCcj6eGcV+hwZaxX55KfZhR5XAdC8QO0nNMyRdRbZyETlAoe
         GK1xB3jAEMs9eWdvIPVF8IcvZ2NH54nyZ9SDtY8YTFqdi+PLdEP7Tn4P70cNgys1doD4
         CQ7LKus17/E0RccRS8C3AsuYdQRUSBnQnU1Rw7C0sS65w2E172xfvDqa/mvIMP060/uF
         DSK2cY6HR54YnW3iUOyrBQtTvVxU/vb+cl0ttJ4PEImFZA7qczx6gqCxCa8G9aPlaZxO
         nJ2w==
X-Gm-Message-State: ABuFfoheciFoTjewZdndkUlV7MgrJB5aA3FRL3AjXHz2iUosYsljBpYv
        AaMDktvJQizNTjfH4DSeczabEWflOJg6R6KYswtOVQ==
X-Google-Smtp-Source: ACcGV62HBf05KFuMOrP70kkRKIphCIJZ5f+gXt79KWKmsAnhFMFBl59wz/aEhnPpeUrq/hycj/d+AmhX/BW2kRNAFjo=
X-Received: by 2002:a02:1b4f:: with SMTP id l76-v6mr10581856jad.57.1539530487530;
 Sun, 14 Oct 2018 08:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181014152010.2021-1-brgl@bgdev.pl>
In-Reply-To: <20181014152010.2021-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 14 Oct 2018 17:21:16 +0200
Message-ID: <CAMRc=MeMXKO_GWdVeH7yaa1qEyZBV-bsXhYzjC7LnU5UmHayNQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 0/4] devres: provide and use devm_kstrdup_const()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 14 pa=C5=BA 2018 o 17:20 Bartosz Golaszewski <brgl@bgdev.pl> napisa=
=C5=82(a):
>
> Hi Greg,
>
> this has been reviewed a lot and three first patches can be picked
> up. Please take it through your tree.
>

Except for patch 4/4 of course - it needs Thierry's Ack, but that can
wait until the first three are merged.

Bart

> This series implements devm_kstrdup_const() together with some
> prerequisite changes and uses it in tegra-hsp driver.
>
> v1 -> v2:
> - fixed the changelog in the patch implementing devm_kstrdup_const()
> - fixed the kernel doc
> - moved is_kernel_rodata() to asm-generic/sections.h
> - fixed constness
>
> v2 -> v3:
> - rebased on top of 4.19-rc5 as there were some conflicts in the
>   pmc-atom driver
> - collected Reviewed-by tags
>
> v3 -> v4:
> - Andy NAK'ed patch 4/4 so I added a different example
> - collected more tags
>
> v4 -> v5:
> - instead of providing devm_kfree_const(), make devm_kfree() check if
>   given pointer is not in .rodata and act accordingly
>
> v5 -> v6:
> - fixed the commit message in patch 2/4 (s/devm_kfree_const/devm_kfree/)
> - collected even more tags
>
> Bartosz Golaszewski (4):
>   devres: constify p in devm_kfree()
>   mm: move is_kernel_rodata() to asm-generic/sections.h
>   devres: provide devm_kstrdup_const()
>   mailbox: tegra-hsp: use devm_kstrdup_const()
>
>  drivers/base/devres.c          | 36 +++++++++++++++++++++++++++--
>  drivers/mailbox/tegra-hsp.c    | 41 ++++++++--------------------------
>  include/asm-generic/sections.h | 14 ++++++++++++
>  include/linux/device.h         |  4 +++-
>  mm/util.c                      |  7 ------
>  5 files changed, 60 insertions(+), 42 deletions(-)
>
> --
> 2.19.1
>
