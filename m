Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id co05JsI6HluFNQAAmS7hNA
	; Mon, 11 Jun 2018 09:02:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 75819607A4; Mon, 11 Jun 2018 09:02:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4oY64Ld"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9442960385;
	Mon, 11 Jun 2018 09:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9442960385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932536AbeFKJC4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 05:02:56 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40152 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754024AbeFKJCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:02:54 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so29349070lfc.7;
        Mon, 11 Jun 2018 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EAidKCBZ+2a3EqXWgXbW+ePZySVlGnhaMBmN/EdlonQ=;
        b=C4oY64LdYBxusgaqA7r4Xl5ZdbT8FlhX1/1fLNDbeVA5QmMChkDU53Wkr72Q8hccCz
         A8a2X+r1fViqanHXM1zI4o9jj65C1b8048N7iFLse22k75kTUTlIPa6yLQUqiTlsDq/q
         a5r4pJbCdoKqyOcfLG76OOHW5+outAMR6R8l7RriOLoZhu722DYM4S3Cs8CUwWJ7wwDA
         GOLkHggPsogstvgvFwDt5M6WlEA7mSZbe53mY4sWkrXfwTjNcE8DR8JP5ywvURLrRmpR
         dtYrJr08iwPyRqy9ZJbOiJcTYZuxXKsM4iCHIz6Q9+8eZ/6UMYB/RBP6UAqOgDN6zL1j
         6VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EAidKCBZ+2a3EqXWgXbW+ePZySVlGnhaMBmN/EdlonQ=;
        b=FXEws7o91AcF+ym3xkZX2x9aizufJKw67r8jJ4O4TN0UUozltE3TOCrG1TEsJb0E5a
         Rgdb/TlVhHz2LAnj6Pl4TJ/N5igF0tp3DBdIekoGk2bQygs3StYCQmCisxI7F7VjoRd+
         rpdBJirC1MzTuGKlt/qPs65qIpOL4jzr4lGRkcxfxhB9tKjYYH3jUBcPnQE2CuBEcAng
         jipfWK5HY811lBVdQHTniAdg1gH7hD3VOgHNocLeVwgFtr6ZsiNVk5BDR4aEZIgW80nQ
         yX8NBn0nnGfL7t7Wcryb5fdzPM5H8nDeCgRXlzWhcouxTc5EUjPokmCdrM4gRiFlRFfl
         rQ8A==
X-Gm-Message-State: APt69E3hTAvfcWf61AGxi9054bhqqeA+52q01Woc1sOYq7p2ryTRa8ZQ
        Yp04we1DMfBv51QbO2ZsL9GiiCyHV7YQuVnRivg=
X-Google-Smtp-Source: ADUXVKIMIRkWNXt4W8iYgYKgIiuWHTTgU6VWAqXixtOF3o9jT0Do6gbMZP13Qp2n75uLDqEA8FTSqg8PPFfvoX5uUEY=
X-Received: by 2002:a19:1460:: with SMTP id k93-v6mr10353795lfi.23.1528707772836;
 Mon, 11 Jun 2018 02:02:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 02:02:52
 -0700 (PDT)
In-Reply-To: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Jun 2018 11:02:52 +0200
X-Google-Sender-Auth: Mxh_Sf2EJaB4_0zemth4sa32SM4
Message-ID: <CAK8P3a0CJmpf0L-OXDmqP=kRLGCokR=v6jUPaCSpnFuCwHa7WA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Legacy clock drivers: Normalize clk API
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
>         Hi all,
>
> When seeing commit bde4975310eb1982 ("net: stmmac: fix build failure due
> to missing COMMON_CLK dependency"), I wondered why this dependency is
> needed, as all implementations of the clock API should implement all
> required functionality, or provide dummies.
>
> It turns out there were still two implementations that lacked the
> clk_set_rate() function: Coldfire and AR7.
>
> This series contains three patches:
>   - The first two patches add dummies for clk_set_rate(),
>     clk_set_rate(), clk_set_parent(), and clk_get_parent() to the
>     Coldfire and AR7, like Arnd has done for other legacy clock
>     implementations a while ago.
>   - The second patch removes the COMMON_CLK dependency from the stmmac
>     network drivers again, as it is no longer needed.
>     Obviously this patch has a hard dependency on the first two patches.

Yes, good idea.

Acked-by: Arnd Bergmann <arnd@arnd.de>

One question: what happens on machines that don't support any CLK
interface, i.e.
that don't have any of COMMON_CLK/HAVE_CLK/CLKDEV_LOOKUP?

I guess those are already hopelessly broken for many drivers, right?

         Arnd
