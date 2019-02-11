Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F61C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C093920844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHUuqiOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfBKLuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:50:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35263 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfBKLuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:50:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so4857861pgs.2;
        Mon, 11 Feb 2019 03:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XU49PgCv4RL4RMGCazRuBER6V4Ggwit8dUrBrWUroqw=;
        b=HHUuqiOoeKfoeVO8hnOkhpT2F59MwVnqpiM0JPJqy0sQSc1oh42kbDF8hYsYrUiBtB
         XeQCa3FVpxXLYDvsCVjSSDMK30H9q44SfaZjkv+Vkw1AcV1KsUPaLC5Ag1Dfwh/k5San
         whtnTjPHtudE6bfNBbIx0wULGYNx/qbf7yk5C8XviNl69N00lArSfEOR9BdgpZrXtix6
         zEGT27c5wYbexzHGULnj1yKeE9QPJWO9KniqBU+0PC7jnZjeNFJPR2nbzipjGmVnq6Cd
         iifuHgUWB9LL8nRJIe1RPCKhmzxcHwXgo+Auxg6EPo8kfRaM5nUgf8mFLeRwyBQ78e/Q
         6FBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XU49PgCv4RL4RMGCazRuBER6V4Ggwit8dUrBrWUroqw=;
        b=mXWxhaqd0LtgfPkw6YyscdwpqUHp7bZ0XG/9YLoEiqlmoWzrWCauCkezz3vk5engDV
         GjxTL0D8EIvpQo9BAqJyB0IL5WzV5ey9Gm7u/lweN2EJjGeVTwzW+xr16FFi9m6DtEgv
         9xqwxm8gyC0+N3NkbaiN3t1qcYduKr1F5g3NJhdcrwFo6b3cid+p/vuj8xxuG4WQ4jNo
         g14994XQcGbcYBXejrnUo/HyKqpW/L3/xrxp8VK99fsjrvLbC9SsUT2r2n7YCrggMNqZ
         ZKTQX0bN3dimwMlJ5R9XVF11p5oD1Etu11JQ2WcU11bqY+hNjmGRMsZtSNYxNeUGtoUv
         I5ww==
X-Gm-Message-State: AHQUAuZlAFDA2Gd3z3YhBxO1zYnF+weaRMWBtGDaZWs7Y2U+7oSgYOoc
        X9lZoN+p60XzikRAdWDjZ96mbehSQuDFrZ2eITsopw9A
X-Google-Smtp-Source: AHgI3Ia6ajnFnMVIOuZweBtgscHaivYNLDJxZeSjYG5wtTZaM9lvactiu9hk+HNCEQeXuJfaFx+dhqHw3ig2QRQQNh4=
X-Received: by 2002:a62:5e41:: with SMTP id s62mr35994658pfb.232.1549885806138;
 Mon, 11 Feb 2019 03:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20190110175845.1203986-1-lkundrak@v3.sk> <16ce7d18e3b9a2232bd30c7d7741873d0d2d855a.camel@v3.sk>
In-Reply-To: <16ce7d18e3b9a2232bd30c7d7741873d0d2d855a.camel@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Feb 2019 13:49:55 +0200
Message-ID: <CAHp75VdUCxx=Hybv8nyd9nTUJ4+8FLeaRM3bCxezAFvdSN0EkQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/10] Add support for OLPC XO 1.75 Embedded Controller
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 1:46 PM Lubomir Rintel <lkundrak@v3.sk> wrote:

> Hello Andy & Darren,
>
> I'm wondering if there's anything more I need to do in order for the
> patches 01-07 to be queued for 5.1? I believe I addressed the issues
> that were pointed out and I believe the patch set is already in a good
> shape.

I remember Darren did some review and according to patch work he is in charge.

I dunno what Darren's plans are, but if I need to look at this series,
it will require some time and may miss v5.1.

-- 
With Best Regards,
Andy Shevchenko
