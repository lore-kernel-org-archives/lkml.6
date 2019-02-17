Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F247C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F094D2195D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NNwIoUyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfBQRY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 12:24:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32965 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfBQRY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 12:24:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id q12so10622029lfm.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 09:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2rY+Pt2bwMEKaVDZ5OrtGryLVkghE/muQQRunt0OsI=;
        b=NNwIoUyP9v0RXhoUf5sao2KYm4BabCU8PVmaY0Xtyj+UJNG1oGBlywTvwim90CigsK
         5OC3rI79l1j6WGj7cYz8U5mxcs6VXOG/DGcjkYxCaV+sDI2RbyZVaeaVuqgKTQz22zxC
         dKG23Lij0GcIWZJybiA+hJYYLvHQfQqC1fggo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2rY+Pt2bwMEKaVDZ5OrtGryLVkghE/muQQRunt0OsI=;
        b=keT1YRCpuzO7arQGKhQmEBNEs6MDsD7eO4vrxzQSoC+pF9ahU3RlGKrHgqM2Qwkh8m
         VEbnHBYs7DDskheyC1D5wtwIrzmE55QeY/DidHPhE1vDgC0Jmv9lEuR2CAuVOmgpj33y
         DJNbD6MlsIeCZsEOPK/OxOf63IqxUp/b7u2zKpphRPoVB5OFhRlNYhT4i0pcQU2Y2s94
         nhGU5g6zNscT4Hf/ZwPjI103L+bGLP9jq4D8pXO5pMN9K2U+43Qaplp9MsaGnAO7MO5U
         1l8SiE5Uxht0eXP9FA+GhQ61D8tZ5217vXKbZjjvZYzv24P1GS7QrkIL13LyrO9KN30u
         2gkg==
X-Gm-Message-State: AHQUAuaRO8wNo23psOpxsfCp3ekKPQVMLXA4ZtKH67Q3a2a+8FiY+h5W
        sp3eKkm5zpmGUK+smBdZcsR3fV4K//4=
X-Google-Smtp-Source: AHgI3IZLYHk3zTpH3MG1BRiow9TkZnlwCbeBirWvOgMcJz1nHXfBdMEAK4MqMIDAi3LZkb5Qui926g==
X-Received: by 2002:a19:384c:: with SMTP id d12mr11000443lfj.105.1550424264990;
        Sun, 17 Feb 2019 09:24:24 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id r11sm2969823ljb.29.2019.02.17.09.24.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 09:24:24 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id v16so12293168ljg.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 09:24:23 -0800 (PST)
X-Received: by 2002:a2e:9117:: with SMTP id m23mr9819677ljg.94.1550424263253;
 Sun, 17 Feb 2019 09:24:23 -0800 (PST)
MIME-Version: 1.0
References: <20190217105926.GA69415@gmail.com>
In-Reply-To: <20190217105926.GA69415@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Feb 2019 09:24:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=ooh9chSKyLipU6+eFbdfc680PUn3uKEoxLAMDMyMgg@mail.gmail.com>
Message-ID: <CAHk-=wi=ooh9chSKyLipU6+eFbdfc680PUn3uKEoxLAMDMyMgg@mail.gmail.com>
Subject: Re: [RFC GIT PULL] EFI fixes, memblock quirk
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Tejun Heo <tj@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Tang Chen <tangchen@cn.fujitsu.com>,
        Alexander Kuleshov <kuleshovmail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 2:59 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> I marked it RFC: please have a second look at the mm/memblock.c change,
> which adds a INIT_MEMBLOCK_RESERVED_REGIONS detour that ARM64 takes for
> these systems.

It's not pretty, but it looks minimal for now. Pulled.

> Perhaps we should upgrade the build time sizing of all platforms to
> INIT_MEMBLOCK_REGIONS+NR_CPUS+1 and thus centrally give an extra
> allocation entry per CPU configured?
>
> Or is there some cleaner solution?

Is there some reason other platforms might want that kind of thing?
If not, then the current hack seems sufficient.

                    Linus
