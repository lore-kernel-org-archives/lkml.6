Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CF6C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65072086B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXv73hN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65072086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932702AbeGCDeG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 23:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932301AbeGCDeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 23:34:04 -0400
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E40DE24EE3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jul 2018 03:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530588844;
        bh=6PZHqHwuOPTuln9V+I3wdJ3Zpqx7ws0aJZMENaOhU0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hXv73hN+io8IMpb1iikeHPOUWFZfrgLVwiEpDgW88bTWchgynr6bv4FSYvXzHRmY0
         M6V3x81XX5WDCN5x0nyBwenw4kufg8iMGsCB+ticAoaDkvbNvK6hsUxmGJa8GY/nIu
         erTPtutavUQKBoGKSEvC4f7hGaqLMrd0HxvoZpAw=
Received: by mail-wm0-f41.google.com with SMTP id b188-v6so666579wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 20:34:03 -0700 (PDT)
X-Gm-Message-State: APt69E04nVt2Snh/mcNcZ2/WSHFot2XhSPxz5zBW6qB3DxYGRDfohad7
        0JoMpgExdNa8p8Fxm2+RuvMaSTRflTEfpINrn7kF3w==
X-Google-Smtp-Source: AAOMgpcjjTruQaUIp9sQDOBDuV7/b+57ufAffloyfhQPQC4o9XfshiBNY8Y3mH5bsJ/+bdgb/3rRO5kDlXFO/Esh1KA=
X-Received: by 2002:a1c:c241:: with SMTP id s62-v6mr10101860wmf.146.1530588842371;
 Mon, 02 Jul 2018 20:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530465325.git.ren_guo@c-sky.com> <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
In-Reply-To: <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 Jul 2018 21:33:51 -0600
X-Gmail-Original-Message-ID: <CABGGiswb+SmdAi9qV80Yum3Uf=ohrSMpZKWkvJXK8n=GjTzxhQ@mail.gmail.com>
Message-ID: <CABGGiswb+SmdAi9qV80Yum3Uf=ohrSMpZKWkvJXK8n=GjTzxhQ@mail.gmail.com>
Subject: Re: [PATCH V2 01/19] csky: Build infrastructure
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

On Sun, Jul 1, 2018 at 11:36 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---

[...]

> +config CSKY_BUILTIN_DTB
> +       bool "Use kernel builtin dtb"
> +
> +config CSKY_BUILTIN_DTB_NAME
> +       string "kernel builtin dtb name"
> +       depends on CSKY_BUILTIN_DTB
> +endmenu

These options generally exist for backwards compatibility with legacy
bootloaders that don't support DT which shouldn't apply here given
this is a new arch. If we need this for other reasons, it should not
be an architecture specific option.

Rob
