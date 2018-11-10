Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC381C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E14C2081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRCSltaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E14C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeKKAES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:04:18 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43827 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbeKKAES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:04:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id r71so6543155qkr.10;
        Sat, 10 Nov 2018 06:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KS2tKNqBu+LC859Gf5UxwSe78RxJXOIfqSVvT4fP/Zg=;
        b=FRCSltazBCAw6z8psM54LqQg3S7bMwLa1CveA+KWdTxbApUMbwnqru4ryGsF0uEQmn
         lJZVUsdfiCAMvusLV+tRv5lbFl+n3AswNfps1DqTx61QUF/6LLl+0ggjRaBMlQQb5UVQ
         S/5KFDie8eeqOFgv/bBlH/86X9og04sbYlByTBPYhrq/CqF4qAGS9fP2Ghy6zwB6i2sG
         lgVhn9lby5Rx/AQTsHwdPloIwnFgVUI2arY7TUOr7ffA+lF0ZcIf6kDOO3xNFrJ9H9G3
         41mNKWvw3/tU9qX9HuU1Ijhw/GNISkbVx8VY39J1fgyXM+3r86WJRfwyWFdQUdFTver9
         p/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KS2tKNqBu+LC859Gf5UxwSe78RxJXOIfqSVvT4fP/Zg=;
        b=BnkzqiIF9l5575xxRDhW8c3AEpIpyPvTtImba5o8MBtF2BIkijWIntmsQNIym+9TXj
         8OHiC9o6TwYwhauynq+Tjc4/iBJcjn0UjttpcF6qmmBHHxXKZhALoOzUiQ+A8oxixn/c
         SKxcLtD+4o8sBAc2Rqkq6ayMb1dyuYCF6EUaRhsbSV+s7sPWSQyz+XohwlfhgtZvPw62
         1d0vb/bUJR64PRrr8Og0ubhfMzGS398+WRg4DRphZ91q67l+FeNfCYpenSv1r1QIpaiz
         W/BJRFt7fNuT4WG3O/U4NqImLCGdlD3bdVvVT9SpgoamiLACQ1DE1yewJamTVCdG7in6
         vaHw==
X-Gm-Message-State: AGRZ1gIWf6pl/2Eue0f+Rm0e6Ur/Xpldr5VZ4dlfVUPjTWMbYbb+RjKC
        /7xcqBw4Ud1e5VqXk6Sk56WUIaww8L753TglNiS0Xd/O
X-Google-Smtp-Source: AJdET5em0paCGuugzN5aQmsScmXp972xzyANmNu61DV+KhdlC1xIlBbVGtS0L3/Cqs7pZ4tcC0Zhfr7hADixO9jXX5w=
X-Received: by 2002:a37:7983:: with SMTP id u125-v6mr11451434qkc.219.1541859547767;
 Sat, 10 Nov 2018 06:19:07 -0800 (PST)
MIME-Version: 1.0
References: <20181109234526.4280-1-ayman.bagabas@gmail.com> <CAHp75VfcaacZvqUiKiP1XWAy4cNsXMajFgy6PbEz_QhxBtZGew@mail.gmail.com>
In-Reply-To: <CAHp75VfcaacZvqUiKiP1XWAy4cNsXMajFgy6PbEz_QhxBtZGew@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 10 Nov 2018 16:18:56 +0200
Message-ID: <CAHp75Vf7_=zLjUmRPWJPP4TMG0s177Dhw5zc6ewz20iZJkhf2A@mail.gmail.com>
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

On Sat, Nov 10, 2018 at 4:17 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Nov 10, 2018 at 1:45 AM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
> >
>
> Thanks for an updated version.
>
> I have pushed this to my review and testing queue, however, I would
> wait till Taskashi ACKs the last two patches in the series.


> Meanwhile you may rename the files to follow the pattern (<VENDOR>-wmi.c etc).

To clarify, I'm talking here of the files regarding to PDx86. Whatever
scheme is used in ALSA I don't care.

> > Changes from v3:
> > * Code formatting
> >
> > Changes from v2:
> > * Support for Huawei MBX
> > * Style and formating issues
> >
> > [PATCH v3 1/3]
> > The first patch adds support for missing hotkeys on some models.
> >
> > [PATCH v3 2/3]
> > This one enables the front speakers on the Huawei Matebook X Pro (MBXP). This
> > solves bug 200501 https://bugzilla.kernel.org/show_bug.cgi?id=200501
> > It simply uses the pins configurations generated by hdajackretast using the
> > settings posted on the bug page https://imgur.com/a/N1xsCVZ
> >
> > [PATCH v3 3/3]
> > This enables the micmute LED on Huawei laptops with these IDs:
> > 1. Matebook X (19e5:3200)
> > 2. Matebook X (19e5:3201)
> > 3. Matebook X Pro (19e5:3204)
> >
> >
> > Ayman Bagabas (3):
> >   x86: add support for Huawei WMI hotkeys.
> >   ALSA: hda: fix front speakers on Huawei MBXP.
> >   ALSA: hda: add support for Huawei WMI micmute LED
> >
> >  drivers/platform/x86/Kconfig                 |  10 +
> >  drivers/platform/x86/Makefile                |   1 +
> >  drivers/platform/x86/huawei_wmi.c            | 215 +++++++++++++++++++
> >  include/linux/platform_data/x86/huawei_wmi.h |   9 +
> >  sound/pci/hda/huawei_wmi_helper.c            |  47 ++++
> >  sound/pci/hda/patch_realtek.c                |  30 +++
> >  6 files changed, 312 insertions(+)
> >  create mode 100644 drivers/platform/x86/huawei_wmi.c
> >  create mode 100644 include/linux/platform_data/x86/huawei_wmi.h
> >  create mode 100644 sound/pci/hda/huawei_wmi_helper.c
> >
> > --
> > 2.17.2
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
