Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA186C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F11204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F11204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbeLNKU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:20:28 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33729 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:20:28 -0500
Received: by mail-vs1-f68.google.com with SMTP id p74so3070582vsc.0;
        Fri, 14 Dec 2018 02:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HKJ43fUSffpqxJ3fvpXXSwfx1YXkqGzZ6wY2YAwuhY=;
        b=hgWc8A76YcbD1dDTYSFXPHF9fjMYLIixwvCD5NNb8Trj78ylIsLaoKfrkjIjtx8iW4
         IXkfrI14ifBXDmnLJpEc/MROV+x3LabgIze7Z7gqZj0nM7AtqItFmU38jaHQkRrgOTft
         kJrot3gR+PiKL5iTBBbmOC3Ijhk560J3M3JbilZvUdQSwCQPjYMnmY1hGy8FYawqm1P8
         9Q+szhqiXgQRWCo10JqJ/VGZS7vFxV1HLzR+ZkM9Gde4ZQrjtBIgM9vB2XswaYMVKuWr
         TPfgSAglDBLAom0ZnVAlNIuerM9HoVvrCZ9aqG6wNL5slrlchEy5S5E9TSYbNSxYwVSN
         OVLw==
X-Gm-Message-State: AA+aEWYA0WUxcVfv9cyi18V/R1guT5WjbYrYAGwswbyEnl+/2nkUSKWn
        ucGa3wnbbwGOZjngVZszChrxiE3Xc/SgaLHEquLS9Ev5
X-Google-Smtp-Source: AFSGD/UdR1tM0IEf+pFI+dENdZuhdQnKNWNLkXinoXr1AMR828mpORK5zokBRe/oG5gmZP/U/9w1dnvmmznumFOYQpU=
X-Received: by 2002:a67:d119:: with SMTP id u25mr928621vsi.63.1544782827369;
 Fri, 14 Dec 2018 02:20:27 -0800 (PST)
MIME-Version: 1.0
References: <1544732471-6730-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732471-6730-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:20:15 +0100
Message-ID: <CAMuHMdVtr5upiNK-B8T3kKqZPH4PQ_-ZpNB5Ut93rNOpXoZaug@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb-xhci: Add r8a774c0 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
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

On Thu, Dec 13, 2018 at 9:21 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Document RZ/G2E (R8A774C0) SoC bindings.
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
