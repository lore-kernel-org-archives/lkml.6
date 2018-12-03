Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA43C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8312082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8312082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeLCOTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:19:02 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46924 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeLCOTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:19:02 -0500
Received: by mail-vs1-f66.google.com with SMTP id r14so7541146vsc.13;
        Mon, 03 Dec 2018 06:17:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ma3SDM/49ZC0gaLNHmZjhPSDOBQ8r0eGGlSiQ5JO5tk=;
        b=a9eRFtdsiVmPqIlQw5Lut1D1aET/m3u2iy3GeTfe9eeHkioIRw8O72vlDPY8FKkZyF
         NEuZGY3VmKCCUgwkOsfHLvIgoW+jk6L/Nd7vQItgNpv8yIV7pN9A7piZ8VVfcV2BabJQ
         RZvTLxcxNAyk1/IOqCbsIq+ZsvZ6qIORojDrTcbq4+Pn5YVdZzJXXWZ6x8DMuldYXcZb
         T0ZibjupFkDEGCzlkF+fEGjqRnCFOC/UKscvQ6qCgH20gGIL02PbtvoFaZUbPWB+lvZC
         Bg3MKy+oT+P4ShMD6d4G8uRta1IA41RYiCUqi8eJkwLlYV0de3LdU078q9zatzUn+cu2
         KPfA==
X-Gm-Message-State: AA+aEWbdKWEf9it5Zw6sKjEbJIbJ/vJVtAqeksDAf/Wh9COjHqOaa/JT
        cW6Mv3FFIs4FZ4nWAnBxAeGgEfK0iHIfwsZgGEA=
X-Google-Smtp-Source: AFSGD/WEP/Q7jcp4q5EekwjaU7Yek3euXtz8jvyU/e9HY7512M86EfhdQvUFAXGpPjfZA7mX/AP5tikEukVrt6E8iNw=
X-Received: by 2002:a67:3885:: with SMTP id n5mr6061783vsi.96.1543846669975;
 Mon, 03 Dec 2018 06:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20181129111839.12879-1-geert+renesas@glider.be> <20181129142508.GJ3175@vkoul-mobl.Dlink>
In-Reply-To: <20181129142508.GJ3175@vkoul-mobl.Dlink>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Dec 2018 15:17:36 +0100
Message-ID: <CAMuHMdX_JS6Ak3jN2wBLTRe0tCY=bhRiU1gpMG_43A0B4uCebw@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: sh: Remove R-Mobile APE6 support
To:     Vinod <vkoul@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Dan Williams <dan.j.williams@intel.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, dmaengine@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Thu, Nov 29, 2018 at 3:25 PM Vinod Koul <vkoul@kernel.org> wrote:
> On 29-11-18, 12:18, Geert Uytterhoeven wrote:
> > Renesas R-Mobile APE6 support is currently unused:
> >   - DMA slaves were never enabled in r8a73a4.dtsi,
> >   - The driver relies on legacy filter matching and describing all
> >     slaves and MID/RIDs in a table, unlike modern DMA engine drivers for
> >     similar hardware like rcar-dmac,
> >   - The driver doesn't seem to work well.
> >
> > Remove the driver, it can be resurrected from git history when needed.
> >
> > As this was the last user of SH_DMAE_BASE on Renesas ARM SoCs, the
> > sh-dma-engine driver core is now used on SuperH only.
> >
> > Note that the DT bindings are still present, as r8a73a4.dtsi uses them.
>
> Sorry but this doesnt apply for me, can you please rebase on topic/sh
> and resend.

Sorry, will rebase and resend.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
