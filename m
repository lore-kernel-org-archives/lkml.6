Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99165C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A502081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A502081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeK2ImZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:42:25 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41328 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2ImY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:42:24 -0500
Received: by mail-qk1-f196.google.com with SMTP id 189so17759120qkj.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 13:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EiarKnn39NjVGvMXlH6qjFTx+j2qctE/BWf0hiux/C8=;
        b=XRAFLhVn2eUJJ3mMQmYNtg42i5LsaH76C3EBhjcsJwer4445hN4aPmLAeIZeyFVZxk
         AZmv75yUpwASfM08XGNsFQqEmZuRqa384LmvhIOxY5n/P8miBd/81GY2EMQChWbrIT8b
         yciJReGD/BZYDVD0p5C+0PGoha7astX8ydMxhb8wqFtstbtOyqHG6xdWlQgbJJZkiyr9
         U6R9kRWmGUdKVpysK3Vo50KbtsLiRX4QYW6gOLxpZMgSHOL7ZQNuZ4VkqpC2TY7bKDFQ
         2guhtkjPKnQFCC+ck08GCw6LSiqCxhugIo9E6YpqyVMalojETCbL10KCoEMzGYaSsyC0
         o0aQ==
X-Gm-Message-State: AA+aEWacWhm4QPAj5X4cje/THzoMZ5oRnnK6LfhxgB80374rl4qW/RVB
        3TtTr6FFtjYotZGusZHc3YGYpskWCfJdPs65aoE=
X-Google-Smtp-Source: AFSGD/XS7vQ9U+psp8ycxkRvP91DA15xOm/nhsAa8GjBeO5TCg+M/BtzpMRtO2p02WfMEjC01a1REZde6P6jAqbuYlU=
X-Received: by 2002:a37:a3c6:: with SMTP id m189mr35746213qke.173.1543441162850;
 Wed, 28 Nov 2018 13:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20181128175324.163202-1-lkundrak@v3.sk>
In-Reply-To: <20181128175324.163202-1-lkundrak@v3.sk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Nov 2018 22:39:06 +0100
Message-ID: <CAK8P3a0jN1PBy1oKHrx5abX4OKHVxjgevbUcXbUDPbU+VdvUPg@mail.gmail.com>
Subject: Re: [PATCH v4 0/20] MMP platform fixes
To:     lkundrak@v3.sk
Cc:     arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pavel Machek <pavel@ucw.cz>, quozl@laptop.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 6:53 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Hi,
>
> this series contains contains a bunch of MMP2 platform fixes.
>
> Previous spins of the patch set were sent out over the course of last
> three months to the MMP platform maintainers, with Arnd and
> linux-arm-kernel@lists.infradead.org on copy.
>
> Unfortunatelly, MMP maintainers (Eric Miao and Haojian Zhuang) don't
> seem to respond anymore. That's a shame, because the MMP2 support seems to
> in need for some love. The DT/multiplatform kernels can't even boot without
> 14/20, 15/20 and perhaps more.
>
> I'm wondering if this cat gen in via the arm-soc tree? Would it be
> appropriate if I followed up with a MAINTAINERS update in that case?

Yes, sounds good to me. I looked through the series again, and
found one patch that seems wrong to me. Everything else should
just go in.

Patches that are purely bugfixes should probably also get backported
to stable kernels, so please add a 'Cc: stable@vger.kernel.org' tag
in the changelog for things that are required to make older kernels
work correctly (as opposed to adding features that were never supposed
to work), and describe in the changelog which kernel versions should
see that backport.

> The patch set has been tested on an OLPC XO-1.75 laptop.

Excellent!

        Arnd
