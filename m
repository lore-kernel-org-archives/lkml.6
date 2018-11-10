Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8E0C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2832081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD2pXWTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2832081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeKKADQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:03:16 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46128 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbeKKADP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:03:15 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so6547671qkf.13;
        Sat, 10 Nov 2018 06:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eC9a3Xn6pHkzpSlpOo7urCeicD9+9lI9g/5Tn9ege/8=;
        b=MD2pXWTC/9qVjeLPjz9dcB0wjpHy5DykynU/Y+L1N1UcsOJpEkuFypNdm2OUBjLsCD
         CydsTLFcnmqiaV7e31KOft7m9T4WiGwwT8T09thCIwseUkpllQZN1LR+MMomJLF59qWL
         4PRUBpLB/sQ+ra6jct1wGBgk5EXpqifQwhsdg7zbywODuZcyFdkNMlmAh48bINQFVhHE
         7l+gfiFqpa1IW2MtnTHHh+XSqg8HX5F4Z8Mzr1649c2Eyj3tLOjNgRHVQAV2sCFztEwy
         vMGNrDVq5hTgKzk6ioHQsbAnK0UmsS+qImCfhOn3a2PPyeoAU17MhII8djhZ1FZp2vVm
         ir5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eC9a3Xn6pHkzpSlpOo7urCeicD9+9lI9g/5Tn9ege/8=;
        b=ZWaRf4H58PvzpJNFsKGCy5U3jW5V5NYiPk1hxUPfagNHNPb56S+Gua8aYV14IknVs/
         u3QGYEjKBm1d0PfptIgMWKjF4Cv1higB6HYhbSKoAtrJPNqyz5vJWV4mZDO0UrU3pP3U
         oExyc+eOdzJd8Aj/OKadAOqE31NhM4yGca7Ot3yngOymH0TTfIdWy3GnJErc1XKKY/j2
         B5gvY+bwQyTWUjE5mZpoS3Y5eapiFlHGP2Z0xlL4R+jLG6htCKMyr5xzym59jTSvF/FD
         y/mN3AM6Y5Dvj8cJt28UKjxpHFi27qE4ClR0/VEf1VMLQGvS4cTwm8mZkAo6/S3fW2o5
         HZkw==
X-Gm-Message-State: AGRZ1gJ5CcDYWvShZAjQFu1sfaeZHm+81EVIFlnJ9uF62wMtaeDU2HzP
        /inCsF3IXIW/3mQuXzmLG1YEks4ndjPTrnYb4ml5xsCN
X-Google-Smtp-Source: AJdET5faRQKSpA0F6YSReNPXvXyTlOaJxll80U+d+VZJ7WEROQg7qci6QDmdr+d9fC4yAelhC/AIh6qYzTQ0W5MRUVg=
X-Received: by 2002:a0c:f74c:: with SMTP id e12mr12734381qvo.26.1541859485468;
 Sat, 10 Nov 2018 06:18:05 -0800 (PST)
MIME-Version: 1.0
References: <20181109234526.4280-1-ayman.bagabas@gmail.com>
In-Reply-To: <20181109234526.4280-1-ayman.bagabas@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 10 Nov 2018 16:17:53 +0200
Message-ID: <CAHp75VfcaacZvqUiKiP1XWAy4cNsXMajFgy6PbEz_QhxBtZGew@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Huawei laptops
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 1:45 AM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
>

Thanks for an updated version.

I have pushed this to my review and testing queue, however, I would
wait till Taskashi ACKs the last two patches in the series.
Meanwhile you may rename the files to follow the pattern (<VENDOR>-wmi.c etc).

> Changes from v3:
> * Code formatting
>
> Changes from v2:
> * Support for Huawei MBX
> * Style and formating issues
>
> [PATCH v3 1/3]
> The first patch adds support for missing hotkeys on some models.
>
> [PATCH v3 2/3]
> This one enables the front speakers on the Huawei Matebook X Pro (MBXP). This
> solves bug 200501 https://bugzilla.kernel.org/show_bug.cgi?id=200501
> It simply uses the pins configurations generated by hdajackretast using the
> settings posted on the bug page https://imgur.com/a/N1xsCVZ
>
> [PATCH v3 3/3]
> This enables the micmute LED on Huawei laptops with these IDs:
> 1. Matebook X (19e5:3200)
> 2. Matebook X (19e5:3201)
> 3. Matebook X Pro (19e5:3204)
>
>
> Ayman Bagabas (3):
>   x86: add support for Huawei WMI hotkeys.
>   ALSA: hda: fix front speakers on Huawei MBXP.
>   ALSA: hda: add support for Huawei WMI micmute LED
>
>  drivers/platform/x86/Kconfig                 |  10 +
>  drivers/platform/x86/Makefile                |   1 +
>  drivers/platform/x86/huawei_wmi.c            | 215 +++++++++++++++++++
>  include/linux/platform_data/x86/huawei_wmi.h |   9 +
>  sound/pci/hda/huawei_wmi_helper.c            |  47 ++++
>  sound/pci/hda/patch_realtek.c                |  30 +++
>  6 files changed, 312 insertions(+)
>  create mode 100644 drivers/platform/x86/huawei_wmi.c
>  create mode 100644 include/linux/platform_data/x86/huawei_wmi.h
>  create mode 100644 sound/pci/hda/huawei_wmi_helper.c
>
> --
> 2.17.2
>


-- 
With Best Regards,
Andy Shevchenko
