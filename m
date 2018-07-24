Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C60FECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BD920779
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcYqYn40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BD920779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbeGXDyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:54:19 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44222 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388367AbeGXDyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:54:19 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so1055643pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 19:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ojutq4boF5lIMHdQb0VP4xSF5l5ADzmGGpOJ1Jf1fRo=;
        b=TcYqYn40gOlcTmcz2Mp5EVm1Ziam3Y6+FFHI94iKNlCTqUEiM4zQ98TnTFqJ+NlXuQ
         rriX5uWQ3gFupyfz6My78QEFyuUlNg1o/BGJ1AqvfzJ3zzsOEzbbWx6aQs0gAw5nHnoX
         ufYL3noMxDPpaajOADOPcm0nRRC40EOW8a2VHU9BiyQUQHHe/oV0qWRBZ1ca3mO+Dm1H
         DN2QJ9PulOkC3Dsd+62G1GzVD9CYpSmIeTSS3W/GXBIU+kv0GeLXvkn5y/2nhf59H2Vs
         NYOfRazkyRYCLSL4rfgctuZd75vGDq0WyVi/8mqsOqIwW6/X08kQ/+TnrHeyefARvxPD
         bV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ojutq4boF5lIMHdQb0VP4xSF5l5ADzmGGpOJ1Jf1fRo=;
        b=PzoY6NJhnYxIkz+pL8Lv/7Xr4hTlJFnl429Pgl+n7rFKWiVnDTu7LlOtGoPmiJO8vI
         COqX6HK9yrtrO+2XNlB8PZnAN62wY9ywA4dB6F3C2+uQqy7ark+5iTAxjFFtE6Z1utwo
         38h/BkaoFz6LpWG0B5avxh9216pYj0I0xZqULFJZwD70V7OAlCilxPgMuzweZm131/Ml
         tAKo3WtliGJpSHRCQDXZBv5kcNi3jlnSfnGHvE88hsdY6K5i/zu06L8kdzmtiJ6iInOn
         DVowcrtk3PSgYDRpCpxoduiYySTKOEEu6jVHHO2MichmwDVgVeatbGyi8QfOeNXLC7T6
         cN/g==
X-Gm-Message-State: AOUpUlFXV3x4ZXn3AQKQkAoZ5zgsw53bpqlMyV6RxZnEODIut8Z5i/u1
        +nXA5MJOP9IBahdnJBGIY97oA6Uj
X-Google-Smtp-Source: AAOMgpeLHQ5n6L1npoBor8TQEjdwcuUhwA5dW2PRV/MPjzffLL8V/05Iu1cAf1fxFBcVVSYQVFVXIQ==
X-Received: by 2002:a17:902:102b:: with SMTP id b40-v6mr15215784pla.125.1532400607470;
        Mon, 23 Jul 2018 19:50:07 -0700 (PDT)
Received: from localhost ([39.7.53.222])
        by smtp.gmail.com with ESMTPSA id i186-v6sm14211746pfc.27.2018.07.23.19.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 19:50:06 -0700 (PDT)
Date:   Tue, 24 Jul 2018 11:53:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Tino Lehnig <tino.lehnig@contabo.de>, ngupta@vflare.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180724025330.GB558@jagdpanzerIV>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/24/18 10:03), Minchan Kim wrote:
> On Mon, Jul 23, 2018 at 02:29:32PM +0200, Tino Lehnig wrote:
> > Hello,
> > 
> > after enabling the writeback feature in zram, I encountered the kernel bug
> > below with heavy swap utilization. There is one specific workload that
> > triggers the bug reliably and that is running Windows in KVM while
> > overcommitting memory. The Windows VMs would fill all allocated memory with
> > zero pages while booting. A few seconds after the host hits zram swap, the
> > console on the host is flooded with the bug message. A few more seconds
> > later I also encountered filesystem errors on the host causing the root
> > filesystem to be mounted read-only. The filesystem errors do not occur when
> > leaving RAM available for the host OS by limiting physical memory of the
> > QEMU processes via cgroups.
> > 
> > I started three KVM instances with the following commands in my tests. Any
> > Windows ISO or disk image can be used. Less instances and smaller allocated
> > memory will also trigger the bug as long as swapping occurs. The type of
> > writeback device does not seem to matter. I have tried a SATA SSD and an
> > NVMe Optane drive so far. My test machine has 256 GB of RAM and one CPU. I
> > saw the same behavior on another machine with two CPUs and 128 GB of RAM.
> > 
> > The bug does not occur when using zram as swap without "backing_dev" being
> > set, but I had even more severe problems when running the same test on
> > Ubuntu Kernels 4.15 and 4.17. Regardless of the writeback feature being used
> > or not, the host would eventually lock up entirely when swap is in use on
> > zram. The lockups may not be related directly to zram though and were
> > apparently fixed in 4.18. I had absolutely no problems on Ubuntu Kernel 4.13
> > either, before the writeback feature was introduced.
> 
> We didn't release v4.18 yet. Could you say what kernel tree/what version
> you used?
> 
> Now I don't have enough time to dig in.
> 
> Sergey, I really appreciate if you could have availabe time to look into.
> Anyway, I could try to see it asap if Sergey is not available.
> No worry.

Interesting case.

Will take me several days to get to it.
Sorry, quite busy at the moment.

	-ss
