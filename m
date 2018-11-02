Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D0BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA172082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuYtgCvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA172082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeKCDNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:13:49 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44048 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbeKCDNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:13:48 -0400
Received: by mail-qk1-f195.google.com with SMTP id n12so4393444qkh.11;
        Fri, 02 Nov 2018 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sL12OitAikGu+FaUigrM6+uRGskxDdxxbxXk2LtoJrs=;
        b=tuYtgCvi+ZmMK5Dxnxg4OsI4yPfXwe1wac7JfH0fsnXYThntBB2Wlus3kiil5NdJ5F
         GKCU2wU+3tA4PoMh6Q/4ekiuzG25aNT9140J0dhJn5kUvCuDFVyP1VWUdLnWfBOIT/u4
         kj04ASRb5hdoVDSKBkfWM72XPJi1XtKjzQOz1HsDRzhpLVq5BR01x282NZplwD0Vwy5h
         OQzYbATieDtCQAVgZ4hMwmTK0Ywa9lI7x15fouvR8MLTSchoLWJeW1uQ4LVfKvvXgSBW
         TbZAjhSj2JOuTDiKPCjzxhZh3P97/4kP6ijKwIrdd47rStUT8+unIv0S9S28LQU/JsGz
         b/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sL12OitAikGu+FaUigrM6+uRGskxDdxxbxXk2LtoJrs=;
        b=CZwk0GXB7RKuKgj0BTnBCPYUTJ1Vr/pOjJw5lrAG/o9XwKcYJUEWOdLm6KRHeRW7nX
         CpjSvR7x1vuJeNNYP16e+Ow1emcAhDrqof8i4HluMvD2sPmApef6xJkLVOmQlKCpKP0z
         s+N0CYfTsPg+GibbInRMFvOTySSclm9syaVDsi/yHejwd7z30E0kQV07lS0nFqjPyTCT
         09RkrZXSVZI15YhcHspFLMh0ldfDsPRbVg4CaOloG4LzKAbdKvJ+Uzqi4FgQpqMY8KLt
         J+LKe+gBk4IjzRc2G34LsyshZqmpgxI1kXYo16xZQGja5gJrcgpxpa0cbX9GVemmbtZR
         KbZw==
X-Gm-Message-State: AGRZ1gJZn7ABLik1JfdpjvCm3DaNgH0h/tk4vg7I0f5FPg4mJC4HIw5g
        ybL0AO63rHM99Xko84WMsK4IwkFw8O2Q0LP8nkM=
X-Google-Smtp-Source: AJdET5cmpY5fIeoiJ88off9hpXLQC1kZ2xvzAPpRoaTG9zr/6bWAlTntqX9KxG7Jqq64JCCxIhN8OgVX2A6i4wbZe4M=
X-Received: by 2002:a37:c3c3:: with SMTP id r64mr11532155qkl.70.1541181945303;
 Fri, 02 Nov 2018 11:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181102041120.7603-1-ayman.bagabas@gmail.com>
In-Reply-To: <20181102041120.7603-1-ayman.bagabas@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Nov 2018 20:05:33 +0200
Message-ID: <CAHp75Vfj7pzuZmheqppjzo-GhSH9dAFuKjzZH8G0wkJKao2fyg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Huawei laptops WMI & sound fixes
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kailang@realtek.com,
        Hui Wang <hui.wang@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 6:11 AM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
>
> This patch set fixes some of the issues with Huawei laptops.
>

Thanks for the series, I'll review it later on.

> [PATCH v2 1/3]
> The first patch adds support for missing hotkeys on some models. Some hotkeys,
> like brightness keys, work out of the box on these models.
>
> [PATCH v2 2/3]
> This one enables the front speakers on the Huawei Matebook X Pro (MBXP). This
> solves bug 200501 https://bugzilla.kernel.org/show_bug.cgi?id=200501
> It simply uses the pins configurations generated by hdajackretast using the
> settings posted on the bug page https://imgur.com/a/N1xsCVZ
>
> [PATCH v2 3/3]
> This enables the micmute LED on Huawei laptops. It calls an WMI method, using
> PATCH #1, to turn the micmute LED on/off.
>
> Ayman Bagabas (3):
>   x86: add support for Huawei WMI hotkeys.
>   ALSA: hda: fix front speakers on Huawei MBXP.
>   ALSA: hda: add support for Huawei WMI MicMute LED
>
>  drivers/platform/x86/Kconfig      |  13 ++
>  drivers/platform/x86/Makefile     |   1 +
>  drivers/platform/x86/huawei_wmi.c | 224 ++++++++++++++++++++++++++++++
>  include/linux/huawei_wmi.h        |   7 +
>  sound/pci/hda/huawei_wmi_helper.c |  48 +++++++
>  sound/pci/hda/patch_realtek.c     |  28 ++++
>  6 files changed, 321 insertions(+)
>  create mode 100644 drivers/platform/x86/huawei_wmi.c
>  create mode 100644 include/linux/huawei_wmi.h
>  create mode 100644 sound/pci/hda/huawei_wmi_helper.c
>
> --
> 2.17.2
>


-- 
With Best Regards,
Andy Shevchenko
