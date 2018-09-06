Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F940C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481B820861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481B820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeIFNTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:19:49 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42929 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeIFNTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:19:48 -0400
Received: by mail-vk0-f66.google.com with SMTP id t4-v6so3739541vke.9;
        Thu, 06 Sep 2018 01:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rvi+IOYTWdzdAFkFyjButdHcycnCfJqn6e62GKz58UE=;
        b=lrtVgiSPR5OFSgnDv0P2rRwvpXks//5JlYTXOn4CfZtlxVcTrsBHulh3Mf3MxEPsM1
         ZQ5IK286ZRytWXsRw50YzfUSVAP31T3olNtN+oP/MkOPaInwUHScHbIxQXDey35E8aMW
         B0Q3TQukdx+bU8E6187K168x5/Ig+FKH5mODprAaTUjDFLc2O863j0d3qswqutFVr2Ry
         4t60SjSG1S3w6I6uEXCE3Q1RGpFGq3GRK0aJXsapWHdPDYBD+pn532u8FK9+UN+rOyEH
         YIob13KADcleDIl63sUsxciume6tUltY0saULlaj6rSKsBA9IG+I79XJCTQQpV0urYTy
         GGeg==
X-Gm-Message-State: APzg51CoGYk2ETYdJpAXNeZOmivWjtp2Xp46g2WONAdq7dZSnnLWJLw1
        uw+A0VlSiddRQGZw+DnnWwjsdT3Et7SlnrreN/bFN8ZQ
X-Google-Smtp-Source: ANB0VdZKXBL0wt2LGiUU1CroI+xQ8sDgpPrDWOoRIXJ5aWg0a0nv+pen0t/ZKP+kzR0rbc+PVQ3kC4gBeKQB4AYEV4U=
X-Received: by 2002:a1f:dd47:: with SMTP id u68-v6mr496215vkg.137.1536223526241;
 Thu, 06 Sep 2018 01:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180905193738.19325-1-robh@kernel.org> <20180905193738.19325-2-robh@kernel.org>
In-Reply-To: <20180905193738.19325-2-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Sep 2018 10:45:14 +0200
Message-ID: <CAMuHMdVQxpkzMMu1-4Bkph=YsXQKFeEHK4WccEzSzHvX=1CH6Q@mail.gmail.com>
Subject: Re: [PATCH 01/21] of: Add cpu node iterator for_each_of_cpu_node()
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 9:38 PM Rob Herring <robh@kernel.org> wrote:
> Iterating thru cpu nodes is a common pattern. Create a common iterator
> which can find child nodes either by node name or device_type == cpu.
> Using the former will allow for eventually dropping device_type
> properties which are deprecated for FDT.
>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
