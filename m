Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614A0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1790620833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1790620833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeIJQtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:49:53 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45830 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbeIJQtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:49:53 -0400
Received: by mail-ua1-f66.google.com with SMTP id q7-v6so17045800uam.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 04:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rC8OrIaxxR9IT1hUb2MIrIEZ6k43EfvfEnnvcXH4MNg=;
        b=dg1IwOZ6JPYCzowJbbp0Tn5dOSYEx/7TqI6UEIr+8zS8W08kxuS2YyHqDflqgSXwzx
         N/BvlhJSgXUFCVqfhnmisBtpXkW12AYd9K+f84rc+NPfRtr56U1tRED65r5p1LoyEbKw
         BXVcsBV5c6yWhozaAqLay880bri6mnbiNlM9yDXwsOqu0Y1Gz1WMfeAkB8d+ecQ9x/pF
         pY4pRzFV3wGkkq5sLlQ5jVIj9Jm9zVlIM1uzA5/vqv8XR3ytPyeaB5axPOVE/Ra2X5rd
         UHu4AGreFPG1Vi8Mn+zMXA2P2WNvWdf3SMv6aVeUQAD+bsUIUYtkf2i4gcCUxi+Ex4lS
         0Ipg==
X-Gm-Message-State: APzg51AONFnxuyPpCW/reDkbrKgeItP0fiQ2cgeORx4DcYvvKO/oUg9O
        rwsVXDvpsXh21btv1ma6L1Q9zYu56GMPnIIDrlfiH8V6
X-Google-Smtp-Source: ANB0VdaVSqe9ZoWedzr7S9wW90N6GpwbugnFVq5IUpDgMhQi9s+MsDsZib3kezrdqZxnM70CF8XJIT9sitUCJwVGeVk=
X-Received: by 2002:ab0:60ae:: with SMTP id f14-v6mr6782686uam.153.1536580569101;
 Mon, 10 Sep 2018 04:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180910115327.17344-1-geert@linux-m68k.org>
In-Reply-To: <20180910115327.17344-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Sep 2018 13:55:57 +0200
Message-ID: <CAMuHMdUPG=KTNK5GuGQyq5j22or_QmsPP0P03mdKemO1GxQVng@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.19-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 1:54 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.19-rc3[1] to v4.19-rc2[3], the summaries are:
>   - build errors: +1/-1

  + error: ene_ub6250.c: relocation truncated to fit:
R_NDS32_9_PCREL_RELA against `.text':  => (.text+0x284)

nds32le/nds32-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/11da3a7f84f19c26da6f86af878298694ede0804/ (all 240 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/57361846b52bc686112da6ca5368d11210796804/ (all 240 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
