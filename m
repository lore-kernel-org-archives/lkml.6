Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9442BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EEC20833
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EEC20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeH1R0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:26:54 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44890 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeH1R0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:26:53 -0400
Received: by mail-ua1-f68.google.com with SMTP id m11-v6so974226uao.11;
        Tue, 28 Aug 2018 06:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b43UYqg7TSsqYI6cn7PWfPDzTQe4AeB2N8ldZ16qUj4=;
        b=pziMrzEYs9kWv+I8FBQMby5slBtOpduhBJrPJr6jXcG/NN4jjBEG4b5ysUw/lCQ/rm
         QHMCfqjfFqdK+AlzobgtqppNtz50jHtqyJx9Us1Tleub4eCDiJ8MMZ3uuYVy1g6TnlXG
         UHITngTsERMQGkX3MrGFIAHEYWKH7lOj4ppM+PVesTnl8BWIrgCD5mRL54ZueuymwItf
         0WucnY/Bd10xsa/zdf+Wpog2Xed7zg3Fwg9f7PgSXZtPSISVrjTAgyfZ5tFqRqlU7oHm
         TvLq0xDq3gCdgA+lS6QoACA9nvSN5JAd60d2pTGeKyzGZm0+3Q55lxzRl5UXbcVACCO8
         3Q1Q==
X-Gm-Message-State: APzg51AAOtjnTjABFSM9BvKfthI5a5OyglN8raSzzvB9I4bVo2XrFn7N
        +6b2P3yBkvHB/7a90dlIcKbrqLFt/j6V5jQyk1c=
X-Google-Smtp-Source: ANB0VdalVg0cDTATIuvHNPv7J0q0TGpzj9mtw5WCrh0fpMO4GnZZ8lWhvVWKFV+eMx6WsJUj7wcJH7IgX3m7CHNIlhk=
X-Received: by 2002:ab0:a85:: with SMTP id d5-v6mr1021413uak.130.1535463289807;
 Tue, 28 Aug 2018 06:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180817103913.52544928@canb.auug.org.au> <CAMuHMdUQcoMxb=0_i1PYyymUpQ1VBOub+EgDbRJWmrq8_xJ-uQ@mail.gmail.com>
 <20180821183012.3b9bc4f3@canb.auug.org.au>
In-Reply-To: <20180821183012.3b9bc4f3@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Aug 2018 15:34:38 +0200
Message-ID: <CAMuHMdU2dK10m2c2b3w6+-6KDr-L5MejJbvo6Y2urj1j-TA7+w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mfd tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        rf@opensource.cirrus.com,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Aug 21, 2018 at 10:31 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Tue, 21 Aug 2018 10:08:54 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > To obey sorting rules, the CIRRUS LOGIC entry should be before the CLANG
> > entry.
> > Upon closer look, it should be inserted before the CISCO entries, too (in
> > the mfd tree).
>
> Thanks for noticing.  Unfortunately it is badly ordered in Linus' tree
> now as well.  Feel like sending him a patch?

Your wish is my command; sent.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
