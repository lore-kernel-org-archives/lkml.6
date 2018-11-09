Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C699DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDDA20818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOkXXRBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDDA20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeKINRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 08:17:31 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:32835 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeKINRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 08:17:31 -0500
Received: by mail-vs1-f66.google.com with SMTP id p74so289891vsc.0;
        Thu, 08 Nov 2018 19:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gJGY3tMz5UmZFHbnuWC+rm3bs5Qoe82/kPj1/mytR6s=;
        b=kOkXXRBYWfeGN3r+ts1IJMONEZqMuc9lNCWwyC0cE3c3MZsCK9rUoaKmpXkujH4YLn
         TNTkrosFpvDhcrAw6wXJ7QajjYIclCaYfrEkmziHOlVs9DwArN26DLQmWrTEGdLj8sEe
         0M6jBz+nAy0mZFDuHi4dutttC6uSYgnGpzz/fUJR9CPR7kdnJlBtmQFJpQAzGxloZpvL
         km6IfhdG8uRvd/k0GZ6cNPyH3/O+/HoZONCB6nQh0n1oE8nRm2O7WsO7SaJcBKDVVL8D
         f/nEVEyoyE1bwpNt0tX4BbVj0u/tgO0EoSoxEsDdEW1OGOJ7m4aGdVSI4GRW0XXz2UrQ
         7zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gJGY3tMz5UmZFHbnuWC+rm3bs5Qoe82/kPj1/mytR6s=;
        b=Yfh/R1LeHyQO7zIlB0Ff5U23ELu1wuoLEzeTyfmyxQscerhIZ8lin7khW77ayJMn5h
         DoncCNf6VHWU3emqgC1X8QhUFsu7POU+2PB83A0TSKnL9FSiC0/kQ9n0KjAW+p8MFnhW
         4B2NA9LQHxcydELPE5P6bDmjR/oMv+8LQbvRuolI5aiYUE4BflTsUTwr4t1svMY13L5f
         LVQcSZgqjcApfUUjfoNtao/d6GZEVtFsG+iSGUD/7TW+5awj+vuj707XaS9V3zXIg1Gb
         qOIZWdnuZPSGBftmC1v32DeIFd/qB5R/6tJv2dE2C8/fR3bXoBHTtm7aii/3EblyotJG
         Tztg==
X-Gm-Message-State: AGRZ1gJqZKWimjyQnTG2HuCBVUJJOpjtdmmPCo/bLZFsOz/fSD9CZFGG
        SC71qcjPcfnlTFoW5W7IxA==
X-Google-Smtp-Source: AJdET5dHJFLahRHFL5nMRHX7TylGd4i7Hkxhw8653eYdYr7CdvD0i16fHdt77WHy2ycCWRO6em9M0A==
X-Received: by 2002:a67:768b:: with SMTP id r133mr3124651vsc.35.1541734730067;
        Thu, 08 Nov 2018 19:38:50 -0800 (PST)
Received: from 960.ws ([2601:902:c200:6512:a7fd:514d:7aab:c075])
        by smtp.gmail.com with ESMTPSA id j133sm1632138vkc.24.2018.11.08.19.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 19:38:49 -0800 (PST)
Message-ID: <0ff07717127d3f3a065c559ad737efcd47dbd75d.camel@gmail.com>
Subject: Re: [PATCH v3 0/3] Huawei laptops
From:   ayman.bagabas@gmail.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Date:   Thu, 08 Nov 2018 22:38:47 -0500
In-Reply-To: <CAHp75VdW-yRDuUd9kvHuV=2AHodpt5Nm1Oo18=FtVEHXrCGkOA@mail.gmail.com>
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
         <CAHp75VdW-yRDuUd9kvHuV=2AHodpt5Nm1Oo18=FtVEHXrCGkOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-08 at 21:59 +0200, Andy Shevchenko wrote:
> On Thu, Nov 8, 2018 at 7:17 PM Ayman Bagabas <ayman.bagabas@gmail.com
> > wrote:
> 
> Is it supposed to go via PDx86 or ALSA tree?

There isn't much of work done on behave of ALSA. So PDx86?

> 
> > Changes from v2:
> > * Support for Huawei MBX
> > * Style and formating issues
> > 
> > [PATCH v3 1/3]
> > The first patch adds support for missing hotkeys on some models.
> > 
> > [PATCH v3 2/3]
> > This one enables the front speakers on the Huawei Matebook X Pro
> > (MBXP). This
> > solves bug 200501 
> > https://bugzilla.kernel.org/show_bug.cgi?id=200501
> > It simply uses the pins configurations generated by hdajackretast
> > using the
> > settings posted on the bug page https://imgur.com/a/N1xsCVZ
> > 
> > [PATCH v3 3/3]
> > This enables the micmute LED on Huawei laptops using ACPI calls.
> > 
> > Ayman Bagabas (3):
> >   x86: add support for Huawei WMI hotkeys.
> >   ALSA: hda: fix front speakers on Huawei MBXP.
> >   ALSA: hda: add support for Huawei WMI micmute LED
> > 
> >  drivers/platform/x86/Kconfig                 |  11 +
> >  drivers/platform/x86/Makefile                |   1 +
> >  drivers/platform/x86/huawei_wmi.c            | 236
> > +++++++++++++++++++
> >  include/linux/platform_data/x86/huawei_wmi.h |   9 +
> >  sound/pci/hda/huawei_wmi_helper.c            |  47 ++++
> >  sound/pci/hda/patch_realtek.c                |  29 +++
> >  6 files changed, 333 insertions(+)
> >  create mode 100644 drivers/platform/x86/huawei_wmi.c
> >  create mode 100644 include/linux/platform_data/x86/huawei_wmi.h
> >  create mode 100644 sound/pci/hda/huawei_wmi_helper.c
> > 
> > --
> > 2.17.2
> > 
> 
> 

