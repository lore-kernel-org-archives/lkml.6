Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2Sq3AOc5HltpPAAAmS7hNA
	; Mon, 11 Jun 2018 08:59:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DC24B607E4; Mon, 11 Jun 2018 08:59:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcTfstZ0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 50969606FA;
	Mon, 11 Jun 2018 08:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50969606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932571AbeFKI7Q (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:59:16 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38767 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754024AbeFKI7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:59:14 -0400
Received: by mail-lf0-f67.google.com with SMTP id i83-v6so29334526lfh.5;
        Mon, 11 Jun 2018 01:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cmHOackrM7toBNxodTtQKxAuxRZbvGgu0kQ/oXiC7HA=;
        b=HcTfstZ0QzMYkABaR5IYWQtcK17fKZMVCVMCU+hSzEsZDa2bbTDSvbVxmkVQ/4BP3u
         qySTxiPJJXQCJtnbLcBbduRIwRNPJOz8vjpTUUH56lY6W7xcwVMDvRVjj4SlvTLTP/bd
         ULHKMkus7ZLYLB+TPdU/kVljJEuo+WDVKXVjjDNfy+6z29HURjdC8AvUghmKsltWlwGX
         F7tIjUXIfgE24kNhLPWSOS3L+owNX3boO5fK0Re3k9ll52qcRiJSP83AZBlxRhyJQVGs
         9OUt0Qx+TZbw0V6J7ubAJXGH8iHw0ni5MzGBCmx93NRiDLxAXNQEmM4c5fmHKM67BlZi
         7lSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cmHOackrM7toBNxodTtQKxAuxRZbvGgu0kQ/oXiC7HA=;
        b=ke2BBdhl8NQMKRJ3DMh8ZxuywN74frpGkgfvndFHNfso7nGmKs9JyWl+P5Aw4gUXVC
         XOId9Eg9fEhz31Km0K0SWmxib6igRetlI7Dd9T7CJ/bS3cfilDOI6FsLROnuqecPuJpM
         7iAPPEiImMjXEVefvzeyfPuOlKeBSlRS4nt+z0MHOjH7vq/Xnmr+9w/cT+2GFlTzrQG3
         7cz2GcV25BSf15gG0HD428V14xGlh3P76mEiGbYPQmc9y9EXipoeFtVu0oh1XiharqT2
         JKf2sOD8PNvX9MgdTyBv5n1Mmrdet6CqmT/HTIa6Sjcl9z/Zr4ZNbeZdxEQv9thkHLat
         EheQ==
X-Gm-Message-State: APt69E3XgKqh6eBd6hl6pa8/B3c3D3V2MXoEk3DgGt93XW24JkB3orHV
        ALrxKxtEgN53mHBjwiCGKnQ4S3CrVlx6FwZu9CA=
X-Google-Smtp-Source: ADUXVKJ070nYlgsetMLgCQk9en45kpPhF58MvywStrrgxcutJ/36ZN8glV8ZS2xkywOtuZpmE3LzidZyWCStaLGY43g=
X-Received: by 2002:a19:c203:: with SMTP id l3-v6mr10330051lfc.55.1528707553231;
 Mon, 11 Jun 2018 01:59:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 01:59:12
 -0700 (PDT)
In-Reply-To: <1528706663-20670-4-git-send-email-geert@linux-m68k.org>
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org> <1528706663-20670-4-git-send-email-geert@linux-m68k.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Jun 2018 10:59:12 +0200
X-Google-Sender-Auth: JgdAQOxMhwOi7TXc4PgGGtPeZBE
Message-ID: <CAK8P3a1mhVJYuQGZM+ypQ1mKbB=+5gA6L=_D7-jjPmShLarwUQ@mail.gmail.com>
Subject: Re: [PATCH 3/3 RFC] Revert "net: stmmac: fix build failure due to
 missing COMMON_CLK dependency"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 10:44 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> This reverts commit bde4975310eb1982bd0bbff673989052d92fd481.
>
> All legacy clock implementations now implement clk_set_rate() (Some
> implementations may be dummies, though).
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Marked "RFC", as this depends on "m68k: coldfire: Normalize clk API" and
> "MIPS: AR7: Normalize clk API".

This seems reasonable. It's possible that it will cause regressions because the
COMMON_CLK dependency hides another dependency on something else
that not everything implements, but we should fix that properly if that happens.

       Arnd
