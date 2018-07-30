Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF21C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5DE20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5DE20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeG3JAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:00:08 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:40970 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeG3JAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:00:07 -0400
Received: by mail-vk0-f67.google.com with SMTP id o82-v6so5229955vko.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 00:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQBHvpUZ+n/b757N+CpbRXlN5Zmy62ISgOom1+KyhHc=;
        b=ptNDP6G7gjXXZ5NeM/QaJTOWXD7ZgWoK01dVyiiOX8f+uLEwEkGSOGN6yrzj8WuN8c
         BzjSL056dzeJ9UC1vOLeF8SMG6bAWkMUZho+J+W0MBIl0CfQFBpzwhcT1dGJbJ2yZ85U
         NpVFBwayMrddvlxqy/J1cQaQ/vAAo9pq4O3cVguOhQd9S5Ow8MYwnDEj0RrumnyFJ11g
         izEmGY8f3tpUMpeXxHe/Z5XviAQgGKO/j7VmJ5a5MdsnueGBX1wc86wV1CUJfrHMWwix
         qortW2OsPLrd9G5WWOOKiYr3DQUyH5che8tq433FspLd+9rkfQPWJufDLoiOkwfF+9lc
         uG1A==
X-Gm-Message-State: AOUpUlG4XjYJeyAxYoP0qBAWoTvHlxXw06Kci4dPDOfWgVZeo5MA9uJ8
        v74wo2nFYbN+IlEyTs88zWDwg8JggDSMVJeGp5o=
X-Google-Smtp-Source: AAOMgpfddda031vPgN/Mrr2Lbf1WrVG0ZVB3lAIG91mD9EcPwoMokDLODAtvEKY9cYfc8Ov8RzhftDVC1PNE/EMvp+Q=
X-Received: by 2002:a1f:8948:: with SMTP id l69-v6mr10215150vkd.132.1532935589272;
 Mon, 30 Jul 2018 00:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530519301.git.fthain@telegraphics.com.au> <03e778fa5a025ac72f6d11c519939c5f8dbc6b8c.1530519301.git.fthain@telegraphics.com.au>
In-Reply-To: <03e778fa5a025ac72f6d11c519939c5f8dbc6b8c.1530519301.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Jul 2018 09:26:17 +0200
Message-ID: <CAMuHMdU_7V0n6HCNR87pmxYSMJxC=WpbtChpdzT2DQi3VWBZ7Q@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] macintosh/via-pmu: Replace via-pmu68k driver
 with via-pmu driver
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 10:21 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Now that the PowerMac via-pmu driver supports m68k PowerBooks,
> switch over to that driver and remove the via-pmu68k driver.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
