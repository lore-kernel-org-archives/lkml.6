Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A1FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8F223C97
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2gJS5NGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8F223C97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932624AbeGCDQn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 23:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932493AbeGCDQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 23:16:41 -0400
Received: from mail-wr0-f178.google.com (mail-wr0-f178.google.com [209.85.128.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 438CB24FA5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jul 2018 03:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530587800;
        bh=08qVetWNtLm9ellgVhEwtLkNRGUFNl9XrQHnbfrBwjc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2gJS5NGltNuiJUkOF8osQfUdxjGPvBJ6rWy4DnMYf25xsWy2ET3ke8VrJTWutlvAJ
         sW1KOzzVmWBR99EvYRU6/xc+oauqeF+LGR9NTCkkrYrVUjUVfd3Yb6hMmoyRWdozNc
         sxrhTgqn9To1VTOfXBuGP4+dHPRjRetkOQbbLkwE=
Received: by mail-wr0-f178.google.com with SMTP id j33-v6so362689wrj.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 20:16:40 -0700 (PDT)
X-Gm-Message-State: APt69E0I13IjR0ICpcABGI6oqCxJ4gmnOxfUujj07JxTAVaXUN+h2q94
        qt8TdXrSIa26PiOwaOeUjM5RfxfiEFPHvUHAwb+7qQ==
X-Google-Smtp-Source: AAOMgpfESnX8kvDO8qJP63yFSKdQurOVcz+kREaLqOW6BEq4fnn9aaJ0SygM6kbw4Y2u1w9IExt7XT4ySTPV5VVrbXc=
X-Received: by 2002:adf:8597:: with SMTP id 23-v6mr19946028wrt.31.1530587798645;
 Mon, 02 Jul 2018 20:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530465325.git.ren_guo@c-sky.com> <8c855b4a175fffcb5c897865b7e3d2fe754f0099.1530465326.git.ren_guo@c-sky.com>
In-Reply-To: <8c855b4a175fffcb5c897865b7e3d2fe754f0099.1530465326.git.ren_guo@c-sky.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 Jul 2018 21:16:27 -0600
X-Gmail-Original-Message-ID: <CABGGisyOSc+Mh3rrEwazgayue7hqZtNuAxRt112VAhDTTEeDrQ@mail.gmail.com>
Message-ID: <CABGGisyOSc+Mh3rrEwazgayue7hqZtNuAxRt112VAhDTTEeDrQ@mail.gmail.com>
Subject: Re: [PATCH V2 02/19] csky: defconfig
To:     ren_guo@c-sky.com
Cc:     linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 11:34 AM Guo Ren <ren_guo@c-sky.com> wrote:
>

Needs a commit msg. Perhaps some overview of what's in each config.

> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  arch/csky/configs/gx66xx_defconfig     | 549 +++++++++++++++++++++++++++++++++
>  arch/csky/configs/qemu_ck807_defconfig | 541 ++++++++++++++++++++++++++++++++
>  2 files changed, 1090 insertions(+)
>  create mode 100644 arch/csky/configs/gx66xx_defconfig
>  create mode 100644 arch/csky/configs/qemu_ck807_defconfig

Are these configs mutually exclusive? We try to have one kernel build
serve many platforms. So you'd probably want to divide things between
the 2 ABIs.

It looks like you still have lots of options enabled that I wouldn't
expect you to need. Start with something more minimal for what you
need to boot and support upstream.

For a full config, you can use allmodconfig at least to build test.

Rob
