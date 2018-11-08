Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36526ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9E82081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmYgiH+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9E82081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeKIFg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:36:57 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45663 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeKIFg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:36:57 -0500
Received: by mail-qk1-f195.google.com with SMTP id d135so28686860qkc.12;
        Thu, 08 Nov 2018 11:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7nxuk2zm5TDF9NN8vf6fh1V0f7WqweHa5hK7Gjr+y2w=;
        b=gmYgiH+RbeI26vTpj1FWu0qt+Na4/9IjNCULu5Qci1toHq+b/scJVLJ4oeJsWTwQOo
         Ad7ZCkGJuVv+rpHKZJST1Jhz1iI9bideEB2lZpZTta7TGyPzAuGr4TPmgD6PG5xJMB4n
         IHwgbi4QoqBW/IgqITG9qhHccTi6Php7ZcLBxdQH+EZkx8dDg6OzQplKC8JyRIiwLd1O
         u/gLH25TJqJFMG58uzaPjnVlojpDXfOSK7SDKmzpzcsXS3TRyMP+oOECK4+gKjxeEbNv
         dmRxg2176bJxFnb1Oq9V7NA4of3ByIie024Bj1yKM0xhi/Hv0VMOZ6evAgEOO6Jp1znI
         ANvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7nxuk2zm5TDF9NN8vf6fh1V0f7WqweHa5hK7Gjr+y2w=;
        b=ukX5F928vtZ8zYJRjeKH91J/rnXI6M+q/DahosPz4L7lPMf2W9MJJl9iFBpIEOWyT7
         zzzyK+aLCQo6fVXoU6v5/imm3p+5tFsRjy/PVxVxGL7Y0o1r0WNeWz2lS6s5ZWabjsbh
         0/H7TNjBtTVY7Eh89SQ7+9wxO4Ruxu8OD0K2Eloyj5jiKV5Vsb2p6m7n04scj+p5BIRo
         YKtaCZBHfrr138h09fxktOOaQoIJS8z1HI9yowTpREOm2/YmXxHMGoJXvE+OHWuWYIuQ
         n7vD7HdykRjS8tk2FRZ0QDXZXnWs+3rRudCK6XAWqlXhBpQpFHwPUKc4hz77UMcOkWiF
         ybdg==
X-Gm-Message-State: AGRZ1gKqNIucJMen55ynEWTJgpSssMq2DDNKXvc1Xb7PxbtpoVK03JRy
        H+flZi+LWekGgI+zWKK4JDoJVyEMKgiHQ6hLafo=
X-Google-Smtp-Source: AJdET5cyqOImAP7hZKIRVxHyrXDkTn7FJONMKvyaIcTWXOjAIocBXaxMsRg8wlnPmsSq7aM0worEutErGdCSgGWeZ5g=
X-Received: by 2002:aed:2d42:: with SMTP id h60mr6015623qtd.373.1541707196337;
 Thu, 08 Nov 2018 11:59:56 -0800 (PST)
MIME-Version: 1.0
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
In-Reply-To: <20181108171701.4444-1-ayman.bagabas@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Nov 2018 21:59:45 +0200
Message-ID: <CAHp75VdW-yRDuUd9kvHuV=2AHodpt5Nm1Oo18=FtVEHXrCGkOA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Huawei laptops
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 7:17 PM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:

Is it supposed to go via PDx86 or ALSA tree?

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
> This enables the micmute LED on Huawei laptops using ACPI calls.
>
> Ayman Bagabas (3):
>   x86: add support for Huawei WMI hotkeys.
>   ALSA: hda: fix front speakers on Huawei MBXP.
>   ALSA: hda: add support for Huawei WMI micmute LED
>
>  drivers/platform/x86/Kconfig                 |  11 +
>  drivers/platform/x86/Makefile                |   1 +
>  drivers/platform/x86/huawei_wmi.c            | 236 +++++++++++++++++++
>  include/linux/platform_data/x86/huawei_wmi.h |   9 +
>  sound/pci/hda/huawei_wmi_helper.c            |  47 ++++
>  sound/pci/hda/patch_realtek.c                |  29 +++
>  6 files changed, 333 insertions(+)
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
