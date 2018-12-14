Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CC6C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0412F20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0412F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbeLNKnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:43:47 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33178 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:43:46 -0500
Received: by mail-ua1-f67.google.com with SMTP id t8so1833136uap.0;
        Fri, 14 Dec 2018 02:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EIlpDjNkO1FvGu7OExjNLb1VWVRQCC01/i4xxUfLIVo=;
        b=dGpZnblxylzPshJs5Y7o7fyRljReDcZPBfJyR74MjRKBzwj1MdKA07ppwJPsb3v8Qd
         1xlyp8prDpINHgTrPmb/GTtOmmqwwpBJvB18yXkFfKZ1Dp15Mk7Ec1cG69XAo4uj5cZY
         EAVH84r8mplT3Gl70AmeQzkQp8P4CK91iYsKQir5X22psSeJUELGCFR1CPO1v02P9Mmj
         7ygl1XIHm38TS0PKX5cFCtdhoh5FqZw54nkQb9qmUDVaJJ7NRuCz2AbYoPaxBxnKpYM9
         ddbiIB2Y7ZpplO5btgqOmHZgC37x5H04AfT20b6XG/TqijbT+dkAgW3syTxFgdtnCbwJ
         FZ3g==
X-Gm-Message-State: AA+aEWaAYaJLxRg+VoCJFic6B0B2Es84jOzRzIx4mCQSBAqyuT+KESUL
        WuHu3+ey1Gsya802JJD6Wldp+VCens4IrRoFP0c=
X-Google-Smtp-Source: AFSGD/UvVMy1r/yJpma9TNmMFA4I9X9vuNGXHgMXh9Iy/NsiTNQVz9XjPEKcaun16ydrsxLN7CuVeGmuFd7zZ5WVEKM=
X-Received: by 2002:ab0:465:: with SMTP id 92mr1070263uav.28.1544784225804;
 Fri, 14 Dec 2018 02:43:45 -0800 (PST)
MIME-Version: 1.0
References: <1544732590-7230-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732590-7230-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:43:33 +0100
Message-ID: <CAMuHMdWt3wBeg2khe5kcyG4V=ZW4ME-vktAHwK0fXgwDmREnxg@mail.gmail.com>
Subject: Re: [PATCH] thermal: rcar_thermal: add R8A774C0 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 9:23 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Add thermal support for the RZ/G2E SoC (a.k.a. R8A774C0).
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
