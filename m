Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB7CECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7143020684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7143020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbeGSPSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:18:09 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:43460 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeGSPSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:18:09 -0400
Received: by mail-vk0-f68.google.com with SMTP id s17-v6so4481617vke.10;
        Thu, 19 Jul 2018 07:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlo8qoM312shHVkd7Ikm1w3cvRIYfoSUmH3Jx/YOBV4=;
        b=LxV9fMD6usJNzhsMe3R6tcYvfqV/MOP4W3Dgn3k0vMRhLq1mYt+InWInbwIZ4PNga/
         BKEPyPTBmaLPs+IbtdBQLe8T8Mkx1HZs+Q9Gm4FXDtFpIK4x7JQsuKQq2QIbytCSBMZf
         ZlLDSIDdvO6Oe8n3dLeta6qz23JpJyiDzoAVVc/rVtX6Gy/rI6ljmXk1ZYfozCLBs29v
         E07sKV5T3wDdln4wLr3NoLHyA6mputAU9/jW3PC9LaDkWzzvxnlqmBKctrhpURfc/xOw
         sc26H9tlOUHruhIJQcP18pXNL+OIFPWS24+2Yo8zsudtcGwBWbWJUEOIqKbrU31X3JPm
         xYBg==
X-Gm-Message-State: AOUpUlGXsEVw+nhqUh9JpMvRVqyPLVfCCJJsQ2KZ9+Y3HZoxCwBe4kOB
        KUzikn3Jb4lR/iTrNVs/A5pID7ElsK0RRzXQ0hQ=
X-Google-Smtp-Source: AAOMgpeeCDDMUuMuYmXkDIADCB/4ZPGNQmRYAk9CeI3C+DjHlZA2SBSOYUJbajuPhwMZlik/A5XrHCseBtcTzHCTO/A=
X-Received: by 2002:a1f:d507:: with SMTP id m7-v6mr5942301vkg.40.1532010881327;
 Thu, 19 Jul 2018 07:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl> <20180719114749.00a7f979@alans-desktop>
 <20180719142844.u3u4p7tywb54y4yd@angband.pl>
In-Reply-To: <20180719142844.u3u4p7tywb54y4yd@angband.pl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 Jul 2018 16:34:28 +0200
Message-ID: <CAMuHMdXGY9YMwXiEm=Jn=rv6WW0V9P0k7DFZ-5BE4Smu7YzMgg@mail.gmail.com>
Subject: Re: [PATCH 0/6] vt: no blinking on console, 256/24-bit color improvements
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Thu, Jul 19, 2018 at 4:29 PM Adam Borowski <kilobyte@angband.pl> wrote:
> And vgacon has code that looks like it can do CGA and MDA (redundant with
> mdacon?), either of which I haven't used in... quite a while.  Might be
> tricky getting access to such hardware to test...

Mdacon is meant to be used next to vgacon, for systems with both color and
monochrome graphics adapters.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
