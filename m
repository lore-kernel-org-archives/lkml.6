Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6F2C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D093C2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFAo/7ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D093C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbeLCIMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:12:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40623 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeLCIMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:12:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so4589658wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 00:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unMMa9AN5ed7phn8mDqbTlDXTzG3IRr0dPibGYUg0h4=;
        b=lFAo/7kaJGdGpH2IduXm4an1I5aa9louXkKZU5Ltr/Lce/B+f5slBjC6BLRzSY5upc
         Tr2UTmF8ij+oRjj4Eht8PGS5GL/Ev4is3od1YeW/6rZphiEYLnY+q8bEAF1RIy8sBpkM
         1+qwkpZJf2EP2jYsHBYB6tvDZOsrdOXrDvEWqwc0UOhpPvGRdlpVOm3tLDzJ/Uy0M2Bc
         Tw/LKzRglS/6DOMSbLnrW84NOHpElSNLeFGbJ0Cn8LNrgMNj0PjS+f+Hghz0TYtGi1t0
         e7nFFYVC2RbQn5qUSGoGpVAsjE9lgeyhN5Qw3YWquE2ySxBs0zO1dwRZmIa6P6H8U8Nd
         PkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unMMa9AN5ed7phn8mDqbTlDXTzG3IRr0dPibGYUg0h4=;
        b=RAuHDeg56F0ErgbZMGtfdZYsgt3H40gYmQrH4nLVLC2c4TEFB4r9e6L0tCCXnb6j1h
         jTCNr69fJpWrW0cI1XyOq/J6PlHCiMynu91CY3fKq2J1PxxxpndA/z8AxOuIhNyznEyF
         AjPOlVrjyJIwBsQH27ys+V7W66p8l/frEGDdFwxAViLmV2BQWbJm1UAAuHsUwIgjY47e
         CI3FWSJ3yZsO4VmaIjIySvpNYVWv1XZmSyM/ZGBECp9jMRD2/W+PRzKFYhOiqdW5cxio
         Y8dzOH2DCjMvBCQSiJUQARhCsnT31D07z0IsdJj0Az1Tx5ZqrPT+z9U3hneOBKa5acZw
         2lFw==
X-Gm-Message-State: AA+aEWZAyGfxDWh0Ur44fPOFMXUHVCKDAgJY3W1zldxR8ObrrV5cSpgP
        31XtUVUpeXpzTDQsmcbFR/Jzneu1m90j/1xX1IVc68hX
X-Google-Smtp-Source: AFSGD/UEE/iRbyw/QiyAA8jDWqmlMa9LKmKsGMEEy45co3upf+mgPR2avIAKCM6pbKoq1YoyDPuOjq8oGLFOGjL8H2s=
X-Received: by 2002:a1c:4108:: with SMTP id o8mr6986253wma.91.1543824761945;
 Mon, 03 Dec 2018 00:12:41 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181128080244eucas1p15d9478c4fdbb0609005a12d24703d6d8@eucas1p1.samsung.com>
 <1543392134-1443-1-git-send-email-huijin.park@samsung.com>
In-Reply-To: <1543392134-1443-1-git-send-email-huijin.park@samsung.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Mon, 3 Dec 2018 09:12:30 +0100
Message-ID: <CACna6rxstGQNmr-9Bi=BEcYgcXV9QqOiXLGfNFC4Y7DmFMVryw@mail.gmail.com>
Subject: Re: [PATCH v3] mtd: spi-nor: cast to u64 to avoid uint overflows
To:     huijin.park@samsung.com
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mtd@lists.infradead.org, bbanghj.park@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 at 09:03, Huijin Park <huijin.park@samsung.com> wrote:
> From: "huijin.park" <huijin.park@samsung.com>
>
> The "params->size" is defined as "u64".
> And "info->sector_size" and "info->n_sectors" are defined as
> unsigned int and u16.
> Thus, u64 data might have strange data(loss data) if the result
> overflows an unsigned int.
> This patch casts "info->sector_size" to an u64.
>
> Signed-off-by: huijin.park <huijin.park@samsung.com>

You may want to adjust your git's "user.name" config to avoid
"malforming" your name (From and Signed-off-by) in the further
contributions :)

Something like
git config --global user.name "John Foo"
