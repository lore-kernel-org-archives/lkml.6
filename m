Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214FEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E645F20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E645F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeLCKMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:12:12 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40129 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCKMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:12:12 -0500
Received: by mail-ed1-f66.google.com with SMTP id d3so10193939edx.7;
        Mon, 03 Dec 2018 02:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRjBFh85MQbS2a8FAsvDnRi2kJOiNyC74NfxuA+bUGk=;
        b=aEuMmeu37H+hO6pMcNOJSXyTJw3WwfbkI582SRHVpSkkOJE0BeDvgOdv7z/I7FoTZD
         jXP4f0T3DEAHsXp8dY7vvAsY712N8GBZ8sOAlyF17oLMjL6K9yyVFOPOrH/wgOugjgAD
         5xT0+PsW6pjBGEbzYQ3E0/5+ScoqmbkDNxrqllOhWqdS9gqda5ELng5bHaUjEIsApo1K
         IME1agsUp/HONDvgLuk7CnQuwQ+boQZI1UuZXiKGlzNzLTj/41XBSV0ZXlfkXdM67ZNU
         GmX0+78eAMY8HcEZlxjJbPsFZPyxkll10eEEkeZzf3I3i74oI8Y+SFnu6vMsoHEkFq70
         yzAw==
X-Gm-Message-State: AA+aEWYfRHxiAYzLfcGE1dx5jEKc1mW696pfYo4cWxdYxm5hzSs8BGsp
        fKX+yaxm/EkaXvVAyPHj8lD6y2Oc/9c=
X-Google-Smtp-Source: AFSGD/WS6UtQYxyrYwCszrNIDcub8DWok6uyNg4mPPqHQkfSSe70HTpU4ybkPC5LNAaoa016xPss+Q==
X-Received: by 2002:a17:906:4b19:: with SMTP id y25-v6mr12271927eju.89.1543831908110;
        Mon, 03 Dec 2018 02:11:48 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id t21-v6sm2144574ejk.33.2018.12.03.02.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:11:47 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id j10so11462053wru.4;
        Mon, 03 Dec 2018 02:11:47 -0800 (PST)
X-Received: by 2002:a5d:5208:: with SMTP id j8mr13937441wrv.188.1543831907353;
 Mon, 03 Dec 2018 02:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20181203100747.16442-1-jagan@amarulasolutions.com> <20181203100747.16442-3-jagan@amarulasolutions.com>
In-Reply-To: <20181203100747.16442-3-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 3 Dec 2018 18:11:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v66pG0kes1_xBNUj4z85fjunjP_Fe5_pPiRja=nDSOS01A@mail.gmail.com>
Message-ID: <CAGb2v66pG0kes1_xBNUj4z85fjunjP_Fe5_pPiRja=nDSOS01A@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: media: sun6i: Add vcc-csi supply property
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 6:08 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Most of the Allwinner A64 CSI controllers are supply with
> VCC-PE pin. which need to supply for some of the boards to
> trigger the power.
>
> So, document the supply property as vcc-csi so-that the required
> board can eable it via device tree.
>
> Used vcc-csi instead of vcc-pe to have better naming convention
> wrt other controller pin supplies.

This is not related to the CSI controller. It belongs in the pin
controller, but that has its own set of problems like possible
circular dependencies.

ChenYu
