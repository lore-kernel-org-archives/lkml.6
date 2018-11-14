Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B05EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AB622419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFtqJwG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AB622419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbeKOCF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:05:29 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45789 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeKOCF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:05:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id d135so26610921qkc.12;
        Wed, 14 Nov 2018 08:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36YaUMQkMgQoLbMgaGpQgaDBjRzVVOMGuDvfuO46hg8=;
        b=AFtqJwG48Clw+ap5F3QcJ0MUwdTP/xtit3YWx2NHEbL48jjpWBdX0ZUODpQrI4WZT1
         eQzuOp6zZbo/FRcYiSqG89dCC05wE18Op/kgtb5BT68I0GAnOSrOtbh/jMWGI2Rrd6xP
         1PAH4SYovaf6Jv5cFnoaKA6DF3yQ7wzxLbaThFKcGm+QDMkpqmIFnkXALhgwzRmUlfVE
         mgbvpoEk/+oZp512n9ltKNLh+PJ6CB1Ff8hI+L09WNmorHJQOoxnpbgf+Bf/n8dQlevy
         r6mhYjyTKiMKLiJWV9miWLJP1zkdOGS3zrR9IWn67wmKi7z71BZQnU1L0vlgCSS7NYRU
         vymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36YaUMQkMgQoLbMgaGpQgaDBjRzVVOMGuDvfuO46hg8=;
        b=ar11BsHiF6U4z7icxxzxEhtTrDLXWTHFDWUQuo9aOEwpDtUhJzHNcEWf/X+oKWlpsf
         Qxis2u3iVfGB1n0PpTubCbJ98DkCZpSynkM3ixCCz57zSJQt3zimnsq4bUbbgVVs1NIH
         oIEHyCkqNmeYQq404JGmORjdXrL4WFqp6N1qG4LIhD92kdqDpjJLFuNMGHy0uJXtsRoN
         /4AUHdUEozDx8Eab+5NP5gBjda6iq24xx/Mzcua85FpRo2qJ8R9wqgZpUqZdiVKQWFe0
         y/86ZJzwdPEoy1GHEcmGJeB1FlP3ZQPfzkgJtmNRmfQV+x6TBhCTgHCLg4ENRIULZXE2
         G91Q==
X-Gm-Message-State: AGRZ1gJuF9+eeNaaZu6f5PBQIBv5XUGaIdtuBvDNViU0b8I/geP8AtAY
        eeARA254FBM5JN21SlCUZbma/hfQaHOEXZB65w0=
X-Google-Smtp-Source: AJdET5caXJWHMcco9cGy+E+g2k57SJgoqxQlGcQuB63ZWZPj9xH4CtZnxdGkxAQGj8ErED7CrqqaygBlNDLNf+OBQZI=
X-Received: by 2002:aed:3e49:: with SMTP id m9mr2106196qtf.99.1542211298869;
 Wed, 14 Nov 2018 08:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20181114152602.7842-1-ayman.bagabas@gmail.com>
In-Reply-To: <20181114152602.7842-1-ayman.bagabas@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Nov 2018 18:01:27 +0200
Message-ID: <CAHp75VdpL7uVmBvu=PEHuvtRrjg_yTgr8mG9UhAk=kJYV_-+Cg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Huawei laptops
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

On Wed, Nov 14, 2018 at 5:26 PM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
>

Pushed to my review and testing queue, thanks!

> Changes from v5:
> * Review tags
>
> Changes from v4:
> * Consistency in file names
> * How module would be enabled (Kconfig)
> * Match license in SPDX and MODULE_LICENSE
>
> Changes from v3:
> * Code formatting
>
> Changes from v2:
> * Support for Huawei MBX
> * Style and formatting issues
>
> [PATCH 1/3]
> The first patch adds support for missing hotkeys on some models.
>
> [PATCH 2/3]
> This one enables the front speakers on the Huawei Matebook X Pro (MBXP). This
> solves bug 200501 https://bugzilla.kernel.org/show_bug.cgi?id=200501
> It simply uses the pins configurations generated by hdajackretast using the
> settings posted on the bug page https://imgur.com/a/N1xsCVZ
>
> [PATCH 3/3]
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
>  drivers/platform/x86/huawei-wmi.c            | 215 +++++++++++++++++++
>  include/linux/platform_data/x86/huawei-wmi.h |   9 +
>  sound/pci/hda/huawei_wmi_helper.c            |  47 ++++
>  sound/pci/hda/patch_realtek.c                |  30 +++
>  6 files changed, 312 insertions(+)
>  create mode 100644 drivers/platform/x86/huawei-wmi.c
>  create mode 100644 include/linux/platform_data/x86/huawei-wmi.h
>  create mode 100644 sound/pci/hda/huawei_wmi_helper.c
>
> --
> 2.17.2
>


-- 
With Best Regards,
Andy Shevchenko
