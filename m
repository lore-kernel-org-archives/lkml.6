Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9617CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E5420685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E5420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502575AbeKWUHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:07:44 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44407 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390277AbeKWUHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:07:44 -0500
Received: by mail-ua1-f66.google.com with SMTP id d19so3884895uaq.11;
        Fri, 23 Nov 2018 01:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAkH23pW7+AfSbhWWADJVAy650w8gpxO+QF3gbCPnP8=;
        b=cS9v9C0iZZQdIPVzCNme/mGqF/+LjuTOilXMCVoOt+W7ByScm0z5pqLNNHnpANVMTx
         gOL2cC4mFX5jNWRYRVXd9bDAD3yIOAj039WlpkItlkt1/nlQFICg3oYfBMhL6TsGeuYU
         aCN/VXUCMs3wyinwD/ZHB+Mbz7SZNuMTXaIU37QUamyo3WjQ1Hc9+/Mq+fafIFjyZ3z1
         JCqtKTdTrZ2/7mQH/J3sfM7sTPRhTGyLfSTtE/3YxqdGmrhGfSqfzFvbhmlxy7+0X7s0
         7P8HZLs1GH9qmtWlI1vEujJ89bBOpJyMbqsntDXGEM5vd9oDEZ7cJu0qCM08EFHHpeQ+
         KtcA==
X-Gm-Message-State: AA+aEWZ0MTNLFKjuhG8c5FM3Ldvub5YqwspVHETXVM9AsGXrxrhb6+7V
        u++CR7bI8wJoAA09lmp5GKgNcGGKpuuB1MdQSSGWyc3IwuE=
X-Google-Smtp-Source: AFSGD/U0AEibpMPp8V/RDz9vOn8K+7AMB2YKvdOIjg3RFY3E9kTYLIIB5nTF/fOGvP1zzsX+yL5S0GRAeknrjBbS2zk=
X-Received: by 2002:ab0:465:: with SMTP id 92mr6241179uav.28.1542965057958;
 Fri, 23 Nov 2018 01:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20181121100844.25825-1-phil.edworthy@renesas.com>
In-Reply-To: <20181121100844.25825-1-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Nov 2018 10:24:06 +0100
Message-ID: <CAMuHMdUH74QA5oSuOe9LgoS08-CEHiGSz_FzPQs6S9BzCijDag@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: r9a06g032: Correct the GIC DT node name
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:10 AM Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> Harmless mistake, but it's incorrect. The DT spec provides recommendations
> for the node names:
> "The name of a node should be somewhat generic, reflecting the function
> of the device and not its precise programming model. If appropriate, the
> name should be one of the following choices:
> ...
> interrupt-controller"
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
