Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ABFC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48CC2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48CC2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbeLNKDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:03:14 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41368 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNKDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:03:14 -0500
Received: by mail-vs1-f67.google.com with SMTP id t17so3010271vsc.8;
        Fri, 14 Dec 2018 02:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fiVlcOzIYJeohesd+fVoDMKCy35RcoPGUP6SkNauWYE=;
        b=G/QsKJbIzu5t8hSLjz278m/j2UDvoBpeK6vgG7L2bKc+eiqjcacyqJeCqZ5hK5z/tD
         31tHVloLpYJONaq1KUYnxEejnZ0ok5Pd4MPyJllO2p/qWf69H4Oiq1yJf8t6gE/j4/9s
         ERCNIy0UZTDypBiDBrG9Ka7UOwiHAJ2tpvSIxTbpdy3Lth1iPx/ugzndZk2kY6wu6xl6
         wMlgiFuP+KD8UnNIck1cJc7w00ZfJ5Q0ik9yD/4wfe3iDuTqCE7Bq+uJko2XB+++gNkO
         r/91oC0A8GbBbbfMVh+crpkWl8QV9QS26UNod9wtsFc64E44DDrye54RtPRRBS1rq7jb
         pUfg==
X-Gm-Message-State: AA+aEWZscX6pj4xRNTzCAiO0ETiuEOZr6EX4yOSQxNboYjtw3zZSmIHq
        0ZG8lkpibHiT4g+GJLXhuNfu6xIfK4TjBHtEAXA=
X-Google-Smtp-Source: AFSGD/UlUzzoLBJVHKVKdHjjhX6951hUGN9flNT8+HpBila9DfU+Jc91Ds+vowhs04K3pqLgGEUqCFkGKA1o5k41R6E=
X-Received: by 2002:a67:d119:: with SMTP id u25mr908111vsi.63.1544781793013;
 Fri, 14 Dec 2018 02:03:13 -0800 (PST)
MIME-Version: 1.0
References: <1544732263-5859-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732263-5859-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:03:00 +0100
Message-ID: <CAMuHMdUeZWmtdqRx+BuwXV++1SMqvoB_NJ7L4gBBQ5W+zyHgBA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: rcar-dmac: Document R8A774C0 bindings
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
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

On Thu, Dec 13, 2018 at 9:17 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Renesas' RZ/G2E (R8A774C0) SoC has DMA controllers compatible
> with this driver, therefore document RZ/G2E specific bindings.
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
