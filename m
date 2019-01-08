Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7B1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D0620850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfAHN1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:27:41 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44959 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfAHN1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:27:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so4253871qte.11;
        Tue, 08 Jan 2019 05:27:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LJNIeOlWFvWz7FljxszZIwj6olWLlHhc5XsiufOa2M8=;
        b=SixIM5VgobrDMnMmqSDcoWF9HDTXYwyOl2w2Nz5PaUmyVkBaPzUQrtqsMpy5KqVKiA
         f48Wzl1mhDAFlw/br76axbvuq3tJSY0cp4uR/XO277fkn1D199xEWYG/TDqQQIQAvddY
         v4Pc6nmvz5Y/OtHjN9dOJxxTYmCILs2mLCqwcUrXxMUUpb9e7ZJyw6HNm9CKMLpLRrdv
         js+yejyhZG14uhnM5FVGXLVlROrTMlrxZGWgDV+BWGVRSL24it1I118WL3gm9Qm8GMrx
         DFIJLlubNxYRBlXRasTqGG8wc6rZRhDeTfSjHk8Y5NQQwn13sJmOyEzewVIBf76bIJhI
         Dyog==
X-Gm-Message-State: AJcUukeQAnlXgTwPNGBiakppQg9yhrldPChfkC7qn3fWk5AFPoaVdt8a
        YAUX33vSkK9+QTfDLzetmuWv1urGMsaj4RT1frQ=
X-Google-Smtp-Source: ALg8bN77B1XiJ1RSZqDKv6kOx9M7UT54tYcBEYdv7VQqHC1T6vrcXlc/c7QC9Ra5jhozr+QGOh9976R/4tX/GHyj+z8=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr1604787qte.212.1546954059166;
 Tue, 08 Jan 2019 05:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20190105100606.6673-1-okaya@kernel.org> <20190105100606.6673-10-okaya@kernel.org>
In-Reply-To: <20190105100606.6673-10-okaya@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 8 Jan 2019 14:27:21 +0100
Message-ID: <CAK8P3a35HQQCVOQORjmuJLdO3ieiZFjSCF+EwJHRkz_727cFsA@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] mmc: sdhci-acpi: Make PCI dependency explicit
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 11:06 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. This driver relies on IOSF_MBI and IOSF_MBI depends
> on PCI. For this reason, add a direct dependency to CONFIG_PCI here.
>
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
