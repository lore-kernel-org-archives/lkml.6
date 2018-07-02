Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69147C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268A325E25
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268A325E25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeGBNvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:51:49 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:41027 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752458AbeGBNvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:51:48 -0400
Received: by mail-ua0-f194.google.com with SMTP id t14-v6so3214834uao.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxHZCSAU+Ew/aRMI7JE7tn10LAUwhk6MHTQun1yhaCU=;
        b=FqkibmkGuH4FtIqePeKIX3LCLMHBotAtYQZDcivUvVzkrUnlrFKq5aBA/7MnQbVz7k
         RxK99wFlPqjvatcZrslYbkLu5wkzDCSfW6v43nfsbJjq/u/DdSbrfECvU94L/F/xsQFA
         DNQgafPMUXd4NXqgdo2egtB4U4B//4pXcHwA+SoKC1sLlS153FAGWswMo+wtXc6Ighqs
         AjynRoGf2C53gtPFiNHZisYzND/lm/YY3rioYN6d+D7h0W4lmsLmaQRv85egj0kPwJRK
         UbCBmPa9EyH2R9WHahSSYkPb17fFOe3dhBN5ho+Dbsb27stakQwOuo/q9q4Na3F3NAqA
         YZmg==
X-Gm-Message-State: APt69E11SMBol4vTYoJaYEJfVq1yu3o937Du2/U0FHtIguMmphRdG71x
        MLxo3xz1lhCGZmaIDABU4o5j8R7eMhxeuV5M7Sw99w==
X-Google-Smtp-Source: AAOMgpdocL3VUOfTYINS4A83VRsLJ9a8TwLduuBp345J4kaGgoWmHPFHK8KSWUQQCuFJe3T9a1vgejacLVRUGJMcqY0=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr15906299uae.12.1530539506410;
 Mon, 02 Jul 2018 06:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <53ce6de3ce0c030aaf5293fe40c4b3a7ae2b1664.1527232847.git.fthain@telegraphics.com.au>
In-Reply-To: <53ce6de3ce0c030aaf5293fe40c4b3a7ae2b1664.1527232847.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Jul 2018 15:51:34 +0200
Message-ID: <CAMuHMdWfkOdCF19dAmUm3c6U8TEyUtCF+95wSYM9XgqnBbbKpA@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Enable PDMA for PowerBook 500 series
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 9:34 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> I can confirm that mac_scsi PDMA now works on these machines.
> This increases sequential read throughput by a factor of 4.5.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks, applied and queued for v4.19.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
