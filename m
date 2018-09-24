Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5951C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7043E208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7043E208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeIYC12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:27:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45917 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeIYC11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:27:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id l2-v6so10961359qtr.12;
        Mon, 24 Sep 2018 13:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3N/nCDRH73L8Q8bibwNfpMawUciGcmS4jn4JU4wuLUU=;
        b=BwoMiuLs4hEuD9frA5TJABvHRdo9/f+yppI8nHqpkQHTr+IhFvMG3IqgEH4na9hOYq
         BjUZw5G2dGbZRONL47+Y1LbCfZeqO48K35ks/TjYKv9ms18qODIm/4i3zze0ITpjYguc
         gAJ/qJKaQdSLlet8Uy+VWHvzQjD5fMLdc93TmObe+99jBteeCAnNqDZgi3x7G64KVPUI
         PsFtxkO9sVK2zfIr4IwNaTJQeM+Bd/cWx8E912TPw0tA6HgHJj/KYc1WD/8OsHjJ/Gxo
         m/hMN4Np6NJd4+ICCSfi489k4lLWV7RIixcFbUpYPHpWAmlRocVBp35gDxc0Wbeif4h3
         CnEQ==
X-Gm-Message-State: ABuFfoihh/jaI714X318eCxvn0+ByMgVbVMYC5uSVMC9y3ar3jr/8j+d
        ft26jgA16E5dXo+ZGdMsooKjjkDGxpzMxnObgDc=
X-Google-Smtp-Source: ACcGV61du7O3LxVmM2F0XQXPaU2MMhki6fQkji8DAaDy1l48huBy3U2WHp0sIC1stNqXrVcTrOuccJftoXon7mJ5OL8=
X-Received: by 2002:ac8:7254:: with SMTP id l20-v6mr396396qtp.213.1537820610714;
 Mon, 24 Sep 2018 13:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537276837.git.ren_guo@c-sky.com> <ec95f397f52b8b5d9191b85d0d907a1a43d2e2c1.1537276837.git.ren_guo@c-sky.com>
In-Reply-To: <ec95f397f52b8b5d9191b85d0d907a1a43d2e2c1.1537276837.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Sep 2018 22:23:14 +0200
Message-ID: <CAK8P3a2WLCZNZ_A1qPQuEQdxEyLKZj2EY2oHzG+_GTGiWEna7w@mail.gmail.com>
Subject: Re: [PATCH V7 2/2] csky: remove irq_mapping from smp.c.
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 3:48 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
>  - remove irq_mapping from smp.c to irq-driver
>  - Add set_ipi_irq_mapping api to irq-driver
>  - update asm/smp.h
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

The patch seems ok to me, but please try to improve the changelog comments.
Generally speaking, use full English sentences instead of an enumerated list,
and explain what the change is for rather than what you are doing. The text
you have here can easily be derived from looking at the code changes,
but I still don't understand what caused you to change it, and why this
is better than the previous version.

       Arnd
