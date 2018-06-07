Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1+GpOLuLGVvWXwAAmS7hNA
	; Thu, 07 Jun 2018 19:49:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 11AD36074D; Thu,  7 Jun 2018 19:49:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up8QIp4E"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 01B20601B4;
	Thu,  7 Jun 2018 19:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01B20601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753635AbeFGTs6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:48:58 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39561 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753153AbeFGTs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:48:56 -0400
Received: by mail-ua0-f193.google.com with SMTP id n4-v6so7319752uad.6;
        Thu, 07 Jun 2018 12:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6iVdwMODDYxCPWnz1mz71FYCerkdjueIFvUKz4N82OE=;
        b=Up8QIp4Eg4worbtvpuRxPfzji1/0ZFjyrw54SFoY410eD42NB3f3IBOYiKz/rY/eiA
         F+xmtu8Vil2yFhVaKgSnCXlnnYoDCdjoWLd+5fgZ6AGHubXQlje2GLsdjElVtf9/u4U3
         k2Z0P1i4BM5s1fUIlypA0RBkwzejJ2XydoSxMdYjTnRLcAz2vaEqpN9o6GspUVWYeRZJ
         hrPtTwqKBYyw+K7rgWDo3R9NJV/WQf90iqKDXntJ2Tay76fFA2ObpnsYy+k8w4VCKtuZ
         G6jntkuj7lI7XGcbP9PnNwYexIT78sDWyW+o9pSSIREGekAQ22xN47ECQ/4gPpXnDdsE
         6X2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6iVdwMODDYxCPWnz1mz71FYCerkdjueIFvUKz4N82OE=;
        b=DTyZ8d2yfHvJfpjSVn3yE8YhWeFUPtIUmjfGOqwG1zxAyFlYeBXg+R1rF78vor2d8p
         NES6WuKUS5Y+hVWu2D1KL5nkBt9Euetj+l8n+GKimN+tgSDLNEizkztRzf1apwtEDe3y
         GyNakIf+OW0iqvMN3xzwDDAT015mF97lefWRTcXsOIGIibxN7ZFIEVjWG7yOC7d9LxZ5
         20iSHhOKCwCvegqalYNlaYl6+5jmyjLVUIOMd3MamihacRpQkTxAA3CmD4a4mhQQHT2Q
         v0BlxPQLc8PGVfpznAvirD0x2OY73j0KaiCOVDTF3+DVc5jyMJ5up7boZvZTUvlKCjh7
         47mg==
X-Gm-Message-State: APt69E01TmnqVXw+8tCktTPxMV/Ih0IR/rnGn1u2RViH9d0pKGktX1iz
        EEVop1R3XTpzd4UM0zmbt2+3/X8t8MgZ3N4di5PacwkC
X-Google-Smtp-Source: ADUXVKJiKhj+UxqUgwt6fsokc9GmrOdJy6C/Kj6xyXSwNKDw/7fTTEpfDSR2l63H5UoijKpPuXHlVMnaajMpcA8yLMk=
X-Received: by 2002:ab0:5105:: with SMTP id e5-v6mr2341065uaa.33.1528400935666;
 Thu, 07 Jun 2018 12:48:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8596:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 12:48:54 -0700 (PDT)
In-Reply-To: <1528400696-32609-1-git-send-email-clabbe@baylibre.com>
References: <1528400696-32609-1-git-send-email-clabbe@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Jun 2018 21:48:54 +0200
X-Google-Sender-Auth: frY_J00Ibx1yechPVgNdYix7gUo
Message-ID: <CAMuHMdV1Utg+UgdRE1k9wL10r4P-rN6C7v9i2WcYxPMyH4J6ww@mail.gmail.com>
Subject: Re: [PATCH] iommu/shmobile: Remove unused include/linux/platform_data/sh_ipmmu.h
 header
To: Corentin Labbe <clabbe@baylibre.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <jroedel@suse.de>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 9:44 PM, Corentin Labbe <clabbe@baylibre.com> wrote:
> include/linux/platform_data/sh_ipmmu.h is unused since commit ae50dc4874c5 ("iommu/shmobile: Remove unused Renesas IPMMU/IPMMUI")
> Let's remove it.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
